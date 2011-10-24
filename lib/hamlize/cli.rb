module Hamlize
  class CLI
    attr_reader :options

    def initialize(args=[])
      @args    = args
      @options = default_options
    end

    def start!
      OptionParser.new(&method(:set_opts)).parse!(@args)
      @options[:auto] ? auto! : default!
    end

  private

    def default!
      Converter.new(@options).start!
    end

    def auto!
      require "guard"
      ::Guard.start(:watchdir => @options[:source], :guardfile_contents => %{
        require "hamlize/guard"

        guard "hamlize", :source => "#{@options[:source]}", :output => "#{@options[:output]}" do
          watch %r(^.+\.haml$)
        end
      })
    end

    def default_options
      { auto: false, source: Dir.pwd, output: File.join(Dir.pwd, "compiled") }
    end

    def set_opts(opts)
      opts.banner = <<-END
Usage: hamlize [OPTIONS]

Description:
  Converts a directory of HAML files.

Options:
      END

      opts.on("-a", "--auto", "Automatically convert file when they change.") do
        @options[:auto] = true
      end

      opts.on("-s", "--source DIRECTORY", "Source directory of HAML files") do |dir|
        @options[:source] = File.expand_path(dir)
      end

      opts.on("-o", "--output DIRECTORY", "Destination of the compiled files") do |dir|
        @options[:output] = File.expand_path(dir)
      end
    end
  end
end
