Remove cached files -done  
Setup Origin for easy start - done
Setup tests for easy start (filter them)

Install rpm-fusion free and non free for virtualbox 5 with guest additions for 5 and the rest of the kernel headers  - done  
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'   -done  


make $OPTIONS in .service work - done  

separate dnf update and install from setting the image up so that it reloads the vagrant machine with the new kernel images - done

make openshift installation separate from base and make it compatible with the centos vps
