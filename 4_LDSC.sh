#!/bin/bash
#SBATCH -t 05:30:00
#SBATCH --mem=50G
#SBATCH -o GSMR.log.out
#SBATCH -e GSMR.errlog.out
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=b.lin@umcutrecht.nl

cd /hpc/hers_en/blin/UkBiobank/GWAS/LDSC/ldsc

module load python 

while IFS= read -r line; do
./munge_sumstats.py \
--sumstats /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/$line".ma.gz" \
--out   /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/$line \
--merge-alleles w_hm3.noMHC.snplist
done /< hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/list


while IFS= read -r line; do
./ldsc.py \
--rg  /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/STA.sumstats.gz,"//hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/"$line".sumstats.gz" --no-intercept --ref-ld-chr eur_w_ld_chr/ --w-ld-chr eur_w_ld_chr/  --out "/hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/smoking/STA_"$line"
done < /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/list


