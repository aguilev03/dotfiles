function fonts
    set cmd $argv[1]
    set fontpack $argv[2]
    set source "$HOME/.font-packs/$fontpack"
    set link "$HOME/.local/share/fonts/$fontpack"

    if test "$cmd" = "toggle"
        if test -L "$link"
            echo "Disabling $fontpack..."
            rm "$link"
        else if test -d "$source"
            echo "Enabling $fontpack..."
            ln -s "$source" "$link"
        else
            echo "Font pack '$fontpack' not found in ~/.font-packs"
            return 1
        end
        echo "Rebuilding font cache..."
        fc-cache -fv
    else
        echo "Usage: fonts toggle [FontPackName]"
    end
end

