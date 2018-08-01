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

        @menu = Menu.new(@root, self)
        createDocument("Welcome")

        @notebook.bind("<NotebookTabChanged>") {
            selectedId = @notebook.index(@notebook.selected)
            @currentDoc = @openDocs[selectedId]
            @menu.document = @currentDoc
        }
    end

    def createDocument(title) #TODO: Fix text of documents not remaining when switching tabs
        frame = Tk::Tile::Frame.new(@notebook)
        @notebook.add(frame, :text => title)
        @notebook.select( @notebook.index(frame) ) #Select frame that just opened
        document = Document.new(frame)
        @openDocs << document
        changeSelected(document)
    end

    def changeSelected(document)
        @currentDoc = document
        @menu.document = @currentDoc
    end

end