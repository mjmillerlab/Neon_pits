#!/bin/bash

# USEARCH PIPELINE FOR NON-OVERLAPPING PAIRED READS

# Copy just R1 into a file

# Unzip read files (USEARCH doesn't like zipped files)
gunzip *fastq.gz

# Rename reads so that sample name is included
./usearch11.0.667_i86osx32 -fastx_relabel BLAN-*R1_001.fastq -prefix BLAN. -fastqout BLAN_R1.fastq -keep_annots
./usearch11.0.667_i86osx32 -fastx_relabel KONZ-*R1_001.fastq -prefix KONZ. -fastqout KONZ_R1.fastq -keep_annots
./usearch11.0.667_i86osx32 -fastx_relabel LAJA-*R1_001.fastq -prefix LAJA. -fastqout LAJA_R1.fastq -keep_annots
./usearch11.0.667_i86osx32 -fastx_relabel OAES-*R1_001.fastq -prefix OAES. -fastqout OAES_R1.fastq -keep_annots
./usearch11.0.667_i86osx32 -fastx_relabel ORNL-*R1_001.fastq -prefix ORNL. -fastqout ORNL_R1.fastq -keep_annots
./usearch11.0.667_i86osx32 -fastx_relabel SCBI*R1_001.fastq -prefix SCBI. -fastqout SCBI_R1.fastq -keep_annots
./usearch11.0.667_i86osx32 -fastx_relabel SERC-*R1_001.fastq -prefix SERC. -fastqout SERC_R1.fastq -keep_annots
./usearch11.0.667_i86osx32 -fastx_relabel TALL-*R1_001.fastq -prefix TALL. -fastqout TALL_R1.fastq -keep_annots

# move original files to backup
mkdir originals
mv *L001_R1_001.fastq originals

# Merge files
mkdir merged
cp usearch11.0.667_i86osx32 merged/usearch11.0.667_i86osx32
cat *.fastq > merged/merged.fq
cd merged

# Remove priming sites from all reads (and end of reads where quality dips)
./usearch11.0.667_i86osx32 -fastx_truncate merged.fq -stripleft 25 -stripright 50 -fastqout stripped.fq

# check that the sample labels are correct
./usearch11.0.667_i86osx32 -fastx_get_sample_names stripped.fq -output samples.txt

# Run remaining code as if overlapping. Make sure to run script on both R1 and R2. Compare output
