# Databricks notebook source
#load necessary packages
library(igraph)
library(dplyr)
library(tidyverse)

#load data, this dataset contains attributes
eie <- read.table("https://web.archive.org/web/20200506190927/http://moreno.ss.uci.edu/eies_attribute.dat",skip = 41,nrow=32)

#rename columns to match attributes they represent
eie = dplyr::rename(eie,c( "Citations" = "V1" , "Discipline"="V2" ))

#read data from time point 1
eie1 <- read.table("https://web.archive.org/web/20200506190922/http://moreno.ss.uci.edu/eies.dat", skip=74,nrow=32)

#calculate degree for each person at time 1 (0 means do not know the person, 1 means they at least know of the person)
eie1_degree <- ifelse(eie1>0,1,0)

xmg=graph.adjacency(as.matrix(eie1_degree),mode="directed",weighted=NULL,diag = F) 

#assign degree time 1 variable to dataset with attributes 
eie$degree_t1 <- degree(xmg) 

#read data from time point 2
eie2 <- read.table("https://web.archive.org/web/20200506190922/http://moreno.ss.uci.edu/eies.dat", skip=106,nrow=32)

eie2_degree <- ifelse(eie2>0,1,0)
xmg=graph.adjacency(as.matrix(eie2_degree),mode="directed",weighted=NULL,diag = F)

#assign degree time 2 variable to dataset with attributes
eie$degree_t2 <- degree(xmg)

#calculate average relationship strength for each person by taking the mean from time 1 and time 2 datasets and assigning it to attribute dataset
eie$rel_strength_t1 <- rowMeans(eie1[,1:32],na.rm=T)
eie$rel_strength_t2 <- rowMeans(eie2[,1:32],na.rm=T)

#calculate another degree time 2 variable that is more conservative (0 means at most know of the person, 1 means at least have met the person)
#use this variable for exploratory analysis
eie2_degree_r <- ifelse(eie2>1,1,0)
xmg=graph.adjacency(as.matrix(eie2_degree_r),mode="directed",weighted=NULL,diag = F) 
eie$degree_t2_r <- degree(xmg)


