module Hamlize
  class Converter
    def initialize(opts={})
      @opts = opts
    end

    def start!
      Pathname.glob(haml).each do |path|
        destination(path).open("w+") { |f| f.write convert(path) }
        puts "[#{Time.now}] #{path} => #{destination(path)}"
      end
    end

  private

    def convert(path)
      ::Haml::Engine.new(path.read).to_html
    end

    def destination(path)
      expand(path).tap { |p| p.dirname.mkpath }
    end

    def expand(path)
      path = path.to_s.gsub(/^#{source}/, "").gsub(".haml", ".html")
      Pathname.new(File.join(output, path))
    end

    def source
      @opts[:source]
    end

    def output
      @opts[:output]
    end

    def haml
      "#{source}/**/*.haml"
    end
  end
end
