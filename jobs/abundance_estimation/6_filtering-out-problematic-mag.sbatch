#!/bin/bash
#SBATCH --job-name=ft_problematic_mag
#SBATCH --output=logs/ft_problematic_mag_output_%A.log
#SBATCH --error=logs/ft_problematic_mag_error_%A.log
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

#script
qiime feature-table filter-features \
    --i-table $data_dir/mags_derep_ft_merged.qza \
    --m-metadata-file $data_dir/remove-mags_1.tsv \
    --p-exclude-ids \
    --o-filtered-table $data_dir/mags_derep_ft_merged_filtered.qza