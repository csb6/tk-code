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
        buildTree

        @tree.bind("<TreeviewSelect>") {
            @currentNode = @tree.focus_item
            currentPath = "#{@path}/#{@tree.itemcget(@currentNode, :tags)[0]}"
            if !Dir.exists?(currentPath)
                @tree.tag_bind("#{@tree.itemcget(@currentNode, :tags)[0]}", "Double-1") {
                    @editor.openTab(currentPath)
                }
            end
        }
    end

    def buildTree
        Dir.entries(@path).each do |file|
            if file[0] != "."
                treeFile = @tree.insert('', 'end', :text => file, :tags => ["#{file}"])
                if Dir.exists?(file) #if file is a directory, sublist its contents
                    Dir.entries(file).each do |f|
                        if f[0] != "." then subFile = @tree.insert(treeFile, 'end', :text => f, :tags => ["#{file}/#{f}"]) end
                    end
                end
            end
        end
    end
end