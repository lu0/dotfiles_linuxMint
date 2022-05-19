#!/usr/bin/env bash

alias ipinfo="curl ipinfo.io"

gp-vpn() {
    usage() {
        echo
        echo "Wrapper for the Global Protect VPN scripts :D"
        echo
        echo "Usage: gp-vpn [-u|d|c|s]"
        echo
        echo "Options:"
        echo "   -u     Up: start the VPN."
        echo "   -d     Down: stop the VPN."
        echo "   -c     Connect: connect to the server."
        echo "   -s     Status: status of the tunnel."
        echo
    }
    down() {
        sudo ${HOME}/loads/installers-linux/global-protect-ta/gp-ui/lu-stop.sh
    }
    PASSED_OPT="true"
    local OPTIND=1
    while getopts :udcs opt; do
        case $opt in
        u)
            down && echo -n 'F%#9HyPo38N/4p' | setclip && \
            sudo ${HOME}/loads/installers-linux/global-protect-ta/gp-ui/lu-start.sh && >> /dev/null
            return
            ;;
        d)
            down
            return
            ;;
        c)
            nc -zw1 192.168.16.72 22 \
                && ssh -o IdentitiesOnly=yes -i ~/.ssh/ta-frisa-edge root@192.168.16.72 \
                || echo "Not connected, run 'gp-vpn -u' first."
                # && sshpass -p 'Fri$a2021.*-' ssh root@192.168.16.72 \
                # || echo "Not connected, run 'gp-vpn -u' first."
            return
                    ;;
        s)
            nmcli con show --active | grep -i tun
            return
            ;;
        *)
            usage
            return
            ;;
        esac
    done

    PASSED_OPT=
    [ -z "$PASSED_OPT" ] && usage && return
}
