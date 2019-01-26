require 'json'

class SettingsManager

    def initialize(root)
        @root = root
        TkOption.add('*tearOff', 0) #Keeps menus from tearing off
        setVSDefaults
    end

    def get(key)
        return @defaults[ key ]
    end

    def setVSDefaults
        defaultSettingsFile = File.read(Constants::Settings::DEFAULT_SETTING_PATH)
        @defaults = JSON.parse(defaultSettingsFile)
        defaultSettingsFile = nil
    end
end
