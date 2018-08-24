require 'tk'
require_relative 'config/Themes'
require_relative 'config/SettingsManager'
require_relative 'util/Constants'
require_relative 'terminal/Tt'
require_relative 'editor/Document'
require_relative 'editor/Editor'
require_relative 'menu/MenuManager'

root = TkRoot.new do
    title "Code"
    background "dark grey"
    minsize(1800, 1000)
    resizable(true, true)
end
# Tk::Tile::Style.theme_use("dark")

settings = SettingsManager.new(root)
terminal = TT.new( settings.get("tt") )
terminal.run
editor = Editor.new(root, settings)

Tk.mainloop