module Constants

    if RUBY_PLATFORM =~ /darwin/
        PLATFORM = "mac"
    else
        PLATFORM = "win"
    end

    module Constants::Editor
        WELCOME_PATH = "/users/coleblakley/test/ruby/tk-code/welcome.md"
        ROW = 0
        COLUMN = 1
    end
    module Constants::Settings
        DEFAULT_SETTING_PATH = "/users/coleblakley/test/ruby/tk-code/config/parsed-default-settings.json"
    end
    module Constants::Document
        DOC_WIDTH = 125
        DOC_HEIGHT = 25
        DOC_PADDING = "5 0"
        DOC_ROW = 0
        DOC_COL = 1
        SCROLL_PADDING = "5 0"
        SCROLL_ROW = 0
        SCROLL_COL = 0
    end
    module Constants::Menu
        MENU_HELP_MSG = "Tk-Code is a prototype clone of VS Code written in Ruby/Tk. 
        It aims to replicate the cross platform, intuitive nature of VS Code using far less memory."
        if PLATFORM == "mac"
            OPEN_ACCEL = ["Command-o", "Mod2-o"]
            SAVE_ACCEL = ["Command-s", "Mod2-s"]
            SAVE_AS_ACCEL = ["Command-Shift-s", "Mod2-Shift-s"]
        else
            OPEN_ACCEL = "Control-o"
            SAVE_ACCEL = "Control-s"
            SAVE_AS_ACCEL = "Control-Shift-s"
        end
    end
    module Constants::Explorer
        ROW = 0
        COLUMN = 0
        HEIGHT = 28
        WIDTH = 240
    end
end