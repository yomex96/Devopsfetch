#!/bin/bash

LOG_FILE="/var/log/devopsfetch.log"

# Create log file if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    sudo touch "$LOG_FILE"
    sudo chmod 666 "$LOG_FILE"
fi

log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "$LOG_FILE" > /dev/null
}

display_help() {
    log "Displaying help information"
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
    log "Fetching ports with argument: $1"
    if [ -z "$1" ]; then
        sudo netstat -tuln | sudo tee -a "$LOG_FILE"
    else
        sudo netstat -tuln | grep ":$1" | sudo tee -a "$LOG_FILE"
    fi
}

fetch_docker() {
    log "Fetching Docker information for: $1"
    if [ -z "$1" ]; then
        docker ps -a | sudo tee -a "$LOG_FILE"
    else
        docker inspect "$1" | sudo tee -a "$LOG_FILE"
    fi
}





fetch_nginx_info() {
    domain=$1

    if [[ -z $domain ]]; then
        # Display all Nginx domains and their ports in a tabular format
        echo -e "Domain\tPort"
        nginx -T 2>/dev/null | grep -E "server_name|listen" | \
        sed 'N;s/\n/ /' | \
        sed 's/server_name //g; s/listen //g; s/;//g' | \
        column -t
    else
        # Provide detailed configuration information for a specific domain
        echo "Detailed configuration for domain: $domain"
        sudo grep -A 20 "server_name $domain" /etc/nginx/sites-available/* /etc/nginx/nginx.conf
    fi
}




fetch_users() {
    log "Fetching user information for: $1"
    if [ -z "$1" ]; then
        lastlog | sudo tee -a "$LOG_FILE"
    else
        lastlog | grep "$1" | sudo tee -a "$LOG_FILE"
    fi
}

fetch_time_range() {
    log "Fetching logs from $1 to $2"
    journalctl --since="$1" --until="$2" | sudo tee -a "$LOG_FILE"
}

case "$1" in
    -p|--port)
        fetch_ports "$2"
        ;;
    -d|--docker)
        fetch_docker "$2"
        ;;
    -n|--nginx)
	 fetch_nginx_info $2
        ;;
    -u|--users)
        fetch_users "$2"
        ;;
    -t|--time)
        fetch_time_range "$2" "$3"
        ;;
    -h|--help)
        display_help
        ;;
    *)
        log "Invalid option provided: $1"
        echo "Invalid option"
        display_help
        ;;
esac

