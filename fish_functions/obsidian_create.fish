function obsidian_create
    # Usage:
    #   obsidian_create class "World History II"

    if test (count $argv) -lt 2
        echo "Usage:"
        echo "  obsidian_create class \"Class Name\""
        return 1
    end

    # First argument is the mode (class, project, etc.)
    set mode $argv[1]

    # Everything after the mode is the name (allows spaces)
    set name $argv[2..-1]

    # Use the CURRENT DIRECTORY as the base
    set BASE_DIR (pwd)

    switch $mode
        case class
            set class_dir "$BASE_DIR/$name"

            if test -e "$class_dir"
                echo "Error: '$class_dir' already exists."
                return 1
            end

            echo "Creating class at: $class_dir"
            mkdir -p "$class_dir"

            # Empty index.md
            touch "$class_dir/index.md"

            # Class-level Project notes
            mkdir -p "$class_dir/Project notes"

            # Week I–VIII
            for R in I II III IV V VI VII VIII
                set week_dir "$class_dir/Week $R"
                echo "  -> $week_dir"
                mkdir -p "$week_dir"

                # Week markdown file
                set week_file "$week_dir/Week $R.md"
                printf '%s\n' \
'---' \
'title: "Week '"$R"'"' \
'type: "class_week"' \
'tags: []' \
'---' \
'' \
'# Week '"$R"'' \
'' \
> "$week_file"

                # Project note inside week
                set pn_file "$week_dir/Project Note.md"
                printf '%s\n' \
'---' \
'title: "Week '"$R"' Project Note"' \
'type: "project_note"' \
'tags: []' \
'---' \
'' \
'# Week '"$R"' – Project Note' \
'' \
> "$pn_file"
            end

            echo "Done! Class created in: $class_dir"

        case project
            echo "Project template not implemented yet. (We can build it next!)"

        case "*"
            echo "Unknown mode: $mode"
            echo "Supported: class"
            return 1
    end
end

