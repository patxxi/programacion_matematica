## Funcion Encargada de calcular y devolver los Pivotes

function [columnaPivote filaPivote elementoPivote] = checkPivote (tabla)
disp('Buscando Columna Pivote (Donde esta el Numero mas positivo de "Z")')
#Columna Pivote
    mayor = -1;
    for j = 1 : size(tabla,2)-1
        for i = 1 : size(tabla,1)
            if (mayor < tabla(i,j))
                mayor = tabla(i,j);
                columnaPivote = j;
            endif
        endfor 
    endfor


    #Fila Pivote
    disp('Buscando Fila Pivote (La que tenga la Razon con el menor Positivo)')
    fprintf('NOTA = La RAZON es el elemento en la columna Solucion\n Dividido entre la columna Pivote\n\n')
    menor = 100;
    for i = 2 : size(tabla,1)
        razon = (tabla(i,size(tabla,2)) / tabla(i,columnaPivote));
        if (menor > razon )
            menor = razon;
            filaPivote = i;
        endif
    endfor

    #Elemento Pivote
    elementoPivote = tabla(filaPivote,columnaPivote)

end