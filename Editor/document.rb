require 'tk'

class Document
    include Constants::Document
    attr_accessor :text, :currentFile
    def initialize(root, settings)
        @root = root
        @settings = settings
        @currentFile = ""
        @textBox = TkText.new(@root) do |t|
            wrap "word"
            width DOC_WIDTH
            height DOC_HEIGHT
            TkScrollbar.new(root) { |s|
                command proc{|*args| t.yview(*args)}
                t.yscrollcommand proc{|first, last| s.set(first, last)}
                grid('row' => SCROLL_ROW, "column" => SCROLL_COL, "sticky" => 'ns', "pady" => SCROLL_PADDING)
            }
            grid("row" => DOC_ROW, "column" => DOC_COL, "pady" => DOC_PADDING)
        end
        @font = "#{@settings.get("editor.fontFamily")} #{@settings.get("editor.fontSize")}"
        @textBox.font(@font)
        @lineNumTag = TkTextTag.new(@textBox, :font => "#{@font} bold")
        @docTextTag = TkTextTag.new(@textBox)
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

            @textBox.insert(i, lineLabel, @lineNumTag)
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