#!/bin/bash

FILE=/usr/local/ltechagent/uninstaller.sh
if [ -f "$FILE" ]; then
    echo "$FILE exists"
	cd /usr/local/ltechagent
	./uninstaller.sh
else 
    echo "$FILE does not exist"
fi

sleep 10
rm -rf /tmp/ltech
mkdir /tmp/ltech
wget -O /tmp/ltech/agent.zip  https://automate.rodin.com.au/LabTech/Deployment.aspx?LINUX=3
cd /tmp/ltech
unzip -o agent.zip
cd /tmp/ltech/LTechAgent
chmod +x install.sh
cd /tmp/ltech/LTechAgent
./install.sh
rm -rf /tmp/ltech
rm -rf /tmp/reinstall.sh