# Get battery information from acpi.
if whence -p acpi > /dev/null; then
    function battery_info() {
        # For simplicity, stop after the first entry.
        acpi -b | awk '/^Battery/ {print $3, $4; exit}' |
        sed -e 's_Charging,_+_'    -e 's_Full,_1_'    \
            -e 's_Discharging,_-_' -e 's_Unknown,_0_' \
            -e 's_%,\?__'
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

        # Charging indicator
        local ch
        case $state in
            +) ch="%{%B%F{yellow}%}⚡%{%b%f%}" ;;
            -) ch="%{%F{red}%}-%{%b%f%}"      ;;
            *) return                         ;;
        esac

        # Text colour
        local col
        if   [[ "$charge" -ge "84" ]]; then
            col="%B%F{green}"
        elif [[ "$charge" -ge "67" ]]; then
            col="%F{green}"
        elif [[ "$charge" -ge "51" ]]; then
            col="%B%F{yellow}"
        elif [[ "$charge" -ge "34" ]]; then
            col="%F{yellow}"
        elif [[ "$charge" -ge "17" ]]; then
            col="%B%F{red}"
        else
            col="%F{red}"
        fi

        echo " [%{$col%}$charge%%%{%b%f%}]$ch"
    }

else
    # Define a no-op function if no battery information is available.
    function prompt_battery() {}
fi
