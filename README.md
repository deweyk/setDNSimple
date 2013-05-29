setDNSimple
===========

This is a script that sets a Dynamic DNS with DNSimple, to be used with Tomato USB router.

The script pulls the user's current IP address and applies the changes using the DNSimple API.

Make sure that you've added your desired subdomain with proper A record on DNSimple's dashboard. (i.e. vpn.yourdomain.com -> XXX.XXX.XXX.XXX)


===========
##To set up DNSimple-based router set up.


#Set up /opt on JFFS, and auto-mount /opt
1. On Tomato dashboard, Administration > JFFS > Enable
2. Administration > Scripts > Init
#This allows mounting of /opt upon restart
mount -o bind /jffs/opt /opt
3. df in SSH to check if the /opt partition's been mounted.


#Install Optware to allow IPKG and CURL
1. Ref: [How to set up NAS optware, etc for total noobs](http://tomatousb.org/tut:how-to-set-up-nas-optware-etc-for-total-noobs#6)
#install optware
wget http://tomatousb.org/local--files/tut:optware-installation/optware-install.sh -O - | tr -d '\r' > /tmp/optware-install.sh
chmod +x /tmp/optware-install.sh
sh /tmp/optware-install.sh
sleep 5
ipkg update
sleep 5


#Installing setDNSimple.sh
1. Set up Tomato Router
2. Using TextWrangler, modify setDNSimple.sh with appropriate account information for DNSimple.
3. Copy setDNSimple.sh to the router.
- SSH into the router [Using SSH on Tomato without passwords](http://tomatousb.org/forum/t-619135/guide-using-ssh-on-tomato-without-passwords-win-mac)
- Create /tmp/home/root/bin/
> mkdir /tmp/home/root/bin/
- scp <local location> root@<ip>:/tmp/home/root/bin/
4. Make sure the script works properly.
> sh /tmp/home/root/bin/setDNSimple.sh

#Add setDNSimple.sh to be included in NVRAM for when the router restarts.
> nvram setfile2nvram /tmp/home/root/bin/setDNSimple.sh
> nvram commit
> reboot


#Add Cron job to execute setDNSimple.sh every 15 mins
> [DNSimple Dynamic DNS guide](http://jasonseifer.com/2011/04/04/auto-update-ip-dnsimple)
1. Access cron file at /var/spool/cron/crontabs/
2. vi root
- i for edit, when complete, esc twice then :x or ZZ to exit.
3. 
*/15 * * * * /home/root/bin/setDNSimple.sh
