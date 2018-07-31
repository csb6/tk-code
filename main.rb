require 'tk'
require_relative 'document'
require_relative 'menu'
TkOption.add('*tearOff', 0) #Keeps menus from tearing off
selectedFont = 'TkTextFont'
selectedFontSize = '12'

root = TkRoot.new do
    title "Code"
    background "dark grey"
    minsize(1800, 1000)
    resizable(true, true)
end

    doc = Document.new(root)
    text = doc.text
    m = Menu.new(root, doc)

    sideBar = TkFrame.new(root) do
        grid("row" => 0, "column" => 0)
    end
      #******************************************
      menu = TkFrame.new(root) { grid('row' => 0, 'column' => 1) } #Menu Bar containing buttons
        
        selectedFont = Tk::Tile::Combobox.new(menu) do   #Font Selecter
          fonts = ['TkTextFont', 'Times', 'Impact', 'Courier']
          values(fonts)
          state(['readonly'])
          bind("<ComboboxSelected>") do
             selectedFont=get
             text.font(selectedFont)
             return selectedFont
          end
          grid('row' => 0, 'column' => 3)
        end
        
       selectedFontSize = Tk::Tile::Combobox.new(menu) do    #Font Size Selecter
          fontSizes = [1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
          values(fontSizes)
          state(['readonly'])
          bind("<ComboboxSelected>") do
             selectedFontSize=get
             text.font("#{selectedFont} #{selectedFontSize}")
             return selectedFontSize
          end
          grid('row' => 0, 'column' => 4)
       end
          #*****************************************************
       TkButton.new(menu) do   #Info Button
          text 'Info'
          command { Tk::messageBox :message => 'This is a simple word processor made by Cole Blakley' }
          grid('row' => 0, 'column' => 6)
        end
       
       TkButton.new(menu) do   #Help button
         text 'Help'
         command {Tk::messageBox :message => 'Click on the white box and begin typing.'}
         grid('row' => 0, 'column' => 7)
       end

Tk.mainloop