##### Annotate cell detection events after each stage of filtering
library(openxlsx)
library(ggplot2)


setwd('~/Box/KK_lab/KK-HG_RSB-Projects/MF - ER_MF Analysis_staining opts for MF/Aim 5 - 10,1,0.1 ER Attempt 4 with cellsave 3 9-27-23/Aim 5 Analysis 2 10-6-23/Aim 5- 10,1,0.1 % Enrich Analysis 2 10-6-23/100% L428 Detection Tracking/')

##########################################################################################################
#### Get files
##########################################################################################################
### Get the initial detections list
initial <- read.table(file="Initial Detections.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
dapi <- read.table(file="DAPI mean (removes bright artificacts on MF).txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
nuclear <- read.table(file="Nuclear Circularity Cutoff.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
manual <- read.table(file="Manual Removals.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")


initial$initial <- "not filtered"
dapi$dapi_filter <- "not filtered"
nuclear$nuclear_filter <- "not filtered"
manual$manual_filter <- "not filtered"

all <- merge(merge(merge(initial, dapi, all.x=T), nuclear, all.x=T), manual, all.x=T)

#all[is.na(all$dapi),"dapi"] <- "filtered"
##########################################################################################################
#### Export tables
##########################################################################################################
write.table(all, file="Merged_files.txt", quote = F, row.names = F, sep = "\t")




initial$initial <- 1
dapi$dapi_filter <- 1
nuclear$nuclear_filter <- 1
manual$manual_filter <- 1

all <- merge(merge(merge(initial, dapi, all.x=T), nuclear, all.x=T), manual, all.x=T)

## Replace all the NAs generated with 0
repNA <- function(x) {
  x[is.na(x)] <- 0
  return(x)
}

## Eliminate NAs in count columns using repNA function
all[,63:ncol(all)] <- lapply(all[,63:ncol(all)], function(x) repNA(x))
