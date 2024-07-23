# #!/bin/bash

# display_help() {
#     echo "Usage: devopsfetch [option] [argument]"
#     echo
#     echo "   -p, --port [port_number]      Display active ports"
#     echo "   -d, --docker [container_name] Display Docker information"
#     echo "   -n, --nginx [domain]          Display Nginx information"
#     echo "   -u, --users [username]        Display user information"
#     echo "   -t, --time [start] [end]      Display activities within time range"
#     echo "   -h, --help                    Display help"
#     echo
# }

# case $1 in
#     -p|--port)
#         devopsfetch_ports $2
#         ;;
#     -d|--docker)
#         devopsfetch_docker $2
#         ;;
#     -n|--nginx)
#         devopsfetch_nginx $2
#         ;;
#     -u|--users)
#         devopsfetch_users $2
#         ;;
#     -t|--time)
#         devopsfetch_time $2 $3
#         ;;
#     -h|--help)
#         display_help
#         ;;
#     *)
#         echo "Invalid option"
#         display_help
#         ;;
# esac


#!/bin/bash

display_help() {
    echo "Usage: devopsfetch [option] [argument]"
    echo
    echo "   -p, --port [port_number]      Display active ports"
    echo "   -d, --docker [container_name] Display Docker information"
    echo "   -n, --nginx [domain]          Display Nginx information"
    echo "   -u, --users [username]        Display user information"
    echo "   -t, --time [start] [end]      Display activities within time range"
    echo "   -h, --help                    Display help"
    echo
}

fetch_ports() {
    if [[ -z $1 ]]; then
        sudo netstat -tuln
    else
        sudo netstat -tuln | grep ":$1"
    fi
}

fetch_docker() {
    if [[ -z $1 ]]; then
        docker ps -a
    else
        docker inspect $1
    fi
}

fetch_nginx() {
    if [[ -z $1 ]]; then
        sudo nginx -T
    else
        sudo nginx -T | grep -A 10 "server_name $1"
    fi
}

fetch_users() {
    if [[ -z $1 ]]; then
        lastlog
    else
        lastlog | grep $1
    fi
}

fetch_time_range() {
    journalctl --since="$1" --until="$2"
}

case $1 in
    -p|--port)
        fetch_ports $2
        ;;
    -d|--docker)
        fetch_docker $2
        ;;
    -n|--nginx)
        fetch_nginx $2
        ;;
    -u|--users)
        fetch_users $2
        ;;
    -t|--time)
        fetch_time_range $2 $3
        ;;
    -h|--help)
        display_help
        ;;
    *)
        echo "Invalid option"
        display_help
        ;;
esac



