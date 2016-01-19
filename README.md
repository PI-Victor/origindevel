Vagrant Fedora 23 Openshift Origin V3.  
---
**In active development**  
This is an unofficial vagrant Fedora23 Image for openshift origin V3 development.
It works with VirtualBox 5 and it's recommended to be used with the vagrant [vbguest plugin](https://github.com/dotless-de/vagrant-vbguest/).  
This image is based on [`boxcutter/fedora23`](https://atlas.hashicorp.com/boxcutter/boxes/fedora23) vagrant image.  


#### Pre-provisioned machine on atlas:
---
Will be available soon:  

```
vagrant init codeflavour/f23origindevel
vagrant up
```

#### Prerequisites:
---
If you didn't compile origin so far then in your openshift repo do `make clean install`.  
When provisioning the vagrant machine you can also turn verbose lower with `export ANSIBLE_VERBOSE='v'`.  
The ansible config assumes you have the binaries in `{{origin_bin_path}}/`.   
See [vars/all](vars/all) to change that path in case you have a different arch.  
This will mount your current `$GOPATH/src/` inside the guest at `/data/src/`.

#### Origin V3 development
---
* `vagrant up`
* Code.
* `make clean install` recompile `openshift` with the latest changes you made.
It's encouraged to `make clean install` on your host because of vboxfs is slow and compiling inside the guest would take longer.
* `sudo service openshift restart` inside the vagrant machine.
* you can see the logs from openshift server inside the vagrant machine with `journalctl -f -u openshift`  
* For the origin UI go to: [https://localhost:8443](https://localhost:8443).
* if for some reason the `openshit` service didn't start, `sudo service openshift restart`.

#### Before using oc:  

(These steps will be automated later)  
* `source /scripts/1-export-config` set config ENV variables for openshift. - needs to be set everytime you log in.  
* `/scripts/2-create-registry-and-router` - creates a registry and router, needs to be run only once.  
* `/scripts/3-create-project` - creates a demo project username is `demo` pass: `a`.
* `/scripts/4-create-image-streams` - creates most used image streams.  

Besides exporting the config, the rest of the commands need to be run once. If you
use `/scripts/cleanup` then you need to run all of the scripts again.

#### Example
---
```
Last login: Tue Jan 19 09:48:19 2016 from 10.0.2.2
Welcome to your Packer-built virtual machine.
[vagrant@origindevel ~]$ source /scripts/1-export-config
Exported KUBECONFIG and CURL_CA_BUNDLE.
Done.
[vagrant@origindevel ~]$ /scripts/2-create-registry-and-router
Adding view role to 'demo' user in the default namespace ...
Creating Docker registry ...
DeploymentConfig "docker-registry" created
Service "docker-registry" created
Creating router ... skipped: missing service account setup
Done.
[vagrant@origindevel ~]$ /scripts/3-create-project
Creating project 'demo' ...
Now using project "demo" on server "https://10.0.2.15:8443".

You can add applications to this project with the 'new-app' command. For example, try:

    $ oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-hello-world.git

to build a new hello-world application in Ruby.
Done.
[vagrant@origindevel ~]$ /scripts/4-create-image-streams
Creating image streams ...
imagestream "ruby" created
imagestream "nodejs" created
imagestream "perl" created
imagestream "php" created
imagestream "python" created
imagestream "wildfly" created
imagestream "mysql" created
imagestream "postgresql" created
imagestream "mongodb" created
imagestream "jenkins" created
Done.
[vagrant@origindevel ~]$ oc login
Authentication required for https://10.0.2.15:8443 (openshift)
Username: demo
Password:
Login successful.

You have access to the following projects and can switch between them with 'oc project <projectname>':

  * default
  * demo (current)
  * openshift

Using project "demo".
```
#### Extras
---
Every time you change something in the buildconfig of the openshift server, you need to rebuild the builder images. The official way is to do a `hack/hack/build-base-images.sh`, if you wan to save time on that, you can just do `/scripts/extras/rebuild-docker-builder` or `/scripts/extras/rebuild-s2i-builder`.    
If you want to cleanup your openshift generated files and containers
`/scripts/cleanup` and `/scripts/docker-cleanup` and do `sudo service openshift restart` so that openshift generates a new config to work with.  
Paranoid mode: you can also remove all containers and all images  with the following commands:  
running and non-running containers  
```
for i in `docker ps -a | grep -v CREATED | awk '{print $1}'`; do docker rm -f $i; done
```
and present docker images:  
```
for i in `docker images | grep -v IMAGE | awk '{print $3}'`; do docker rmi $i; done
```
**Remeber this will remove all images, so if you rebuilt your builder images to update the code, you need to do that again after this.**  
