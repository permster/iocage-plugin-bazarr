#!/bin/sh

# Clone from git repo
git clone https://gitlab.com/LazyLibrarian/LazyLibrarian.git /usr/local/share/LazyLibrarian

# Create user
pw user add lazylibrarian -c lazylibrarian -u 488 -d /nonexistent -s /usr/bin/nologin

# make "lazylibrarian" the owner of the install location
mkdir /config
chown -R lazylibrarian:lazylibrarian /usr/local/share/LazyLibrarian /config

#Set write permission to be able to write plugins update
chmod 755 /usr/local/share/LazyLibrarian

# Start the services
chmod u+x /etc/rc.d/lazylibrarian
sysrc -f /etc/rc.conf lazylibrarian_enable="YES"
service lazylibrarian start

echo "LazyLibrarian successfully installed" > /root/PLUGIN_INFO
