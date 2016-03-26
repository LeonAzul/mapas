# QGIS

En este archivo se encuentra guardada la sesion que carga los mapas que se analizaron.

Con la base de equivalencias correcta los numeros de las secciones coinciden


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
