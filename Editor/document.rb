require 'tk'

class Document
    attr_accessor :text, :currentFile
    def initialize(root, editor)
        @root = root
        @editor = editor
        @currentFile = ""
        @textBox = TkText.new(@root) do
            wrap "word"
            width 125
            height 25
            grid("row" => 1, "column" => 1, "pady" => "5 0")
        end
        @textBox.font("#{@editor.settings.getSetting("editor.fontFamily")} #{@editor.settings.getSetting("editor.fontSize")}")

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

    def display
        File.open(@currentFile) do |line|
            @textBox.insert(1.0, line.read)
        end
    end

    def save
        content = getText.chomp
        
        if @currentFile != ""
            file = File.open(@currentFile, "w+")
            fcontent = ""
            file.each do |line|
                fcontent = fcontent + line
            end
            fcontent != content ? file.print(content) : #Makes sure the program doesn't rewrite the file if it hasn't been edited
            file.rewind
            file.close
        end
    end

    def saveAs(path)
        content = getText.chomp
        
        if @currentFile != ""
            file = File.new(path, "w")
            file.print(content)
            file.rewind
            file.close
            @currentFile = path
        end
    end


end