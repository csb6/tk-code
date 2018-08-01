require 'tk'

class Document
    attr_accessor :text, :currentFile
    def initialize(root)
        @root = root
        @currentFile = ""
        @textBox = TkText.new(@root) do
            wrap "word"
            width 125
            height 60
            grid("row" => 1, "column" => 1, "pady" => "5 0")
        end

        s = Tk::Tile::Scrollbar.new(@root) do #Scrollbar on left
            orient "vertical"
            command proc{|*args| @textBox.yview(*args)}
            grid('row' => 1, "column" => 0, "sticky" => 'ns', "pady" => "5 0")
          end
          @textBox.yscrollcommand proc{|*args| s.set(*args)}
    end

    def clearText
        @textBox.delete("1.0", "end")
    end
    
    def getText
        return @textBox.get("1.0", "end")
    end

    def displayCurrentFile
        File.open(@currentFile) do |line|
            @textBox.insert(1.0, line.read)
        end
    end


end