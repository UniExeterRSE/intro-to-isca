---
layout: page
title: File Transfer Methods
order: 5
session: 1
length: 20
toc: true
---

## Learning Objectives

At the end of this lesson you will be able to:

- Use `wget` to download files from the Web
- Transfer files using `scp` & `rsync`
- Understand what other data transfer tools Exeter has available for *large* data transfers

## From the Internet

If the data is readily available on the internet, we can use the program `wget` to _get_ files directly from _webpages_.

~~~
username@login02:~$ wget <http-address of file(s)>
~~~
{: .language-bash}

As an example, let's download the [list](http://login02.isca.ex.ac.uk:8080/modules.txt) of installed software modules on ISCA from the cluster's webserver directly into our ISCA home directory.

~~~
wget -P $HOME 'http://login02.isca.ex.ac.uk:8080/modules.txt'
~~~
{: .language-bash}

Open up the text file with your preferred text editor and peruse the contents. This info will be valuable in a later session when we talk about managing software libraries with modules and virtual environments.


## Secure Copy

### The Command Line
When we want to copy files back and forth from the cluster, the standard tool is `scp`, which leverages the same *OpenSSH* protocol as `ssh`. The syntax of `scp` mirrors that of the shell command `cp`
~~~
[you@laptop ~]$ scp <File Source> <Target Destination>
~~~
{: .language-bash}

The three components of a remote machine path `<username>@<hostname>:<filepath>`
1) `username`: your login ID for that machine
2) `hostname`: the remote address for the machine
3) `filepath`: the path to the file on the specified machine

While one can run `scp` commands from either the source or the target, if one is transfering to/from a personal machine, I would recommend running the commands there rather than on the server. 

For example, to copy *modules.txt* from ISCA to the *Downloads* folder on your laptop, run this command on your laptop in either a Unix shell or Windows Powershell terminal, making sure to specify your own `username`.
~~~
[you@laptop ~]$ scp username@login02.isca.ex.ac.uk:~/modules.txt $HOME/Downloads
~~~
{: .language-bash}

### Question
> How would one copy *modules.txt* back from *Downloads* to our home directory on ISCA but with the new name *modules_copy.txt*?
>
> > #### Solution
> > ~~~
> > scp $HOME/Downloads/modules.txt username@login02.isca.ex.ac.uk:~/modules_copy.txt
> > ~~~
> > {: .language-bash}
> {: .solution}
{: .challenge}


    
## GUI interface

FileZilla is a cross-platform client for downloading and uploading files to and from a remote computer. It is absolutely fool-proof and always works quite well. It uses the sftp protocol. You can read more about using the sftp protocol in the command line in the lesson discussion.

Download and install the FileZilla client from https://filezilla-project.org. After installing and opening the program, you should end up with a window with a file browser of your local system on the left hand side of the screen. When you connect to the cluster, your cluster files will appear on the right hand side.

To connect to the cluster, we’ll just need to enter our credentials at the top of the screen:

    Host: sftp://login.isca.ex.ac.uk
    User: Your cluster username
    Password: Your cluster password
    Port: (leave blank to use the default port)

Hit “Quickconnect” to connect. You should see your remote files appear on the right hand side of the screen. You can drag-and-drop files between the left (local) and right (remote) sides of the screen to transfer files.

Finally, if you need to move large files (typically larger than a gigabyte) from one remote computer to another remote computer, SSH in to the computer hosting the files and use scp or rsync to transfer over to the other. This will be more efficient than using FileZilla (or related applications) that would copy from the source to your local machine, then to the destination machine.
