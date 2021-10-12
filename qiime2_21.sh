#!/bin/sh
#SBATCH --job-name=qiime2_mites
#SBATCH --account=biomics
#SBATCH --partition=defq
#SBATCH --time=72:00:00
#SBATCH --mail-user=jean-francois.martin@supagro.fr
#SBATCH --mail-type=end
echo « Running on: $SLURM_NODELIST »

# qiime2.sif tools import --type 'SampleData[PairedEndSequencesWithQuality]' --input-path reads/ --input-format CasavaOneEightSingleLanePerSampleDirFmt --output-path mites_p21.qza

qiime2.sif cutadapt trim-paired --p-front-f file:forward_p2.fas --p-front-r file:reverse_p2.fas --p-error-rate 0.05 --p-times 1 --p-match-adapter-wildcards TRUE --verbose --p-minimum-length 100 --p-discard-untrimmed TRUE --i-demultiplexed-sequences mites_p21.qza --o-trimmed-sequences trimmed_mites_p21.qza

# qiime2.sif dada2 denoise-paired --i-demultiplexed-seqs trimmed_mites_p21.qza --p-trunc-len-f 220 --p-trunc-len-r 220 --p-chimera-method 'consensus' --p-n-reads-learn 10000 --p-hashed-feature-ids TRUE --o-table ASVS-table_mites_p21.qza --o-representative-sequences ASVS-sequences_mites_p21.qza --o-denoising-stats denoising-stats_mites_p21.qza --verbose
