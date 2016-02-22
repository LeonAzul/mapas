#library(shapefiles)
library(maptools)
#library(rgdal)
#library(maps)
library(RColorBrewer)

rm(list=ls())

#workdir <- c("~/Dropbox/data/elecs/redistrict/planesEdomex/shapes")
#maplocs <- c("~/Dropbox/data/mapas/seccionesIfe/mex")
#votlocs <- c("~/Dropbox/data/elecs/MXelsCalendGovt/elecReturns")
workdir <- c("d:/01/Dropbox/data/elecs/redistrict/planesEdomex/shapes")
maplocs <- c("d:/01/Dropbox/data/mapas/seccionesIfe/mex")
votlocs <- c("d:/01/Dropbox/data/elecs/MXelsCalendGovt/elecReturns")
setwd <- workdir

## vote margins
df2012 <- read.csv(paste(votlocs, "dfSeccion2012.csv", sep="/"))
df2012 <- df2012[df2012$edon==15,]
df2012$pric <- df2012$pri+df2012$pvem+df2012$pripvem
df2012$prdc <- df2012$prd+df2012$pt+df2012$mc+df2012$prdptmc+df2012$prdpt+df2012$prdmc+df2012$ptmc
df2012$pri <- NULL; df2012$pvem <- NULL; df2012$pripvem <- NULL; df2012$prd <- NULL; df2012$pt <- NULL; df2012$mc <- NULL; df2012$prdptmc <- NULL; df2012$prdpt <- NULL; df2012$prdmc <- NULL; df2012$ptmc <- NULL;
df2012$efec <- df2012$pan+df2012$pric+df2012$prdc+df2012$panal
#df2012$pansh <- df2012$pan/df2012$efec; df2012$pricsh <- df2012$pric/df2012$efec; df2012$prdcsh <- df2012$prdc/df2012$efec; df2012$panalsh <- df2012$panal/df2012$efec;
## PARTY RANKS
tmp <- data.frame(pan=rep(NA,nrow(df2012)), pric=rep(NA,nrow(df2012)), prdc=rep(NA,nrow(df2012)), panal=rep(NA,nrow(df2012)))
for (j in 1:nrow(df2012)){
    tmp[j,] <- -rank(df2012[j,c("pan","pric","prdc","panal")], ties.method = "random")+5
}
df2012$win <- rep(".",nrow(df2012)); df2012$margin <- rep(NA,nrow(df2012))
for (j in 1:nrow(df2012)){
    df2012$win[j] <- ifelse(tmp[j,1]==1, "pan",
                      ifelse(tmp[j,2]==1, "pric",
                       ifelse(tmp[j,3]==1, "prdc", "oth")))
    df2012$margin[j] <- ifelse(tmp[j,1]==1 & tmp[j,2]==2, (df2012$pan[j]-df2012$pric[j])/df2012$efec[j],
                  ifelse(tmp[j,1]==1 & tmp[j,3]==2, (df2012$pan[j]-df2012$prdc[j])/df2012$efec[j],
                   ifelse(tmp[j,1]==1 & tmp[j,4]==2, (df2012$pan[j]-df2012$panal[j])/df2012$efec[j],
                    ifelse(tmp[j,2]==1 & tmp[j,1]==2, (df2012$pric[j]-df2012$pan[j])/df2012$efec[j],
                     ifelse(tmp[j,2]==1 & tmp[j,3]==2, (df2012$pric[j]-df2012$prdc[j])/df2012$efec[j],
                      ifelse(tmp[j,2]==1 & tmp[j,4]==2, (df2012$pric[j]-df2012$panal[j])/df2012$efec[j],
                       ifelse(tmp[j,3]==1 & tmp[j,1]==2, (df2012$prdc[j]-df2012$pan[j])/df2012$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,2]==2, (df2012$prdc[j]-df2012$pric[j])/df2012$efec[j],
                         ifelse(tmp[j,3]==1 & tmp[j,4]==2, (df2012$prdc[j]-df2012$panal[j])/df2012$efec[j],
                          ifelse(tmp[j,4]==1 & tmp[j,1]==2, (df2012$panal[j]-df2012$pan[j])/df2012$efec[j],
                           ifelse(tmp[j,4]==1 & tmp[j,2]==2, (df2012$panal[j]-df2012$pric[j])/df2012$efec[j],
                            ifelse(tmp[j,4]==1 & tmp[j,3]==2, (df2012$panal[j]-df2012$prdc[j])/df2012$efec[j], df2012$margin[j]))))))))))))
}
#data.frame(win=df2012$win, mg=df2012$margin, pric=df2012$pric, efec=df2012$efec)
#
df2009 <- read.csv(paste(votlocs, "dfSeccion2009.csv", sep="/"))
df2009 <- df2009[df2009$edon==15,]
## coalición parcial EdoMex pri-pvem (no en los distritos 9, 15, 19, 20, 25, 29:31, 36)
dnocoal <- rep(0,nrow(df2009)); dnocoal[df2009$disn==9] <- 1; dnocoal[df2009$disn==15] <- 1; dnocoal[df2009$disn==19] <- 1; dnocoal[df2009$disn==20] <- 1; dnocoal[df2009$disn==25] <- 1; dnocoal[df2009$disn==29] <- 1; dnocoal[df2009$disn==30] <- 1; dnocoal[df2009$disn==31] <- 1; dnocoal[df2009$disn==36] <- 1;
df2009$pric <- df2009$pri+df2009$pvem+df2009$primero_mexico
df2009$pric[dnocoal==1] <- df2009$pri[dnocoal==1]; df2009$pvem[dnocoal==0] <- 0
df2009$ptc <- df2009$pt+df2009$conve+df2009$salvemos_mexico
rm(dnocoal)
df2009$efec <- df2009$tot - df2009$nr - df2009$nul
df2009$pri <- NULL; df2009$primero_mexico <- NULL; df2009$pt <- NULL; df2009$conve <- NULL; df2009$primero_mexico <- NULL; df2009$salvemos_mexico <- NULL; df2009$tot <- NULL
## PARTY RANKS
tmp <- data.frame(pan=rep(NA,nrow(df2009)), pric=rep(NA,nrow(df2009)), prd=rep(NA,nrow(df2009)), ptc=rep(NA,nrow(df2009)), pvem=rep(NA,nrow(df2009)), panal=rep(NA,nrow(df2009)), psd=rep(NA,nrow(df2009)))
for (j in 1:nrow(df2009)){
    tmp[j,] <- -rank(df2009[j,c("pan","pric","prd","ptc","pvem","panal","psd")], ties.method = "random")+8
}
df2009$win <- rep(".",nrow(df2009)); df2009$margin <- rep(NA,nrow(df2009))
for (j in 1:nrow(df2009)){
    df2009$win[j] <- ifelse(tmp[j,1]==1, "pan",
                      ifelse(tmp[j,2]==1, "pric",
                       ifelse(tmp[j,3]==1, "prd", "oth")))
    df2009$margin[j] <- ifelse(tmp[j,1]==1 & tmp[j,2]==2, (df2009$pan[j]-df2009$pric[j])/df2009$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,3]==2, (df2009$pan[j]-df2009$prd[j])/df2009$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,4]==2, (df2009$pan[j]-df2009$ptc[j])/df2009$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,5]==2, (df2009$pan[j]-df2009$pvem[j])/df2009$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,6]==2, (df2009$pan[j]-df2009$panal[j])/df2009$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,7]==2, (df2009$pan[j]-df2009$psd[j])/df2009$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,1]==2, (df2009$pric[j]-df2009$pan[j])/df2009$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,3]==2, (df2009$pric[j]-df2009$prd[j])/df2009$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,4]==2, (df2009$pric[j]-df2009$ptc[j])/df2009$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,5]==2, (df2009$pric[j]-df2009$pvem[j])/df2009$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,6]==2, (df2009$pric[j]-df2009$panal[j])/df2009$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,7]==2, (df2009$pric[j]-df2009$psd[j])/df2009$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,1]==2, (df2009$prd[j]-df2009$pan[j])/df2009$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,2]==2, (df2009$prd[j]-df2009$pric[j])/df2009$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,4]==2, (df2009$prd[j]-df2009$ptc[j])/df2009$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,5]==2, (df2009$prd[j]-df2009$pvem[j])/df2009$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,6]==2, (df2009$prd[j]-df2009$panal[j])/df2009$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,7]==2, (df2009$prd[j]-df2009$psd[j])/df2009$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,1]==2, (df2009$ptc[j]-df2009$pan[j])/df2009$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,2]==2, (df2009$ptc[j]-df2009$pric[j])/df2009$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,3]==2, (df2009$ptc[j]-df2009$prd[j])/df2009$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,5]==2, (df2009$ptc[j]-df2009$pvem[j])/df2009$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,6]==2, (df2009$ptc[j]-df2009$panal[j])/df2009$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,7]==2, (df2009$ptc[j]-df2009$psd[j])/df2009$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,1]==2, (df2009$pvem[j]-df2009$pan[j])/df2009$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,2]==2, (df2009$pvem[j]-df2009$pric[j])/df2009$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,3]==2, (df2009$pvem[j]-df2009$prd[j])/df2009$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,4]==2, (df2009$pvem[j]-df2009$ptc[j])/df2009$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,6]==2, (df2009$pvem[j]-df2009$panal[j])/df2009$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,7]==2, (df2009$pvem[j]-df2009$psd[j])/df2009$efec[j],
                        ifelse(tmp[j,6]==1 & tmp[j,1]==2, (df2009$panal[j]-df2009$pan[j])/df2009$efec[j],
                        ifelse(tmp[j,6]==1 & tmp[j,2]==2, (df2009$panal[j]-df2009$pric[j])/df2009$efec[j],
                        ifelse(tmp[j,6]==1 & tmp[j,3]==2, (df2009$panal[j]-df2009$prd[j])/df2009$efec[j],
                        ifelse(tmp[j,6]==1 & tmp[j,4]==2, (df2009$panal[j]-df2009$ptc[j])/df2009$efec[j],
                        ifelse(tmp[j,6]==1 & tmp[j,5]==2, (df2009$panal[j]-df2009$pvem[j])/df2009$efec[j],
                        ifelse(tmp[j,6]==1 & tmp[j,7]==2, (df2009$panal[j]-df2009$psd[j])/df2009$efec[j],
                        ifelse(tmp[j,7]==1 & tmp[j,1]==2, (df2009$psd[j]-df2009$pan[j])/df2009$efec[j],
                        ifelse(tmp[j,7]==1 & tmp[j,2]==2, (df2009$psd[j]-df2009$pric[j])/df2009$efec[j],
                        ifelse(tmp[j,7]==1 & tmp[j,3]==2, (df2009$psd[j]-df2009$prd[j])/df2009$efec[j],
                        ifelse(tmp[j,7]==1 & tmp[j,4]==2, (df2009$psd[j]-df2009$ptc[j])/df2009$efec[j],
                        ifelse(tmp[j,7]==1 & tmp[j,5]==2, (df2009$psd[j]-df2009$pvem[j])/df2009$efec[j],
                        ifelse(tmp[j,7]==1 & tmp[j,6]==2, (df2009$psd[j]-df2009$panal[j])/df2009$efec[j], df2009$margin[j]))))))))))))))))))))))))))))))))))))))))))
}
#data.frame(win=df2009$win, mg=df2009$margin, pric=df2009$pric, efec=df2009$efec)
#table(win=df2009$win)
#
df2006 <- read.csv(paste(votlocs, "dfSeccion2006.csv", sep="/"))
df2006 <- df2006[df2006$edon==15,]
colnames(df2006) <- c("edon","disn","munn","seccion","id_elec","pan","pric","prdc","panal","asdc","efec","nr","nul","tot")
df2006$id_elec <- NULL; df2006$tot <- NULL;
## PARTY RANKS
tmp <- data.frame(pan=rep(NA,nrow(df2006)), pric=rep(NA,nrow(df2006)), prdc=rep(NA,nrow(df2006)), panal=rep(NA,nrow(df2006)), asdc=rep(NA,nrow(df2006)))
for (j in 1:nrow(df2006)){
    tmp[j,] <- -rank(df2006[j,c("pan","pric","prdc","panal","asdc")], ties.method = "random")+6
}
df2006$win <- rep(".",nrow(df2006)); df2006$margin <- rep(NA,nrow(df2006))
for (j in 1:nrow(df2006)){
    df2006$win[j] <- ifelse(tmp[j,1]==1, "pan",
                      ifelse(tmp[j,2]==1, "pric",
                       ifelse(tmp[j,3]==1, "prdc", "oth")))
    df2006$margin[j] <- ifelse(tmp[j,1]==1 & tmp[j,2]==2, (df2006$pan[j]-df2006$pric[j])/df2006$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,3]==2, (df2006$pan[j]-df2006$prdc[j])/df2006$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,4]==2, (df2006$pan[j]-df2006$panal[j])/df2006$efec[j],
                        ifelse(tmp[j,1]==1 & tmp[j,5]==2, (df2006$pan[j]-df2006$asdc[j])/df2006$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,1]==2, (df2006$pric[j]-df2006$pan[j])/df2006$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,3]==2, (df2006$pric[j]-df2006$prdc[j])/df2006$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,4]==2, (df2006$pric[j]-df2006$panal[j])/df2006$efec[j],
                        ifelse(tmp[j,2]==1 & tmp[j,5]==2, (df2006$pric[j]-df2006$asdc[j])/df2006$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,1]==2, (df2006$prdc[j]-df2006$pan[j])/df2006$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,2]==2, (df2006$prdc[j]-df2006$pric[j])/df2006$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,4]==2, (df2006$prdc[j]-df2006$panal[j])/df2006$efec[j],
                        ifelse(tmp[j,3]==1 & tmp[j,5]==2, (df2006$prdc[j]-df2006$asdc[j])/df2006$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,1]==2, (df2006$panal[j]-df2006$pan[j])/df2006$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,2]==2, (df2006$panal[j]-df2006$pric[j])/df2006$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,3]==2, (df2006$panal[j]-df2006$prdc[j])/df2006$efec[j],
                        ifelse(tmp[j,4]==1 & tmp[j,5]==2, (df2006$panal[j]-df2006$asdc[j])/df2006$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,1]==2, (df2006$asdc[j]-df2006$pan[j])/df2006$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,2]==2, (df2006$asdc[j]-df2006$pric[j])/df2006$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,3]==2, (df2006$asdc[j]-df2006$prdc[j])/df2006$efec[j],
                        ifelse(tmp[j,5]==1 & tmp[j,4]==2, (df2006$asdc[j]-df2006$panal[j])/df2006$efec[j], df2006$margin[j]))))))))))))))))))))
}
#data.frame(win=df2006$win, mg=df2006$margin, pric=df2006$pric, efec=df2006$efec)
#table(win=df2006$win)


nclr <- 5                                     #CATEGORÍAS DE COLOR
prishd <- brewer.pal(nclr,"Greens")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
panshd <- brewer.pal(nclr,"Blues")            #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
prdshd <- brewer.pal(nclr,"YlOrBr")           #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
othshd <- brewer.pal(nclr,"Greys")            #GENERA CODIGOS DE COLOR QUE CRECEN CON GRADO
rm(nclr)
## 2012 DIPFED MARGIN COLORS
numpri <- ifelse(df2012$margin>0 & df2012$margin<.10 & df2012$win=="pric", 2,
                ifelse(df2012$margin>=.10 & df2012$margin<.30 & df2012$win=="pric", 3,
                ifelse(df2012$margin>=.30 & df2012$margin<1 & df2012$win=="pric", 4,
                ifelse(df2012$margin==1 & df2012$win=="pric", 5, NA))))
numpan <- ifelse(df2012$margin>0 & df2012$margin<.10 & df2012$win=="pan", 2,
                ifelse(df2012$margin>=.10 & df2012$margin<.30 & df2012$win=="pan", 3,
                ifelse(df2012$margin>=.30 & df2012$margin<1 & df2012$win=="pan", 4,
                ifelse(df2012$margin==1 & df2012$win=="pan", 5, NA))))
numprd <- ifelse(df2012$margin>0 & df2012$margin<.10 & df2012$win=="prdc", 2,
                ifelse(df2012$margin>=.10 & df2012$margin<.30 & df2012$win=="prdc", 3,
                ifelse(df2012$margin>=.30 & df2012$margin<1 & df2012$win=="prdc", 4,
                ifelse(df2012$margin==1 & df2012$win=="prdc", 5, NA))))
numoth <- ifelse(df2012$margin>0 & df2012$margin<.10 & df2012$win=="oth", 2,
                ifelse(df2012$margin>=.10 & df2012$margin<.30 & df2012$win=="oth", 3,
                ifelse(df2012$margin>=.30 & df2012$margin<1 & df2012$win=="oth", 4,
                ifelse(df2012$margin==1 & df2012$win=="oth", 5, NA))))
#colornumpri <- cut(delpri, nclr, labels=FALSE) #SI LA VAR ES CONTINUA ESTO LA VUELVE ORDINAL
colpri <- prishd[numpri]; colpan <- panshd[numpan]; colprd <- prdshd[numprd]; coloth <- othshd[numoth];
color2012 <- ifelse(is.na(colpri)==FALSE,colpri,
         ifelse(is.na(colpan)==FALSE,colpan,
         ifelse(is.na(colprd)==FALSE,colprd,
         ifelse(is.na(coloth)==FALSE,coloth, NA))))
## 2009 DIPFED MARGIN COLORS
numpri <- ifelse(df2009$margin>0 & df2009$margin<.10 & df2009$win=="pric", 2,
                ifelse(df2009$margin>=.10 & df2009$margin<.30 & df2009$win=="pric", 3,
                ifelse(df2009$margin>=.30 & df2009$margin<1 & df2009$win=="pric", 4,
                ifelse(df2009$margin==1 & df2009$win=="pric", 5, NA))))
numpan <- ifelse(df2009$margin>0 & df2009$margin<.10 & df2009$win=="pan", 2,
                ifelse(df2009$margin>=.10 & df2009$margin<.30 & df2009$win=="pan", 3,
                ifelse(df2009$margin>=.30 & df2009$margin<1 & df2009$win=="pan", 4,
                ifelse(df2009$margin==1 & df2009$win=="pan", 5, NA))))
numprd <- ifelse(df2009$margin>0 & df2009$margin<.10 & df2009$win=="prd", 2,
                ifelse(df2009$margin>=.10 & df2009$margin<.30 & df2009$win=="prd", 3,
                ifelse(df2009$margin>=.30 & df2009$margin<1 & df2009$win=="prd", 4,
                ifelse(df2009$margin==1 & df2009$win=="prd", 5, NA))))
numoth <- ifelse(df2009$margin>0 & df2009$margin<.10 & df2009$win=="oth", 2,
                ifelse(df2009$margin>=.10 & df2009$margin<.30 & df2009$win=="oth", 3,
                ifelse(df2009$margin>=.30 & df2009$margin<1 & df2009$win=="oth", 4,
                ifelse(df2009$margin==1 & df2009$win=="oth", 5, NA))))
#colornumpri <- cut(delpri, nclr, labels=FALSE) #SI LA VAR ES CONTINUA ESTO LA VUELVE ORDINAL
colpri <- prishd[numpri]; colpan <- panshd[numpan]; colprd <- prdshd[numprd]; coloth <- othshd[numoth];
color2009 <- ifelse(is.na(colpri)==FALSE,colpri,
         ifelse(is.na(colpan)==FALSE,colpan,
         ifelse(is.na(colprd)==FALSE,colprd,
         ifelse(is.na(coloth)==FALSE,coloth, NA))))
## 2006 DIPFED MARGIN COLORS
numpri <- ifelse(df2006$margin>0 & df2006$margin<.10 & df2006$win=="pric", 2,
                ifelse(df2006$margin>=.10 & df2006$margin<.30 & df2006$win=="pric", 3,
                ifelse(df2006$margin>=.30 & df2006$margin<1 & df2006$win=="pric", 4,
                ifelse(df2006$margin==1 & df2006$win=="pric", 5, NA))))
numpan <- ifelse(df2006$margin>0 & df2006$margin<.10 & df2006$win=="pan", 2,
                ifelse(df2006$margin>=.10 & df2006$margin<.30 & df2006$win=="pan", 3,
                ifelse(df2006$margin>=.30 & df2006$margin<1 & df2006$win=="pan", 4,
                ifelse(df2006$margin==1 & df2006$win=="pan", 5, NA))))
numprd <- ifelse(df2006$margin>0 & df2006$margin<.10 & df2006$win=="prdc", 2,
                ifelse(df2006$margin>=.10 & df2006$margin<.30 & df2006$win=="prdc", 3,
                ifelse(df2006$margin>=.30 & df2006$margin<1 & df2006$win=="prdc", 4,
                ifelse(df2006$margin==1 & df2006$win=="prdc", 5, NA))))
numoth <- ifelse(df2006$margin>0 & df2006$margin<.10 & df2006$win=="oth", 2,
                ifelse(df2006$margin>=.10 & df2006$margin<.30 & df2006$win=="oth", 3,
                ifelse(df2006$margin>=.30 & df2006$margin<1 & df2006$win=="oth", 4,
                ifelse(df2006$margin==1 & df2006$win=="oth", 5, NA))))
#colornumpri <- cut(delpri, nclr, labels=FALSE) #SI LA VAR ES CONTINUA ESTO LA VUELVE ORDINAL
colpri <- prishd[numpri]; colpan <- panshd[numpan]; colprd <- prdshd[numprd]; coloth <- othshd[numoth];
color2006 <- ifelse(is.na(colpri)==FALSE,colpri,
         ifelse(is.na(colpan)==FALSE,colpan,
         ifelse(is.na(colprd)==FALSE,colprd,
         ifelse(is.na(coloth)==FALSE,coloth, NA))))

sec <- readShapeSpatial(paste(maplocs,"secciones_15",sep="/"))#, proj4string=CRS("+proj=longlat"))
munlocs <- c("d:/01/Dropbox/data/mapas/municipio")
mun <- readShapeLines(paste(munlocs,"MUNICIPIO2005",sep="/"))#, proj4string=CRS("+proj=longlat"))
mun <- subset(mun, mun@data$ENT == 15)
#attributes(mun)

color <- color2006; yr <- 2006 ## SELECT YEAR TO PLOT HERE
#
pdf (file = paste("mgSeccMapDipFed",yr,".pdf", sep=""))
par(mar=c(.5,1,2,1))
plot(sec, xlim = c(-100.6,-98.65), ylim = c(18.3,20.3), border = "grey", las = 1, lwd=.01, col=color)
#plot(sec, col=color, add = TRUE, border=NA)
title(main=paste("Elección federal de diputados", yr))
#plot(mun, add=TRUE)
#
legend(-99.26, 18.7, legend=c("","","",""), fill=panshd[2:5], bty="n", cex=.85)
legend(-99.20, 18.7, legend=c("","","",""), fill=prishd[2:5], bty="n", cex=.85)
legend(-99.14, 18.7, legend=c("","","",""), fill=prdshd[2:5], bty="n", cex=.85)
legend(-99.08, 18.7, legend=c("0-10%","10-30%","30-99%","100%"), fill=othshd[2:5], bty="n", cex=.85)
text(-99.19, 18.7, labels="PAN", cex=.375)
text(-99.13, 18.7, labels="PRI", cex=.375)
text(-99.07, 18.7, labels="PRD", cex=.375)
text(-99.01, 18.7, labels="Oth", cex=.375)
text(-99.625, 18.2, pos=3, labels="Margen del partido ganador, secciones. Preparado por E. Magar con datos del IFE e INEGI.", cex=.7)
dev.off()
