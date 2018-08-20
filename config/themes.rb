#Dark Theme. Note: doesn't support TableList widgets

# NB: These colors must be in sync with the ones in black.rdb
colors = {
    "disabledfg" => "#a9a9a9",
    "frame"  =>  "#424242",
    "dark"  =>   "#222222",
    "darker"  => "#121212",
    "darkest"  => "#000000",
    "lighter"  => "#626262",
    "lightest" => "#ffffff",
    "selectbg" => "#4a6984",
    "selectfg" => "#ffffff"
}

Tk::Tile::Style.configure('dark', {
    "background" => colors["frame"], 
    "foreground" => "#ffffff",
    "bordercolor" => colors["darkest"], 
    "darkcolor" => colors["dark"], 
    "lightcolor" => colors["lighter"], 
    "troughcolor" => colors["darker"], 
    "selectbackground" => colors["selectbg"], 
    "selectforeground" => colors["selectfg"], 
    "selectborderwidth" => 0,
    "font" => "Consolas"
})
    #   ttk::style map "." 
    #       -background [list disabled $colors(-frame) 
    #       active $colors(-lighter)] 
    #       -foreground [list disabled $colors(-disabledfg)] 
    #       -selectbackground [list  !focus $colors(-darkest)] 
    #       -selectforeground [list  !focus #ffffff]
  
      # ttk widgets.
      Tk::Tile::Style.configure("TButton", "width" => 8, "padding" => "5 1", "relief" => "raised")
      Tk::Tile::Style.configure("TMenubutton", "width" => 11, "padding" => "5 1", "relief" => "raised")
      Tk::Tile::Style.configure("TCheckbutton", "indicatorbackground" => "#ffffff", "indicatormargin" => "1 1 4 1")
      Tk::Tile::Style.configure("TRadiobutton", "indicatorbackground" => "#ffffff", "indicatormargin" => "1 1 4 1")
  
      Tk::Tile::Style.configure("TEntry", "fieldbackground" => "#ffffff", "foreground" => "#000000", "padding" => "2 0")
      Tk::Tile::Style.configure("TCombobox", "fieldbackground" => "#ffffff", "foreground" => "#000000", "padding" => "2 0")
      Tk::Tile::Style.configure("TSpinbox", "foreground" => "#000000")
  
      Tk::Tile::Style.configure("TNotebook.Tab", "padding" => "6 2 6 2")
  
#       # tk widgets.
#       Tk::Tile::Style map Menu 
# -background [list active $colors(-lighter)] 
# -foreground [list disabled $colors(-disabledfg)]
  
#       Tk::Tile::Style.configure("TreeCtrl 
# -background gray30 -itembackground {gray60 gray50} 
# -itemfill #ffffff -itemaccentfill yellow
#     }
#   }
