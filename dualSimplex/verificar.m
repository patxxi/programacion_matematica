function bool = verificar(tabla)
    bool = true;
    
        if(tabla(1,1) != 0 || tabla(1,2) != 0 || tabla(1,3))
            bool = false;
            printf('No Cumple la condicion de Resultado Optimo\n Iniciando Iteracion...\n\n')
            
            # ********************************************************************************* #
            # La condicion es que los Elementos de la Fila Z en las primeras columnas sean == 0 #
            # Quedando La Matriz Identidad en las Columnas A,B y C                              #
            # ********************************************************************************* #
        end
    
endfunction