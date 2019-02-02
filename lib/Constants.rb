#Basic data concerning platform, set-up files, GUI layout, and keybindings.
module Constants

    if RUBY_PLATFORM =~ /darwin/
        PLATFORM = "mac"
    else
        PLATFORM = "win"
    end

    WELCOME_PATH = "/users/coleblakley/test/ruby/tk-code/welcome.md"
    EDITOR_ROW = 0
    EDITOR_COLUMN = 1
    DEFAULT_SETTING_PATH = "/users/coleblakley/test/ruby/tk-code/data/config/parsed-default-settings.json"
    
    DOC_WIDTH = 125
    DOC_HEIGHT = 25
    DOC_PADDING = "5 0"
    DOC_ROW = 0
    DOC_COL = 1
    SCROLL_PADDING = "5 0"
    SCROLL_ROW = 0
    SCROLL_COL = 0
    
    MENU_HELP_MSG = "Tk-Code is a prototype clone of VS Code written in Ruby/Tk. It aims to replicate the cross platform, intuitive nature of VS Code using far less memory."
    if PLATFORM == "mac"
        OPEN_ACCEL = ["Command-o", "Mod2-o"]
        SAVE_ACCEL = ["Command-s", "Mod2-s"]
        SAVE_AS_ACCEL = ["Command-Shift-s", "Mod2-Shift-s"]
    else
        OPEN_ACCEL = "Control-o"
        SAVE_ACCEL = "Control-s"
        SAVE_AS_ACCEL = "Control-Shift-s"
    end
    
    EXPLORER_ROW = 0
    EXPLORER_COLUMN = 0
    EXPLORER_HEIGHT = 28
    EXPLORER_WIDTH = 240

    TERM_ROW = 1
    TERM_COLUMN = 1
end
