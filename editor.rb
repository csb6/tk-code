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

        openTab("/users/kevinblakley/test/ruby/tk-code/welcome.md")
        @menuManager = MenuManager.new(@root, self)

        @notebook.bind("<NotebookTabChanged>") {
            selectedId = @notebook.index(@notebook.selected)
            @currentDoc = @openDocs[selectedId]
        }
    end

    def openTab(path)
        frame = Tk::Tile::Frame.new(@notebook)
        @notebook.add(frame, :text => path)
        openDocument(path, frame)
        @notebook.select( @notebook.index(frame) ) #Select frame that just opened
    end

    def openDocument(path, frame)
        @currentDoc = Document.new(frame)
        @currentDoc.currentFile = path
        @currentDoc.display
        @openDocs << @currentDoc
    end
end