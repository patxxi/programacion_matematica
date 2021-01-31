function bool = verificar(tabla)
    columnas = size(tabla,2);
    bool = true;
    for i=2:columnas-1
        if  (tabla(1,i) > 0)
            bool = false;
            printf('El elemento %d > 0 No Cumple la condicion de Resultado Optimo, Se hace otra Iteracion\n\n',tabla(1,i))
            break
        end
    end
endfunction