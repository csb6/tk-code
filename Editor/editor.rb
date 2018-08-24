class Editor
    attr_reader :currentDoc

    def initialize(root, settings)
        @root = root
        @openDocs = [ ]
        @settings = settings

        @notebook = Tk::Tile::Notebook.new(root) do
            grid("row" => 0, "column" => 0)
        end

        openTab(Constants::WELCOME_PATH)
        @menuManager = MenuManager.new(@root, self)

        @notebook.bind("<NotebookTabChanged>") {
            selectedId = @notebook.index(@notebook.selected)
            @currentDoc = @openDocs[selectedId]
        }

        @notebook.bind("2", proc { #Right click to close tab
            if @openDocs.size > 1
                id = @notebook.index(@notebook.selected)
                @notebook.forget(id)
                @openDocs.delete_at(id)
            end
        })
    end

    def openTab(path)
        frame = Tk::Tile::Frame.new(@notebook)
        @notebook.add(frame, :text => path.split("/")[-1] )
        openDocument(path, frame)
        @notebook.select( @notebook.index(frame) ) #Select frame that just opened
    end

    def openDocument(path, frame)
        @currentDoc = Document.new(frame, @settings)
        @currentDoc.currentFile = path
        @currentDoc.display
        @openDocs << @currentDoc
    end
end