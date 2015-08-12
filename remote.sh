#!/bin/bash
echo "$1" | sudo -S apt-get update -y
echo "$1" | sudo -S apt-get upgrade -y
echo "$1" | sudo -S apt-get dist-upgrade -y
echo "$1" | sudo -S apt-get autoremove -y
echo "$1" | sudo -S apt-get clean
if [ -f /var/run/reboot-required ]; then
  if [ "$2" -eq 1 ]; then
    echo "Autoreboot enabled, will reboot now."
    echo "$1" | sudo -S reboot
  elif [ "$2" -eq 2 ]; then
    rebootBool=0;
    while [ $rebootBool -eq 0 ]; do
      echo "The newly installed updates require the server to be rebooted, do you wish to reboot this server ($3) now? (yes/no):"
      read reboot

      if [ "$reboot" == "yes" ] || [ "$reboot" == "y" ]; then
        rebootBool=1;
        echo "$1" | sudo -S reboot
      elif [ "$reboot" == "no" ] || [ "$reboot" == "n" ]; then
        rebootBool=1;
        echo
        echo "Updates installed but might not be applied until a reboot takes place."
      else
        echo
        echo "$reboot is not a valid response."
      fi
    done
  elif [ "$2" -eq 3 ]; then
    echo "Autoignore enabled, will ignore reboot."
    echo "Updates installed but might not be applied until a reboot takes place."
  fi
else
  echo "Reboot not required"
fi
