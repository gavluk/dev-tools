#!/bin/sh

ps auxw | grep [j]ava | awk '{print $2}' | xargs kill -9