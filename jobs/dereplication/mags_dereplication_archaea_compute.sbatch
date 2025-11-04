#!/bin/bash
#SBATCH --job-name=mags_derep_archaea_1       # A short name for your job
#SBATCH --output=logs/output_mags_derep_archaea_1_%j.log         # Output file (%j adds the job ID)
#SBATCH --error=logs/error_mags_derep_archaea_1_%j.log           # Error file
#SBATCH --time=1-00:00:00                # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                     # Number of tasks (1 = single process)
#SBATCH --cpus-per-task=1              # Number of CPUs
#SBATCH --mem-per-cpu=8G               # Memory (1 gigabyte)
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END

#to write in the terminal before sending the job
source ${HOME}/.bashrc
conda activate qiime2-moshpit-2025.7

#acces to internet for the job
module load eth_proxy

#some paths
home_dir=/cluster/home/$USER
data_dir=/cluster/scratch/$USER/updog

cd $data_dir


# ----- add script here -------

mosh sourmash compute \
    --i-sequence-file $data_dir/mags_filtered_archaea_50.qza \
    --p-ksizes 105 \
    --p-scaled 100 \
    --o-min-hash-signature $data_dir/mags-hashes-archaea.qza