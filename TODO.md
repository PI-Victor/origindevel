Remove cached files -done  
Setup Origin for easy start 
Setup tests for easy start (filter them) -done  

Install rpm-fusion free and non free for virtualbox 5 with guest additions for 5 and the rest of the kernel headers  - done  
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'