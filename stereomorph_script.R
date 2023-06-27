library(StereoMorph)

# código para iniciar a aplicação
# imagge.file = pasta onde estão as imagens
# shapes.file = arquivo criado com os valores de landmarks e curvas
# lanmarks.ref = arquivo de texto com a lista de pontos a serem marcados
# curves.ref = arquivo de texto com a lista de curvas a serem marcadas

digitizeImage(image.file = 'teste', shapes.file = 'shapes', 
              landmarks.ref = 'landmarks_erik.txt', 
              curves.ref = 'curves_erik.txt')


