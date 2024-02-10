# DNS server build
# Description:
This script sets up a Raspberry Pi to act as a DNS server with Pi-hole-like functionality and a local Apache server for displaying an access denied page. 
It configures dnsmasq to forward DNS queries to OpenDNS servers while allowing for the blocking of specific domains and logging DNS queries. 
Additionally, it creates a visually appealing access denied page with a Matrix-style effect using HTML and JavaScript.

# Usage:
This script is useful for individuals who want to have control over DNS resolution on their network, allowing them to block specific domains (such as ads, trackers, or malicious sites) and log DNS queries for analysis. It also provides a customizable access denied page that is displayed when a blocked domain is accessed. This setup can be particularly beneficial for enhancing privacy, security, and control over internet access on home networks or small business environments.

# Process Overview:

Package Installation: The script begins by updating the package repositories and installing the necessary packages (dnsmasq and apache2) for setting up the DNS and Apache servers.

Dnsmasq Configuration: Dnsmasq is configured to act as the DNS server, forwarding DNS queries to OpenDNS servers (208.67.222.222 and 208.67.220.220). Query logging is enabled to log DNS queries for analysis.

Apache Server Setup: The script sets up a local Apache server with a document root at /var/www/html. An HTML access denied page with a Matrix-style effect is created and placed in the document root.

Restart Services: After configuring both dnsmasq and Apache, the script restarts both services to apply the changes.

# Usage:
Once the script has been executed, the Raspberry Pi acts as a DNS server for the network, allowing users to control DNS resolution and block specific domains. When a blocked domain is accessed, the access denied page with the Matrix-style effect is displayed, providing a visual indication of the blocked request.

Overall, this script provides a straightforward way to set up a DNS server with advanced functionality and a customizable access denied page on a Raspberry Pi, offering enhanced control and monitoring capabilities over network DNS traffic.
