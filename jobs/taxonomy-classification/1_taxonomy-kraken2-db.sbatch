#!/bin/bash
#SBATCH --job-name=remove_fungi_duplicates
#SBATCH --output=logs/remove_fungi_duplicates_%A.log
#SBATCH --error=logs/remove_fungi_duplicates_%A.log
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
mosh annotate build-kraken-db \
    --p-collection pluspf16 \
    --o-kraken2-db $data_dir/kraken2_db16 \
    --o-bracken-db $data_dir/bracken_db16 \
 