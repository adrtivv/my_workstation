**susceptible to changes**

# About
I make use of a combination of [ansible playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html) and [chezmoi](https://www.chezmoi.io/)
to automate backup/restore functionality for my personal workstation.

# Playbooks
There are two playbooks included in this repo both of which accomplish opposite tasks. They are:-

## backup

Its main job is to back up files/directories on my local filesystem inside tarballs(.tar files), which I just store in my usb drive. One example would be the browser's config
and cache files so that I can have the browser restored on the newer workstation in the exact same state it was at the time of backup without having to do it all again.

Run the script `init.sh` and select the backup option to kick off the backup process.

## restore

Its job is to automate almost all things I have to do to get the workstation reinstated to my desired state. Along with tasks for restoring the backups made by
the backup job, it includes a lot of other automation tasks as well. One example would be installing packages.

Run the script `init.sh` and select the restore option to kick off the restore process.
