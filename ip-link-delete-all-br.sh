#!/bin/bash

sudo ip link ls | grep br- | sed -E 's/.*(br-.*):.*/\1/g' | xargs -n 1 sudo  ip link delete

