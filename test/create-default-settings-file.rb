require "util/SettingsParser"

parser = SettingsParser.new("../config/parsed-default-settings.json")
parser.parseIntoFile("../config/default-settings-reduced.json")