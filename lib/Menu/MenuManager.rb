#Allows organization/creation of system menus and menu items, as well as blocks
#of code to excute when each menu item is selected.
class MenuManager
    include Constants
    def initialize(root, editor)
        @root = root
        @editor = editor
        @menuBar = TkMenu.new(@root)
            @root['menu'] = @menuBar
        @menuBuilder = MenuBuilder.new(@menuBar, @root)
            addFileMenu
            @menuBuilder.createMenu("Edit")
            @menuBuilder.createMenu("Selection")
            @menuBuilder.createMenu("View")
            @menuBuilder.createMenu("Go")
            addHelpMenu
    end

    class MenuBuilder
        def initialize(menuBar, root)
            @menuBar = menuBar
            @root = root
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
            Tk::messageBox :message => MENU_HELP_MSG 
        })
    end
end
