# ddns-updater

The Digitalocean ddns updater is meant to be run as a script from the command line.  There are two parameters -d for the domain to be updated and -t for your Digitalocean api token

Example crontab usage that would run every four hours:
0 */4 * * *  /home/moshguy/ddns-updater/digitalocean-ddns-updater.sh -d {$YOUR_DOMAIN} -t {$YOUR_TOKEN} > /var/log/digitalocean-ddns.log  2>&1
