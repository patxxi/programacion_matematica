fprintf('Funcion Objetivo:\n\n')
fprintf('Minimizar: Z = 4X1 + 1X2 + 0S1 + 0S2 + MA1 + MA2\n\n')
fprintf('Sujeto a:\n\n')
fprintf('4X1 + 3X2 - 1S1 + 0S2 + 1A1 + 0A2 = 6\n')
fprintf('3X1 + 1X2 + 0S1 + 0S2 + 0A1 + 1A2 = 3\n\n')
fprintf('1X1 + 2X2 + 0S1 + 1S2 + 0A1 + 0A2 = 3\n')
fprintf('X1, X2, S1, S2, A1, A2 >= 0\n\n')
fprintf('Suponiendo M = 100\n\n')
fprintf('=======================================================\n\n\n')

tabla = [ 4  1  0 0  100  100 0;
          3  1  0 0    1    0 3;
          4  3 -1 0    0    1 6;
          1  1  0 1    0    0 3]

variables_filas = ["Z"; "R1"; "R2"; "S2"]
VARIABLES_COLUMNAS = ["X", "Y", "S1", "S2", "R1","R2"]

fprintf("\nEn Columna Z(1) Hay valores M(100), Realizando Ajuste\n\n")
disp('Nueva Fila Z = Anterior Fila Z + (100 x Fila R1(2)) + (100 x Fila R2(3))')
for j = 1:size(tabla,2)
    fprintf('Ajustando Tabla...\n')
  tabla(1,j) = tabla(1,j) + (100*tabla(2,j)) + (100*tabla(3,j))
endfor
x=0;
while !verificar(tabla) && x < 10
    fprintf('Buscando Elemento Pivote...\n\n')
    [columnaPivote filaPivote elementoPivote] = checkPivote(tabla)
    fprintf('Actualizando las Variables Basicas por Fila...  ')
    variables_filas(filaPivote) = VARIABLES_COLUMNAS(columnaPivote);
    tabla = actualizarTabla(tabla, columnaPivote, filaPivote, elementoPivote);
    x++;
endwhile

fprintf('\n\n=================== RESULTADOS FINALES ===================\n\n')

for a = 1: 4
    printf('%s = %d\n',variables_filas(a),tabla(a,size(tabla,2)))
endfor