#!/bin/bash
#SBATCH --job-name=4-taxonomy-qzv_db16
#SBATCH --output=logs/4-taxonomy-qzv_error_db16_%A.log
#SBATCH --error=logs/4-taxonomy-qzv_output_db16_%A.log
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
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
qiime metadata tabulate \
  --m-input-file $data_dir/mags-taxonomy-db16-filtered.qza \
  --o-visualization $data_dir/mags-taxonomy-db16-filtered.qzv
 