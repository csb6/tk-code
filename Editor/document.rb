require 'tk'

class Document
    include Constants
    attr_accessor :text, :currentFile
    def initialize(root, settings)
        @root = root
        @settings = settings
        @currentFile = ""
        @textBox = TkText.new(@root) do
            wrap "word"
            width DOC_WIDTH
            height DOC_HEIGHT
            grid("row" => 1, "column" => 1, "pady" => DOC_PADDING)
        end
        @textBox.font("#{@settings.get("editor.fontFamily")} #{@settings.get("editor.fontSize")}")

        s = Tk::Tile::Scrollbar.new(root, orient: "vertical", command: proc{|*args| @textBox.yview(*args)})
          s.grid('row' => 1, "column" => 0, "sticky" => 'ns', "pady" => SCROLL_PADDING)
          @textBox.yscrollcommand proc{|*args| s.set(*args)}
    end

    def clearText
        @textBox.delete("1.0", "end")
    end
    
    def getText
        return @textBox.get("1.0", "end")
    end

    def display
        File.open(@currentFile) do |line|
            @textBox.insert(1.0, line.read)
        end
    end

    def save
        content = getText.chomp
        
        if @currentFile != ""
            File.write(@currentFile, content)
        end
    end

    def saveAs(path)
        content = getText.chomp
        
        if @currentFile != ""
            File.write(path, content)
            @currentFile = path
        end
    end

end