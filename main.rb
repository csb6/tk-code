require 'tk'
require_relative 'document'
require_relative 'menu'
require_relative 'editor'
TkOption.add('*tearOff', 0) #Keeps menus from tearing off

root = TkRoot.new do
    title "Code"
    background "dark grey"
    minsize(1800, 1000)
    resizable(true, true)
end

editor = Editor.new(root)

    # doc = Document.new(root)
    # text = doc.text
    # m = Menu.new(root, doc)

    # sideBar = TkFrame.new(root) do
    #     grid("row" => 0, "column" => 0)
    # end

    #   menu = TkFrame.new(root) { grid('row' => 0, 'column' => 1) } #Menu Bar containing buttons
        
    #     selectedFont = Tk::Tile::Combobox.new(menu) do   #Font Selecter
    #       fonts = ['TkTextFont', 'Times', 'Impact', 'Courier']
    #       values(fonts)
    #       state(['readonly'])
    #       bind("<ComboboxSelected>") do
    #          selectedFont=get
    #          text.font(selectedFont)
    #          return selectedFont
    #       end
    #       grid('row' => 0, 'column' => 3)
    #     end
        
    #    selectedFontSize = Tk::Tile::Combobox.new(menu) do    #Font Size Selecter
    #       fontSizes = [1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
    #       values(fontSizes)
    #       state(['readonly'])
    #       bind("<ComboboxSelected>") do
    #          selectedFontSize=get
    #          text.font("#{selectedFont} #{selectedFontSize}")
    #          return selectedFontSize
    #       end
    #       grid('row' => 0, 'column' => 4)
    #    end

Tk.mainloop