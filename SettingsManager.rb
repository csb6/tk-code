require 'json'

class SettingsManager
    attr_reader :fontSize, :font
    def initialize
        defaultSettingsFile = File.read("/users/kevinblakley/test/ruby/tk-code/default-settings-reduced.json")
        @defaults = JSON.parse(defaultSettingsFile)
        @fontSize = @defaults["editor.fontSize"]
        @font = @defaults["editor.fontFamily"].split(", ")[0]
        defaultSettingsFile = nil
    end

    def getSetting(key)
        return @defaults[ key ]
    end
end