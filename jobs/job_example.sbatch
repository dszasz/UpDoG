#!/bin/bash
#SBATCH --job-name=my_python_job       # A short name for your job
#SBATCH --output=output_jobname_%j.log         # Output file (%j adds the job ID)
#SBATCH --error=error_%j.log           # Error file
#SBATCH --time=00:10:00                # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                     # Number of tasks (1 = single process)
#SBATCH --cpus-per-task=1              # Number of CPUs
#SBATCH --mem-per-cpu=1G                       # Memory (1 gigabyte)
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END

#to write in the terminal before sending the job
conda activate qiime2-moshpit-2025.7

#acces to internet for the job
module load eth_proxy

#some paths
home_dir = /cluster/home/clambert/$USER
scratch_dir = /cluster/scratch/$USER/updog

#new dirrectory only for the first job
mkdir -p /cluster/scratch/$USER/updog/results

cd $scratch_dir


# ----- add script here -------

