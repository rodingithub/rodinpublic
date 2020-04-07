#!/bin/bash

FILE=/usr/local/ltechagent/uninstaller.sh
if [ -f "$FILE" ]; then
    echo "$FILE exists"
	cd /usr/local/ltechagent
	./uninstaller.sh
else 
    echo "$FILE does not exist"
fi

sleep 30
rm -rd /tmp/ltech
mkdir /tmp/ltech
wget -O /tmp/ltech/agent.zip  https://automate.rodin.com.au/LabTech/Deployment.aspx?LINUX=4
unzip -o ./agent.zip
cd /tmp/ltech/LTechAgent
chmod +x install.sh
exec "/tmp/ltech/LTechAgent/install.sh"