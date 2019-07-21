#!/bin/sh

dbus-send --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval "string:global.reexec_self()"

