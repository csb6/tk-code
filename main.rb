require 'tk'
TkOption.add('*tearOff', 0) #Keeps menus from tearing off

root = TkRoot.new do
    title "Code"
    background "dark grey"
    minsize(1800, 1000)
    resizable(true, true)
end

    sideBar = TkFrame.new(root) do
        grid("row" => 0, "column" => 0)
    end

Tk.mainloop