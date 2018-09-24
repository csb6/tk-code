require 'json'

#Every syntax extension is 100% within a folder in the extensions directory, and each folder contains:
#    -A package.json file, which contains the applicable file extensions and the path to the TextMate syntax file
#    -A TextMate syntax file (e.g. ruby.tmLanguage.json), which contains grammar rules for highlighting syntax
#
#SyntaxManager loads these extensions when the editor starts, then activates the appropriate syntax highlighting
#when a new file is opened in the editor.

class SyntaxManager
    def initialize(filePath)
        # @textBox = textBox
        @filePath = filePath
        @syntaxPath = ""
        #Add a better way to do colors; need a lot more of them
        @colors =["blue", "red", "green", "yellow", "brown", "red", "orange", "alice blue", "aquamarine", "beige", "blue violet", "green", "dark green", "red orange"]
        @syntaxRules = Hash.new
        @extensionFolder = "../extensions"
        @extensions = Array.new
        loadExtensions
    end

    def loadExtensions
        Dir.entries(@extensionFolder).each do |extension|
            extensionPath = @extensionFolder + "/" + extension

            if extension[0] != "." && Dir.exists?(extensionPath) #Only scan for extensions in directories
                packageFile = JSON.parse( File.read(extensionPath + "/package.json") )
                fileExtensions = packageFile["contributes"]["languages"][0]["extensions"]
                syntaxPath = extensionPath + packageFile["contributes"]["grammars"][0]["path"].delete_prefix(".")
                #Stores an array of all file extensions for a language and the path to the language syntax rules
                @extensions << [ fileExtensions, syntaxPath ]
            end
        end
    end

    def loadSyntax(fileExtension)
        #Goes through the loaded VS extensions, finds which is appropriate for the current file's extension (e.g. .rb, .py)
        @extensions.each do |language|
            language[0].each do |langExtension|
                #If the given extension matches one defined in an extension, record the syntaxFile path, break
                if langExtension === fileExtension
                    @syntaxPath = language[1]
                    @syntaxRules = JSON.parse( File.read(@syntaxPath) )
                    break
                end
            end
        end
    end

    def findHighlightedSyntax(text)
        #Goes through given text, finding which patterns match the current language's syntax highlighting rules.
        #It returns the words to highlight and in what color.
        allMatches = Array.new
        text.split("\n").each do |line|
            @syntaxRules["patterns"].each do |capture|
                matches = /#{capture["match"]}/.match(line)
                if matches != nil && capture["name"] != nil
                    matches = matches.captures.uniq
                    matches.delete(nil)
                    matches.delete("")
                    if !matches.empty? 
                        allMatches << [matches, capture["name"]]
                    end
                end
            end
        end
        wordsAndColors = findHighlightColors(allMatches)
        return wordsAndColors
    end

    def findHighlightColors(matches)
        #Assigns colors to groups of matches that have the same capture name in the syntax files
        nameToColorAndWord = Hash.new
        wordsAndColors = Array.new
        j = 0
        matches.each_index do |i|
            if nameToColorAndWord[ matches[i][1] ] === nil
                nameToColorAndWord[ matches[i][1] ] = Array.new
                nameToColorAndWord[ matches[i][1] ] = [ @colors[i], [ matches[i][0] ] ]
                j += 1
            else
                nameToColorAndWord[ matches[i][1] ][1] << matches[i][0]
            end
        end
        nameToColorAndWord.each_value do |v|
            wordsAndColors << [v[0], v[1].flatten.uniq] #Fix this mess
        end
        return wordsAndColors
    end
end

sm = SyntaxManager.new("hello")
sm.loadSyntax(".rb")
puts sm.findHighlightedSyntax(File.read("document.rb")).to_s