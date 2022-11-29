# File Transfer Methods

## From the Internet

One of the most straightforward ways to download files is to use either curl or wget. One of these is usually installed in most Linux shells, on Mac OS terminal and in GitBash. Any file that can be downloaded in your web browser through a direct link can be downloaded using curl -O or wget. This is a quick way to download datasets or source code.

The syntax for these commands is: curl -O https://some/link/to/a/file and wget https://some/link/to/a/file. Try it out by downloading some material we’ll use later on, from a terminal on your local machine.

[user@laptop ~]$ curl -O https://carpentries-incubator.github.io/hpc-intro/files/hpc-intro-data.tar.gz

or

[user@laptop ~]$ wget https://carpentries-incubator.github.io/hpc-intro/files/hpc-intro-data.tar.gz


## Using SCP from the command line

To copy a single file to or from the cluster, we can use scp (“secure copy”). The syntax can be a little complex for new users, but we’ll break it down. The scp command is a relative of the ssh command we used to access the system, and can use the same public-key authentication mechanism.

To upload to another computer:

[user@laptop ~]$ scp path/to/local/file.txt yourUsername@graham.computecanada.ca:/path/on/Graham

To download from another computer:

[user@laptop ~]$ scp yourUsername@graham.computecanada.ca:/path/on/Graham/file.txt path/to/local/

Note that everything after the : is relative to our home directory on the remote computer. We can leave it at that if we don’t care where the file goes.

[user@laptop ~]$ scp local-file.txt yourUsername@graham.computecanada.ca:

    Upload a File

    Copy the file you just downloaded from the Internet to your home directory on Graham.

        Solution

        [user@laptop ~]$ scp hpc-intro-data.tar.gz yourUsername@graham.computecanada.ca:~/

Most computer clusters are protected from the open internet by a firewall. This means that the curl command will fail, as an address outside the firewall is unreachable from the inside. To get around this, run the curl or wget command from your local machine to download the file, then use the scp command to upload it to the cluster.

## GUI interface

FileZilla is a cross-platform client for downloading and uploading files to and from a remote computer. It is absolutely fool-proof and always works quite well. It uses the sftp protocol. You can read more about using the sftp protocol in the command line in the lesson discussion.

Download and install the FileZilla client from https://filezilla-project.org. After installing and opening the program, you should end up with a window with a file browser of your local system on the left hand side of the screen. When you connect to the cluster, your cluster files will appear on the right hand side.

To connect to the cluster, we’ll just need to enter our credentials at the top of the screen:

    Host: sftp://graham.computecanada.ca
    User: Your cluster username
    Password: Your cluster password
    Port: (leave blank to use the default port)

Hit “Quickconnect” to connect. You should see your remote files appear on the right hand side of the screen. You can drag-and-drop files between the left (local) and right (remote) sides of the screen to transfer files.

Finally, if you need to move large files (typically larger than a gigabyte) from one remote computer to another remote computer, SSH in to the computer hosting the files and use scp or rsync to transfer over to the other. This will be more efficient than using FileZilla (or related applications) that would copy from the source to your local machine, then to the destination machine.
