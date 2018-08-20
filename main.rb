require 'tk'
require_relative 'config/Themes'
require_relative 'util/Constants'
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

editor = Editor.new(root)
Tk.mainloop