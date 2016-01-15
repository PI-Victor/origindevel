Vagrant Fedora 23 openshift Origin V3.  
---
** In active development.  **  
This is an unofficial vagrant Fedora23 Image for openshift origin V3 development.
It works with VirtualBox 5 and it's recommended to be used with the vagrant [vbguest plugin](https://github.com/dotless-de/vagrant-vbguest/).


Pre-built: Vagrant machine

An already compiled and working vagrant box is already available at:

Prerequisites:
If you didn't compile origin so far then in your openshift repo do `make clean install`.
The ansible config assumes you have the binaries in `{{origin_bin_path}}/`, See [vars/all](vars/all) to change that path in case you have a different arch.
This will mount your current `$GOPATH/src/` inside the guest at `/data/src`.

Dev Stuff
---
See openshift logs only with `journalctl -f -u openshift`, i suggest using `tmux` with a different split/window that outputs the logs while working.  

When you provision the vagrant machine if you want to turn verbose mode down for ansible you can do `export ANSIBLE_VERBOSE='v'`.  
