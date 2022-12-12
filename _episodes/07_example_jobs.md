---
layout: page
title: Running more complex jobs on a HPC system 
order: 8
session: 2
length: 20
toc: true
---

     Questions

        How do we run a job not written in bash?

    Objectives

        Write a job submission script to use preinstalled software

        Submit a python script to the scheduler

        Submit an R script to the scheduler


In the job we submitted to the cluster so far only included bash/UNIX commands. It is highly likely that most of what we want to do on the command line involves using other software or programming languages. In this lesson we are going to look at how we run a variety of different scripts or use a range of different software on the system. Ultimately we need to use UNIX commands to call/execute/run our script.

## Command line programmes

The first extension we will cover is how to use command line tools. If you use these frequently in your work, you will be aware that these are executables you call from a shell terminal possible with some flags or arguments. 

The example job submission script below uses a command line tool called (plink)[https://zzz.bwh.harvard.edu/plink/index.shtml] which is used in the analysis of genetic data. 

The components are the script are 

1. The SLURM commands to tell the scheduler the parameters for the job, including which queue to submit to, how many processors to use, which project, and the paths to the output/log files. 

2. Load the relevant modules. When the job gets transferred to the compute nodes, the environment is empty. As part of your job you need to load all the relevant software via the module loading system. 

3. The command(s). In this example we are just asking the plink programme to print the help pages.

```
#!/bin/sh
#SBATCH -p training # submit to the serial queue
#SBATCH --time=00:10:00 # Maximum wall time for the job.
#SBATCH -A Research_Project-HPC-Training # research project to submit under. 
#SBATCH --nodes=1 # specify number of nodes.
#SBATCH --ntasks-per-node=1 # specify number of processors per node
#SBATCH --mail-type=END # send email at job completion 
#SBATCH --output=plink.o
#SBATCH --error=plink.e
#SBATCH --job-name=plink


## print start date and time
echo Job started on:
date -u

module load PLINK

plink2 --help

## print end date and time
echo Job ended on:
date -u

```

## R example

## Python example

## Matlab example