#!/usr/bin/bash

ignore_option=""

while read line ; do
    if [ ! -z "$line" ]; then
        echo "Text read from file: $line"
        ignore_option="-i $line $ignore_option"
    fi
done < "/etc/opengrok/config"

echo "Ignore option:$ignore_option"


cmd="java \
-Djava.util.logging.config.file=/opt/opengrok/etc/logging.properties \
-jar /opt/opengrok/dist/lib/opengrok.jar \
-c /usr/local/bin/ctags \
-s /opt/opengrok/src \
-d /opt/opengrok/data \
-P --progress \
-W /opt/opengrok/etc/configuration.xml \
-U http://localhost:8080/source \
$ignore_option "


$cmd

sudo rm -rf /opt/tomcat/apache-tomcat-10.0.27/temp/opengrok*


