""" análises morphogeo - pibics da galera """

rm(list = ls())

library (geomorph)
library (segmented)
library (Morpho)
library (ggplot2)
library (ggfortify)

#importar coordenadas landmarks
haem_sulcus <- readland.tps("Landmarks_S_TUDO.TPS", specID = "ID")

#importar classifiers
haem_class <- read.csv("Haemulidae_separados_final.csv")

#análise de procrustes

haem_sulcus_gpa <- gpagen(haem_sulcus)

plot(haem_sulcus_gpa)

#transformar os classifiers em fatores

habitat <- factor(haem_class$Habitat)
maturacao <- factor (haem_class$Maturacao)
local <- factor (haem_class$Localidade)
especie <- factor (haem_class$Pop)
sexo <- factor (haem_class$Sexo)

#PCA
PCA <- gm.prcomp(haem_sulcus_gpa$coords, scale = TRUE)

plot(PCA, col = habitat)
plot (PCA, col = maturacao)

summary(PCA) #visualização resultados da PCA
scores.PCA <- PCA$x #scores de cada indivíduo
eigen.PCA <- PCA$d

#análise da disparidade morfológica entre grupos

haem_gdf <- geomorph.data.frame (haem_sulcus_gpa, especie = especie, habitat = habitat,
                                 maturacao = maturacao, sexo = sexo) #criar um geomorph data frame

haem_sulcus_disparidade <- morphol.disparity (haem_sulcus_gpa$coords ~ 1, groups = ~ habitat * maturacao, 
                   data = haem_gdf, print.progress = FALSE)

print(haem_sulcus_disparidade)

haem_fit <- procD.lm(haem_sulcus_gpa$coords ~1, groups = ~habitat * maturacao, 
         data = haem_gdf, print.progress = FALSE)

#alometria usando a pca
pc.plot <- plotAllometry(haem_fit, haem_gdf$Csize, logsz = TRUE,
                         method = "size.shape", pch = 19, 
                         col = as.numeric(interaction(haem_gdf$habitat, haem_gdf$maturacao)))


#Canonical Variate Analysis

haem_sulcus_cva <- CVA (scores.PCA, habitat)

typprobs <- typprobClass (haem_sulcus_cva$CVscores, group = maturacao)

if (require(car)) {
  scatterplot(haem_sulcus_cva$CVscores [,1], haem_sulcus_cva$CVscores[,2], 
              groups = typprobs$groupaffinCV, smooth = FALSE, reg.line = FALSE)
}

# plot da CVA

plot (haem_sulcus_cva$CVscores, col = habitat, pch = as.numeric (maturacao), typ = "n", asp = 1,
      xlab = paste ("1st canonical axis", paste (round(haem_sulcus_cva$Var[1,2], 1),"%")),
      ylab = paste ("2nd canonical axis", paste (round(haem_sulcus_cva$Var[2,2], 1), "%")))

text (haem_sulcus_cva$CVscores, as.character(maturacao), col = as.numeric(habitat), cex = 0.5)

#adicionar convex hull

for (jj in 1:length (levels (habitat))) {
  ii = levels(maturacao) [jj]
  kk = chull (haem_sulcus_cva$CVscores[habitat == ii, 1:2])
  lines (haem_sulcus_cva$CVscores[habitat == ii, 1][c(kk, kk[1])],
         haem_sulcus_cva$CVscores[habitat == ii, 2][c(kk, kk[1])], col = jj)
}





















'''
esse bloco abaixo era uma tentativa de replicar a função segment pra definir
quantos PCs explicavam a variabilidade
'''
#pca.lm <- lm(eigen.PCA ~ scores.PCA)

#teste <- segmented(pca.lm, seg.Z = ~scores.PCA)
plot(teste)

