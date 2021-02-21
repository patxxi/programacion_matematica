## Funcion Encargada de calcular y devolver los Pivotes

function [columnaPivote filaPivote elementoPivote] = checkPivote (tabla)
fprintf('Buscando Columna Pivote (Donde esta el Numero mas positivo de "Z")\n')
#Columna Pivote
    mayor = -1;
    for i = 1 : size(tabla,1)-1
        if (mayor < tabla(1,i))
            mayor = tabla(1,i);
            columnaPivote = i;
        endif 
    endfor
    

    #Fila Pivote
    fprintf('Buscando Fila Pivote (La que tenga la Razon con el menor Positivo)\n')
    fprintf('NOTA = La RAZON es el elemento en la columna Solucion, dividido entre la columna Pivote\n\n')
    menor = 100;
    for i = 2 : size(tabla,1) # Por cada fila que no sea la fila Z
        if (tabla(i,columnaPivote) != 0 )
            razon = (tabla(i,size(tabla,2)) / tabla(i,columnaPivote));
            razon = round(100 * razon) / 100;
        endif

        if razon < menor && razon >= 0
            menor = razon;
            filaPivote = i;
        endif
    endfor

    #Elemento Pivote
    elementoPivote = tabla(filaPivote,columnaPivote);

end