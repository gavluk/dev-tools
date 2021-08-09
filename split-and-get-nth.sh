#!/bin/bash

#set -x 
tr "${1}" "\n" | sed -n "${2}p"

