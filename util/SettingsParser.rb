require 'json'

class SettingsParser
    def initialize(parsedSettingPath)
        @parsedSettingPath = parsedSettingPath
    end

    def parseIntoFile(targetSettingPath)
        targetSettingFile = File.read(targetSettingPath)
        uncorrectedSettings = JSON.parse(targetSettingFile)
        @correctSettings = Hash.new
        uncorrectedSettings.each do |key, value|
            case key
            when "editor.fontFamily"
                @correctSettings[key] = value.split(", ")[0]
            when "editor.cursorBlinking"
                @correctSettings[key] = true
            when "editor.suggestFontSize"
                @correctSettings[key] = false
            when "editor.suggestLineHeight"
                @correctSettings[key] = false
            else
                @correctSettings[key] = value
            end
        end
        File.write( @parsedSettingPath, JSON.pretty_generate(@correctSettings) )
    end

end
