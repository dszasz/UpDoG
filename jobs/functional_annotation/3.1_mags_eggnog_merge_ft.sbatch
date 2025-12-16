#!/bin/bash
#SBATCH --job-name=eggnog-merging
#SBATCH --output=logs/eggnog-merging-ft_%A.log
#SBATCH --error=logs/eggnog-merging-ft_%A.log
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


qiime feature-table merge \
  --i-tables $data_dir/mags-derep-bacteria-orthologs/1_eggnog_ft.qza \
  --i-tables $data_dir/mags-derep-bacteria-orthologs/2_eggnog_ft.qza \
  --i-tables $data_dir/mags-derep-bacteria-orthologs/3_eggnog_ft.qza \
  --i-tables $data_dir/mags-derep-bacteria-orthologs/4_eggnog_ft.qza \
  --o-merged-table $data_dir/eggnog_ft_merged_1-4.qza