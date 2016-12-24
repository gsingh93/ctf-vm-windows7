# Windows 7 CTF VM

This is a Windows 7 SP1 VM for use with CTF challenges that require Windows. For Ubuntu 14.04 and 16.04 VMs for CTFs, check out my [other repo](https://github.com/gsingh93/ctf-vm).

# Building

[Packer](https://www.packer.io/) is required to build the base image. Run the following command,

```
packer build windows_7.json
```

This will build a Windows 7 SP1 base image with VirtualBox guest tools and Chocolatey installed. Note that this will take some time.

If you do not require SP1, you can remove `./scripts/sp1.ps1` from `windows_7.json` to significantly speed up the build. Note that some tools (like Visual Studios), require at least SP1.

# Running

Once the image is built, you'll see a `windows_7_virtualbox.box`. If you want to use this directly with VirtualBox, you can extract an OVF file from it and import it into VirtualBox. I like to use `vagrant` to provision it, so we can just run `vagrant up`. This will bring the machine up, install some packages with Chocolatey, and pin/unpin some programs on the taskbar.

# Mounts

By default, the folder containing the `Vagrantfile` will be mounted to `C:\vagrant`. If the `CTF_PATH` environment variable is set, that will be mounted to `C:\Users\vagrant\ctf`.
