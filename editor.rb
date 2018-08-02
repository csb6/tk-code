class Editor
    attr_reader :currentDoc

    def initialize(root)
        @root = root
        @font = 'TkTextFont'
        @fontSize = '12'
        @openDocs = [ ]

        @notebook = Tk::Tile::Notebook.new(root) do
            grid("row" => 1, "column" => 0)
        end

        @menuManager = MenuManager.new(@root, self)
        openTab("/users/kevinblakley/test/ruby/tk-code/welcome.md")

        @notebook.bind("<NotebookTabChanged>") {
            selectedId = @notebook.index(@notebook.selected)
            changeSelected( @openDocs[selectedId] )
        }
    end

    def openTab(path)
        frame = Tk::Tile::Frame.new(@notebook)
        @notebook.add(frame, :text => path)
        openDocument(path, frame)
        @notebook.select( @notebook.index(frame) ) #Select frame that just opened
    end

    def changeSelected(document)
        @currentDoc = document
        @menuManager.document = @currentDoc
    end

    def openDocument(path, frame)
        document = Document.new(frame)
        document.currentFile = path
        document.displayCurrentFile
        changeSelected(document) #Tell menuManager which document is selected
        @openDocs << document
    end

    def saveSelectedDocument
        @currentDoc.saveCurrentFile
    end

    def saveAsSelectedDocument(path)
        @currentDoc.saveAsCurrentFile(path)
    end

end