#!/usr/bin/env bash

# This is used to install ansible dep inside the vm

sudo dnf install -y python python-dnf \
                    http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
                    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
