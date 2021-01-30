function bool = verificar(tabla)
    f = size(tabla,1);
    c = size(tabla,2);
    bool = true;
    for i=2:c-1
        if 1 == 1#(tabla(1,i) >= 1)
            bool = false;
            printf('El elemento %d > 0 No Cumple la condicion de Resultado Optimo, Se hace otra Iteracion\n\n',tabla(1,i))
            break
        end
    end
endfunction