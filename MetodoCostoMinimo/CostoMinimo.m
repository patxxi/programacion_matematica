% Una cadena de ventas de computadoras en Carabobo cuenta con proveedores en Caracas, Maracay y Punto Fijo, %
% y cuatro puntos de ventas, identificados como Local 1, Local 2, Local 3 y Local 4. Por su parte, El proovedor %
% Por su parte, El proovedor de Caracas tiene disponibles 35 computadoras, mientras en Maracay la existencia %
% alcanza las 50 y Punto Fijo 40. Se sabe que el Local 1 requiere de 40 computadoras, El Local 2 requiere 20 %
% mientras que tanto el Local 3 como el Local 4 necesitan 30 computadoras cada una. Los costos de transporte %
% unitarios en $ asociados desde cada origen a cada destino, se muestra en la siguente tabla: %

##################################################################
###############  Local 1 # Local 2 # Local 3 # Local 4 # Oferta ##
##################################################################
## Caracas    #    8     #    6    #   10    #    9    #   35   ##
##################################################################
## Maracay    #    9     #    12   #   13    #    7    #   50   ##
##################################################################
## Punto Fijo #   14     #    9    #   16    #    5    #   40   ##
##################################################################
## Demanda    #   40     #   20    #   30    #   30    ###########
##################################################################


costo = [
    8     6    10    9 ;
    9    12    13    7 ;
    14    9    16    5
]

demanda = [ 40 20 30 30 ] # Columna
oferta  = [ 35 50 40 ]    # Fila


## Buscar el elemento con menor valor de coste
function [fila, columna] = menorCoste(costo, oferta)
    valor_minimo = 99999999;
    for i = 1 : size(costo, 1)
        for j = 1 : size(costo, 2)

            # En caso de hallar un nuevo valor minimo
            if costo(i, j) < valor_minimo
                valor_minimo = costo(i,j);
                fila = i;
                columna = j;

            # En caso de que el valor mminimo sea igual se comprueba cual seria mas optimo
            elseif costo(i,j) == valor_minimo

                # El elemento comparado tiene mas oferta que el actual
                if oferta(i) > oferta(fila)
                    valor_minimo = costo(i, j)
                    fila = i
                    columna = j
                endif

            # No hay nuevo valor minimo
            else
                # Do Nothing

            endif
        endfor
    endfor
endfunction

function [Resultado, demanda, oferta] = actualizarResultado(Resultado, demanda, oferta, fila, columna)

    if demanda(columna) < oferta(fila)
        # La Oferta supera la demanda
        valor = demanda(columna)
        demanda(columna) = 0
        oferta(fila) = oferta(fila) - valor
    else
        # La Oferta no suple la demanda
        valor = oferta(fila)
        oferta(fila) = 0
        demanda(columna) = demanda(columna) - valor
    endif

    # Guardamos el Valor
    Resultado(fila,columna) = valor;

endfunction

function costoActualizado = actualizarCosto(costo, demanda, oferta)

    costoActualizado = zeros(size(costo,1), size(costo,2))


    for i = 1 : size(costo, 1)
        for j = 1 : size(costo, 2)
            if demanda(j) == 0 ||  oferta(i) == 0
                costoActualizado(i,j) = inf;
            else
                costoActualizado(i,j) = costo(i,j);
            endif
        endfor
    endfor
endfunction


function suma = calculoCostoFinal(Resultado, costo)
    suma = 0 ;
    for i = 1 : size(costo, 1)
        for j = 1 : size(costo, 2)
            suma = suma + (Resultado(i,j) * costo(i,j));
        endfor
    endfor
end


function Resultado = CostoMinimo(costo, oferta,demanda)
    costoActualizado = costo;
    Resultado = zeros(size(costo,1), size(costo,2));


    while sum(demanda) > 0
        [fila, columna] = menorCoste(costoActualizado, oferta)
        [Resultado, demanda, oferta] = actualizarResultado(Resultado, demanda, oferta, fila, columna)
        costoActualizado = actualizarCosto(costo, demanda, oferta)
    endwhile
    Resultado
endfunction

function [tablaUV fila columna] = TablaUV(costo, Resultado)
    U = [0 0 0]; # Filas
    V = [0 0 0 0 ]; #zeros(size(costo,2)); # Columnas

    tablaUV = zeros(size(costo,1), size(costo,2));
    # Calculo de U y V
    for i = 1 : size(costo, 1)
        i
        for j = 1 : size(costo, 2)
            j
            # U(1) = 0
            if i == 1
                if Resultado(1,j) != 0 # Se usa en solucion inicial
                    # V(j) = Costo(i,j) - U(i)
                    val = costo(1,j)
                    V(j) = val
                endif

            # Calculamos U(i)
            else
                # Si no se ha calculado U(i) se busca
                if U(i) == 0
                    for k = 1 : size(costo,1)
                        if V(k) != 0
                            if Resultado(i,k) != 0
                                if U(i) == 0
                                    k
                                    # U(i) = costo(i,k) - V(k)
                                    val = costo(i,k) - V(k)
                                    U(i) = val
                                endif
                            endif
                        endif
                    endfor
                endif

                # Calcular las V(j) Faltantes
                if V(j) == 0
                    if Resultado(i,j) != 0
                        val = costo(i,j) - U(i);
                        V(j) = val
                    endif
                endif
            endif


        endfor
    endfor

    mayor = -1
    # Rellenamos la tabla UV
    for i = 1 : size(costo, 1)
        for j = 1 : size(costo, 2)
            if Resultado(i,j) == 0
                val = U(i) + V(j) - costo(i,j);
                if val > mayor
                    mayor = val
                    columna = j
                    fila = i
                endif
                tablaUV(i,j) = val
            endif
        endfor
    endfor
    U
    V
end

Resultado = CostoMinimo(costo, oferta, demanda)
sum = calculoCostoFinal(Resultado, costo)
[tablaUV fila columna] = TablaUV(costo, Resultado)