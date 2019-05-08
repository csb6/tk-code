# Tk-Code Text Editor

Demonstration Video:

[![IMAGE ALT TEXT](http://img.youtube.com/vi/7E6L7qqxqCs/0.jpg)](http://www.youtube.com/watch?v=7E6L7qqxqCs "Video Title")

Tk-Code is a fairly basic editor built using Ruby and the Tk widget toolkit. It is designed to resemble the basic interface of VS Code. The goal of this project was to increase my skills in modeling and managing GUIs using classes and a simple architecture. Along the way, I learned a lot about encapsulating the state of different widgets, as well as how to parse user input in a simple terminal emulator.

## Usage:
- Open/Save/Save As in the File menu work as expected
- Click on tabs to switch between opened documents
- Right click on the row of tabs at the top-center of the screen to close the current document
- The left sidebar contains a tree view of the current working directory (the repository folder) and all its sub-directories
- Double-click on any file in the tree to open it in a new tab of the editor
- The lower white box is an extremely basic terminal emulator. Only commands with simple printed output (like ls or cat) work, but it does support changing the current directory using cd

## Features:
- Multi-document editing using tabbed views
- Simple, in-window terminal
- File tree for working directory with the ability to open files into new tabs
