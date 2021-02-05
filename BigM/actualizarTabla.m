## Funcion encargada de la creacion de una nueva ntabla simplex
## La calcula según los pivotes respectivos

function tabla = actualizarTabla(viejaTabla, columnaPivote, filaPivote, elementoPivote)
disp("Se crea Tabla vacia para los proximos resultados...");
tabla = zeros(size(viejaTabla));
    
    for k = 1:size(viejaTabla,2)
        fprintf('\nActualizando Fila Pivote... ')
        printf('Tabla(%d,%d) = %d / %d = %f    ',filaPivote,k,viejaTabla(filaPivote,k),elementoPivote,(viejaTabla(filaPivote,k) / elementoPivote))
        tabla(filaPivote,k) = viejaTabla(filaPivote,k) / elementoPivote;
    endfor

    for i = 1:size(viejaTabla,1)
        for j = 1 : size(viejaTabla,2)
            
            #Fila entrante
            if (i == filaPivote)
            
            #Calculo de las demas filas
            else
                fprintf('\nActualizando Otras Filas... ') 
                printf('Aux = %d * %d  ->  ',viejaTabla(i,columnaPivote),tabla(filaPivote,j))
                aux = (viejaTabla(i,columnaPivote) * tabla(filaPivote,j));
                printf('Tabla(%d,%d) = %d - %d = %f   ',i,j,viejaTabla(i,j),aux,(viejaTabla(i,j) - aux));
                tabla(i,j) = viejaTabla(i,j) - aux;
            endif
            
        endfor
    endfor
    
    fprintf("\n\n")

endfunction