# Get battery information from acpi.
if whence -p acpi > /dev/null; then
    function battery_info() {
        # For simplicity, stop after the first entry.
        acpi -b | awk '/^Battery/ {print $3, $4; exit}' |
        sed -e 's_Charging,_+_'    -e 's_Full,_1_'    \
            -e 's_Discharging,_-_' -e 's_Unknown,_0_' \
            -e 's_%,__'
    }
fi

if whence battery_info > /dev/null; then

    function prompt_battery() {
        # Get the current battery status.
        battery_info | read state charge

        if [ -z "$charge" ]; then
            echo "battery.zsh: empty \$charge variable." 1>&2
            return
        fi

        # The character to fill the battery with.
        local c
        case $state in
            +) c='<'  ;; # Discharging.
            -) c='>'  ;; # Charging.
            *) return ;; # Something else. In this case, don't show the battery
                         # in the prompt.
         esac

         # Charge levels and their corresponding colours.
         local -a levels
         levels=(80 60 40 20)
         local -a colours
         colours[80]="%{%F{green}%}"
         colours[60]="%{%B%F{yellow}%}"
         colours[40]="%{%F{yellow}%}"
         colours[20]="%{%B%F{red}%}"

         local bars
         local colour
         for i in "${levels[@]}"; do
             if [ "$charge" -ge "$i" ]; then
                 if [ -z "$colour" ]; then
                     colour="${colours[$i]}"
                 fi
                 bars+="$c"
             else
                 bars+=" "
             fi
         done

         echo " [$colour$bars%{%b%f%}] $charge%%"
    }
else
    # Define a no-op function if no batteries are found.
    function prompt_battery() {}
fi
