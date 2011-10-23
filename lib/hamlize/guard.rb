require "rbconfig"
require "guard/guard"

case RbConfig::CONFIG["host_os"]
when /darwin/      then require "rb-fsevent"
when /linux/       then require "rb-inotify"
when /mswin|mingw/ then require "rb-fchange"
end

class Guard::Hamlize < Guard::Guard
  def run_on_change(paths)
    Hamlize::Converter.new(options).start!
  end
end
