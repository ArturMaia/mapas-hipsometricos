library(rnaturalearth)
library(ggplot2)
library(maptools)
library(raster)
library(rgdal)
library(sf)
library(RColorBrewer)
library(dplyr)
library(geodata)
library(geobr)
library(elevatr)

#PALETA DE CORES
cores <-c('#bcd2a4','#89d2a4','#28a77e',
          '#90b262','#ddb747','#fecf5b',
          '#da9248','#b75554','#ad7562',
          '#b8a29a','#9f9e98')


#MUNDIAL
terra<-getData('worldclim', var='alt', res=10)
cores <- colorRampPalette(cores)(250)
plot(terra,col=cores,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",
                      side=3, line=0.5, cex=0.8))+title('Hipsometria mundial')


#CONTINENTAL
continente<-ne_countries(continent  = 'south america' , returnclass = 'sf')
altitude<- getData('worldclim', var='alt' , res=10)
sam<-crop(altitude,continente)
cores <- colorRampPalette(cores)(250)
plot(sam,col=cores,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",
                      side=3, line=0.5, cex=0.8))+title('Hipsometria da América do Sul')


#PAÍS
br<-getData('alt', country='Brazil', mask=TRUE)
cores <- colorRampPalette(cores)(250)
plot(br,col=cores,
     legend.width= 1.5,  axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",
                      side=3, line=0.5, cex=0.6))+title('Hipsometria do Brasil')

#ESTADO
pa<-read_state(code_state = "PA", year= 2010)
topo<-get_elev_raster(pa,z=8,clip ='location')
cores <- colorRampPalette(cores)(250)

plot(pa$geom)+
  plot(topo,add=T,col=cores,legend.width= 1.5,axis.args=list(cex.axis=0.6),
       legend.args=list(text="Altitude (mt)",
                        side=3, line=0.5, cex=0.8))+
  title('Hipsometria do Estado do Pará')


#MUNICIPIO
file.choose()
img<-raster("C:\\Users\\luiza\\OneDrive\\Área de Trabalho\\prof\\ananin.tif")

ananindeua<-read_municipality(code_muni = 1500800)
cores <- colorRampPalette(cores)(250)
recortado<-crop(img,ananindeua)
topoananin<-mask(recortado,ananindeua)
plot(img,col=cores)
plot(topoananin,col=cores)
plot(recortado,col=cores)


plot(recortado,col=cores,legend.width= 1.5,axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",
                      side=3, line=0.5, cex=0.8))+
  plot(ananindeua$geom,add=T)+title('Hipsometria de Ananindeua')

plot(topoananin,col=cores,legend.width= 1.5,axis.args=list(cex.axis=0.6),
     legend.args=list(text="Altitude (mt)",
                      side=3, line=0.5, cex=0.8))+title('Hipsometria de Ananindeua')

