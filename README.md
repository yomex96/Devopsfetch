# devopsfetch 

## Introduction

`devopsfetch` is a tool for DevOps professionals to collect and display system information. It retrieves details on active ports, user logins, Nginx configurations, Docker images, and container statuses. The tool also includes a systemd service to monitor and log these activities continuously.

### Features

1. **Ports**
   - Display all active ports and services.
   - Provide detailed information about a specific port.
2. **Docker**
   - List all Docker images and containers.
   - Provide detailed information about a specific container.
3. **Nginx**
   - Display all Nginx domains and their ports.
   - Provide detailed configuration information for a specific domain.
4. **Users**
   - List all users and their last login times.
   - Provide detailed information about a specific user.
5. **Time Range**
   - Display activities within a specified time range.

### Installation

To install `devopsfetch`, follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/yomex96/Devopsfetch.git
    cd devopsfetch
    ```

2. Run the installation script:
    ```sh
    ./install.sh
    ```

The installation script will:
- Install necessary dependencies.
- Set up a systemd service for continuous monitoring and logging.

## Usage

### Command-Line Flags

- `-p` or `--port`: Display all active ports and services.
  - Example: `devopsfetch -p`
  - Example: `devopsfetch -p 8080`

- `-d` or `--docker`: List all Docker images and containers.
  - Example: `devopsfetch -d`
  - Example: `devopsfetch -d container_name`

- `-n` or `--nginx`: Display all Nginx domains and their ports.
  - Example: `devopsfetch -n`
  - Example: `devopsfetch -n domain.com`

- `-u` or `--users`: List all users and their last login times.
  - Example: `devopsfetch -u`
  - Example: `devopsfetch -u username`

- `-t` or `--time`: Display activities within a specified time range.
  - Example: `devopsfetch -t "2024-07-01 00:00:00" "2024-07-01 23:59:59"`

- `-h` or `--help`: Display help information.

### Examples

1. Display all active ports:
    ```sh
    devopsfetch -p
    ```

2. Get details of a specific port (e.g., port 8080):
    ```sh
    devopsfetch -p 8080
    ```

3. List all Docker images and containers:
    ```sh
    devopsfetch -d
    ```

4. Get details of a specific Docker container (e.g., container_name):
    ```sh
    devopsfetch -d container_name
    ```

5. Display all Nginx domains and their ports:
    ```sh
    devopsfetch -n
    ```

6. Get details of a specific Nginx domain (e.g., domain.com):
    ```sh
    devopsfetch -n domain.com
    ```

7. List all users and their last login times:
    ```sh
    devopsfetch -u
    ```

8. Get details of a specific user (e.g., username):
    ```sh
    devopsfetch -u username
    ```

9. Display activities within a specified time range:
    ```sh
    devopsfetch -t "2024-07-01 00:00:00" "2024-07-01 23:59:59"
    ```

## Continuous Monitoring

`devopsfetch` can run as a systemd service to continuously monitor and log activities.

### Enabling the Service

1. Enable the systemd service:
    ```sh
    sudo systemctl enable devopsfetch.service
    ```

2. Start the service:
    ```sh
    sudo systemctl start devopsfetch.service
    ```

### Logs

Logs are stored in `/var/log/devopsfetch.log`. Log rotation is managed to prevent log files from becoming too large.

To view the logs:
```sh
tail -f /var/log/devopsfetch.log
```

## Uninstallation

To uninstall `devopsfetch` and remove the systemd service:

1. Stop and disable the service:
    ```sh
    sudo systemctl stop devopsfetch.service
    sudo systemctl disable devopsfetch.service
    ```

2. Remove the service file and logs:
    ```sh
    sudo rm /etc/systemd/system/devopsfetch.service
    sudo rm /var/log/devopsfetch.log
    ```

3. Remove the `devopsfetch` files:
    ```sh
    sudo rm -r /path/to/devopsfetch
    ```

## Contributing

If you would like to contribute to `devopsfetch`, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Auhtor
Abayomi Robert Onawole

