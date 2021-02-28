function tabla = tablaInicial (Z,rest1,rest2,rest3)
    fprintf('\n\nSe Crea la tabla segun las Ecuaciones dadas\n')
    
    # *********************************************************************************** #
    # No se muestran las Iteraciones de Esta Funcion debido a que la Consola de Octave    #
    # Eliminaba el Principio por ser mucho texto    	                                  #
    # *********************************************************************************** #
    
    tabla = zeros(4,length(Z));
    for i = 1: 4
        for j = 1: length(Z) 
            if i == 1
                tabla(i,j) = Z(j);
            elseif i == 2 && j != 4;
                tabla(i,j) = -rest1(j);
            elseif i == 3 && j != 5;
                tabla(i,j) = -rest2(j);
            elseif i == 4 && j != 6;
                tabla(i,j) = -rest3(j);
            else
                tabla(i,j) = 1;
            endif
        endfor
    endfor  
endfunction