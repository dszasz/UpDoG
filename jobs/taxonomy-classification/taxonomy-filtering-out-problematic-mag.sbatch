#!/bin/bash
#SBATCH --job-name=taxonomy_problematic_mag
#SBATCH --output=logs/taxonomy_problematic_mag_output_%A.log
#SBATCH --error=logs/taxonomy_problematic_mag_error_%A.log
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
mosh annotate filter-kraken2-results \
  --i-reports $data_dir/kraken2-reports-mags_db16.qza \
  --i-outputs $data_dir/kraken2-hits-mags_db16.qza \
  --m-metadata-file $data_dir/remove-mags_1.tsv \
  --p-exclude-ids \
  --o-filtered-reports $data_dir/kraken2-reports-mags_db16_filtered-1.qza \
  --o-filtered-outputs $data_dir/kraken2-hits-mags_db16_filtered-1.qza \