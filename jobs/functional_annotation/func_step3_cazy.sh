#!/bin/bash
#SBATCH --job-name=func_step2_eggnog
#SBATCH --output=func_step2_%j.out
#SBATCH --error=func_step2_%j.err
#SBATCH --time=5-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --partition=normal
#SBATCH --mail-type=END

# access to internet for the job
module load eth_proxy

data_dir=/cluster/scratch/cgebert/UpDoG/scripts

cd $data_dir

# activate QIIME2 MOSHPIT environment (robuste Variante)
source /cluster/home/cgebert/miniconda3/etc/profile.d/conda.sh
conda activate qiime2-moshpit-2025.10

set -euo pipefail

echo "==== Step 3: extract-annotations (CAZy) ===="

mosh annotate extract-annotations \
    --i-ortholog-annotations eggnog_annotations.qza \
    --p-annotation caz \
    --p-max-evalue 0.0001 \
    --o-annotation-frequency caz_annot_ft.qza \
    --verbose

echo "==== Step 3 fertig ===="
