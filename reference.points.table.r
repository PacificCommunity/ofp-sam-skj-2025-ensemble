## This Rcode caculates the reference points table from the ensemble models

rm(list=ls())

library(tidyverse)
library(magrittr)
library(FLR4MFCL)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

source("utilities/read.MFCLVar.r")
source("utilities/find.biggest.r")

set.seed(62834802)

## list the ensemble file names
sim.Dir <- "Simulations/"
file.names <- list.files(path = sim.Dir)

for(i in 1:length(file.names)){
  
  cur.Dir <- paste0(sim.Dir, file.names[i], "/")
  rep <- read.MFCLRep(find_biggest_rep(cur.Dir))
  var <- read.MFCLVar(paste0(cur.Dir, "skj.var"))
  
  max.yr <- as.character(rep@range["maxyear"])
  tmp.df <- data.frame(fmsy = FMSY(rep))
  tmp.df$fmult <- Fmult(rep)
  ## have to use inverse of Fmult instead of ffmsy from var file
  tmp.df$ffmsy <- 1 / Fmult(rep)
  # MSY by year (individual values are per quarter)
  tmp.df$MSY <- MSY(rep)*4
  tmp.df$sblatest <- c(SBlatest(rep)[,max.yr])
  tmp.df$sbrecent <- c(SBrecent(rep)[,max.yr])
  tmp.df$sbF0 <- c(SBF0(rep, mean_nyears = 10,
                        lag_nyears = 1)[,max.yr])
  tmp.df$sblatest.sbf0 <- c(SBSBF0latest(rep)[,max.yr])
  tmp.df$sblatest.sbmsy <- tmp.df$sblatest / BMSY(rep)
  tmp.df$sbmsy <- BMSY(rep) # Adult biomass at MSY
  tmp.df$sbmsy.sbf0 <- BMSY(rep) / tmp.df$sbF0
  tmp.df$sbrecent.sbf0 <- c(SBSBF0recent(rep)[,max.yr])
  tmp.df$sbrecent_sbmsy <- c(SBrecent(rep)[,max.yr]) / BMSY(rep)
  # YFcurrent
  # EQ yield at average F of period 2020-2023
  # Get EQ yield at effort multiplier of 1
  # Effort mult goes from 0 in steps of 0.01
  #effmult <- seq(from=0, to=1, by=0.01)
  #length(effmult) # = 101
  tmp.df$yfcurrent <- c(eq_yield(rep))[101]
  tmp.df$lrp <- 0.2*tmp.df$sbF0
  tmp.df$iter <- i
  rm(rep)
  
  if(!exists("ref.pts.df")){
    ref.pts.df <- tmp.df
  } else {
    ref.pts.df %<>% rbind(tmp.df)
  }
  rm(tmp.df)
}

save(ref.pts.df, file = "ref.points.results.Rdata")

summaryFun <- function(vec){
  mean <- mean(vec)
  median <- median(vec)
  min <- min(vec)
  q10 <- quantile(vec, probs = 0.1)
  q90 <- quantile(vec, probs = 0.9)
  max <- max(vec)
  
  return(c(mean = mean, median = median, min = min, q10, q90, max = max))
}

quants <- setdiff(colnames(ref.pts.df), "iter")

for(i in 1:length(quants)){
  tmp.df <- data.frame(matrix(summaryFun(ref.pts.df[,quants[i]]), nrow = 1))
  colnames(tmp.df) <- c("mean", "median", "min", "q10", "q90", "max")
  tmp.df$quant <- quants[i]
  
  if(!exists("ref.pts.tab")){
    ref.pts.tab <- tmp.df
  } else {
    ref.pts.tab %<>% rbind(tmp.df)
  }
  rm(tmp.df)
}

write.csv(ref.pts.tab, file = "ref.points.table.csv", row.names = F)
