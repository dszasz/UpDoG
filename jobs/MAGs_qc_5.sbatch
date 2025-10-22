#!/bin/bash
#SBATCH --job-name=MAGs_qc_5       # A short name for your job
#SBATCH --output=logs/output_MAGs_qc_5_%j.log         # Output file (%j adds the job ID)
#SBATCH --error=logs/error_MAGs_qc_5_%j.log           # Error file
#SBATCH --time=4:00:00                # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                     # Number of tasks (1 = single process)
#SBATCH --cpus-per-task=1              # Number of CPUs
#SBATCH --mem-per-cpu=8G               # Memory (1 gigabyte)
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END

#to write in the terminal before sending the job
source ${HOME}/.bashrc
conda activate qiime2-moshpit-2025.7

#acces to internet for the job
module load eth_proxy

#some paths
home_dir=/cluster/home/$USER
data_dir=/cluster/scratch/$USER/updog

#new dirrectory only for the first job
#mkdir -p /cluster/scratch/$USER/updog/results

cd $data_dir


# ----- add script here -------

qiime annotate evaluate-busco \
    --i-mags $data_dir/updog_mags_131025.qza \
    --i-db $data_dir/busco-db-fungi.qza \
    --p-lineage-dataset fungi_odb12 \
    --p-cpu 3 \
    --o-results $data_dir/busco-results-fungi.qza \
    --o-visualization $data_dir/mags-busco-fungi.qzv