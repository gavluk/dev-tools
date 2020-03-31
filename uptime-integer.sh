#!/bin/sh

uptime | sed -E 's/^.*average: ([0-9]+)[\.\,]([0-9]+).*/\1\.\2\*100/g' | bc | sed -E 's/([0-9]+).*/\1/g'

