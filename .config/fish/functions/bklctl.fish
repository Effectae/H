function bklctl --argument-names rate -d 'backlight control'
    set -l LPATH '/sys/class/backlight/amdgpu_bl0'
    test -z "$rate";and begin
        math  $(cat $LPATH/brightness) / $(cat $LPATH/max_brightness)
        return
    end
    math -s0 $(cat $LPATH/max_brightness) \* $rate | doas tee $LPATH/brightness
end
