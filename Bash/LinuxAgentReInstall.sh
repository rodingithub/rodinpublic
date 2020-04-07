#!/bin/bash
cd /usr/local/ltechagent
exec  "/usr/local/ltechagent/uninstaller.sh"
sleep 30
mkdir /tmp/ltech
cd /tmp/ltech
wget -O agent.zip  https://automate.rodin.com.au/LabTech/Deployment.aspx?LINUX=4
unzip -o ./agent.zip
cd /tmp/ltech/LTechAgent
chmod +x install.sh
exec "/tmp/ltech/LTechAgent/install.sh"