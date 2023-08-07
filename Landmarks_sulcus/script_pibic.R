'''
análises morphogeo - pibics da galera
'''

rm(list = ls())

library (geomorph)

#importar coordenadas landmarks
con_nobilis <- readland.tps("Landmarks_CN.TPS", specID = "ID")

#importar classifiers
con_nobilis_class <- read.csv("CN_classifier.csv")

#procrustres

con_nobilis_gpa <- gpagen(con_nobilis)
plot(con_nobilis_gpa)


summary (con_nobilis_gpa, consensus) 
