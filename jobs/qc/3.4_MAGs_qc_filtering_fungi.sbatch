#!/bin/bash
#SBATCH --job-name=MAGs_qc_filtering   # short name for your job
#SBATCH --output=logs/output_MAGs_qc_filtering_%A_%a.log
#SBATCH --error=logs/error_MAGs_qc_filtering_%A_%a.log
#SBATCH --time=2-00:00:00               # adjust if needed
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=normal
#SBATCH --mail-type=END
#SBATCH --array=1-126                    # one job per sample

# Load environment
source ${HOME}/.bashrc
conda activate qiime2-moshpit-2025.7
module load eth_proxy

# Paths
data_dir=/cluster/scratch/$USER/updog
samples_dir=$data_dir/busco_inputs/updog_mags_partitions          # directory with per-sample .qza
busco_metrics=$data_dir/busco-results-bacteria.qza  # your BUSCO results file
output_dir=$data_dir/busco_filtered
mkdir -p $output_dir

# Pick the sample file for this array task
SAMPLE_FILE=$(ls $samples_dir/*.qza | sed -n "${SLURM_ARRAY_TASK_ID}p")
BASENAME=$(basename "$SAMPLE_FILE" .qza)

echo "Filtering $SAMPLE_FILE on $SLURM_JOB_NODELIST"

# Run the filter
mosh annotate filter-mags \
  --i-mags $SAMPLE_FILE \
  --m-metadata-file $busco_metrics \
  --p-where "complete > 50 AND contamination < 10" \
  --p-no-exclude-ids \
  --p-on mag \
  --o-filtered-mags $output_dir/${BASENAME}_filtered.qza \
  --verbose