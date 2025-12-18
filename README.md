# MAG Analysis Pipeline – Euler Jobs and Jupyter Notebooks

This repository contains the workflow used to process, evaluate, dereplicate, classify, quantify, and analyze metagenome-assembled genomes (MAGs). It includes both Slurm job scripts submitted to the Euler cluster and the Jupyter notebooks that document each processing step.

## Repository Structure

### jobs/

Slurm job files and directories containing the cluster jobs for each MAG-processing stage.

* **qc/**
  MAG quality control, filtering, completeness/contamination checks, and statistics.

* **dereplication/**
  Jobs for dereplicating MAGs to obtain a non-redundant genome set.

* **taxonomy-classification/**
  Jobs for assigning taxonomy to MAGs.

* **abundance_estimation/**
  Jobs producing per-sample MAG abundance profiles.

* **functional_annotation/**
  Jobs to identify and classify of the genes in the MAGs.

* **job_example.sbatch**
  Minimal template showing the structure of an Euler Slurm submission.

### scripts/

Jupyter notebooks documenting each stage of the MAG workflow.

* **mags_qc.ipynb**
  Quality control and selection of MAGs.

* **mags_dereplication.ipynb**
  Dereplication workflow and parameter explanation.

* **mags_taxonomy_classification.ipynb**
  Taxonomic classification of dereplicated MAGs with Kraken2.

* **functional_annotation.ipynb**
  Functional annotation of MAGs with EGGNOG.

* **abundance_estimation.ipynb**
  Computation of MAG abundances across samples.

* **taxonomy_analysis.ipynb**
  Summary and visualization of MAG-level taxonomy.

* **alpha_beta_diversity.ipynb**
  Diversity analyses using MAG abundance data.

* **differential_abundance_analysis**
  Differential abundance analyses using ANCOMBC and comparing the different subsitance mode.

## Recommended Notebook Order

1. **mags_qc.ipynb**
2. **mags_dereplication.ipynb**
3. **mags_taxonomy_classification.ipynb**
4. **abundance_estimation.ipynb**
5. **functional_annotation.ipynb** 
6. **alpha_beta_diversity.ipynb**
7. **differential_abundance_analysis**
8. **ML_classifier**
9. **protein_identification**



