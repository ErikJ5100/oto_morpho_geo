
"""
análises morphogeo - pibics da galera
"""

rm(list = ls())

library (geomorph)
library (segmented)
library (Morpho)

#importar coordenadas landmarks
haem_todos <- readland.tps("Landmarks_TODOS.TPS", specID = "ID")

#importar classifiers
haem_class <- read.csv("Haemulidae_separados_final.csv")

#procrustres

haem_gpa <- gpagen(haem_todos)
plot(haem_gpa)


summary (con_nobilis_gpa, consensus) 
