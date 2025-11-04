#!/bin/bash
#SBATCH --job-name=taxonomy_classify
#SBATCH --output=logs/output-taxonomy_classify_%A.log
#SBATCH --error=logs/error-taxonomy_classify_%A.log
#SBATCH --time=5-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem-per-cpu=4G
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
! qiime annotate classify-kraken2 \
    --i-seqs $data_dir/mags_derep_all_domains.qza \
    --i-db $data_dir/kraken2_db.qza \
    --p-threads 40 \
    --p-confidence 0.5 \
    --p-memory-mapping False \
    --p-report-minimizer-data \
    --o-reports $data_dir/kraken2-reports-mags.qza \
    --o-outputs $data_dir/kraken2-hits-mags.qza
    --verbose