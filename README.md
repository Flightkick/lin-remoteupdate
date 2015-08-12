# lin-remoteupdate
These scripts can update multiple remote Linux machines over SSH.
Currently only works on servers which support apt-get.

## Prerequisites
The scripts require sshpass (http://sourceforge.net/projects/sshpass/).
```
Ubuntu/Debian: apt-get install sshpass
Fedora/CentOS: yum install sshpass
Arch: pacman -S sshpass
```

## Usage instructions
1. Download the files to your Linux computer (not the server)
2. Install the prerequisites (see above)
2. Enable file execution permissions on local.sh if applicable
3. Open a terminal and run local.sh
4. Enter the IP's/Hostnames of the servers you would like to update, seperated by a semicolon (;)
5. Enter a sudoers account name
6. Enter the specified account's password
7. Choose the mode to run in:
  * 1 = Auto restart when required
  * 2 = Promt if restart is required
  * 3 = Ignore (do not restart)
8. Profit!

## What does it do?
The local script opens a SSH tunnel to the remote server and does the following:
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean

After that the script will check if the machine requires a reboot, depending on your choices when running local.sh it will either automatically restart, prompt for restart or ignore the restart.
