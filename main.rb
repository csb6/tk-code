require 'tk'
$LOAD_PATH << "./lib"
#require 'config/Themes'
require 'SettingsManager'
require 'Constants'
require 'terminal/Tt'
require 'explorer/Explorer'
require 'editor/Document'
require 'editor/Editor'
require 'menu/MenuManager'

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
menu = MenuManager.new(root, editor)
explorer = Explorer.new(root, editor)

Tk.mainloop