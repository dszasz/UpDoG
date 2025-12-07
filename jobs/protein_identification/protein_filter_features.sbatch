#!/bin/bash
#SBATCH --job-name=subsampling
#SBATCH --output=logs/subsampling_%A.log
#SBATCH --error=logs/subsampling_%A.log
#SBATCH --time=1-00:00:00
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


mosh annotate filter-derep-mags \
    --i-mags $data_dir/mags_derep_all_domains.qza \
    --m-metadata-file $data_dir/ids.tsv \
    --p-no-exclude-ids \
    --o-filtered-mags $data_dir/mags-filtered-for-proteins.qza