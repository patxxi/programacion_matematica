fprintf('Funcion Objetivo:\n\n')
fprintf('Minimizar: Z = 315X1 + 110X2 + 50X3\n\n')
fprintf('Sujeto a:\n\n')
fprintf('15X1 + 2X2 + X3 >= 200\n')
fprintf('7.5X1 + 3X2 + X3 >= 150\n\n')
fprintf('5X1 + 2X2 + X3 >= 120\n')
fprintf('X1, X2, X3 >= 0\n\n')
fprintf('=======================================================\n\n\n')

ecuacion_Z =    [315 110 50   0 0 0    0]
restriccion_1 = [ 15   2  1   1 0 0  200]
restriccion_2 = [7.5   3  1   0 1 0  150]
restriccion_3 = [  5   2  1   0 0 1  120]

variables_filas = ["Z", "S1", "S2", "S3"]
VARIABLES_COLUMNAS = ["A","B", "C","S","S","S"]

# ************************************************* #
#          	  A    B   C    S1 S2 S3   R            #
# tabla  = [ 315 -110 50    0  0  0    0;   % Z     #
# inicial   - 15  -2  -1    1  0  0  -200;  % S1    #
#           -7.5  -3  -1    0  1  0  -150;  % S2    #
#           -  5  -2  -1    0  0  1  -120]  % S3    #
# ************************************************* #

tabla = tablaInicial(ecuacion_Z,restriccion_1,restriccion_2,restriccion_3)

x=0;
while !verificar(tabla) && x < 10
    fprintf('Buscando Elemento Pivote...\n\n')
    [columnaPivote filaPivote elementoPivote] = pivote(tabla)
    fprintf('\nActualizando las Variables Basicas por Fila...  ')
    variables_filas(filaPivote) = VARIABLES_COLUMNAS(columnaPivote)
    tabla = actualizarTabla(tabla, columnaPivote, filaPivote, elementoPivote)
    x++;
endwhile

fprintf('\n\n=================== RESULTADOS FINALES ===================\n\n')

for a = 1: 4
    printf('%s = %d\n',variables_filas(a),tabla(a,size(tabla,2)))
endfor

# ****************************************************************** #
# ************************* Links De Apoyo ************************* #
# http://www.investigaciondeoperaciones.net/metodo_simplex_dual.html #
# https://linprog.com/en/main-dual-simplex/result;queryParams=%7B%22n%22:3,%22m%22:3,%22max_min%22:%222%22,%22values%22:%5B%5B%2215%22,%222%22,%221%22,%22200%22%5D,%5B%227.5%22,%223%22,%221%22,%22150%22%5D,%5B%225%22,%222%22,%221%22,%22120%22%5D%5D,%22function%22:%5B%22315%22,%22110%22,%2250%22%5D,%22equalSign%22:%5B%223%22,%223%22,%223%22%5D%7D #
# ****************************************************************** #
