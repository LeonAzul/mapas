# QGIS

En este archivo se encuentra guardada la sesion que carga los mapas que se analizaron.

Las seciones de el Estado de Mexico en este mapa son 6430 mientras que en el archivo csv hay 6391. Claramente ambos numeros no coinciden por lo que no es posible reconstruir a todos los distritos electorales.

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