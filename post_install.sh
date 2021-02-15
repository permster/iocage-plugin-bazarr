#!/bin/sh

# Download latest v3 release
fetch $(curl -s https://api.github.com/repos/morpheus65535/bazarr/releases/latest | grep tarball_url | cut -d '"' -f 4) -o /usr/local/share/tmp.tar.gz
mkdir -p /usr/local/share/bazarr
tar -xzvf /usr/local/share/tmp.tar.gz -C /usr/local/share/bazarr --strip-components=1
rm /usr/local/share/tmp.tar.gz

# install required pip packages
yes | pip-3.7 install -r /usr/local/share/bazarr/requirements.txt

# Create user
pw user add bazarr -c bazarr -u 1056 -d /nonexistent -s /usr/bin/nologin

# make "bazarr" the owner of the install location
mkdir /config
chown -R bazarr:bazarr /usr/local/share/bazarr /config

#Set write permission to be able to write plugins update
chmod 755 /usr/local/share/bazarr

# Start the services
chmod u+x /etc/rc.d/bazarr
sysrc -f /etc/rc.conf bazarr_enable="YES"
service bazarr start

echo "Bazarr successfully installed" > /root/PLUGIN_INFO
