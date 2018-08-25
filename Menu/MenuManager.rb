class MenuManager

    def initialize(root, editor)
        @root = root
        @editor = editor
        TkOption.add('*tearOff', 0) #Keeps menus from tearing off
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
            path = Tk::getOpenFile
            if path != ""  #If there's a proper filename, open file in editor
                @editor.openTab(path)
            end
        })

        @menuBuilder.addItem("Save", proc {
            @editor.currentDoc.save
        })

        @menuBuilder.addItem("Save As...", proc {
            path = Tk::getSaveFile
            if path != ""
                @editor.currentDoc.saveAs(path)
            end
        })
    end

    def addHelpMenu
        @menuBuilder.createMenu("Help")
        @menuBuilder.addItem("About", proc { 
            Tk::messageBox :message => 'Tk-Code is a prototype clone of VS Code written in Ruby/Tk. It aims to replicate the cross platform, intuitive nature of VS Code using far less memory.' 
        })
    end
end