""" análises morphogeo - pibics da galera """

rm(list = ls())

library (geomorph)
library (segmented)
library (Morpho)
library (ggplot2)
library (ggfortify)

#importar coordenadas landmarks
haem_todos <- readland.tps("Landmarks_SEO_TUDO.TPS", specID = "ID")

#importar classifiers
haem_class <- read.csv("Haemulidae_separados_final.csv")

#análise de procrustes

haem_gpa <- gpagen(haem_todos)

plot(haem_gpa)

#PCA
PCA <- gm.prcomp(haem_gpa$coords, scale = TRUE)

plot(PCA)

summary(PCA) #visualização dos resultados da PCA
scores.PCA <- PCA$x[1:34] #scores de cada indivíduo
eigen.PCA <- PCA$d

'''
esse bloco abaixo era uma tentativa de replicar a função segment pra definir
quantos PCs explicavam a variabilidade
'''
pca.lm <- lm(eigen.PCA ~ scores.PCA)

teste <- segmented(pca.lm, seg.Z = ~scores.PCA)
plot(teste)

