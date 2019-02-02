require 'tk'
$LOAD_PATH << "./lib"
require 'SettingsManager'
require 'Constants'
require 'terminal/bash'
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

settings = SettingsManager.new(root)
terminal = Terminal.new(root)
terminal.prompt_user
editor = Editor.new(root, settings)
menu = MenuManager.new(root, editor)
explorer = Explorer.new(root, editor)

Tk.mainloop
