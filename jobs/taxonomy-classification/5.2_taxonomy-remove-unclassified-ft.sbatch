#!/bin/bash
#SBATCH --job-name=filtering_unclassified
#SBATCH --output=logs/filtering_unclassified_output_%A.log
#SBATCH --error=logs/filtering_unclassified_error_%A.log
#SBATCH --time=02:00:00
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

qiime taxa filter-table \
    --i-table $data_dir/mags_derep_ft_merged_filtered.qza \
    --i-taxonomy $data_dir/kraken2-mags-taxonomy_db16_milo.qza \
    --p-exclude Unassigned \
    --o-filtered-table $data_dir/mags-table-filtered-milo-no-unassigned.qza