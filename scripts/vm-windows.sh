#!/bin/bash

# Start the Windows VM
# github.com/lu0

DETECTED_WIN_VM=$(vboxmanage list vms | grep -i windows | cut -d "{" -f2 | cut -d "}" -f1)

virtualboxvm --startvm "{$DETECTED_WIN_VM}"
 