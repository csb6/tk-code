require 'json'
#Loads settings for VS Code compatability
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
        defaultSettingsFile = File.read(Constants::DEFAULT_SETTING_PATH)
        @defaults = JSON.parse(defaultSettingsFile)
        defaultSettingsFile = nil
    end
end
