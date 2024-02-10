#!/bin/bash

# install required packages
sudo apt-get update
sudo apt-get install -y dnsmasq apache2

# gets ip variable for dns servers
ipVariable=$(ip route get 1 | awk '{print $7}')

# Configure dnsmasq 12:listen Ip. 13-14:OPENDNS servers 15-16:log location 17-18:block list
sudo tee -a /etc/dnsmasq.conf > /dev/null <<EOT
listen-address=$ipVariable
server=208.67.222.222
server=208.67.220.220
log-queries
log-facility=/var/log/dns.log
address=/*porn*/127.0.0.1
address=/*facebook*/127.0.0.1
EOT


# set up local Apache server with access denied page
sudo mkdir -p /var/www/html
sudo tee /var/www/html/index.html > /dev/null <<EOT
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied</title>
    <style>
        body {
            background-color: black;
            color: green;
            font-family: 'Courier New', Courier, monospace;
            font-size: 20px;
            overflow: hidden;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
        }

        .matrix {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .access-denied {
            position: absolute;
            color: red;
            font-weight: bold;
            font-size: 40px;
            text-align: center;
            top: 50%;
            transform: translateY(-50%);
        }
    </style>
</head>
<body>
    <div class="matrix"></div>
    <div class="access-denied">Access Denied</div>
    <script>
        function createMatrix() {
            const matrix = document.querySelector('.matrix');
            const columns = Math.floor(window.innerWidth / 20);
            const rows = Math.floor(window.innerHeight / 20);
            const columnElements = [];

            for (let i = 0; i < rows; i++) {
                for (let j = 0; j < columns; j++) {
                    const column = document.createElement('span');
                    column.style.position = 'absolute';
                    column.style.left = \`\${j * 20}px\`;
                    column.style.top = \`\${i * 20}px\`;
                    column.textContent = getRandomCharacter();
                    column.style.color = 'green';
                    columnElements.push(column);
                    matrix.appendChild(column);
                }
            }

            animateMatrix(columnElements);
        }

        function animateMatrix(columns) {
            setInterval(() => {
                columns.forEach(column => {
                    column.textContent = getRandomCharacter();
                });
            }, 100);
        }

        function getRandomCharacter() {
            const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[{]}|;:,<.>/?';
            return characters.charAt(Math.floor(Math.random() * characters.length));
        }

        createMatrix();
    </script>
</body>
</html>
EOT

systemctl stop systemd-resolved
systemctl disable systemd-resolved
# restart dnsmasq and Apache
sudo systemctl restart dnsmasq apache2
