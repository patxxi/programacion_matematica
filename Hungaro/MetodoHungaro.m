matrix = [
    22, 18, 30, 18, 0;
    18, inf, 27, 22, 0;
    26, 20, 28, 28, 0;
    16, 22, inf, 14, 0;
    21, inf, 25, 28, 0;
]

original_matrix = [
    22, 18, 30, 18, 0;
    18, inf, 27, 22, 0;
    26, 20, 28, 28, 0;
    16, 22, inf, 14, 0;
    21, inf, 25, 28, 0;
]
prueba1 = [
    6,0,5,4,0;
    2,inf,2,8,0;
    10,2,3,14,0;
    0,4,inf,0,0;
    5,inf,0,14,0;
]

prueba2 = [
    6,0,5,4,2;
    0,inf,0,6,0;
    8,0,1,12,0;
    0,4,inf,0,2;
    5,inf,0,14,2
]



function count = how_many_zeros_matrix(matrix)
    [row, col] = size(matrix);
    count = 0;
    
    for i=1: row
        actual = 0;
        for j=1: col
            if(matrix(i,j) == 0)
                actual += 1;
            end
        end

        if(actual > count)
            count = actual;
        end
    end
end

function count = how_many_zeros_vector(vector)
    n = length(vector);
    count = 0;

    for i=1: n
        if(vector(i) == 0)
            count += 1;
        end
    end
end

function is_zero = checkRow(matrix)
    [row, col] = size(matrix);
    count = 0;
    for i=1: row
        for j=1: col
            if(matrix(i,j) == 0)
                count += 1;
                break;
            end
        end
    end
    is_zero = count == row;
end

function is_zero = checkCol(matrix)
    [row, col] = size(matrix);
    count = 0;
    for j=1: col
        for i=1: row
            if(matrix(i,j) == 0)
                count += 1;
                break;
            end
        end
    end
    is_zero = count == row;
end

function matrix = sustractLowerValueCol(matrix)
    [row, col] = size(matrix);
    for j=1: col
        low = min(matrix(1:end, j));
        matrix(1:end, j) -= low;
    end
end

function [matrix_zeros, is_solution] = checkSolution(matrix)
    [row, col] = size(matrix);
    multipOptions = [];
    applications = [0,0,0,0,0];
    aux_zeros = [];
    count_zeros = how_many_zeros_matrix(matrix);
    matrix_zeros = zeros(row, col);
    iter = 1;

    while(iter <= 3)

        for i=1: row
            aux_conflicts = 0;
            indexs = [];


            if(how_many_zeros_vector(matrix(i, 1:end)) == iter)

                for j=1: col
                    if( matrix(i,j) == 0 && applications(j) == 0)
                        aux_conflicts += 1;
                        indexs = [indexs, j];
                    elseif( matrix(i,j) == 0 && iter == 1 && applications(j) == 1)
                        is_solution = 0;
                        return
                    end
                end

                if(aux_conflicts < 2)
                    for k=1: length(indexs)
                        applications(indexs(k)) = 1;
                        matrix_zeros(i, indexs(k)) = 1;
                    end
                else
                    multipOptions = [multipOptions; matrix(i, 1:end)];
                end

            end
        end
        iter += 1;
    end
    [options_row, options_col] = size(multipOptions);
        if(options_row > 0)
            for j=1: col
                if(multipOptions(j) == 0 && applications(j) == 0)
                    applications(j) = 1;
                    matrix_zeros(4, j) = 1;
                    is_solution = 1;
                    return
                end
            end
        end
    is_solution = 0;

end

function matrix = phase2(matrix)
    [row, col] = size(matrix);
    matrix_copy = zeros(row,col);
    matrix_copy = matrix_copy + matrix;
    low = inf;

    for i=1: row

        for j=1: col
            if(i == 1 || i == 4 || i == 5 || j == 5)
                continue;
            end
            if(matrix(i,j) < low)
                low = matrix(i,j);
            end
        end
    end
    fprintf("\n\nLos elementos tachados serán los de la fila 1, 3, 5 y columna 5\n\n");
    fprintf("Menor valor de los elementos no tachados: %d\n\n", low)

    for i=1: row

        for j=1: col
            if(i != 1 && i != 4 && i != 5 && j != 5)
                matrix(i,j) -= low;

            elseif( (i == 1 || i == 4 || i == 5) && j == 5 )
                matrix(i,j) += low;
            end
        end
    end
    
end

function matrix = result(matrix, matrix_bin)
    [row, col] = size(matrix);
    total = 0;

    for i=1: row

        for j=1: col
            if(matrix_bin(i,j) == 1)
                fprintf("\nDesarollador %d va a la Aplicacion %d, horas = %d \n", i, j, matrix(i,j));
                total += matrix(i,j);
            end

        end
    end

    fprintf("\n\nTotal de horas: %d\n\n", total);
end












while(true)
    fprintf("Matrix original: \n\n");
    disp(matrix)
    fprintf("Checkamos filas: \n");
    if(checkRow(matrix))
        disp("Todas las filas tienen al menos un cero.")
    else
        disp("Las filas no tienen al menos un cero, se prcede a hacer los calculos pertinentes")
    end

    if(checkCol(matrix))
        disp("Todas las columnas tienen al menos un cero.")
    else
        disp("Las columnas no tienen al menos un cero por columna, se prcede a hacer los calculos pertinentes")
        fprintf("Matrix antes de sustraer el menor numero por columnas: \n\n");
        matrix
        fprintf("\n\nMatrix despues de sustraer el menor por columnas: \\n")
        matrix = sustractLowerValueCol(matrix);
        matrix
    end
    fprintf("\n\nVerificamos el resultado de la matriz y si existe un resultado posible: \n\n");
    [matrix_bin, is_solution] = checkSolution(matrix);
    if(is_solution)
        fprintf("Se halló una solucion optima, pasamos a mostrarlo en la matriz original \n\n")
        break
    end
    fprintf("No se halló una solución optima, hacemos proceso de la fase 2 \n\n")
    matrix = phase2(matrix);
    fprintf("Matriz despues de restar y sumar el menor valor a las intersecciones y elementos no tachados \n\n")
    matrix
end




fprintf("\n\nMatriz original con los valores iniciales: \n\n")
disp(original_matrix);
fprintf("\n\nMatrix binaria creada como guia para vertificar a que puesto irá cada programador: \n\n");
disp(matrix_bin);
result(original_matrix, matrix_bin);