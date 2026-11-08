function fish_prompt
        set_color fdb88f
        printf '%s' $USER
        set_color --reset
        printf ' at '
    
        set_color red
        echo -n (prompt_hostname)
        set_color --reset
        printf ' in '
    
        set_color $fish_color_cwd
        printf '%s' (prompt_pwd)
        set_color --reset
    
        echo
        printf '↪ '

        set_color --reset
end
