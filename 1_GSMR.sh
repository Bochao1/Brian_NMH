#!/bin/bash
#SBATCH -t 05:30:00
#SBATCH --mem=50G
#SBATCH -o GSMR.log.out
#SBATCH -e GSMR.errlog.out
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=b.lin@umcutrecht.nl

dir=/hpc/hers_en/blin/
gcta=/hpc/hers_en/blin/program/gcta-1.94.1-linux-kernel-3-x86_64/gcta64

###reference files, 5000 random selected UKB samples plink file list 
plinklist=/hpc/hers_en/blin/Publicdata/UKB/GSMR/reference/ref.file.list
EXP_LIST=$dir/enigma/TSA_MTH.list
OUT_LIST=$dir/out/double_nomral/OUT.list

##perfom bidrectional forward univariable MR

$gcta \
--mbfile  ${plinklist} \
--gsmr-file ${EXP_LIST} ${OUT_LIST} \
--gsmr-snp-min 2 \
--clump-r2 0.01 \
--effect-plot \
--gsmr-direction 2 \
--out $dir/BI_GSMMR_Brain \
--diff-freq 0.2 \
--thread-num 10
 --gwas-thresh 1e-7