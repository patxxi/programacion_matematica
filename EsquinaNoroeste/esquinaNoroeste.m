fprintf("#############################################################################\n")
fprintf("#                            Solucion Inicial                               #\n")
fprintf("#                     Metodo de la Esquina Noroeste                         #\n")
fprintf("# Segun:                                                                    #\n")
fprintf("#   Caracas:       Local 1 =  8, Local 2 =  6, Local 3 = 10, Local 4 = 9    #\n")
fprintf("#   Maracay:       Local 1 =  9, Local 2 = 12, Local 3 = 13, Local 4 = 7    #\n")
fprintf("#   Punto Fijo:    Local 1 = 14, Local 2 =  9, Local 3 = 16, Local 4 = 5    #\n")
fprintf("#############################################################################\n")
fprintf("# Segun la Demanda: Local 1 = 40, Local 2 = 20, Local 3 = 30, Local 4 = 30  #\n")
fprintf("# Segun la Oferta: Caracas = 35, Maracay = 50, PuntoFijo = 40               #\n")
fprintf("#############################################################################\n\n\n")


########################################################################
# ******************************************************************** #
# *********************Tabla Inicial********************************** #
# ******************************************************************** #
#          	    Local 1    Local 2     Local 3      Local 4   Oferta   #
# Caracas         8           6          10           9         35     #
# Maracay         9          12          13           7         50     #
# Punto Fijo     14           9          16           5         40     #
# ******************************************************************** #
# Demanda        40          20          30           30               #
# ******************************************************************** #
########################################################################
# ******************************************************************** #
# ***************************Tabla Resultado************************** #
# ******************************************************************** #
#          	    Local 1    Local 2     Local 3      Local 4   Oferta   #
# Caracas         8           6          10           9         35     #
# Maracay         9          12          13           7         50     #
# Punto Fijo     14           9          16           5         40     #
# ******************************************************************** #
# ******************************************************************** #
# Costo Total = 35*8 + 5*9 + 20*12 + 25*13 + 5*16 + 30*5               #
# Costo Total = 1120                                                   #
# ******************************************************************** #
########################################################################




Caracas   =   [  8    6  10   9   35 ]
Maracay   =   [  9   12  13   7   50 ]
PuntoFijo =   [ 14    9  16   5   40 ]
demanda   =   [ 40   20  30  30    0 ]


tablaInicial = [Caracas;Maracay;PuntoFijo;demanda]
tabla = tablaInicial;
columna = 1;
fila = 1;
costos = "";
costoFinal = 0;

fprintf("\n===============================================================================================\n")
fprintf("===============================================================================================\n")
fprintf("===============================================================================================\n\n\n")


while columna < 5

    fprintf("Comprobando si la oferta satisface la demanda...   ")
    ofertaYDemanda = tabla(fila,end) - tabla(end,columna)

    # Suministro mayor o Igual a Demanda
    if ofertaYDemanda >= 0

        fprintf("\nLa oferta SI satisface la demanda. Ajustando datos...\n")
        fprintf("\nAgregando compra en casilla respectiva...    ")
        tabla(fila,columna) = tabla(end,columna)
        fprintf("\nAjustando Oferta...  ")
        tabla(fila,end) = tabla(fila,end) - tabla(end,columna)
        fprintf("\nAjustando Demanda...  ")
        tabla(end,columna) = 0
        fprintf("\nCalculo actual de costos...   \n")
        fprintf("\n")
        if ofertaYDemanda == 0
            costos = [costos mat2str(tabla(fila,columna))  "*"  mat2str(tablaInicial(fila,columna)) ]
        else
            costos = [costos mat2str(tabla(fila,columna))  "*"  mat2str(tablaInicial(fila,columna)) " + "]
        endif

        costoFinal = costoFinal + (tabla(fila,columna)*tablaInicial(fila,columna))

        if columna < 4
            fprintf("\nAvanzando a siguente Columna...\n\n")
        endif
        fprintf("===============================================================================================\n\n")
        columna = columna + 1;

    # Suministro menor a Demanda
    else
        fprintf("\nLa oferta NO satisface la demanda. Ajustando datos...   \n")
        fprintf("\nAgregando compra en casilla respectiva...    ")
        tabla(fila,columna) = tabla(fila,end)
        fprintf("\nAjustando Demanda...  ")
        tabla(end,columna) = tabla(end,columna) - tabla(fila,end)
        fprintf("\nAjustando Oferta...  ")
        tabla(fila,end) = 0

        fprintf("\nCalculo actual de costos...   \n")
        fprintf("\n")
        costos = [costos mat2str(tabla(fila,columna))  "*"  mat2str(tablaInicial(fila,columna)) " + "]
        costoFinal = costoFinal + (tabla(fila,columna)*tablaInicial(fila,columna))
        fprintf("\nAvanzando a siguente Fila...\n\n")
        fprintf("===============================================================================================\n\n")
        fila = fila + 1;
    endif

    #fprintf("Costo Actual ") # Crear costosing con valores de multiplicacion ej. 600*3 + ...
    # imprimir el resultado despues

endwhile

for i=1 : 4
    for j=1: 5
        if(tabla(i,j) < 10)
        fprintf("Limpiando tabla...\n")
            tabla(i,j) = 0
        endif
    endfor
endfor

fprintf("\n\n===============================================================================================\n")
fprintf("=================================== Resultados Finales ========================================\n")
fprintf("===============================================================================================\n")
printf("================       %s = %d       ===============\n",costos,costoFinal)
fprintf("===============================================================================================\n")
fprintf("==================================== Estado de Tablas =========================================\n")
tablaInicial
tabla
fprintf("===============================================================================================\n")
fprintf("==================================== Fin Del Programa =========================================\n")
fprintf("===============================================================================================\n")

# ********************************************************************************************************** #
# ********************************************* Links De Apoyo ********************************************* #
# ********************************************************************************************************** #
# https://www.ingenieriainducostosialonline.com/investigacion-de-operaciones/metodo-de-la-esquina-noroeste/  #
# ********************************************************************************************************** #
#   https://www.easycalculation.com/operations-research/minimum-transportation-northwest-corner-method.php   #
# ********************************************************************************************************** #
#           https://www.youtube.com/watch?v=s5bXn-YDRcg&ab_channel=FELIPEROJASLEIVA                          #
# ********************************************************************************************************** #
# ********************************************************************************************************** #
