#!/usr/bin/bash

set -e;

FILEDATE=$(date --date="last thursday" +%d%m%Y);
#FILEDATE="02062022";
TODAY=$(date +%Y%m%d);
MONTH=$(date +%m);
#MONTH="08";
YEAR=$(date +%Y);
ZIPFILE="DEFUNCIONES_FUENTE_DEIS_2016_2022_${FILEDATE}.zip";
URL="https://repositoriodeis.minsal.cl/DatosAbiertos/VITALES/${ZIPFILE}"; 
WORKFILES=${HOME}/datagov/scripts-icovid/icovid-dead/work-files;

cd ${WORKFILES};
wget ${URL};
unzip ${ZIPFILE};

# Cambiamos el encoding de Latin-1 (ISO-8859-1) a UTF-8
iconv --from-code=iso-8859-1 --to-code=utf-8 DEFUNCIONES_FUENTE_DEIS_2016_2022_${FILEDATE}.csv > fallecidos-utf8.csv;
rm DEFUNCIONES_FUENTE_DEIS_2016_2022_${FILEDATE}.csv;

# Generamos el subset de fallecimiento COVID
egrep "U071|U072" fallecidos-utf8.csv > fallecidos-subset-utf8.csv; # use this one for "universal" use
# rg "U071|U072" fallecidos-utf8.csv > fallecidos-subset-utf8.csv;

# Seleccionamos los campos fecha, sexo, edad y región
# awk 'BEGIN{FS=";";OFS=","} {print $1,$2,$4,$7}' fallecidos-subset-utf8.csv > fallecidos-four-fields.csv;
awk 'BEGIN{FS=";";OFS=","} {print $2,$3,$5,$8}' fallecidos-subset-utf8.csv > fallecidos-four-fields.csv;

awk  'BEGIN{FS=OFS=","}
{
  if ($3 < 50){rango="<50"; print $1, $2, $3, rango, $4}
  else if ($3 > 50 && $3 < 70){rango="50-69"; print $1, $2, $3, rango, $4} 
  else if ($3 > 69){rango=">=70"; print $1, $2, $3, rango, $4}
}' fallecidos-four-fields.csv > fallecidos-five-fields.csv;

# Agregamos encabezado al archivo
sed -i '1i fecha,sexo,edad,grupo_etario,region' fallecidos-five-fields.csv;

awk 'BEGIN{FS=OFS=","} {print $1, $2, $4, $5}' fallecidos-five-fields.csv > fallecidos_rango.csv;

# Generamos los archivos .csv necesarios para hacer visualizaciones
cd ..;
python3 dead.py;

cd $(pwd)/fallecidos-etario/${TODAY};
sed -i 's/inf/0/g' fallecidos-etario.csv;
sed -i 's/inf/0/g' fallecidos-etario-sexo.csv;
