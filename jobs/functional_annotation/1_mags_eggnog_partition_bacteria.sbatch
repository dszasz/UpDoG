#!/bin/bash
#SBATCH --job-name=subsampling
#SBATCH --output=logs/subsampling_%A.log
#SBATCH --error=logs/subsampling_%A.log
#SBATCH --time=0-01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END

#to write in the terminal before sending the job
source ${HOME}/.bashrc
conda activate qiime2-moshpit-2025.7

#acces to internet for the job
module load eth_proxy

# Paths
data_dir=/cluster/scratch/$USER/updog

# Change to main directory
cd $data_dir


qiime types partition-feature-data-mags \
  --i-mags mags-derep-bacteria.qza \
  --p-num-partitions 10 \
  --o-partitioned-mags mags-derep-bacteria