#!/bin/bash
#SBATCH --job-name=3-taxonomy-generic
#SBATCH --output=logs/3-taxonomy-generic_%A.log
#SBATCH --error=logs/3-taxonomy-generic_%A.log
#SBATCH --time=3-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16G
#SBATCH --partition=normal
#SBATCH --mail-type=END

# Load environment
source ${HOME}/.bashrc
conda activate qiime2-moshpit-2025.7



#acces to internet for the job
module load eth_proxy

#some paths
home_dir=/cluster/home/$USER
data_dir=/cluster/scratch/$USER/updog

cd $data_dir

#script
mosh annotate kraken2-to-mag-features \
    --i-reports $data_dir/kraken2-reports-mags_db16_filtered-1.qza \
    --i-outputs $data_dir/kraken2-hits-mags_db16_filtered-1.qza \
    --o-taxonomy $data_dir/mags-taxonomy-db16-filtered.qza\
    --verbose