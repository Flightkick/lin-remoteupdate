#!/bin/bash
hostReachable=0;
IFS=";"
while [ "$hostReachable" -eq 0 ]; do
  echo "Please enter the IP/Hostname of the server you would like to update. You can enter multiple hosts semicolon (;) separated:"
  read hostlist
  for host in $hostlist
  do
    if ! ping -c 1 "$host" &> /dev/null
    then
      echo "ERROR: The specified IP/Hostname ($host) is unreachable."
      hostReachable=0;
      break
    else
        hostReachable=1;
    fi
  done
done

echo "Please enter the account name you would like to log in with:"
read user

echo "Please enter the password for the specified user account:"
read -s -p Password: pass
echo

echo "When new updates have been installed a server might need a restart, you can run this updater in various modes:"
echo "1 = Automatically reboot when needed"
echo "2 = Ask me if I would like to reboot"
echo "3 = Automatically ignore the need to reboot"
echo
echo "Please choose the mode you would like to run. (1, 2, 3):"

rebootBool=0;
while [ $rebootBool -eq 0 ]; do
  read rebootInt
  if [ "$rebootInt" == "1" ] || [ "$rebootInt" == "2" ] || [ "$rebootInt" == "3" ]; then
    rebootBool=1;
  else
    echo "No valid response. (1, 2, 3):"
  fi
done

echo "Starting routine..."
echo

for host in $hostlist
do
  sshpass -p "$pass" ssh "$host" -l "$user" -o StrictHostKeyChecking=no "bash -s $pass $rebootInt $host" < remote.sh
done

echo
echo "Script finished!"
