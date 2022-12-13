#!/bin/sh
#SBATCH -p training # submit to the serial queue
#SBATCH --time=00:10:00 # Maximum wall time for the job.
#SBATCH -A Research_Project-HPC-Training # research project to submit under. 
#SBATCH --nodes=1 # specify number of nodes.
#SBATCH --ntasks-per-node=1 # specify number of processors per node
#SBATCH --mail-type=END # send email at job completion 
#SBATCH --output=exampleJob.o
#SBATCH --error=exampleJob.e
#SBATCH --job-name=exampleJob


## print start date and time
echo Job started on:
date -u

module load Python/3.10.4-GCCcore-11.3.0

python calc-squares.py

module purge

module load R

Rscript calc-squares.R

## print end date and time
echo Job ended on:
date -u