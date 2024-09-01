{\rtf1\ansi\ansicpg1252\cocoartf2706
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww20680\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
#SBATCH -t 05:30:00\
#SBATCH --mem=50G\
#SBATCH -o GSMR.log.out\
#SBATCH -e GSMR.errlog.out\
#SBATCH --mail-type=FAIL\
#SBATCH --mail-user=b.lin@umcutrecht.nl\
\
cd /hpc/hers_en/blin/UkBiobank/GWAS/LDSC/ldsc\
\
module load python \
\
while IFS= read -r line; do\
./munge_sumstats.py \\\
--sumstats /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/$line".ma.gz" \\\
--out   /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/$line \\\
--merge-alleles w_hm3.noMHC.snplist\
done /< hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/list\
\
\
while IFS= read -r line; do\
./ldsc.py \\\
--rg  /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/STA.sumstats.gz,"//hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/"$line".sumstats.gz" --no-intercept --ref-ld-chr eur_w_ld_chr/ --w-ld-chr eur_w_ld_chr/  --out "/hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/smoking/STA_"$line"\
done < /hpc/hers_en/blin/Publicdata/ENIGMA/ldsc/out/list\
\
}