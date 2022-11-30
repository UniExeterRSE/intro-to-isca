---
layout: page
title: How do I connect to a HPC Cluster?
order: 3
session: 1
length: 20
toc: true
---

## Questions

    How do I log in to a remote HPC system?

## Objectives

    Configure secure access to a remote HPC system.

    Connect to a remote HPC system.

## SSH

The first step in using a cluster is to establish a connection from our laptop to the cluster. When we are sitting at a computer (or standing, or holding it in our hands or on our wrists), we have come to expect a visual display with icons, widgets, and perhaps some windows or applications: a graphical user interface, or GUI. Since computer clusters are remote resources that we connect to over slow or intermittent interfaces (WiFi and VPNs especially), it is more practical to use a command-line interface, or CLI, to send commands as plain-text. If a command returns output, it is printed as plain text as well. The commands we run today will not open a window to show graphical results.

If you have ever opened the Windows Command Prompt or macOS Terminal, you have seen a CLI. If you have already taken The Carpentries’ courses on the UNIX Shell or Version Control, you have used the CLI on your local machine extensively. The only leap to be made here is to open a CLI on a remote machine, while taking some precautions so that other folks on the network can’t see (or change) the commands you’re running or the results the remote machine sends back. We will use the Secure SHell protocol (or SSH) to open an encrypted network connection between two machines, allowing you to send & receive text and data without having to worry about prying eyes.
/hpc-intro/Connect%20to%20cluster

SSH clients are usually command-line tools, where you provide the remote machine address as the only required argument. If your username on the remote system differs from what you use locally, you must provide that as well. If your SSH client has a graphical front-end, such as PuTTY or MobaXterm, you will set these arguments before clicking “connect.” From the terminal, you’ll write something like ssh userName@hostname, where the argument is just like an email address: the “@” symbol is used to separate the personal ID from the address of the remote machine.

When logging in to a laptop, tablet, or other personal device, a username, password, or pattern are normally required to prevent unauthorized access. In these situations, the likelihood of somebody else intercepting your password is low, since logging your keystrokes requires a malicious exploit or physical access. For systems like gra-login1 running an SSH server, anybody on the network can log in, or try to. Since usernames are often public or easy to guess, your password is often the weakest link in the security chain. Many clusters therefore forbid password-based login, requiring instead that you generate and configure a public-private key pair with a much stronger password. Even if your cluster does not require it, the next section will guide you through the use of SSH keys and an SSH agent to both strengthen your security and make it more convenient to log in to remote systems.

## What About Windows?

## Whoami?
