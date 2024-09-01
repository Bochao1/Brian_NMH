#----------------------------multivariable MR
library(MendelianRandomization)

data <- read,table('MVMR.txt')
res=as.data.frame(datat$snp_effect)
res_mv_prune<- clump_data(res)

gsmr_res_mv_prune <-subset(gsmr_res_mv_prune, select = c(exp.id.sub, betas.exp,ses.exp, betas.out,ses.out ) )
head(gsmr_res_mv)

  by= as.numeric(paste(gsmr_res[,betas.out]))  ;byse= as.numeric(paste(gsmr_res[,ses.out]))
  bx=as.matrix(bx); bxse=as.matrix(bxse)
  
  MR_input=MendelianRandomization::mr_mvinput(bx= bx, bxse=bxse,
                                              by=by ,byse=  byse)
  
  resultsivw=MendelianRandomization::mr_mvivw(MR_input,distribution="t-dist",model="fixed")
  resultsivw
  
  resultsegger=MendelianRandomization::mr_mvegger(MR_input, orientate = 1,distribution="t-dist")
  resultsegger

