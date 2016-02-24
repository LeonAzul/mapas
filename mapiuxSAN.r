#In R

library(shapefiles)
library(maptools)
library(rgdal)
library(maps)
library(RColorBrewer)

setwd("c:\\data\\1new\\mapas\\municipio")
rm(list = ls())

### IMPORTA Y TRANSFORMA A PUNTOS LAS FRONTERAS DE LOS ESTADOS
# edo<-read.shape("c:/data/1new/mapas/entidad/ENTIDAD.shp") #ESTA ES FUNCION DE MAPTOOLS QUE TOMA DE LOS 3 COMPONENTES ESRI
# ###DEBE DE HABER UN MODO MAS EFICIENTE DE HACER ESTO QUE TARDA 30 MINUTOS###
# edoPts<-data.frame(x=edo$Shapes[[1]]$verts[,1], 
#                    y=edo$Shapes[[1]]$verts[,2], 
#                    ID=edo$att.data$ID[1],
#                    EDO=edo$att.data$NOMBRE[1])
# for (i in 2:32){
#     tmp<-data.frame(x=edo$Shapes[[i]]$verts[,1], 
#                     y=edo$Shapes[[i]]$verts[,2], 
#                     ID=edo$att.data$ID[i],
#                     EDO=edo$att.data$NOMBRE[i])
#     edoPts<-rbind(edoPts,tmp) 
#     cat("processing ID",i,"\n") }
# edoPts$EDON <- edoPts$ID; edoPts$ID <- NULL
# edoPts$EDON[edoPts$EDON==8] <- 33
# for (i in 9:27){edoPts$EDON[edoPts$EDON==i] <- i-1}
# edoPts$EDON[edoPts$EDON==33] <- 27
# save(edoPts, file="c:/data/1new/mapas/entidad/entidadPorPuntos.txt")
load(file="c:/data/1new/mapas/entidad/entidadPorPuntos.txt")

#Hay 1 tutorial útil en http://geography.uoregon.edu/GeogR/topics/maps01.htm
#Otro muy completo: http://www.nceas.ucsb.edu/scicomp/GISSeminar/UseCases/ReadEsriShapefiles/ReadEsriShapefiles.html
#HAY QUE EDITAR EL COMPONENTE .DBF PARA INCORPORAR LA INFORMACION QUE SE QUIERA ANALIZAR
mun<-read.shape("MUNICIPIO2005.shp") #ESTA ES FUNCION DE MAPTOOLS QUE TOMA DE LOS 3 COMPONENTES ESRI
#mun<-read.shape("MUNICIPIO2005_SimplifyPolygo.shp") #ESTA ES FUNCION DE MAPTOOLS QUE TOMA DE LOS 3 COMPONENTES ESRI

###DEBE DE HABER UN MODO MAS EFICIENTE DE HACER ESTO QUE TARDA 30 MINUTOS###
# munPts<-data.frame(x=mun$Shapes[[1]]$verts[,1], 
#                    y=mun$Shapes[[1]]$verts[,2], 
#                    ID=mun$att.data$ID[1], 
#                    ENT=mun$att.data$ENT[1])
# for (i in 2:2441){
#     tmp<-data.frame(x=mun$Shapes[[i]]$verts[,1], 
#                     y=mun$Shapes[[i]]$verts[,2], 
#                     ID=mun$att.data$ID[i], 
#                     ENT=mun$att.data$ENT[i])
#     munPts<-rbind(munPts,tmp) 
#     cat("processing ID",i,"\n") }
# save(munPts, file="municipio2005porPuntos_SimplifyPolygo.txt")
load(file="municipio2005porPuntos.txt")
#load(file="municipio2005porPuntos_SimplifyPolygo.txt")

#RESUMENES
#summary(mun)
#attributes(mun$att.data)
#attributes(mun$Shapes)
#summary(mun$att.data$CANDSPAN)

#SACA IDs DE ESTADOS
idags <- mun$att.data$ID[mun$att.data$ENT == 1]
idbc <-  mun$att.data$ID[mun$att.data$ENT == 2]
idbcs <- mun$att.data$ID[mun$att.data$ENT == 3]
idcam <- mun$att.data$ID[mun$att.data$ENT == 4]
idcoa <- mun$att.data$ID[mun$att.data$ENT == 5]
idcol <- mun$att.data$ID[mun$att.data$ENT == 6]
idcps <- mun$att.data$ID[mun$att.data$ENT == 7]
idcua <- mun$att.data$ID[mun$att.data$ENT == 8]
iddf <-  mun$att.data$ID[mun$att.data$ENT == 9]
iddgo <- mun$att.data$ID[mun$att.data$ENT == 10]
idgua <- mun$att.data$ID[mun$att.data$ENT == 11]
idgue <- mun$att.data$ID[mun$att.data$ENT == 12]
idhgo <- mun$att.data$ID[mun$att.data$ENT == 13]
idjal <- mun$att.data$ID[mun$att.data$ENT == 14]
idmex <- mun$att.data$ID[mun$att.data$ENT == 15]
idmic <- mun$att.data$ID[mun$att.data$ENT == 16]
idmor <- mun$att.data$ID[mun$att.data$ENT == 17]
idnay <- mun$att.data$ID[mun$att.data$ENT == 18]
idnl <-  mun$att.data$ID[mun$att.data$ENT == 19]
idoax <- mun$att.data$ID[mun$att.data$ENT == 20]
idpue <- mun$att.data$ID[mun$att.data$ENT == 21]
idque <- mun$att.data$ID[mun$att.data$ENT == 22]
idqui <- mun$att.data$ID[mun$att.data$ENT == 23]
idsan <- mun$att.data$ID[mun$att.data$ENT == 24]
idsin <- mun$att.data$ID[mun$att.data$ENT == 25]
idson <- mun$att.data$ID[mun$att.data$ENT == 26]
idtab <- mun$att.data$ID[mun$att.data$ENT == 27]
idtam <- mun$att.data$ID[mun$att.data$ENT == 28]
idtla <- mun$att.data$ID[mun$att.data$ENT == 29]
idver <- mun$att.data$ID[mun$att.data$ENT == 30]
idyuc <- mun$att.data$ID[mun$att.data$ENT == 31]
idzac <- mun$att.data$ID[mun$att.data$ENT == 32]

# OBTIENE DATOS DESDE EL .dbf DEL SHAPEFILE O LOS QUE EXPORTÉ DESDE STATA (ay.do) PARA INCORPORAR AL MAPA
moreData1  <-read.csv("dataFrStataSAN1.out", header=TRUE)
moreData2  <-read.csv("dataFrStataSAN2.out", header=TRUE)
tmp <- as.data.frame(list(ID=mun$att.data$ID,ife=mun$att.data$CLAVE))
moreData1 <- merge(moreData1,tmp,by.x="ife",by.y="ife",all=FALSE)
moreData1 <- moreData1[order(moreData1$trien,moreData1$ID,moreData1$inegi),]
moreData2 <- merge(moreData2,tmp,by.x="ife",by.y="ife",all=FALSE)
moreData2 <- moreData2[order(moreData2$trien,moreData2$ID,moreData2$inegi),]

#IMPORTA DATOS DE POB>18
tmp <-read.csv("c:/data/1new/MX els calend govt/censos/conteo05ife/p18.out", header=TRUE)
tmp$munn <- tmp$ife; tmp$ife <- tmp$edon*1000+tmp$munn; tmp$munn <- NULL; tmp$edon <- NULL
tmp$p18cat <- ifelse( tmp$p18<10000,1,ifelse( tmp$p18>=10000 & tmp$p18<25000,2, ifelse( tmp$p18>=25000 & tmp$p18<50000,3, ifelse( tmp$p18>=50000 & tmp$p18<100000,4, ifelse( tmp$p18>=100000 & tmp$p18<200000,5, ifelse( tmp$p18>=200000 & tmp$p18<400000,6,7) ) ) ) ) ) 
moreData1 <- merge(moreData1,tmp,by.x="ife",by.y="ife",all=FALSE)
moreData2 <- merge(moreData2,tmp,by.x="ife",by.y="ife",all=FALSE)

# IMPORTA CURVAS DE NIVEL
curNiv<-read.shape("C:/data/1new/mapas/inegi/curvasNivel/CurvasNivel.shp") #ESTA ES FUNCION DE MAPTOOLS QUE TOMA DE LOS 3 COMPONENTES ESRI
###DEBE DE HABER UN MODO MAS EFICIENTE DE HACER ESTO QUE TARDA 30 MINUTOS###
x<-curNiv$Shapes[[1]]$verts[,1]
for (i in 2:length(curNiv$att.data$ELEVACION)){
    x<-c(x,curNiv$Shapes[[i]]$verts[,1]) 
    cat("processing ID",i,"\n") }

curNivPts<-data.frame(x=curNiv$Shapes[[1]]$verts[,1], 
                   y=curNiv$Shapes[[1]]$verts[,2], 
                   id=curNiv$att.data$OBJECTID[1], 
                   elev=curNiv$att.data$ELEVACION[1])
for (i in 2:length(curNiv$att.data$ELEVACION)){
    tmp<-data.frame(x=curNiv$Shapes[[i]]$verts[,1], 
                   y=curNiv$Shapes[[i]]$verts[,2], 
                   id=curNiv$att.data$OBJECTID[i], 
                   elev=curNiv$att.data$ELEVACION[i])
    curNivPts<-rbind(curNivPts,tmp) 
    cat("processing ID",i,"\n") }
save(curNivPts, file="C:/data/1new/mapas/inegi/curvasNivel/CurvasNivel/CurvasNivelporPuntos.txt")
#load(file="C:/data/1new/mapas/inegi/curvasNivel/CurvasNivel/CurvasNivelporPuntos.txt")


## MAPA 1 MUN CON LEYENDA
tr <- 11 ## TRIENIO QUE SE QUIERE SACAR
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
#plotvar <- mun$att.data$AGPAN8587
#
nclr <- 5                                    #CATEGORÍAS DE COLOR (MIN=3 MAX=9)
plotclrpri <- brewer.pal(nclr,"Greens")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
plotclrpan <- brewer.pal(nclr,"Blues")            #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
plotclrprd <- brewer.pal(nclr,"YlOrBr")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
plotclroth <- brewer.pal(nclr,"Greys")            #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
#
#ESTO VUELVE LAS VARIABLES ORDINALES
### colornumpri <- ifelse(delpri>0 & delpri<10, 1, 
###                 ifelse(delpri>=10 & delpri<25, 2, 
###                 ifelse(delpri>=25 & delpri<50, 3, 
###                 ifelse(delpri>=50 & delpri<75, 4, 
###                 ifelse(delpri>=75 & delpri<100, 5, 
###                 ifelse(delpri==100, 6, NA)))))) 
### colornumpan <- ifelse(delpan>0 & delpan<10, 1, 
###                 ifelse(delpan>=10 & delpan<25, 2, 
###                 ifelse(delpan>=25 & delpan<50, 3, 
###                 ifelse(delpan>=50 & delpan<75, 4, 
###                 ifelse(delpan>=75 & delpan<100, 5, 
###                 ifelse(delpan==100, 6, NA)))))) 
### colornumprd <- ifelse(delprd>0 & delprd<10, 1, 
###                 ifelse(delprd>=10 & delprd<25, 2, 
###                 ifelse(delprd>=25 & delprd<50, 3, 
###                 ifelse(delprd>=50 & delprd<75, 4, 
###                 ifelse(delprd>=75 & delprd<100, 5, 
###                 ifelse(delprd==100, 6, NA)))))) 
### colornumoth <- ifelse(deloth>0 & deloth<10, 1, 
###                 ifelse(deloth>=10 & deloth<25, 2, 
###                 ifelse(deloth>=25 & deloth<50, 3, 
###                 ifelse(deloth>=50 & deloth<75, 4, 
###                 ifelse(deloth>=75 & deloth<100, 5, 
###                 ifelse(deloth==100, 6, NA)))))) 
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
#
#colornumpri <- cut(delpri, nclr, labels=FALSE) #SI LA VAR ES CONTINUA ESTO LA VUELVE ORDINAL
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
#
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
#
### nclr <- 7                                    #CATEGORÍAS DE COLOR (MIN=3 MAX=9)
### plotclr <- brewer.pal(nclr,"Blues")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
### #plotclr <- brewer.pal(nclr,"YlOrBr")        #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
### colornum <- cut(plotvar, nclr, labels=FALSE) #SI LA VAR ES CONTINUA ESTO LA VUELVE ORDINAL
### colorcode <- plotclr[colornum]               
### #colorcode <- plotclr[plotvar]
#
#FORMA DEPRECATED
#plot(mun, fg=colorcode, xlab="", ylab="")
#
#ESTA PARECE SER LA FORMA NO DEPRECATED
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
#ptsmun <- Map2points(mun2)
#xylims <- attr(ptsmun, "maplim")
#plot(xylims$x, xylims$y, asp=1, type='n', xlab="", ylab="")
#points(baltpts)
#plot(polymun, col=colorcode)
#
san <- c(idsan)
tri <- c(1976,1979,1982,1985,1988,1991,1994,1997,2000,2003,2006,2009)
#
edos <- san # estados que se quieren incluir ### checar 2006-08 en centroocc gue hereda missings ajenos
polysub <- subset(polymun, 1:length(polymun) %in% edos)
ptssub <- munPts[munPts$ID %in% edos,]
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
plot(polysub, col=colsub, axes=FALSE, main=paste("Margen de triunfo, 1a vuelta",tri[tr]))
#plot(polysub, col=colsub, axes=FALSE, main=paste("Margen de triunfo, ballotage",tri[tr]))
legend(220000,1360000, legend=c("","","",""), fill=plotclrpri[2:5], bty="n", cex=.85)
legend(230000,1360000, legend=c("","","",""), fill=plotclrpan[2:5], bty="n", cex=.85)
legend(240000,1360000, legend=c("","","",""), fill=plotclrprd[2:5], bty="n", cex=.85)
legend(250000,1360000, legend=c("0-10%","10-30%","30-99%","100%"), fill=plotclroth[2:5], bty="n", cex=.85)

#EQUIVALENTE PERO CON PUNTOS -- GRAFICADO MAS VERSATIL 
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , c(min(ptssub$y),max(ptssub$y)), asp=1, type='n', xlab="", ylab="", axes=FALSE, main=paste("Margen de triunfo, 1a vuelta",tri[tr]))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
legend(220000,1360000, legend=c("","","",""), fill=plotclrpri[2:5], bty="n", cex=.85)
legend(230000,1360000, legend=c("","","",""), fill=plotclrpan[2:5], bty="n", cex=.85)
legend(240000,1360000, legend=c("","","",""), fill=plotclrprd[2:5], bty="n", cex=.85)
legend(250000,1360000, legend=c("0-10%","10-30%","30-99%","100%"), fill=plotclroth[2:5], bty="n", cex=.85)

## 11 mapas 1988--2009 (CORRE TODO DESDE AQUI)
par( mfrow=c(4,3) )
nclr <- 5                                    #CATEGORÍAS DE COLOR (MIN=3 MAX=9)
plotclrpri <- brewer.pal(nclr,"Greens")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
plotclrpan <- brewer.pal(nclr,"Blues")            #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
plotclrprd <- brewer.pal(nclr,"YlOrBr")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
plotclroth <- brewer.pal(nclr,"Greys")            #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
san <- c(idsan)
tri <- c(1976,1979,1982,1985,1988,1991,1994,1997,2000,2003,2006,2009)
edos <- san # estados que se quieren incluir ### checar 2006-08 en centroocc gue hereda missings ajenos
#
tr <- 5 ##1988
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr]))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 6 ##1991
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr]))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 7 ##1994
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr]))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 8 ##1997 1a vuelta
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr],"1a vuelta"))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 9 ##2000 1a vuelta
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr],"1a vuelta"))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 10 ##2003 1a vuelta
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr],"1a vuelta"))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 8 ##1997 2a vuelta
moreData <- moreData2                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr],"ballottage"))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 9 ##2000 2a vuelta
moreData <- moreData2                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr],"ballottage"))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 10 ##2003 2a vuelta
moreData <- moreData2                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr],"ballottage"))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 11 ##2006
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr]))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
tr <- 12 ##2009
moreData <- moreData1                 ## VUELTA QUE SE QUIERE ANALIZAR 1 o 2
delpri <- moreData$mgpri[moreData$trien==tr]
delpri <- ifelse(delpri<=0,NA,delpri) #RETIENE SOLO MARGENES POSITIVOS
delpan <- moreData$mgpan[moreData$trien==tr]
delpan <- ifelse(delpan<=0,NA,delpan) #RETIENE SOLO MARGENES POSITIVOS
delprd <- moreData$mgprd[moreData$trien==tr]
delprd <- ifelse(delprd<=0,NA,delprd) #RETIENE SOLO MARGENES POSITIVOS
deloth <- moreData$mgoth[moreData$trien==tr]
deloth <- ifelse(deloth<=0,NA,deloth) #RETIENE SOLO MARGENES POSITIVOS
colornumpri <- ifelse(delpri>0 & delpri<10, 2, 
                ifelse(delpri>=10 & delpri<30, 3, 
                ifelse(delpri>=30 & delpri<100, 4, 
                ifelse(delpri==100, 5, NA))))
colornumpan <- ifelse(delpan>0 & delpan<10, 2, 
                ifelse(delpan>=10 & delpan<30, 3, 
                ifelse(delpan>=30 & delpan<100, 4, 
                ifelse(delpan==100, 5, NA)))) 
colornumprd <- ifelse(delprd>0 & delprd<10, 2, 
                ifelse(delprd>=10 & delprd<30, 3, 
                ifelse(delprd>=30 & delprd<100, 4, 
                ifelse(delprd==100, 5, NA)))) 
colornumoth <- ifelse(deloth>0 & deloth<10, 2, 
                ifelse(deloth>=10 & deloth<30, 3, 
                ifelse(deloth>=30 & deloth<100, 4, 
                ifelse(deloth==100, 5, NA)))) 
colorcodepri <- plotclrpri[colornumpri]               
colorcodepan <- plotclrpan[colornumpan]               
colorcodeprd <- plotclrprd[colornumprd]               
colorcodeoth <- plotclroth[colornumoth]               
colorcode <- ifelse(is.na(colorcodepri)==FALSE,colorcodepri,
             ifelse(is.na(colorcodepan)==FALSE,colorcodepan,
             ifelse(is.na(colorcodeprd)==FALSE,colorcodeprd, 
             ifelse(is.na(colorcodeoth)==FALSE,colorcodeoth, NA))))
polymun <- Map2poly(mun, as.character(mun$att.data$ID), quiet=FALSE)
polysub <- subset(polymun, 1:length(polymun) %in% edos)
colsub <- colorcode[edos]
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , 
     c(min(ptssub$y),max(ptssub$y)), 
     asp=1, type='n', xlab="", ylab="", axes=FALSE, 
     main=paste(tri[tr]))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
#
# LEYENDA
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(0,1),c(0,1),type="n",xlab="",ylab="",axes=FALSE)
legend(0,.825, legend=c("","","",""), fill=plotclrpri[2:5], bty="n", cex=.9)
legend(.09,.825, legend=c("","","",""), fill=plotclrpan[2:5], bty="n", cex=.9)
legend(.18,.825, legend=c("","","",""), fill=plotclrprd[2:5], bty="n", cex=.9)
legend(.27,.825, legend=c("0-10%","10-30%","30-99%","100%"), fill=plotclroth[2:5], bty="n", cex=.9)
text(.1,.875,"PRI",srt=90,cex=.9)
text(.19,.875,"PAN",srt=90,cex=.9)
text(.28,.875,"PRD",srt=90,cex=.9)
text(.37,.875,"Otros",srt=90,cex=.9)
text(.4,.05,"Preparado por Eric Magar 2009 emagar@itam.mx",cex=.35)
title("Margen de triunfo",cex.main=.85)

## MAPA DE MARGEN CON ESTADOS ALEDAÑOS
par(mar=c(.5,1,2,1))
colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcode[edos])
plot(c(min(ptssub$x),max(ptssub$x)) , c(min(ptssub$y),max(ptssub$y)), asp=1, type='n', xlab="", ylab="", axes=FALSE, main=paste("Margen de triunfo",tri[tr]))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub2$col[colsub2$ID==i]) )
    }
for (i in c(11,13,19,22,28,30,32)){
    polygon(edoPts$x[edoPts$EDON==i],edoPts$y[edoPts$EDON==i], border="grey") }
rect(200000,1270000,280000,1600000,border=NA,col="white")
rect(30000,1387500,100000,1600000,border=NA,col="white")
rect(110000,1400500,130000,1600000,border=NA,col="white")
rect(4500,1100000,-100000,1165000,border=NA,col="white")
rect(2000,1095000,37000,1135000,border=NA,col="white")
rect(1500,900000,55000,1082500,border=NA,col="white")
rect(150000,900000,285000,1040000,border=NA,col="white")
rect(365000,900000,400000,1030000,border=NA,col="white")
rect(365000,1152500,400000,1200000,border=NA,col="white")
text(110000,1047500,"Guanajuato",srt=-25,cex=.65)
text(265000,1030000,"Querétaro",srt=-5,cex=.65)
text(340000,1012500,"Hidalgo",srt=10,cex=.65)
text(370000,1082500,"Veracruz",srt=80,cex=.65)
text(265000,1200000,"Tamaulipas",srt=-12,cex=.65)
text(8500,1150000,"Zacatecas",srt=-30,cex=.65)
text(42000,1320000,"Zacatecas",srt=40,cex=.65)
text(170000,1330000,"Nuevo León",srt=-80,cex=.65)
arrows(2500,1350000,2500,1380000,lwd=2,length=.1)
text(2500,1390000,"N")
points(101500,1125000,pch=19,col="black"); points(101500,1125000,pch=20,col="red") #capital
legend(220000,1360000, legend=c("","","",""), fill=plotclrpri[2:5], bty="n", cex=.85)
legend(230000,1360000, legend=c("","","",""), fill=plotclrpan[2:5], bty="n", cex=.85)
legend(240000,1360000, legend=c("","","",""), fill=plotclrprd[2:5], bty="n", cex=.85)
legend(250000,1360000, legend=c("0-10%","10-30%","30-99%","100%"), fill=plotclroth[2:5], bty="n", cex=.85)


#colsub2 <- data.frame(ID=min(ptssub$ID):max(ptssub$ID),col=colorcodep18[edos])
colsub2 <- data.frame(ID=moreData$ID[edos],col=colorcodep18[edos])
  tmp<-moreData[moreData$trien==tr,]
  tmp$col<-colorcodep18
  tmp<-tmp[tmp$edon==24,]
  tmp[,c(4,14:17)]
  colsub2  ## SALE DISTINTO!!!

## MAPA DE POBLACIÓN CON ESTADOS ALEDAÑOS
plotclrp18 <- brewer.pal(7,"Purples")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
#colorcodep18 <- plotclrp18[moreData$p18cat[moreData$trien==tr]]               
colorcodep18 <- plotclrp18[moreData$p18cat]               
moreData$col <- colorcodep18
colsub <- data.frame(ID=moreData$ID[moreData$ID %in% edos],col=moreData$col[moreData$ID %in% edos])
par(mar=c(.5,1,2,1))
plot(c(min(ptssub$x),max(ptssub$x)) , c(min(ptssub$y),max(ptssub$y)), asp=1, type='n', xlab="", ylab="", axes=FALSE, main=paste("Ciudadanos totales, conteo 2005"))
for (i in min(ptssub$ID):max(ptssub$ID)){
    polygon(ptssub$x[ptssub$ID==i], ptssub$y[ptssub$ID==i],
    lwd=.1,
    col=as.character(colsub$col[colsub$ID==i]) )
    }
for (i in c(11,13,19,22,28,30,32)){
    polygon(edoPts$x[edoPts$EDON==i],edoPts$y[edoPts$EDON==i], border="grey") }
rect(200000,1270000,280000,1600000,border=NA,col="white")
rect(30000,1387500,100000,1600000,border=NA,col="white")
rect(110000,1400500,130000,1600000,border=NA,col="white")
rect(4500,1100000,-100000,1165000,border=NA,col="white")
rect(2000,1095000,37000,1135000,border=NA,col="white")
rect(1500,900000,55000,1082500,border=NA,col="white")
rect(150000,900000,285000,1040000,border=NA,col="white")
rect(365000,900000,400000,1030000,border=NA,col="white")
rect(365000,1152500,400000,1200000,border=NA,col="white")
text(110000,1047500,"Guanajuato",srt=-25,cex=.65)
text(265000,1030000,"Querétaro",srt=-5,cex=.65)
text(340000,1012500,"Hidalgo",srt=10,cex=.65)
text(370000,1082500,"Veracruz",srt=80,cex=.65)
text(265000,1200000,"Tamaulipas",srt=-12,cex=.65)
text(8500,1150000,"Zacatecas",srt=-30,cex=.65)
text(42000,1320000,"Zacatecas",srt=40,cex=.65)
text(170000,1330000,"Nuevo León",srt=-80,cex=.65)
arrows(2500,1350000,2500,1380000,lwd=2,length=.1)
text(2500,1390000,"N")
lines(c(-20000,67500),c(1012500,1012500))
lines(c(-20000,-20000),c(1012500,1014000))
lines(c(1875,1875),c(1012500,1014000))
lines(c(23750,23750),c(1012500,1014000))
lines(c(67500,67500),c(1012500,1014000))
text(-20000,1019000,"0",cex=.35)
text(1875,1019000,"25",cex=.35)
text(23750,1019000,"50km",cex=.35)
text(67500,1019000,"100km",cex=.35)
points(101500,1125000,pch=19,col="black"); points(101500,1125000,pch=20,col="red") #capital
legend(220000,1360000, legend=c("1-9,999","10,000-24,999","25,000-49,999","50,000-99,999","100,000-199,999","200,000-400,000","400,000+"), fill=plotclrp18[1:7], bty="n", cex=.75)


#ESTAS SON FUNCIONES DE PACKAGE:SHAPEFILES
entidad<-read.shapefile("ENTIDAD")    #ESTO LEE LOS 3 COMPONENTES DE ESRI
entidad <- add.xy(entidad)            #ADDS X & Y COORDINATES TO DBF LIST OF (POINT) OBJECT
entidad <- scaleXY(entidad, scale.factor=2)  #SCALES OBJECT

shp<-read.shp("ENTIDAD.shp")
shx<-read.shx("ENTIDAD.shx")
dbf<-read.dbf("ENTIDAD2.dbf")

simpleShp<-convert.to.simple(shp)
simpleShp<-change.id(simpleShp, c("a","b"))

###########################################
#Polyline simplification with dp algorithm (from shapefile pckg)
x <- c(5,3,4,1,8,9,10,11)
y <- c(6,4,2,1,1,5,2,3)
points <- list(x=x,y=y)
plot(points, type="l")
simpleLine <- dp(points, 2)
lines(simpleLine, type="l", col="blue")
###########################################

ent<-read.shape("ENTIDAD.shp") #ESTA ES FUNCION DE MAPTOOLS
mapent <- Map2poly(ent, as.character(ent$att.data$ENT), quiet=FALSE)
plot(mapent)

dis<-read.shape("DISTRITO.shp")
mapdis <- Map2poly(dis, as.character(mun$att.data$DIS), quiet=FALSE)
plot(mapdis)

mun<-read.shape("MUNICIPIO.shp")
mapmun <- Map2poly(mun, as.character(mun$att.data$MUN), quiet=FALSE)
plot(mapmun)

#extrae atributos de polyfiles
idnums <- attr(mapent, "region.id")



simpleShpFormat <- convert.to.simple(shp)

tmp<-map('state')
