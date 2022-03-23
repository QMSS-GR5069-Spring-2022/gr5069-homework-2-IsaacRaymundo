# Databricks notebook source
#load necessary package for visualization
library(sjPlot)

#create model and graph of degree at time 2 predicting citations
m1 <- lm(Citations~degree_t2,eie);plot_model(m1,"pred")

#create model and graph of degree at time 2 predicting citations while controlling for relationship strength and discipline
m2 <- lm(Citations~degree_t2 + rel_strength_t2 + Discipline,eie);plot_model(m2,"pred",terms = "degree_t2")

#create model and graph for the same analyses as above but with the conservative degree measure
m3 <- lm(Citations~degree_t2_r,eie);plot_model(m3,"pred")

m4 <- lm(Citations~degree_t2_r + rel_strength_t2 + Discipline,eie);plot_model(m4,"pred",terms = "degree_t2_r")

#create model and graph to see if relationship strength affects the relationship of degree (time 2) on citations
m5 <- lm(Citations~degree_t2*rel_strength_t2 + Discipline,eie);plot_model(m5,"int",mdrt.values = "meansd")

#with conservative degree measure
m6 <- lm(Citations~degree_t2_r*rel_strength_t2 + Discipline,eie);plot_model(m6,"int",mdrt.values = "meansd")
