#!/bin/bash
cd /usr/local/ltechagent
sh ./uninstaller.sh
mkdir /tmp/ltech
cd /tmp/ltech
wget -O agent.zip  https://automate.rodin.com.au/LabTech/Deployment.aspx?LINUX=4
unzip ./agent.zip
cd /tmp/ltech/LTechAgent
chmod +x install.sh
sh ./install.sh