require 'tk'
require_relative 'syntaxmanager'

class Document
    include Constants::Document
    attr_accessor :text, :currentFile
    def initialize(root, settings)
        @root = root
        @settings = settings
        @currentFile = ""
        @syntaxmanager = SyntaxManager.new
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
    end

    def clearText
        @textBox.delete("1.0", "end")
    end
    
    def getText
        return @textBox.get("1.0", "end")
    end

    def display
        i = 1.0
        File.open(@currentFile).each do |line|
            @textBox.insert(i, line)
            i += 1
        end
        applyHighlights
    end

    def applyHighlights
        @syntaxmanager.loadSyntax(".rb")
        @syntaxmanager.findSyntax(getText)
        textToHighlight = @syntaxmanager.findHighlights
        textToHighlight.each do |color, words|
            words.each do |word|
                start_pos = @textBox.search(word, "1.0", "end")
                if start_pos != "" && color != nil
                    end_pos = (start_pos.to_f + word.length).to_s
                    @textBox.tag_configure(color.to_s, 'foreground' => color.to_s)
                    @textBox.add_tag(color.to_s, start_pos, end_pos)
                end
            end
        end
    end

    def save
        if @currentFile != ""
            File.write(@currentFile, getText.chomp)
        end
    end

    def saveAs(path)
        if path != ""
            File.write(path, getText.chomp)
            @currentFile = path
        end
    end

end