#!/bin/bash

myIP=$(bash myIP.bash)


# Todo-1: Create a helpmenu function that prints help for the script

function helpmenu(){
	echo -e "HELP MENU\n-----------\n-n: Add -n as an argument for this script to use nmap\n -n external: External NMAP scan\n -n internal: Internal NMAP scan\n-s: Add -s as an argument for this script to use ss\n -s external: External ss(Netstat) scan\n -s internal: Internal ss(Netstat) scan\nUsage: bash networkchecker.bash -n/-s external/internal\nroot@xubuntu:/\n----------"
}
#helpmenu

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){
# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
 expo=$(ss -ltpn | awk -F"[[:space:]:(),]+" '/^LISTEN.*0.0.0.0/ {print $5, $9}' | tr -d "\"")
    echo "External Listening Ports:"
    echo "$expo"
}

# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
inpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
}



# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu

if [[ $# -lt 2 ]]; then
    helpmenu
    exit 1
fi

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)

while getopts "n:s:h" opt; do
    case $opt in
        n)
            case $OPTARG in
                external)
                    ExternalNmap
                    ;;
                internal)
                    InternalNmap
                    ;;
                *)
                    echo "Invalid argument for -n: $OPTARG"
                    helpmenu
                    exit 1
                    ;;
            esac
            ;;
        s)
            case $OPTARG in
                external)
                    ExternalListeningPorts
                    ;;
                internal)
                    InternalListeningPorts
                    ;;
                *)
                    echo "Invalid argument for -s: $OPTARG"
                    helpmenu
                    exit 1
                    ;;
            esac
            ;;
        h)
            helpmenu
            exit 0
            ;;
        *)
            helpmenu
            exit 1
            ;;
    esac
done
