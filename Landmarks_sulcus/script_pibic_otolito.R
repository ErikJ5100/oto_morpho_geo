""" análises morphogeo - pibics da galera """

rm(list = ls())

library (geomorph)
library (segmented)
library (Morpho)
library (ggplot2)
library (ggfortify)

#importar coordenadas landmarks
haem_oto <- readland.tps("Landmarks_O_TUDO.TPS", specID = "ID")

#importar classifiers
haem_class <- read.csv("Haemulidae_separados_final.csv")

#análise de procrustes

haem_oto_gpa <- gpagen(haem_oto)

plot(haem_oto_gpa)

#transformar os classifiers em fatores

habitat <- factor(haem_class$Habitat)
maturacao <- factor (haem_class$Maturacao)
local <- factor (haem_class$Localidade)
especie <- factor (haem_class$Pop)
sexo <- factor (haem_class$Sexo)

#PCA
PCA <- gm.prcomp(haem_oto_gpa$coords, scale = TRUE)

plot(PCA, col = habitat)

plot (PCA, col = maturacao)

summary(PCA) #visualização resultados da PCA

scores.PCA <- PCA$x[,1:3] #scores de cada indivíduo

eigen.PCA <- PCA$d

print(eigen.PCA)

#análise da disparidade morfológica entre grupos

haem_gdf <- geomorph.data.frame (haem_oto_gpa, especie = especie, habitat = habitat,
                                 maturacao = maturacao, sexo = sexo) #criar um geomorph data frame

haem_oto_disparidade <- morphol.disparity (haem_oto_gpa$coords ~ 1, groups = ~ habitat * maturacao, 
                   data = haem_gdf, print.progress = FALSE)

print(haem_oto_disparidade)

#disparidade morfológica considerando alometria

haem_oto_disp_alom <- morphol.disparity(haem_oto_gpa$coords ~ haem_oto_gpa$Csize, groups = ~ habitat*maturacao,
                                        data = haem_gdf, print.progress = FALSE)


haem_fit <- procD.lm(haem_oto_gpa$coords ~1, groups = ~habitat * maturacao, 
         data = haem_gdf, print.progress = FALSE)

#alometria usando a pca
pc.plot <- plotAllometry(haem_fit, haem_gdf$Csize, logsz = TRUE,
                         method = "size.shape", pch = 19, 
                         col = as.numeric(interaction(haem_gdf$habitat, haem_gdf$maturacao)))

summary(pc.plot$size.shape.PCA)

fit3 <- procD.lm(haem_oto_gpa$coords ~ habitat, data = haem_gdf, iter = 0,
                 print.progress = FALSE)

plotAllometry(fit3, size = haem_gdf$Csize, logsz = T,
              method = "RegScore", pch = 19, col = as.factor(haem_gdf$especie))


#canonical variate analysis

cvall <- CVA(scores.PCA, habitat)



