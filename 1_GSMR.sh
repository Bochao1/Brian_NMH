{\rtf1\ansi\ansicpg1252\cocoartf2706
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\csgray\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww16040\viewh12300\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
#SBATCH -t 05:30:00\
#SBATCH --mem=50G\
#SBATCH -o GSMR.log.out\
#SBATCH -e GSMR.errlog.out\
#SBATCH --mail-type=FAIL\
#SBATCH --mail-user=b.lin@umcutrecht.nl\
\
dir=/hpc/hers_en/blin/\
gcta=
\f1\fs22 \cf2 \CocoaLigature0 /hpc/hers_en/blin/program/gcta-1.94.1-linux-kernel-3-x86_64/gcta64
\f0\fs24 \cf0 \CocoaLigature1 \
\
###reference files, 5000 random selected UKB samples plink file list \
plinklist=/hpc/hers_en/blin/Publicdata/UKB/GSMR/reference/ref.file.list\
EXP_LIST=$dir/enigma/TSA_MTH.list\
OUT_LIST=$dir/out/double_nomral/OUT.list\
\
##perfom bidrectional forward univariable MR\
\
$gcta \\\
--mbfile  $\{plinklist\} \\\
--gsmr-file $\{EXP_LIST\} $\{OUT_LIST\} \\\
--gsmr-snp-min 2 \\\
--clump-r2 0.01 \\\
--effect-plot \\\
--gsmr-direction 2 \\\
--out $dir/BI_GSMMR_Brain \\\
--diff-freq 0.2 \\\
--thread-num 10\
 
\f1\fs22 \cf2 \CocoaLigature0 --gwas-thresh 1e-7}