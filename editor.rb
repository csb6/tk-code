class Editor

    def initialize(root)
        @root = root
        @font = 'TkTextFont'
        @fontSize = '12'
        @openDocs = [ ]

        @notebook = Tk::Tile::Notebook.new(root) do
            grid("row" => 1, "column" => 0)
        end

        createDocument("Welcome")
        createDocument("Document1")
        @selectedDoc = @openDocs[0]
        @menu = Menu.new(@root, @selectedDoc)

        @notebook.bind("<NotebookTabChanged>") {
            selectedId = @notebook.index(@notebook.selected)
            @selectedDoc = @openDocs[selectedId]
            @menu.document = @selectedDoc
        }
    end

    def createDocument(title)
        frame = Tk::Tile::Frame.new(@notebook)
        @notebook.add(frame, :text => title)
        document = Document.new(frame)
        @openDocs << document
    end

end