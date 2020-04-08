#!/bin/bash

FILE=/usr/local/ltechagent/uninstaller.sh
if [ -f "$FILE" ]; then
    echo "$FILE exists"
	cd /usr/local/ltechagent
	exec "/tmp/uninstaller.sh"
else 
    echo "$FILE does not exist"
fi

wget -O /tmp/install.sh https://raw.githubusercontent.com/rodingithub/rodinpublic/master/Bash/LinuxAgentReInstall.sh
sleep 30

cd /tmp
echo "#!/bin/bash
sleep 5
rm -rf /tmp/ltech
mkdir /tmp/ltech
wget -O /tmp/ltech/agent.zip  https://automate.rodin.com.au/LabTech/Deployment.aspx?LINUX=3
cd /tmp/ltech
unzip -o agent.zip
cd /tmp/ltech/LTechAgent
./install.sh
rm -rf /tmp/ltech"  > install.sh
chmod +x install.sh
exec "/tmp/install.sh"