matrix = [0, 0, 0, 0, 0, -1, -1, -1, 0;
          3. 1. -1. 0. 0. 1. 0, 0, 3;
          4, 3, 0, -1, 0, 0, 1, 0, 6;
          1, 2, 0, 0, -1, 0, 0, 1, 3];

iter = 1;
Z = [-2, -1, 0, 0, 0, 0];

function [value, indexColPivot] = getColPivot(matrix)
    [value, indexColPivot] = max(matrix(1, 1:end-1));
end


function [value,indexRowPivot] = getRowPivot(matrix, indexColPivot)
    columnY = matrix(2:end, end);
    columnPivot = matrix(2:end, indexColPivot);
    [value, indexRowPivot] = min(abs(columnY ./ columnPivot));
    indexRowPivot++;
    
end

function matrix = sumAllRows(matrix)
    [row, col] = size(matrix);
    for i = 2:row 
        matrix(1,1:end) = matrix(1,1:end) + matrix(i, 1:end);
    end
end


function matrix = makePivotOne(matrix, indexRowPivot, pivot)
    matrix(indexRowPivot, :) = matrix(indexRowPivot, :) / pivot;
end

function matrix = makeColumnPivotZeros(matrix, rowIndexPivot, colIndexPivot)
    rowPivot = matrix(rowIndexPivot,:);
    [fil, col] = size(matrix);

    for i = 1: fil
        if(i == rowIndexPivot)
            continue;
        end
        valueColumnPivot = matrix(i,colIndexPivot);
        matrix(i,:) = (-valueColumnPivot * rowPivot) + matrix(i,:);
    end
end


function matrix = convertToPhase2(matrix, Z)
    matrix(:, 6:8) = [];
    matrix(1, :) = Z;

end

function matrix = makeXZero(matrix)
   matrix(1,:) = (-matrix(1,1) * matrix(2,:)) + matrix(1,:);  
   matrix(1,:) = (-matrix(1,2) * matrix(3,:)) + matrix(1,:);
end

function result(matrix)
    fprintf("Resultados de los valores de X1, X2 y Z\n\n");
    fprintf("X1 = %d\nX2 = %d\nZ = %d\n\n", matrix(2,end), matrix(3,end), matrix(1, end));
end

fprintf("Comienzo de la Primera Fase: \n\n");
disp(matrix);

fprintf("Fase 1 Iteracion %d\n\n", iter);
iter++;

fprintf("Hacemos los -1 de las variables artificiales 0:\n\n");
matrix = sumAllRows(matrix);
disp(matrix);

fprintf("Valor e indice de la columna pivote:\n\n");
[valueCol,indexColPivot] = getColPivot(matrix)

fprintf("Valor e indice de la fila pivote:\n\n");
[valueRow, indexRowPivot] = getRowPivot(matrix, indexColPivot)

fprintf("Sacamos el valor del pivote:\n\n");
pivot = matrix(indexRowPivot, indexColPivot)

fprintf("Volvemos 1 el pivote:\n\n");
matrix = makePivotOne(matrix, indexRowPivot,pivot);
disp(matrix);

fprintf("Volvemos 0 la columna pivote:\n\n");
matrix = makeColumnPivotZeros(matrix, indexRowPivot, indexColPivot);
disp(matrix);


while(true)
    fprintf("Fase 1 Iteracion %d\n\n", iter);
    iter++;
    [valueCol,indexColPivot] = getColPivot(matrix)
    if(valueCol <= 0)
        fprintf("Debido a que no existen mas valores mayores a 0, se procede a finalizar las iteraciones de la primera fase\n\n");
        break;
    end
    fprintf("Valor e indice de la fila pivote:\n\n");
    [valueRow, indexRowPivot] = getRowPivot(matrix, indexColPivot)

    fprintf("Sacamos el valor del pivote:\n\n");
    pivot = matrix(indexRowPivot, indexColPivot)

    fprintf("Volvemos 1 el pivote:\n\n");
    matrix = makePivotOne(matrix, indexRowPivot,pivot);
    disp(matrix);

    fprintf("Volvemos 0 la columna pivote:\n\n");
    matrix = makeColumnPivotZeros(matrix, indexRowPivot, indexColPivot);
    disp(matrix);

end
fprintf("Pasamos a remover las columnas de las variables artificiales y a cambiar la primera fila de la matriz por la de la funcion Z original:\n\n");
fprintf("Damos comienzo ahora con la Fase 2\n\n");
matrix = convertToPhase2(matrix,Z);
disp(matrix);

fprintf("Volvemos 0 los valores de las columnas X en la fila Z:\n\n");
matrix = makeXZero(matrix);
disp(matrix);

while(true)
    [valueCol,indexColPivot] = getColPivot(matrix)
    if(valueCol <= 0)
        fprintf("Debido a que no existen mas valores mayores a 0, se procede a finalizar las iteraciones de la segunda fase\n\n");
        break;
    end
end

result(matrix);