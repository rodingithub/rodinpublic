#!/bin/bash

# Pusae to make sure the old agent is retired from Automate.
sleep 15

service ltechagent stop

FILE=/usr/local/ltechagent/uninstaller.sh
if [ -f "$FILE" ]; then
    echo "$FILE exists"
	cd /usr/local/ltechagent
	./uninstaller.sh
else 
    echo "$FILE does not exist"
fi

sleep 5
rm -rf /tmp/install.sh
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
wget -O /usr/local/ltechagent/computer_config https://raw.githubusercontent.com/rodingithub/rodinpublic/master/Bash/computer_config
rm -rf /tmp/ltech
sleep 5
service ltechagent start"  > install.sh
chmod +x install.sh
exec "/tmp/install.sh"