#Recursively builds a list of directories and files in the working directory
#(the tk-code folder where main.rb is) and displayes them in a sidebar with
#folding items.
class Explorer
    include Constants
    def initialize(root, editor)
        @root = root
        @editor = editor
        @tree = Tk::Tile::Treeview.new(@root) do
            height EXPLORER_HEIGHT
            column_configure("#0", "width" => EXPLORER_WIDTH)
            grid('row' => EXPLORER_ROW, "column" => EXPLORER_COLUMN, "sticky" => "ne")
        end
        @treeFiles = [ ]
        @path = Dir.getwd
        buildTree(@path)

        @tree.bind("<TreeviewSelect>") {
            @currentNode = @tree.focus_item
            currentPath = "#{@tree.itemcget(@currentNode, :tags)[0]}"
            if !Dir.exists?(currentPath)
                @tree.tag_bind("#{@tree.itemcget(@currentNode, :tags)[0]}", "Double-1") {
                    @editor.openTab(currentPath)
                }
            end
        }
    end

    def buildTree(parentFile="", parentEntry="") #Recursively build tree structure of folder
        Dir.entries(parentFile).each do |file|
            if file[0] != "."
                treeEntry = @tree.insert(parentEntry, 'end', :text => file, :tags => ["#{parentFile}/#{file}"])
                if Dir.exists?("#{parentFile}/#{file}") then buildTree("#{parentFile}/#{file}", treeEntry) end
            end
        end
    end
end
