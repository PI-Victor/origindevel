Vagrant Fedora 23 openshift Origin V3.  
---
This is an unofficial vagrant Fedora23 Image for openshift origin V3 development.  
It works with VirtualBox 5 and it's recommended to be used with the vagrant [vbguest plugin](https://github.com/dotless-de/vagrant-vbguest/).


An already compiled and working vagrant box is already available at

Prerequisites:
If you didn't compile origin so far then in your openshift repo do `make clean install`.
The ansible

This will mount your current `$GOPATH/src/` inside the guest at `/data/src`.

The ansible script also tries to install openshift as a service inside the guest and assumes that you have your openshift binaries in



Dev Stuff
---
I suggest using `tmux` with a different split that outputs the logs while working.
you can run it with `journalctl -f -u openshift`.
