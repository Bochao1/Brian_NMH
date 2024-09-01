{\rtf1\ansi\ansicpg1252\cocoartf2706
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww19780\viewh17300\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #----------------------------multivariable MR\
library(MendelianRandomization)\
\
data <- read,table('MVMR.txt')\
res=as.data.frame(datat$snp_effect)\
res_mv_prune<- clump_data(res)\
\
gsmr_res_mv_prune <-subset(gsmr_res_mv_prune, select = c(exp.id.sub, betas.exp,ses.exp, betas.out,ses.out ) )\
head(gsmr_res_mv)\
\
  by= as.numeric(paste(gsmr_res[,betas.out]))  ;byse= as.numeric(paste(gsmr_res[,ses.out]))\
  bx=as.matrix(bx); bxse=as.matrix(bxse)\
  \
  MR_input=MendelianRandomization::mr_mvinput(bx= bx, bxse=bxse,\
                                              by=by ,byse=  byse)\
  \
  resultsivw=MendelianRandomization::mr_mvivw(MR_input,distribution="t-dist",model="fixed")\
  resultsivw\
  \
  resultsegger=MendelianRandomization::mr_mvegger(MR_input, orientate = 1,distribution="t-dist")\
  resultsegger\
}