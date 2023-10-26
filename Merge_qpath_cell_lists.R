##### Annotate cell detection events after each stage of filtering
library(openxlsx)
library(ggplot2)
library(Amelia)


setwd('~/Box/KK_lab/KK-HG_RSB-Projects/Aim 3- 10,1,0.1 ER/Aim 3 Analysis 2 10-6-23/Aim 5- 10,1,0.1 % Enrich Analysis 2 10-6-23/1%  L428 Detection Tracking/')

##########################################################################################################
#### Get files
##########################################################################################################
### Get the initial detections list
initial <- read.table(file="Initial Detections.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
nucleus <- read.table(file="Nucleus Area.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
nuclear <- read.table(file="Nuclear Circularity.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
dapi <- read.table(file="DAPI mean (removes bright artificacts on MF).txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
manual <- read.table(file="DAPI- manual removals.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
cd30_initial <- read.table(file="Initial CD30 Detections.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")
final <- read.table(file="Final Detections - includ. manual annotations of undetected cells.txt", header=T, sep="\t", check.names = FALSE, comment.char = "")

initial$initial <- 1
nucleus$nucleus_filter <- 1
nuclear$nuclear_filter <- 1
dapi$dapi_filter <- 1
manual$manual_filter <- 1
cd30_initial$cd30_initial <- 1
final$final_detections <- 1

all <- merge(merge(merge(merge(merge(merge(initial, nucleus, all=T), nuclear, all=T), dapi, all=T), manual, all=T), cd30_initial, all=T), final, all=T)

## Replace all the NAs generated with 0
repNA <- function(x) {
  x[is.na(x)] <- 0
  return(x)
}

## Eliminate NAs in count columns using repNA function
all[,63:ncol(all)] <- lapply(all[,63:ncol(all)], function(x) repNA(x))


##########################################################################################################
#### Export tables
##########################################################################################################
write.table(all, file="Merged_files.txt", quote = F, row.names = F, sep = "\t")

##########################################################################################################
#### Additional analysis
##########################################################################################################
# library(mlbench)
# library(caret)




# initial$initial <- 1
# dapi$dapi_filter <- 1
# nuclear$nuclear_filter <- 1
# manual$manual_filter <- 1
# 
# all <- merge(merge(merge(initial, dapi, all.x=T), nuclear, all.x=T), manual, all.x=T)
# 
# ## Replace all the NAs generated with 0
# repNA <- function(x) {
#   x[is.na(x)] <- 0
#   return(x)
# }
# 
# ## Eliminate NAs in count columns using repNA function
# all[,63:ncol(all)] <- lapply(all[,63:ncol(all)], function(x) repNA(x))
