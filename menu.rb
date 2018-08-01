class Menu
    attr_accessor :document
    def initialize(root, editor)
        @root = root
        @editor = editor
        @document = @editor.currentDoc
        @menuBar = TkMenu.new(@root)
            @root['menu'] = @menuBar
        @menuBuilder = MenuBuilder.new(@menuBar)
            addFileMenu
            @menuBuilder.createMenu("Edit")
            @menuBuilder.createMenu("Selection")
            @menuBuilder.createMenu("View")
            @menuBuilder.createMenu("Go")
            addHelpMenu
    end

    class MenuBuilder
        def initialize(menuBar)
            @menuBar = menuBar
        end

        def createMenu(label)
            @menu = TkMenu.new(@menuBar)
            @menuBar.add(:cascade, :menu => @menu, :label => label)
        end

        def addItem(label, command)
            @menu.add(:command, :label => label, :command => command)
        end
    end

    def addFileMenu
        @menuBuilder.createMenu("File")

        @menuBuilder.addItem("Open", proc {
            currentFile = Tk::getOpenFile
            
            if currentFile != ""  #If there's a proper filename, write updated version to file
                @editor.createDocument(currentFile)
                @document.currentFile = currentFile
                @document.displayCurrentFile
            end
        })

        @menuBuilder.addItem("Save", proc {
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

        @menuBuilder.addItem("Save As...", proc {
            content = @document.getText
            currentFile = Tk::getSaveFile
            
            if currentFile != ""
                file = File.new(currentFile, "w")
                file.print(content)
                file.rewind
                file.close
                @document.currentFile = currentFile
            end
        })
    end

    def addHelpMenu
        @menuBuilder.createMenu("Help")
        @menuBuilder.addItem("About", proc { Tk::messageBox :message => 'Tk-Code is a prototype clone of VS Code written in Ruby/Tk. It aims to replicate the cross platform, intuitive-to-use nature of VS Code using far less memory.' })
    end
end