#!/bin/bash

#SBATCH --job-name=rMATS_NMD
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user="j.m.van_der_molen@lumc.nl"
#SBATCH --mail-type="ALL"
#SBATCH --partition="short"
#SBATCH --mem=18G
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=8


SAMPLE=HG00096_ncbi

module load tools/miniconda/python3.12/24.9.2

source /share/software/tools/miniconda/3.12/24.9.2/etc/profile.d/conda.sh
conda activate /exports/sascstudent/jmvandermolen1/conda_envs/rmats_env

BASE=/exports/sascstudent/jmvandermolen1/Developer/drop_demo_fraser2/Data/rna_bam/with_nh/loo_groups
OUT=/exports/sascstudent/jmvandermolen1/Developer/rmats_turbo_SASC/NMD_24
TMP=/exports/sascstudent/jmvandermolen1/Developer/rmats_turbo_SASC/NMD_24/NMD_24_tmp
mkdir -p "$OUT" "$TMP"

rmats.py \
  --b1 b1.txt \
  --b2 b2.txt \
  --gtf /exports/sascstudent/jmvandermolen1/107432-004/Homo_sapiens.GRCh38.104.gtf \
  --od "$OUT" \
  --tmp "$TMP" \
  -t paired \
  --readLength 75 \
  --libType fr-unstranded \
  --novelSS \
  --nthread 8 \
  --statoff