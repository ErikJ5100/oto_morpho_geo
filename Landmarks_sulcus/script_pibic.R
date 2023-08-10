<<<<<<< HEAD

"""
análises morphogeo - pibics da galera
"""

rm(list = ls())

library (geomorph)
library (segmented)
library (Morpho)

#importar coordenadas landmarks
haem_todos <- readland.tps("Landmarks_SEO_TUDO.TPS", specID = "ID")

#importar classifiers
haem_class <- read.csv("Haemulidae_separados_final.csv")

#análise de procrustes

haem_gpa <- gpagen(haem_todos)

plot(haem_gpa)

#PCA
PCA <- gm.prcomp(haem_gpa$coords)


=======

"""
análises morphogeo - pibics da galera
"""

rm(list = ls())

library (geomorph)
library (segmented)
library (Morpho)

#importar coordenadas landmarks
haem_todos <- readland.tps("Landmarks_SEO_TUDO.TPS", specID = "ID")

#importar classifiers
haem_class <- read.csv("Haemulidae_separados_final.csv")

#procrustres

haem_gpa <- gpagen(haem_todos)
plot(haem_gpa)


summary (con_nobilis_gpa, consensus)

# tentativa de dividir os landmarks em dois subsets

#subset sulcus




>>>>>>> main
