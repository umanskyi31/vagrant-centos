Issues:
 - How to fixed error 
 ```
 Using a SSH password instead of a key is not possible because Host Key checking is enabled and sshpass does not support this.  Please add this host's fingerprint to your known_hosts file to manage this host.
 ```
 Firstly, you should try to connect via ssh to virtual machine. In current example this will be like this:
 ```
    -> ssh vagrant@192.168.33.33
    -> password: vagrant
    -> ECDSA key fingerprint is SHA256:nNG8sjDjMtXDByqEal/rOMkuhUpgBwt3Mp8+o7djTno.
       Are you sure you want to continue connecting (yes/no)? yes
 ``` 
 After that SHA256 will add to your know_hosts and you can work with playbook directly.
 