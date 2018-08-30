require 'tk'

class Document
    include Constants::Document
    attr_accessor :text, :currentFile
    def initialize(root, settings)
        @root = root
        @settings = settings
        @currentFile = ""
        @textBox = TkText.new(@root) do
            wrap "word"
            width DOC_WIDTH
            height DOC_HEIGHT
            grid("row" => DOC_ROW, "column" => DOC_COL, "pady" => DOC_PADDING)
        end
        @font = "#{@settings.get("editor.fontFamily")} #{@settings.get("editor.fontSize")}"
        @textBox.font(@font)
        @textBox.tag_configure('lineNumTag', :font => "#{@font} bold")
        @docTextTag = TkTextTag.new(@textBox)

        s = Tk::Tile::Scrollbar.new(root, orient: "vertical", command: proc{|*args| @textBox.yview(*args)})
          s.grid('row' => SCROLL_ROW, "column" => SCROLL_COL, "sticky" => 'ns', "pady" => SCROLL_PADDING)
          @textBox.yscrollcommand proc{|*args| s.set(*args)}
    end

    def clearText
        @textBox.delete("1.0", "end")
    end
    
    def getText
        docText = ""
        @docTextTag.ranges.each do |range| #Get each range of document text
            docText << @textBox.get( range[0], range[1] )
        end
        return docText
    end

    def display
        i = 1.0
        lineNum = 1
        File.open(@currentFile).each do |line|
            lineLabel = sprintf("%-5d", "#{lineNum}")
            
            @textBox.insert(i, lineLabel, "lineNumTag")
            i += lineLabel.length
            @textBox.insert(i, line, @docTextTag)
            i += line.length
            lineNum += 1
        end
    end

    def save
        if @currentFile != ""
            File.write(@currentFile, getText.chomp)
        end
    end

    def saveAs(path)
        if @currentFile != ""
            File.write(path, getText.chomp)
            @currentFile = path
        end
    end

end