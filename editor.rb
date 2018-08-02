require_relative 'SettingsManager'

class Editor
    attr_reader :currentDoc, :settings

    def initialize(root)
        @root = root
        @openDocs = [ ]
        @settings = SettingsManager.new

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
        @currentDoc = Document.new(frame, self)
        @currentDoc.currentFile = path
        @currentDoc.display
        @openDocs << @currentDoc
    end
end