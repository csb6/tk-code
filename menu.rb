class Menu
    def initialize(root, document)
        @root = root
        @document = document
        @menuBar = TkMenu.new(@root)
            @root['menu'] = @menuBar
        addFileMenu
        @editMenu = addMenu("Edit")
        @selectionMenu = addMenu("Selection")
        @viewMenu = addMenu("View")
    end

    def addMenu(label)
        menu = TkMenu.new(@menuBar)
        @menuBar.add(:cascade, :menu => menu, :label => label)
        return menu
    end

    def addMenuItem(menu, label, command)
        menu.add(:command, :label => label, :command => command)
    end

    def addFileMenu
        @fileMenu = addMenu("File")

        addMenuItem(@fileMenu, "Save", proc {
            content = @document.getText
            currentFile = @document.currentFile
            
            if currentFile != ""
                file = File.open(currentFile, "w+")
                fcontent = ""
                file.each do |line|
                    fcontent = fcontent + line
                end
                fcontent != content ? file.puts(content) : #Makes sure the program doesn't rewrite the file if it hasn't been edited
                file.rewind
                file.close
            end
        })

        addMenuItem(@fileMenu, "Open", proc {
            currentFile = Tk::getOpenFile
            
            if currentFile != ""  #If there's a proper filename, write updated version to file
                @document.clearText
                @document.displayFile(currentFile)
                @document.currentFile = currentFile
            end
        })

        addMenuItem(@fileMenu, "Save As", proc {
            content = @document.getText
            currentFile = Tk::getSaveFile
            
            if currentFile != ""
                file = File.new(currentFile, "w")
                file.puts(content)
                file.rewind
                file.close
                @document.currentFile = currentFile
            end
        })
    end
end