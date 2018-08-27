class Explorer
    def initialize(root)
        @root = root
        @tree = Tk::Tile::Treeview.new(@root) do
            height 28
            column_configure("#0", "width" => 240)
            grid('row' => 0, "column" => 0, "sticky" => "ne")
        end
        @treeFiles = [ ]
        @path = Dir.getwd
        buildTree

        @tree.bind("<TreeviewSelect>", proc{
            @currentNode = @tree.index( @tree.selection_get )
            puts "#{@tree.itemcget(@tree.selection_get, :text)}"
        })
    end

    def buildTree
        Dir.entries(@path).each do |file|
            if file[0] != "."
                treeFile = @tree.insert('', 'end', :id => file, :text => file)
                if Dir.exists?(file) #if file is a directory, sublist its contents
                    Dir.entries(file).each do |f|
                        if f[0] != "." then subFile = @tree.insert(treeFile, 'end', :id => "#{file}/#{f}", :text => f) end
                    end
                end
            end
        end
    end
end