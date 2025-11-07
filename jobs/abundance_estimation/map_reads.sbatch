#!/bin/bash
#SBATCH --job-name=map-reads     # A short name for your job
#SBATCH --output=logs/output_map-reads_%j.log         # Output file (%j adds the job ID)
#SBATCH --error=logs/error_map-reads%j.log           # Error file
#SBATCH --time=2-00:00:00                # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                     # Number of tasks (1 = single process)
#SBATCH --cpus-per-task=8              # Number of CPUs
#SBATCH --mem-per-cpu=4G                       # Memory (1 gigabyte)
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END

#to write in the terminal before sending the job
source ~/.bashrc
conda activate qiime2-moshpit-2025.7

#acces to internet for the job
module load eth_proxy

#some paths
home_dir="/cluster/home/$USER"
data_dir="/cluster/scratch/$USER/updog/scripts"

#new directory only for the first job
#mkdir -p /cluster/scratch/$USER/updog/results

cd "$data_dir"

mosh assembly map-reads \
    --i-index "$data_dir/mags_derep_all_domains_index.qza" \
    --i-reads "$data_dir/partitioned_seqs/partitioned_seqs.qza" \   #not sure which file -> updog_seqs
    --p-threads 8 \
    --p-seed 100 \
    --o-alignment-maps reads_to_derep_mags \