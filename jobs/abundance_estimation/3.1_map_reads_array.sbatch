#!/bin/bash
#SBATCH --job-name=map-reads
#SBATCH --output=logs/output_map-reads_%A_%a.log
#SBATCH --error=logs/error_map-reads_%A_%a.log
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --partition=normal
#SBATCH --mail-type=END

## #SBATCH --array=1-10%5   # (10 parts, max 5 running at once)

set -euo pipefail

# --- ENV ---------------------------------------------------------------
source ~/.bashrc
conda activate qiime2-moshpit-2025.7
module load eth_proxy   # keep if your env/tools need web access

# --- PATHS -------------------------------------------------------------
home_dir="/cluster/home/$USER"
data_dir="/cluster/scratch/$USER/updog/scripts"
part_dir="$data_dir/partitioned_seqs"
results_dir="/cluster/scratch/$USER/updog/results/map_reads"

mkdir -p "$results_dir" "$data_dir/logs"

# array index -> choose the partition number
PART_NUM="${SLURM_ARRAY_TASK_ID}"

READS_QZA="${part_dir}/seqs_${PART_NUM}.qza"
INDEX_QZA="${data_dir}/mags_derep_all_domains_index.qza"
OUT_QZA="${results_dir}/reads_to_derep_mags_${PART_NUM}.qza"

# sanity checks
if [[ ! -f "$READS_QZA" ]]; then
  echo "ERROR: Missing reads file: $READS_QZA" >&2
  exit 1
fi
if [[ ! -f "$INDEX_QZA" ]]; then
  echo "ERROR: Missing index: $INDEX_QZA" >&2
  exit 1
fi

export OMP_NUM_THREADS="$SLURM_CPUS_PER_TASK"

# --- RUN ---------------------------------------------------------------
mosh assembly map-reads \
  --i-index  "$INDEX_QZA" \
  --i-reads  "$READS_QZA" \
  --p-threads "$SLURM_CPUS_PER_TASK" \
  --p-seed 100 \
  --o-alignment-maps "$OUT_QZA"

echo "Done: $(basename "$READS_QZA") -> $(basename "$OUT_QZA")"