import pandas as pd
import os
import shutil
from datetime import date, timedelta

# Avance de vacunación: primera dosis más dosis única
# Cobertura de vacunación: segunda dosis más dosis única

url = "https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto76/vacunacion_std.csv"
vac = pd.read_csv(url)

yesterday = date.today() - timedelta(days=1)
yesterday = yesterday.strftime("%Y-%m-%d")

# regiones = vac.loc[vac.Fecha == yesterday] # filtramos para mostrar la cantidad de vacunas según dosis para el día de ayer
# regiones = regiones.loc[regiones.Region != "Total"]
regiones = vac.loc[vac.Region != "Total"]

reg_primera = regiones.loc[regiones.Dosis == "Primera"].rename(columns={"Cantidad": "primera_dosis"})
reg_primera = reg_primera[["Region", "Fecha", "primera_dosis"]].reset_index(drop=True)

reg_segunda = regiones.loc[regiones.Dosis == "Segunda"].rename(columns={"Cantidad": "segunda_dosis"})
reg_segunda = reg_segunda[["segunda_dosis"]].reset_index(drop=True)

reg_unica = regiones.loc[regiones.Dosis == "Unica"].rename(columns={"Cantidad": "unica_dosis"})
reg_unica = reg_unica[["unica_dosis"]].reset_index(drop=True)

reg_tercera = regiones.loc[regiones.Dosis == "Refuerzo"].rename(columns={"Cantidad": "tercera_dosis"})
reg_tercera = reg_tercera[["tercera_dosis"]].reset_index(drop=True)

reg_cuarta = regiones.loc[regiones.Dosis == "Cuarta"].rename(columns={"Cantidad": "cuarta_dosis"})
reg_cuarta = reg_cuarta[["cuarta_dosis"]].reset_index(drop=True)

reg = pd.concat([reg_primera, reg_segunda, reg_unica, reg_tercera, reg_cuarta], axis=1)
reg = reg.rename(columns={"Region": "region_nombre"})

dic_reg = {
    "Aysén":"11",
    "Antofagasta":"2",
    "Arica y Parinacota":"15",
    "Atacama":"3",
    "Coquimbo":"4",
    "Araucanía":"9",
    "Los Lagos":"10",
    "Los Ríos":"14",
    "Magallanes":"12",
    "Tarapacá":"1",
    "Valparaíso":"5",
    "Ñuble":"16",
    "Biobío":"8",
    "O’Higgins":"6",
    "Maule":"7",
    "Metropolitana":"13"
}

reg_id = pd.DataFrame(dic_reg.items())
reg_id.columns = ["region_nombre", "Region"]
reg_id = reg_id.astype({"Region": int})


## POBLACIÓN POR REGIÓN Y EDAD ##
dir_path = os.path.abspath(os.path.dirname(__file__))
ine = pd.read_csv(f"{dir_path}/ine/ine_pob_region.csv")
# ine = ine.loc[ine.Edad > 17]
ine = ine.astype({"Region":int})

ine_region = ine.merge(reg_id, on="Region", how="left")
ine_pob_reg = ine_region.groupby(["Region", "region_nombre"]).a2021.sum().reset_index()
ine_pob_reg = ine_pob_reg.rename(columns={"Region": "region", "a2021": "pob_2021"})

## JOIN DOSIS POR REGION Y POBLACION POR REGION ##
reg_final = reg.merge(ine_pob_reg, on="region_nombre", how="left")
reg_final["avance_vacunacion"] = reg_final["primera_dosis"] + reg_final["unica_dosis"]
reg_final["cobertura_vacunacion"] = reg_final["segunda_dosis"] + reg_final["unica_dosis"]
reg_final["avance_porcentual"] = round(100 * reg_final["avance_vacunacion"] / reg_final["pob_2021"],2)
reg_final["cobertura_porcentual"] = round(100 * reg_final["cobertura_vacunacion"] / reg_final["pob_2021"], 2)

reg_sum = reg_final[["region_nombre", "Fecha", "avance_porcentual", "cobertura_porcentual"]]

## RANGOS DE PORCENTAJES DE COBERTURA ##
copy_reg_sum = reg_sum.copy()
copy_reg_sum.loc[copy_reg_sum.cobertura_porcentual < 50, "rango_cobertura"] = "<50" # rojo
copy_reg_sum.loc[(copy_reg_sum.cobertura_porcentual < 70) & (copy_reg_sum.cobertura_porcentual >= 50), "rango_cobertura"] = "[50-70[" # naranjo
copy_reg_sum.loc[(copy_reg_sum.cobertura_porcentual < 90) & (copy_reg_sum.cobertura_porcentual >= 70), "rango_cobertura"] = "[70-90[" # amarillo
copy_reg_sum.loc[copy_reg_sum.cobertura_porcentual >= 90, "rango_cobertura"] = ">=90" # verde

if os.path.exists(f"{dir_path}/archivos_nuevos_vacunas"):
    shutil.rmtree(f"{dir_path}/archivos_nuevos_vacunas")
    
os.mkdir(f"{dir_path}/archivos_nuevos_vacunas")
copy_reg_sum.to_csv(f"{dir_path}/archivos_nuevos_vacunas/vacunacion_regiones.csv", index=False)


## PARA EL GRÁFICO DE COBERTURA NACIONAL ##
total_nacional = vac.loc[vac.Region == "Total"]
total_nacional = total_nacional[["Dosis", "Fecha", "Cantidad"]]

aux_primera_nac = total_nacional.loc[total_nacional.Dosis == "Primera"].rename(columns={"Cantidad": "primera_dosis"})
aux_primera_nac = aux_primera_nac[["Fecha", "primera_dosis"]]
aux_segunda_nac = total_nacional.loc[total_nacional.Dosis == "Segunda"].rename(columns={"Cantidad": "segunda_dosis"})
aux_segunda_nac = aux_segunda_nac[["Fecha", "segunda_dosis"]]
aux_unica_nac = total_nacional.loc[total_nacional.Dosis == "Unica"].rename(columns={"Cantidad": "unica_dosis"})
aux_unica_nac = aux_unica_nac[["Fecha", "unica_dosis"]]
aux_tercera_nac = total_nacional.loc[total_nacional.Dosis == "Refuerzo"].rename(columns={"Cantidad": "tercera_dosis"})
aux_tercera_nac = aux_tercera_nac[["Fecha", "tercera_dosis"]]
aux_cuarta_nac = total_nacional.loc[total_nacional.Dosis == "Cuarta"].rename(columns={"Cantidad": "cuarta_dosis"})
aux_cuarta_nac = aux_cuarta_nac[["Fecha", "cuarta_dosis"]]

aux_join = aux_primera_nac.merge(aux_segunda_nac, on="Fecha", how="left")
aux_join_final = aux_join.merge(aux_unica_nac, on="Fecha", how="left")

pob_nacional = ine.a2021.sum() #considra la población total proyectada desde los 0 años en adelante
aux_join_final["avance"] = round(100 * (aux_join_final["primera_dosis"] + aux_join_final["unica_dosis"]) / pob_nacional, 2)
aux_join_final["cobertura"] = round(100 * (aux_join_final["segunda_dosis"] + aux_join_final["unica_dosis"]) / pob_nacional, 2)

## RANGOS DE PORCENTAJES DE COBERTURA ##
nacional = aux_join_final[["Fecha", "avance", "cobertura"]]
copy_nacional = nacional.copy()
copy_nacional.loc[copy_nacional.cobertura < 50, "rango_cobertura"] = "<50" # rojo
copy_nacional.loc[(copy_nacional.cobertura < 70) & (copy_nacional.cobertura >= 50), "rango_cobertura"] = "[50-70[" # naranjo
copy_nacional.loc[(copy_nacional.cobertura < 90) & (copy_nacional.cobertura >= 70), "rango_cobertura"] = "[70-90[" # amarillo
copy_nacional.loc[copy_nacional.cobertura >= 90, "rango_cobertura"] = ">=90" # verde

copy_nacional.to_csv(f"{dir_path}/archivos_nuevos_vacunas/total_nacional_vacunas.csv", index=False)

# PARA EL GRÁFICO COMPLETO A NIVEL NACIONAL ##
url_primera = "https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto78/vacunados_edad_fecha_1eraDosis_std.csv"
url_segunda = "https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto78/vacunados_edad_fecha_2daDosis_std.csv"
url_unica = "https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto78/vacunados_edad_fecha_UnicaDosis_std.csv"
url_tercera = "https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto78/vacunados_edad_fecha_Refuerzo_std.csv"
url_cuarta = "https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto78/vacunados_edad_fecha_Cuarta_std.csv"

vac_primera = pd.read_csv(url_primera)
vac_primera = vac_primera.groupby(["Fecha"])["Primera Dosis"].sum().reset_index()
vac_primera = vac_primera.rename(columns={"Primera Dosis": "cantidad"})
vac_primera["dosis"] = "primera"

vac_segunda = pd.read_csv(url_segunda)
vac_segunda = vac_segunda.groupby(["Fecha"])["Segunda Dosis"].sum().reset_index()
vac_segunda = vac_segunda.rename(columns={"Segunda Dosis": "cantidad"})
vac_segunda["dosis"] = "segunda"

vac_unica = pd.read_csv(url_unica)
vac_unica = vac_unica.groupby(["Fecha"])["Unica Dosis"].sum().reset_index()
vac_unica = vac_unica.rename(columns={"Unica Dosis": "cantidad"})
vac_unica["dosis"] = "unica"

vac_tercera = pd.read_csv(url_tercera)
vac_tercera = vac_tercera.groupby(["Fecha"])["Dosis Refuerzo"].sum().reset_index()
vac_tercera = vac_tercera.rename(columns={"Dosis Refuerzo": "cantidad"})
vac_tercera["dosis"] = "tercera"

vac_cuarta = pd.read_csv(url_cuarta)
vac_cuarta = vac_cuarta.groupby(["Fecha"])["Cuarta Dosis"].sum().reset_index()
vac_cuarta = vac_cuarta.rename(columns={"Cuarta Dosis": "cantidad"})
vac_cuarta["dosis"] = "cuarta"

total = pd.concat([vac_primera, vac_segunda, vac_unica, vac_tercera, vac_cuarta])
total.to_csv(f"{dir_path}/archivos_nuevos_vacunas/consolidado_vacunas.csv", index=False)
