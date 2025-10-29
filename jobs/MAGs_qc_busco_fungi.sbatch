#!/bin/bash
#SBATCH --job-name=MAGs_qc_5       # A short name for your job
#SBATCH --output=logs/output_MAGs_qc_5_%j.log         # Output file (%j adds the job ID)
#SBATCH --error=logs/error_MAGs_qc_5_%j.log           # Error file
#SBATCH --time=3-00:00:00                # Time limit (hh:mm:ss)
#SBATCH --ntasks=1                     # Number of tasks (1 = single process)
#SBATCH --cpus-per-task=4              # Number of CPUs
#SBATCH --mem-per-cpu=2G               # Memory (1 gigabyte)
#SBATCH --partition=normal             # Queue/partition to use
#SBATCH --mail-type=END
#SBATCH --array=1-126       

#to write in the terminal before sending the job
source ${HOME}/.bashrc
conda activate qiime2-moshpit-2025.7

#acces to internet for the job
module load eth_proxy

# Paths
# Directories
data_dir="/cluster/scratch/$USER/updog"
output_dir="/cluster/scratch/$USER/updog/busco_fungi_outputs"
mkdir -p $output_dir

# Change to main directory
cd $data_dir

# Directory with your qza files
QZA_DIR="/cluster/scratch/$USER/updog/busco_inputs/updog_mags_partitions"

# Pick the file corresponding to this task
SAMPLE_FILE=$(ls $QZA_DIR/*.qza | sed -n "${SLURM_ARRAY_TASK_ID}p")

echo "Processing $SAMPLE_FILE on $SLURM_JOB_NODELIST"

# Run BUSCO for fungi
qiime annotate evaluate-busco \
    --i-mags $SAMPLE_FILE \
    --i-db $data_dir/busco-db-fungi.qza \
    --p-lineage-dataset fungi_odb12 \
    --p-cpu 3 \
    --o-results $output_dir/$(basename $SAMPLE_FILE .qza)_busco-results-fungi.qza \
    --o-visualization $output_dir/$(basename $SAMPLE_FILE .qza)_busco-fungi.qzv