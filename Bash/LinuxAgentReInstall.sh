#!/bin/bash

FILE=/usr/local/ltechagent/uninstaller.sh
if [ -f "$FILE" ]; then
    echo "$FILE exists"
	cd /usr/local/ltechagent
	./uninstaller.sh
else 
    echo "$FILE does not exist"
fi

sleep 5

cd /tmp
echo "#!/bin/bash
sleep 5
rm -rf /tmp/ltech
mkdir /tmp/ltech
wget -O /tmp/ltech/agent.zip  https://automate.rodin.com.au/LabTech/Deployment.aspx?LINUX=4
cd /tmp/ltech
unzip -o agent.zip
cd /tmp/ltech/LTechAgent
chmod +x install.sh
./install.sh
rm -rf /tmp/ltech"  > install.sh
chmod +x install.sh
exec "/tmp/install.sh"
sleep 30
rm -rf /tmp/install.sh

service ltechagent start