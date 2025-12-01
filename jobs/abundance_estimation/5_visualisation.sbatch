#!/bin/bash
#SBATCH --job-name=visualisation    # A short name for your job
#SBATCH --output=logs/output_visualisation_%j.log         # Output file (%j adds the job ID)
#SBATCH --error=logs/error_visualisation%j.log           # Error file
#SBATCH --time=2-00:00:00                # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                     # Number of tasks (1 = single process)
#SBATCH --cpus-per-task=16              # Number of CPUs
#SBATCH --mem-per-cpu=8G                       # Memory (1 gigabyte)
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END

#to write in the terminal before sending the job
source ~/.bashrc
conda activate qiime2-moshpit-2025.7

#acces to internet for the job
module load eth_proxy

#some paths
home_dir="/cluster/home/$USER"
data_dir="/cluster/scratch/$USER/updog/results"

#new directory only for the first job
#mkdir -p /cluster/scratch/$USER/updog/results

cd "$data_dir"

qiime feature-table summarize \
  --i-table "$data_dir/mags_derep_ft_merged.qza" \
  --o-visualization mags_derep_ft_merged.qzv