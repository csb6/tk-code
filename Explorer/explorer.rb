class Explorer
    include Constants::Explorer
    def initialize(root, editor)
        @root = root
        @editor = editor
        @tree = Tk::Tile::Treeview.new(@root) do
            height HEIGHT
            column_configure("#0", "width" => WIDTH)
            grid('row' => ROW, "column" => COLUMN, "sticky" => "ne")
        end
        @treeFiles = [ ]
        @path = Dir.getwd
        rBuildTree(@path)

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

    def rBuildTree(parentFile="", parentEntry="")
        Dir.entries(parentFile).each do |file|
            if file[0] != "."
                treeEntry = @tree.insert(parentEntry, 'end', :text => file, :tags => ["#{parentFile}/#{file}"])
                if Dir.exists?("#{parentFile}/#{file}") then rBuildTree("#{parentFile}/#{file}", treeEntry) end
            end
        end
    end
end