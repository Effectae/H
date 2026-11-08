function set_home -d 'Set $<TARGET>_HOME and optionally add its bin to PATH'
    argparse 'h/help' 'B/bin' 'p/prepend' -- $argv; or return

    set -q _flag_help; and begin
        echo "Usage: $argv[0] [-h] [-B] TARGET PATH"
        return
    end

    test (count $argv) -lt 2; and begin
        echo "Error: require TARGET and PATH" >&2
        return 1
    end
    
    set -l target $argv[1]
    set -l _path $argv[2]

    set -l target_home "$target""_HOME"

    set -q "$target_home"; and return
    set -xg "$target_home" "$_path"

    test -d "$$target_home"; or begin
        set -e "$target_home"
        echo "Error: $target_home ($$target_home) is not a directory or does not exist" >&2
        return 1
    end
 
    set -q _flag_bin; and begin
        set -l p "$$target_home/bin"
        test -d "$p"; or begin
            echo "Error: \$$target_home ($$target_home) has no bin directory" >&2
        end
        set -q _flag_prepend
        and    set OPT "-Pp"
        or     set OPT "-Pa"
        fish_add_path "$OPT" "$p"
    end
end
