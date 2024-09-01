{\rtf1\ansi\ansicpg1252\cocoartf2706
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww19940\viewh16860\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 setwd('/Users/blin/Documents/ENIGMA/gsmr/')\
rm(list = ls(all.names = TRUE))\
library(TwoSampleMR)\
source("GSMR_plot.R")\
#options(scipen = 1)\
#options(digits = 2)\
#options(stringsAsFactors = F)\
#------------------read outcome\
exposure <- read_exposure_data(\
  filename = '/hpc/hers_en/blin/Publicdata/ENIGMA/TSA.txt.gz',  sep = ' ',   snp_col = 'SNP',\
  beta_col = 'b',   se_col = 'se',   effect_allele_col = 'A1',   other_allele_col = 'A2',\
  eaf_col = 'freq',   pval_col = 'p',   samplesize_col="N",\
  phenotype_col="anything")\
head(exposure)\
exposure$exposure<-'CP'\
exposure_instru<- clump_data(exposure)\
outcome <- read_outcome_data( snps = NULL,\
                              filename = "/hpc/hers_en/blin/Publicdata/ENIGMA/exposure/STA_'CP'.txt.gz",\
                              sep = " ",\
                              snp_col = "SNP",\
                              beta_col = "b",\
                              se_col = "se",\
                              effect_allele_col = "A1",\
                              other_allele_col = "A2",\
                              eaf_col = "freq",\
                              pval_col = "p",\
                              samplesize_col="N")\
clump_data<- clump_data(dat_small)\
\
#Perform IVW, Weighted Median, and Egger model\
\
res <- mr(clump_data,method_list =c('mr_ivw','mr_weighted_median','mr_egger_regression'))\
res\
\
#check the intercept from Egger model \
\
egger_inter<-mr_pleiotropy_test(clump_data)\
egger_inter$egger_intercept\
\
#Perform  MR_PRESSON\
\
press<- run_mr_presso(clump_data, NbDistribution = 1000, SignifThreshold = 0.05)\
\
#----------------------------------------\
#------------------read GSMR results \
#----------------------------------------\
gsmr_data_plot <- read_gsmr_data('Uni_MR_PGC_COVID.eff_plot.gz')\
gsmr_res_c$p=as.numeric(paste(gsmr_res_c$p))\
gsmr_res=as.data.frame(gsmr_data_plot$snp_effect)\
gsmr<- gsmr_res_c[gsmr_res_c$Exposure=='CP' & gsmr_res_c$Outcome =='D1', ]\
\
\
#-----------scatter plots \
source("GSMR_plot.R")\
pdf(paste('./res/scatter/',gsmr$Exposure,'_',gsmr$Outcome,'_scatter.pdf',sep=''),width = 8,height = 8)\
par(mar = c(5.1, 5.1, 4.1, 2.1))\
plot_gsmr_effect(gsmr_data_plot, gsmr_res_c$Exposure[var], gsmr_res_c$Outcome[var], colors()[75])\
abline(0, res$b[1], lwd=4, lty=1, col="black")\
abline(0,res$b[2], lwd=4, lty=2, col="green")\
abline(egger_inter$egger_intercept, res$b[3], lwd=4, lty=2, col="darkorange3")\
abline(0, gsmr$bxy, lwd=4, lty=4, col="blue")\
abline(0, press[[1]]$`Main MR results`$`Causal Estimate`[1], lwd=4, lty=3, col="orchid2")\
abline(h=0, lwd=1, lty=2, col="grey")\
abline(v=0, lwd=1, lty=2, col="grey")\
box() #draw box around graph\
legend( "bottomleft", \
        legend=c(expression(paste( "IVW" )), \
                 expression(paste("weighted median")),\
                 expression(paste( "MR-Egger")),\
                 expression(paste("GSMR")),\
                 expression(paste("PRESSO"))), cex = 0.75, \
        col=c('black','green','darkorange3','blue','orchid2'), lwd=1, lty=c(2,2,2,3,4),merge=FALSE)\
dev.off()\
\
## Qstatitsic \
heterogeneity_results<-mr_heterogeneity(clump_data , method_list=c("mr_ivw","mr_egger_regression"))\
heterogeneity_results\
\
##F statitsics\
F = mean(clump_data$beta.exposure^2/clump_data$se.exposure^2)\
F \
\
#I2 for Egger model\
mrinput=MendelianRandomization::mr_input(bx =clump_data$beta.exposure, bxse =clump_data$se.exposure, by =clump_data$beta.outcome,\
                                         byse =clump_data$se.outcome)\
egger<- MendelianRandomization::mr_egger(mrinput)\
I2<-egger@I.sq\
I2\
res\
\
# leave one out \
leave<-mr_leaveoneout(clump_data, parameters = default_parameters(), method = mr_ivw)\
pdf(paste('./res/leave_one_out/',gsmr$Exposure,'_',gsmr$Outcome,'_LOO.pdf',sep=''))\
mr_leaveoneout_plot(leave)\
dev.off()\
# # First estimate the Wald ratio for each SNP to see if any particular SNP is having a big influence on the overall causal estimate and save into an object.\
res_single <- mr_singlesnp(clump_data)\
\
##funnel plot \
pdf(paste('./res/funnel/',gsmr$Exposure,'_',gsmr$Outcome,'_funnel.pdf',sep=''))\
mr_funnel_plot(res_single)\
dev.off()\
\
# Create a forest plot to visualise heterogeneity.\
pdf(paste('./forest/',gsmr$Exposure,'_',gsmr$Outcome,'_forest.pdf',sep=''))\
mr_forest_plot(res_single)\
dev.off()}