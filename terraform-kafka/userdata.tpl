#!/usr/bin/env bash
sudo sysctl vm.swappiness=${swapvalue}
sudo sysctl vm.swappiness > /tmp/done.txt
sudo chmod 755 /tmp/done.txt