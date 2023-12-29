#!/bin/sh

if ! command -v gdb &> /dev/null
then
  echo "install gdb by running the brew install script first."
  exit 1
fi

codesign --entitlements ./Library/gdb-entitlement.xml -fs gdb-cert $(which gdb)

sudo killall taskgated

echo check if the 'taskgated' service restarted, using ps $(pgrep -f taskgated)
echo if the service hasn\'t restarted, manually restart the mac




