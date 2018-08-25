require 'tk'

class Document
    attr_accessor :text, :currentFile
    def initialize(root, settings)
        @root = root
        @settings = settings
        @currentFile = ""
        @textBox = TkText.new(@root) do
            wrap "word"
            width 125
            height 25
            grid("row" => 1, "column" => 1, "pady" => "5 0")
        end
        @textBox.font("#{@settings.get("editor.fontFamily")} #{@settings.get("editor.fontSize")}")

        s = Tk::Tile::Scrollbar.new(root, orient: "vertical", command: proc{|*args| @textBox.yview(*args)})
          s.grid('row' => 1, "column" => 0, "sticky" => 'ns', "pady" => "5 0")
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
            file = File.open(@currentFile, "w+")
            file.print(content)
            file.close
        end
    end

    def saveAs(path)
        content = getText.chomp
        
        if @currentFile != ""
            file = File.new(path, "w")
            file.print(content)
            file.close
            @currentFile = path
        end
    end


end