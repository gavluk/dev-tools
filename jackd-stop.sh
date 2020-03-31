#!/bin/sh

ps auxw | grep [j]ackd | awk '{ print $2}' | xargs kill -9

