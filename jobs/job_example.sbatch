#!/bin/bash
#SBATCH --job-name=my_python_job       # A short name for your job
#SBATCH --output=output_%j.log         # Output file (%j adds the job ID)
#SBATCH --error=error_%j.log           # Error file
#SBATCH --time=00:10:00                # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                     # Number of tasks (1 = single process)
#SBATCH --cpus-per-task=1              # Number of CPUs
#SBATCH --mem=1G                       # Memory (1 gigabyte)
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END


conda activate qiime2-moshpit-2025.7

# ----- add script here -------

