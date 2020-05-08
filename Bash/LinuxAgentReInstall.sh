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
cd /usr/local/ltechagent/
rm -rf agent_config
echo "server_url automate.rodin.com.au
server_uploads_path /LabTech/Upload.aspx
server_transfers_path /LabTech/Transfer/
ssl no
ssl_verify_cert no
system_password MYP55G21uPXeTP1XdX9pwA==
signin_retry_time 60
location_id 132
log_commands no
log_info no
log_redirectors no
log_server_comm no
log_remote_monitors no
log_tray_comm no
log_heartbeat no
log_telnet_proxy no
log_ssh_proxy no
auto_update yes" > agent_config
sleep 5
service ltechagent start
sleep 5
service ltechagent restart"  > install.sh
chmod +x install.sh
exec "/tmp/install.sh"