library("stringr")
#Lo primero que se hace es leer la data

data <- read.csv("~/Github/mapas/arian/Colima94-13 v1.0(ConNotacionIntegradora).csv", stringsAsFactors = FALSE)

#Se verifica en que columnas hay datos del tipo [] con dos cajas de corchetes

colbrsqr <-grep( "\\[[0-9]*\\]\\[[0-9]*-[0-9]*\\]" , data)

#ya que se tienen las columnas se busca cuales son las celdas especificas que las contiene
#y se cambian por loque dice el distrito anterior que eran (si en la seccion que les tocaba
#en ese entonces eran distrito 1 entonces se les pone eso)

for (i in colbrsqr){
  temp<-grep( "\\[[0-9]*\\]\\[[0-9]*-[0-9]*\\]" , data[,i])
  for(j in temp){
    data[j,i]<-data[ as.numeric(str_extract(data[j,i], "[0-9]+")), i]
    #rint(j+i)
  }
}


#Se buscan las filas que se eliminaran del data frame
colfinderase<-grep( "\\[[0-9]*:[0-9]*\\]" , data)
#Aqui el supuesto es que la ultima columna tendra a todas las que hay que eliminar
rowdel<-grep( "\\[[0-9]*:[0-9]*\\]" , data[,colfinderase[length(colfinderase)] ] )
#Se crea la nueva tabla ya recortada
data2<-data[-rowdel,]
#Se escribe (es importante cambiar el nombre del csv)
write.csv(data2, "colimarenombrado.csv")

#Forma de ver si tiene dos cajas de corchetes(regresa true o false)
#grep( "\\[[0-9]*\\]\\[[0-9]*-[0-9]*\\]" , "[163][1-36]")

#una sola caja de corchetes
#grep( "\\[[0-9]*:[0-9]*\\]" , "[25:27]")


