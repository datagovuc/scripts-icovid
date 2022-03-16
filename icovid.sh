#!/usr/bin/bash

EXECUTIONDATE=$(date +%Y%m%d); # para los backups
UNIXTIME=$(date +%s);                # genera unix time para diferencias las carpetas de backup cuando hay más de una generada por día
PATHDOC="/mnt/c/Users/${1}/Documents"; # ponemos el nombre usuario en Windows
ROOTPATH="${HOME}/datagov/scripts-icovid";
ROOTPATH2="${HOME}/datagov";

echo "Copiando archivo producto 24"

cd ${PATHDOC}/ICOVID;
rm 'CamasHospital_Diario_std.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto24/CamasHospital_Diario_std.csv';

echo "[$(date +"%F %T")] Git pull al repo de ICOVID"

cd ${HOME}/datagov/ICOVID;
git pull;

echo "[$(date +"%F %T")] Copiamos los archivos desde el repo minciencias para dimensiones de la 1 a la 3"

cd ${HOME}/datagov/ICOVID/dimension1/R/nacional/;
rm 'r.nacional_n.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto54/r.nacional_n.csv';

cd ${HOME}/datagov/ICOVID/dimension1/R/regional/;
rm 'r.regional_n.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto54/r.regional_n.csv';

cd ${HOME}/datagov/ICOVID/dimension1/R/Provincial/;
rm 'r.provincial_n.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto54/r.provincial_n.csv';

cd ${HOME}/datagov/ICOVID/dimension1/R/SS/;
rm 'r.ss_n.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto54/r.ss_n.csv';

cd ${HOME}/datagov/ICOVID/dimension1/carga/nacional/;
rm 'carga.nacional.ajustada.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto69/carga.nacional.ajustada.csv';

cd ${HOME}/datagov/ICOVID/dimension1/carga/nacional/;
rm 'confirmados nacional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto53/confirmados_nacional.csv';
mv confirmados_nacional.csv "confirmados nacional.csv";

cd ${HOME}/datagov/ICOVID/dimension1/carga/regional/;
rm 'carga.regional.ajustada.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto69/carga.regional.ajustada.csv';

cd ${HOME}/datagov/ICOVID/dimension1/carga/regional/;
rm 'confirmados_regionales.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto53/confirmados_regionales.csv';

cd ${HOME}/datagov/ICOVID/dimension1/carga/Provincial/;
rm 'carga.provincial.ajustada.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto69/carga.provincial.ajustada.csv';

cd ${HOME}/datagov/ICOVID/dimension1/carga/Provincial/;
rm 'confirmados_provinciales.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto53/confirmados_provinciales.csv';

cd ${HOME}/datagov/ICOVID/dimension1/carga/SS/;
rm 'carga.ss.ajustada.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto69/carga.ss.ajustada.csv';

cd ${HOME}/datagov/ICOVID/dimension1/carga/SS/;
rm 'confirmados_ss.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto53/confirmados_ss.csv';

cd ${HOME}/datagov/ICOVID/dimension2/positividad/nacional/;
rm 'Positividad nacional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto55/Positividad_nacional.csv';
mv Positividad_nacional.csv "Positividad nacional.csv";

cd ${HOME}/datagov/ICOVID/dimension2/positividad/regional/;
rm 'Positividad por region.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto55/Positividad_por_region.csv';
mv Positividad_por_region.csv "Positividad por region.csv";

cd ${HOME}/datagov/ICOVID/dimension2/positividad/provincial/;
rm 'Positividad por provincia.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto55/Positividad_por_provincia.csv';
mv Positividad_por_provincia.csv "Positividad por provincia.csv";

cd ${HOME}/datagov/ICOVID/dimension2/positividad/comunal/;
rm 'Positividad por comuna.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto55/Positividad_por_comuna.csv';
mv Positividad_por_comuna.csv "Positividad por comuna.csv";

cd ${HOME}/datagov/ICOVID/dimension2/tasatest/nacional/;
rm 'tasa test semanal nacional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto68/tasa_test_semanal_nacional.csv';
mv tasa_test_semanal_nacional.csv "tasa test semanal nacional.csv";

cd ${HOME}/datagov/ICOVID/dimension2/tasatest/regional/;
rm 'tasa test semanal regional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto68/tasa_test_semanal_regional.csv';
mv tasa_test_semanal_regional.csv "tasa test semanal regional.csv";

cd ${HOME}/datagov/ICOVID/dimension2/tasatest/provincial/;
rm 'tasa test semanal provincial.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto68/tasa_test_semanal_provincial.csv';
mv tasa_test_semanal_provincial.csv "tasa test semanal provincial.csv";

cd ${HOME}/datagov/ICOVID/dimension2/tasatest/comunal/;
rm 'tasa test semanal comunal.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto68/tasa_test_semanal_comunal.csv';
mv tasa_test_semanal_comunal.csv "tasa test semanal comunal.csv";

cd ${HOME}/datagov/ICOVID/dimension3/notificacion/Nacional/;
rm 'not48.nacional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto71/not48.nacional.csv';

cd ${HOME}/datagov/ICOVID/dimension3/notificacion/Regional/;
rm 'not48.regional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto71/not48.regional.csv';

cd ${HOME}/datagov/ICOVID/dimension3/notificacion/Provincial/;
rm 'not48.provincial.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto71/not48.provincial.csv';

cd ${HOME}/datagov/ICOVID/dimension3/total/Nacional/;
rm 'total72.nacional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto70/total72.nacional.csv';

cd ${HOME}/datagov/ICOVID/dimension3/total/Regional/;
rm 'total72.regional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto70/total72.regional.csv';

cd ${HOME}/datagov/ICOVID/dimension3/total/Provincial/;
rm 'total72.provincial.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto70/total72.provincial.csv';

cd ${HOME}/datagov/ICOVID/dimension3/laboratorio/Nacional/;
rm 'lab24.nacional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto72/lab24.nacional.csv';

cd ${HOME}/datagov/ICOVID/dimension3/laboratorio/Regional/;
rm 'lab24.regional.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto72/lab24.regional.csv';

cd ${HOME}/datagov/ICOVID/dimension3/laboratorio/Provincial/;
rm 'lab24.provincial.csv';
wget 'https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto72/lab24.provincial.csv';

cd ${HOME}/datagov/ICOVID;
git add .;
git commit -m "Pull manual del repo ${EXECUTIONDATE}";
git push;

cd ${ROOTPATH};

echo "[$(date +"%F %T")] Generamos los archivos para las dimensiones de la 1 a la 4"

python3 icovid-dimensiones/step_one.py;
python3 icovid-dimensiones/step_two.py;

echo "[$(date +"%F %T")] Copiamos los archivos generados en la ruta ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE}"

if [ ! -d "${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE}" ]; then
  sudo mkdir -p ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-dimensiones/archivos-step-one/${EXECUTIONDATE}/*.xlsx ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-dimensiones/archivos-step-two/${EXECUTIONDATE}/*.xlsx ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE};
else
  sudo mkdir -p ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE}_${UNIXTIME};
  sudo mv ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE}/*.xlsx ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE}_${UNIXTIME};
  sudo cp ${ROOTPATH}/icovid-dimensiones/archivos-step-one/${EXECUTIONDATE}/*.xlsx ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-dimensiones/archivos-step-two/${EXECUTIONDATE}/*.xlsx ${PATHDOC}/ICOVID/resumen/${EXECUTIONDATE};
fi

echo "[$(date +"%F %T")] Copiamos las carpetas del repo actualizadas en la ruta ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE}"

if [ ! -d "${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE}" ]; then
  sudo mkdir -p ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension1 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension2 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension3 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension4 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
else
  sudo mkdir -p ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE}_${UNIXTIME};
  sudo mv ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE}/* ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE}_${UNIXTIME};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension1 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension2 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension3 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
  sudo cp -r ${ROOTPATH2}/ICOVID/dimension4 ${PATHDOC}/ICOVID/icovid-repo/${EXECUTIONDATE};
fi

echo "[$(date +"%F %T")] Generamos los archivos para fallecidos"

bash icovid-dead/dead.sh;

echo "[$(date +"%F %T")] Generamos los archivos para hospitalizados"

python3 icovid-hosp/hospitalizados.py;

echo "[$(date +"%F %T")] Generamos los archivos para vacunados"

python3 icovid-vacunacion/vacunas.py;
python3 icovid-vacunacion/nuevos_vacunas.py;


if [ ! -d "${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE}" ]; then
  sudo mkdir -p ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-dead/fallecidos-etario/${EXECUTIONDATE}/fallecidos-etario.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-hosp/archivos_hospitalizados/${EXECUTIONDATE}/hospitalizados_etario.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-vacunacion/archivos_vacunas/*.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-vacunacion/archivos_nuevos_vacunas/*.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
else
  sudo mkdir -p ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE}_${UNIXTIME};
  sudo mv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE}/* ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE}_${UNIXTIME};
  sudo cp ${ROOTPATH}/icovid-dead/fallecidos-etario/${EXECUTIONDATE}/fallecidos-etario.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-hosp/archivos_hospitalizados/${EXECUTIONDATE}/hospitalizados_etario.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-vacunacion/archivos_vacunas/*.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
  sudo cp ${ROOTPATH}/icovid-vacunacion/archivos_nuevos_vacunas/*.csv ${PATHDOC}/ICOVID/nuevas-visualizaciones/${EXECUTIONDATE};
fi

echo "[$(date +"%F %T")] Proceso finalizado con éxito"
