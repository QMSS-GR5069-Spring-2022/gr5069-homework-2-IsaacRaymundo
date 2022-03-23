# Databricks notebook source
#read data

eie <- read.csv("https://raw.githubusercontent.com/QMSS-GR5069-Spring-2022/gr5069-homework-2-IsaacRaymundo/main/SocialNetworksData_clean.csv")

#rename variables

#run model to test if degree at time 2 predicts citations
m1 <- lm(Citations~degree_t2,eie);summary(m1)

#run model to test if degree at time 2 predicts citations while controlling for relationship strength and discipline
m2 <- lm(Citations~degree_t2 + rel_strength_t2 + Discipline,eie);summary(m2)

#run the same modesl as above but with the conservative degree measure
m3 <- lm(Citations~degree_t2_r,eie);summary(m3)

m4 <- lm(Citations~degree_t2_r + rel_strength_t2 + Discipline,eie);summary(m4)

#test to see if relationship strength affects the relationship of degree (time 2) on citations
m5 <- lm(Citations~degree_t2*rel_strength_t2 + Discipline,eie);summary(m5)

#with conservative degree measure
m6 <- lm(Citations~degree_t2_r*rel_strength_t2 + Discipline,eie);summary(m6)
