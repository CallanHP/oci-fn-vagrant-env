#!/bin/sh
#Create a temporary replacement file for sed
sed -e 's/\//\\\//g' -e '/^#/d' -e '/^$/d' -e 's/^/s\/{/g' -e 's/=/}\//g' -e 's/$/\//g' /vagrant/config.sh > /tmp/replace.sed

#Write the oci config file (using the template)
mkdir ~/.oci
sed -f /tmp/replace.sed /vagrant/.oci/config_template > ~/.oci/config

#Write the oci-curl file (using the template)
sed -f /tmp/replace.sed /vagrant/.oci/oci-curl_template > ~/.oci/oci-curl.sh

chmod +x ~/.oci/oci-curl.sh

rm /tmp/replace.sed

