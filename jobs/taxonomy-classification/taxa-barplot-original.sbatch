#!/bin/bash
#SBATCH --job-name=taxa-barplot-original
#SBATCH --output=logs/taxa-barplot-original_output_%A.log
#SBATCH --error=logs/taxa-barplot-original_error_%A.log
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
qiime taxa barplot \
    --i-table $data_dir/mags_derep_ft_merged_filtered.qza \
    --i-taxonomy $data_dir/mags-taxonomy-db16-filtered.qza \
    --m-metadata-file $data_dir/updog_metadata.tsv \
    --o-visualization $data_dir/mags-taxa-bar-plot-original.qzv