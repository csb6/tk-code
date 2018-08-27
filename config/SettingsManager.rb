require 'json'

class SettingsManager

    def initialize(root)
        @root = root
        setVSDefaults
        setTtDefaults
    end

    def get(key)
        return @defaults[ key ]
    end

    def setVSDefaults
        defaultSettingsFile = File.read(Constants::DEFAULT_SETTING_PATH)
        @defaults = JSON.parse(defaultSettingsFile)
        defaultSettingsFile = nil
    end

    def setTtDefaults
        @defaults["tt"] = {
            "rootWin" => @root,
            "sb" => true,
            "fw" => true,
            "sc" => true,
            "cu" => true,
            "zi" => true,
            "bg" => "#ffffff",
            "fg" => "#000000",
            "fn" => DEFAULT_FONT,
            "af" => ALTERNATE_FONT,
            "browser" => "xdg-open",
            "width" => "118",
            "height" => "15",
            "tn" => "9term",
            "title" => "tt",
            "cmd" => [ENV["SHELL"] || "/bin/sh"],
            "bar" => nil,
          }
          until ARGV.empty?
            case arg = ARGV.shift
            when /\A([+-])(sb|sc|fw|cu|zi)\z/
              opts[$2] = ($1 == "-")
            when /\A-(fn|af|tn|fg|bg|cr|title|browser|bar)\z/
              opts[$1] = ARGV.shift
            when /\A-(g(eometry)?)\z/
              g = ARGV.shift
              if g =~ /\A(\d+x\d+)?([+-]\d+[+-]\d+)?\z/
                opts["width"], opts["height"] = $1.split("x")  if $1
                opts["geom"] = $2
              else
                abort "invalid geometry #{g}"
              end
            when "-e"
              opts["cmd"] = ARGV
              break
            when "-h", "-help", "--help"
              puts "tt #{TT::VERSION}"
              puts "Usage: tt [-help] [--help]
           [-tn string] [-geometry geometry] [-/+fw] [-/+sb] [-/+sc] [-/+zi]
           [-bg color] [-fg color] [-cr color] [-fn fontname] [-af fontname]
           [-bar string] [-browser string] [-title string] [-e command arg...]"
              exit
            else
              abort "invalid argument #{arg}"
            end
          end
    end
end