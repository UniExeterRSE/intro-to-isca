#!/bin/sh
#SBATCH --export=ALL # export all environment variables to the batch job.
#SBATCH -p training # submit to the serial queue
#SBATCH --time=00:10:00 # Maximum wall time for the job.
#SBATCH -A Research_Project-HPC-Training # research project to submit under. 
#SBATCH --nodes=1 # specify number of nodes.
#SBATCH --ntasks-per-node=1 # specify number of processors per node
#SBATCH --mail-type=END # send email at job completion 
#SBATCH --output=hello-world-%A_%a.o
#SBATCH --error=hello-world-%A_%a.e
#SBATCH --job-name=hello-world-%A_%a
#SBATCH --array=0-10

## print start date and time
echo Job started on:
date -u

echo "hello-world"

## print node job run on
echo -n "This script is running on "
hostname

## print which array number this is
echo "This job number " ${SLURM_ARRAY_JOB_ID}  " and array number " ${SLURM_ARRAY_TASK_ID}

## print end date and time
echo Job ended on:
date -u