---
layout: page
title: Loading software packages on HPC
order: 6
session: 1
length: 20
toc: true
---

     Questions

        How do we load and unload software packages?

    Objectives

        Load and use a software package.

        Explain how the shell environment changes when the module mechanism loads or unloads packages.

On a high-performance computing system, it is seldom the case that the software we want to use is available when we log in. It is installed, but we will need to “load” it before it can run.

Before we start using individual software packages, however, we should understand the reasoning behind this approach. The three biggest factors are:

+ software incompatibilities
+ versioning
+ dependencies

Software incompatibility is a major headache for programmers. Sometimes the presence (or absence) of a software package will break others that depend on it. Two of the most famous examples are Python 2 and 3 and C compiler versions. Python 3 famously provides a python command that conflicts with that provided by Python 2. Software compiled against a newer version of the C libraries and then used when they are not present will result in a nasty 'GLIBCXX_3.4.20' not found error, for instance.

Software versioning is another common issue. A team might depend on a certain package version for their research project - if the software version was to change (for instance, if a package was updated), it might affect their results. Having access to multiple software versions allow a set of researchers to prevent software versioning issues from affecting their results.

Dependencies are where a particular software package (or even a particular version) depends on having access to another software package (or even a particular version of another software package). For example, the VASP materials science software may depend on having a particular version of the FFTW (Fastest Fourier Transform in the West) software library available for it to work.

## Environment Modules

Environment modules are the solution to these problems. A module is a self-contained description of a software package – it contains the settings required to run a software package and, usually, encodes required dependencies on other software packages.

There are a number of different environment module implementations commonly used on HPC systems: the two most common are TCL modules and Lmod. Both of these use similar syntax and the concepts are the same so learning to use one will allow you to use whichever is installed on the system you are using. In both implementations the module command is used to interact with environment modules. An additional subcommand is usually added to the command to specify what you want to do. For a list of subcommands you can use module -h or module help. As for all commands, you can access the full help on the man pages with man module.

On login you may start out with a default set of modules loaded or you may start out with an empty environment; this depends on the setup of the system you are using. On ISCA you start with an empty environment.

## Listing Available Modules

To see available software modules, use `module avail`:

![](fig/module-avail.png)

This is will give you a very long list of all software, and all versions, available to load and use.  

Use "module keyword key1 key2 ..." to search for all possible modules matching
any of the "keys".

## Listing Currently Loaded Modules

You can use the module list command to see which modules you currently have loaded in your environment. If you have no modules loaded, you will see a message telling you so

![](fig/module-list.png)

## Loading and Unloading Software

To load a software module, use module load. In this example we will use Python 3.

Initially, Python 3 is not loaded. We can test this by using the which command. which looks for programs the same way that Bash does, so we can use it to tell us where a particular piece of software is stored.

[yourUsername@login02 ~]$ which python3

/usr/bin/which: no python3 in (
/opt/software/slurm/16.05.9/bin:
/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/imkl/11.3.4.258/bin:
/opt/software/bin:/opt/puppetlabs/puppet/bin:/opt/software/slurm/current/bin:
/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:
/home/yourUsername/.local/bin:/home/yourUsername/bin)

We can load the python3 command with module load:

[yourUsername@login02 ~]$ module load python
[yourUsername@login02 ~]$ which python3

/cvmfs/soft.computecanada.ca/nix/var/nix/profiles/python-3.5.2/bin/python3

So, what just happened?

To understand the output, first we need to understand the nature of the $PATH environment variable. $PATH is a special environment variable that controls where a UNIX system looks for software. Specifically $PATH is a list of directories (separated by :) that the OS searches through for a command before giving up and telling us it can’t find it. As with all environment variables we can print it out using echo.

[yourUsername@login02 ~]$ echo $PATH

/cvmfs/soft.computecanada.ca/nix/var/nix/profiles/python-3.5.2/bin:/opt/software/slurm/16.05.9/bin:/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/Compiler/intel2016.4/openmpi/2.1.1/bin:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/imkl/11.3.4.258/mkl/bin:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/imkl/11.3.4.258/bin:/cvmfs/soft.computecanada.ca/nix/var/nix/profiles/gcc-5.4.0/bin:/opt/software/bin:/opt/puppetlabs/puppet/bin:/opt/software/slurm/current/bin:/opt/software/slurm/bin:/cvmfs/soft.computecanada.ca/easybuild/bin:/cvmfs/soft.computecanada.ca/nix/var/nix/profiles/16.09/bin:/cvmfs/soft.computecanada.ca/nix/var/nix/profiles/16.09/sbin:/cvmfs/soft.computecanada.ca/custom/bin:/opt/software/slurm/current/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/yourUsername/.local/bin:/home/yourUsername/bin

You’ll notice a similarity to the output of the which command. In this case, there’s only one difference: the different directory at the beginning. When we ran the module load command, it added a directory to the beginning of our $PATH. Let’s examine what’s there:

[yourUsername@login02 ~]$ ls /cvmfs/soft.computecanada.ca/nix/var/nix/profiles/python-3.5.2/bin

2to3              idle3.5  pydoc3.5          python3.5m         virtualenv
2to3-3.5          pip      python            python3.5m-config  wheel
easy_install      pip3     python3           python3-config
easy_install-3.5  pip3.5   python3.5         pyvenv
idle3             pydoc3   python3.5-config  pyvenv-3.5

Taking this to its conclusion, module load will add software to your $PATH. It “loads” software. A special note on this - depending on which version of the module program that is installed at your site, module load will also load required software dependencies.

To demonstrate, let’s use module list. module list shows all loaded software modules.

[yourUsername@login02 ~]$ module list

Currently Loaded Modules:
  1) nixpkgs/.16.09    (H,S)      5) intel/2016.4  (t)
  2) icc/.2016.4.258   (H)        6) openmpi/2.1.1 (m)
  3) gcccore/.5.4.0    (H)        7) StdEnv/2016.4 (S)
  4) ifort/.2016.4.258 (H)        8) python/3.5.2  (t)

  Where:
   S:  Module is Sticky, requires --force to unload or purge
   m:  MPI implementations / Implémentations MPI
   t:  Tools for development / Outils de développement
   H:             Hidden Module

[yourUsername@login02 ~]$ module load beast
[yourUsername@login02 ~]$ module list

Currently Loaded Modules:
  1) nixpkgs/.16.09    (H,S)  5) intel/2016.4  (t)   9) java/1.8.0_121   (t)
  2) icc/.2016.4.258   (H)    6) openmpi/2.1.1 (m)  10) beagle-lib/2.1.2 (bio)
  3) gcccore/.5.4.0    (H)    7) StdEnv/2016.4 (S)  11) beast/2.4.0      (chem)
  4) ifort/.2016.4.258 (H)    8) python/3.5.2  (t)

  Where:
   S:     Module is Sticky, requires --force to unload or purge
   bio:   Bioinformatic libraries/apps / Logiciels de bioinformatique
   m:     MPI implementations / Implémentations MPI
   t:     Tools for development / Outils de développement
   chem:  Chemistry libraries/apps / Logiciels de chimie
   H:                Hidden Module

So in this case, loading the beast module (a bioinformatics software package), also loaded java/1.8.0_121 and beagle-lib/2.1.2 as well. Let’s try unloading the beast package.

[yourUsername@login02 ~]$ module unload beast
[yourUsername@login02 ~]$ module list

Currently Loaded Modules:
  1) nixpkgs/.16.09    (H,S)      5) intel/2016.4  (t)
  2) icc/.2016.4.258   (H)        6) openmpi/2.1.1 (m)
  3) gcccore/.5.4.0    (H)        7) StdEnv/2016.4 (S)
  4) ifort/.2016.4.258 (H)        8) python/3.5.2  (t)

  Where:
   S:  Module is Sticky, requires --force to unload or purge
   m:  MPI implementations / Implémentations MPI
   t:  Tools for development / Outils de développement
   H:             Hidden Module

So using module unload “un-loads” a module along with its dependencies. If we wanted to unload everything at once, we could run module purge (unloads everything).

[yourUsername@login02 ~]$ module purge

The following modules were not unloaded:
  (Use "module --force purge" to unload all):

  1) StdEnv/2016.4                5) ifort/.2016.4.258
  2) nixpkgs/.16.09               6) intel/2016.4
  3) icc/.2016.4.258              7) imkl/11.3.4.258
  4) gcccore/.5.4.0               8) openmpi/2.1.1

Note that module purge is informative. It lets us know that all but a default set of packages have been unloaded (and how to actually unload these if we truly so desired).

Note that this module loading process happens principally through the manipulation of environment variables like $PATH. There is usually little or no data transfer involved.

The module loading process manipulates other special environment variables as well, including variables that influence where the system looks for software libraries, and sometimes variables which tell commercial software packages where to find license servers.

The module command also restores these shell environment variables to their previous state when a module is unloaded.
Software Versioning

So far, we’ve learned how to load and unload software packages. This is very useful. However, we have not yet addressed the issue of software versioning. At some point or other, you will run into issues where only one particular version of some software will be suitable. Perhaps a key bugfix only happened in a certain version, or version X broke compatibility with a file format you use. In either of these example cases, it helps to be very specific about what software is loaded.

Let’s examine the output of module avail more closely.

[yourUsername@login02 ~]$ module avail

---------------- MPI-dependent avx2 modules -----------------
 abinit/8.2.2     (chem)           ncl/6.4.0
 abyss/1.9.0      (bio)            ncview/2.1.7        (vis)
 boost-mpi/1.60.0 (t)              plumed/2.3.0        (chem)
 cdo/1.7.2        (geo)            pnetcdf/1.8.1       (io)
 lammps/20170331                   quantumespresso/6.0 (chem)
 mrbayes/3.2.6            (bio)    ray/2.3.1           (bio)


[removed most of the output here for clarity]

   t:        Tools for development / Outils de développement
   vis:      Visualisation software / Logiciels de visualisation
   chem:     Chemistry libraries/apps / Logiciels de chimie
   geo:      Geography libraries/apps / Logiciels de géographie
   phys:     Physics libraries/apps / Logiciels de physique
   Aliases:  Aliases exist: foo/1.2.3 (1.2) means that
             "module load foo/1.2" will load foo/1.2.3
   D:        Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching
any of the "keys".

Let’s take a closer look at the gcc module. GCC is an extremely widely used C/C++/Fortran compiler. Tons of software is dependent on the GCC version, and might not compile or run if the wrong version is loaded. In this case, there are two different versions: gcc/4.8.5 and gcc/5.4.0. How do we load each copy and which copy is the default?

In this case, gcc/5.4.0 has a (D) next to it. This indicates that it is the default — if we type module load gcc, this is the copy that will be loaded.

[yourUsername@login02 ~]$ module load gcc
[yourUsername@login02 ~]$ gcc --version

Lmod is automatically replacing "intel/2016.4" with "gcc/5.4.0".

Due to MODULEPATH changes, the following have been reloaded:
  1) openmpi/2.1.1

gcc (GCC) 5.4.0
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Note that three things happened: the default copy of GCC was loaded (version 5.4.0), the Intel compilers (which conflict with GCC) were unloaded, and software that is dependent on compiler (OpenMPI) was reloaded. The module system turned what might be a super-complex operation into a single command.

So how do we load the non-default copy of a software package? In this case, the only change we need to make is be more specific about the module we are loading. There are two GCC modules: gcc/5.4.0 and gcc/4.8.5. To load a non-default module, the only change we need to make to our module load command is to leave in the version number after the /.

[yourUsername@login02 ~]$ module load gcc/4.8.5
[yourUsername@login02 ~]$ gcc --version

Inactive Modules:
  1) openmpi

The following have been reloaded with a version change:
  1) gcc/5.4.0 => gcc/4.8.5

gcc (GCC) 4.8.5
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

We now have successfully switched from GCC 5.4.0 to GCC 4.8.5. It is also important to note that there was no compatible OpenMPI module available for GCC 4.8.5. Because of this, the module program has “inactivated” the module. All this means for us is that if we re-load GCC 5.4.0, module will remember OpenMPI used to be loaded and load that module as well.

[yourUsername@login02 ~]$ module load gcc/5.4.0

Activating Modules:
  1) openmpi/2.1.1

The following have been reloaded with a version change:
  1) gcc/4.8.5 => gcc/5.4.0

    Using Software Modules in Scripts

    Create a job that is able to run python3 --version. Remember, no software is loaded by default! Running a job is just like logging on to the system (you should not assume a module loaded on the login node is loaded on a compute node).

        Solution

        [yourUsername@login02 ~]$ nano python-module.sh
        [yourUsername@login02 ~]$ cat python-module.sh

        #!/usr/bin/env bash

        module load python3

        python3 --version

        [yourUsername@login02 ~]$ sbatch python-module.sh

