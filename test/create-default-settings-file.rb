require_relative "../SettingsParser"

parser = SettingsParser.new("../parsed-default-settings.json")
parser.parseIntoFile("../default-settings-reduced.json")