require 'json'

class SettingsManager
    attr_reader :fontSize, :font
    def initialize
        defaultSettingsFile = File.read("./parsed-default-settings.json")
        @defaults = JSON.parse(defaultSettingsFile)
        defaultSettingsFile = nil
    end

    def getSetting(key)
        return @defaults[ key ]
    end
end