# QGIS

En este archivo se encuentra guardada la sesion que carga los mapas que se analizaron.

Las seciones del Estado de Mexico en este mapa son diferentes a la del archivo csv. No se puede reconstruir distritos porque los numeros no concuerdan. Si se tuvieran los mapas de alguno de los años de la base csv si se podrian hacer equivalencias.. 

Lo que se necesita es una base de datos que este acorde al mapa, para que apartir de ella se pueda reconstruir ese año, y por equivalencias los años anteriores. 


Comandos usados en python qgis

layer = iface.activeLayer()
layer.select(7) #(void) Selecciona una parte del mapa. En especifico la fila 7 de la tabla


for f in layer.getFeatures():
  print f['name'], f['iata_code']


Select by expressions
"DISTRITO" IN (1)

for feature in layer:
	writer.addFeature(feature)

# close the writer and flush features to disk
del writer