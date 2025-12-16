#!/bin/bash
#SBATCH --job-name=func_step1_diamond
#SBATCH --output=logs/func_s1_%j.out
#SBATCH --error=logs/func_s1_%j.err
#SBATCH --time=05-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=normal
#SBATCH --mail-type=END
#SBATCH --array=1-10    

#to write in the terminal before sending the job
source ${HOME}/.bashrc
conda activate qiime2-moshpit-2025.7


data_dir=/cluster/scratch/$USER/updog
samples_dir=$data_dir/mags-derep-bacteria
output_dir=$data_dir/mags-derep-bacteria-orthologs
mkdir -p $output_dir

cd $data_dir

# Input file is directly the array index
SAMPLE_FILE=${samples_dir}/${SLURM_ARRAY_TASK_ID}.qza
BASENAME=${SLURM_ARRAY_TASK_ID}

echo "Running on file $SAMPLE_FILE"

mosh annotate search-orthologs-diamond \
  --i-seqs "$SAMPLE_FILE" \
  --i-db diamond_db.qza \
  --p-num-cpus 20 \
  --p-db-in-memory \
  --o-eggnog-hits "${output_dir}/${BASENAME}_eggnog_hits.qza" \
  --o-table "${output_dir}/${BASENAME}_eggnog_ft.qza" \
  --o-loci "${output_dir}/${BASENAME}_eggnog_loci.qza" \
  --verbose