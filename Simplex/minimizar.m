M = 1000;

matrix = [5, 15, -1, 1, 0, 0, 0, 0, 50; 
		  20, 5, 0, 0, -1, 1, 0, 0, 40; 
		  15, 2, 0, 0, 0, 0, -1, 1, 60;
		   0, 0, 0, 0, 0, 0, 0, 0, 0];
cj_zj = [0, 0, 0, 0, 0, 0, 0, 0];
cj = [5, 2, 0, M, 0, M, 0, M];
variablesBasic = [M,M,M];

fprintf("Matrix original \n\n");
disp(matrix);
fprintf("Variables Cj \n\n");
disp(cj);
fprintf("variables basicas columna cj \n\n");
disp(variablesBasic);

function matrix = getZj(matrix, variablesBasic)
	[row,col] = size(matrix);
	aux = 0;

	for i = 1: row-1

		for j=1: col
			matrix(end, j) += variablesBasic(i) * matrix(i,j);
		end
	end
	
end

function cj_zj = getCjZj(matrix, cj)
	cj_zj = cj - matrix(end,1:end-1);
end

function [value, indexColPivot] = getColPivot(cj_zj)
	[value, indexColPivot] = min(cj_zj);
end

function indexRowPivot = getRowPivot(matrix, colPivot)
	columnR = matrix(1:end-1, end);
	columnPivot = (matrix(1:end-1, colPivot));
	aux = [];
	for i = 1: length(columnR)
		if(columnPivot(i) < 0)
			aux = [aux 1000];

		else	
			aux = [aux abs((columnR(i) / columnPivot(i)))];
		end

	end
	[value, indexRowPivot] = min(aux);

end

function variablesBasic = Update(variablesBasic, colPivot, rowPivot, cj)
	variablesBasic(rowPivot) = cj(colPivot);
	
end

function matrix = makePivotOne(matrix,pivot, rowPivot)
	matrix(rowPivot,:) = matrix(rowPivot,:) / pivot;
	
end

function matrix = makeColumnPivotZeros(matrix, rowIndexPivot, columnIndexPivot)
	rowPivot = matrix(rowIndexPivot, :);
	[fil, col] = size(matrix);
	
	for i = 1: fil-1
		if(i == rowIndexPivot)
			continue;
		end
		valueColumnPivot = matrix(i,columnIndexPivot);
		matrix(i,:) = (-valueColumnPivot * rowPivot) + matrix(i,:);
	end
end

function result(matrix)

	fprintf("\n\nSolucion: \n\n Z = %d \n\nX1 = %d \n\nX2 = %d\n", matrix(end,end), matrix(2,end), matrix(1,end));

end

iter = 1;

matrix = getZj(matrix, variablesBasic);
cj_zj = getCjZj(matrix, cj);
fprintf("Obtenido primer calculo de Zj y cj - zj\n\n");
matrix
fprintf("\nCj - Zj\n\n");
cj_zj

fprintf("\n\n Indice de la columna pivote y el valor de Cj - Zj de esa columna: \n\n");
[valueColPivot, indexColPivot] = getColPivot(cj_zj)
fprintf("\n\n Indice de la Fila pivote: \n\n");
indexRowPivot = getRowPivot(matrix,indexColPivot)
fprintf("\n\n valor del pivote:\n ");
pivot = matrix(indexRowPivot, indexColPivot)
fprintf("\n\n valor del vector de las variables basicas actualizadas:\n ");
variablesBasic = Update(variablesBasic, indexColPivot, indexRowPivot, cj)
fprintf("\n\n Matriz despues de convertir el pivote en 1 y modificar toda su fila: \n\n");
matrix = makePivotOne(matrix, pivot, indexRowPivot);
fprintf("\n\n Matriz despues de convertir la columna pivote en 0 y modificar sus filas \n\n");
matrix = makeColumnPivotZeros(matrix, indexRowPivot, indexColPivot)


while(true)
	fprintf("\n\nMatriz antes de calcular ZJ en la iteracion %d \n\n", iter);
	matrix(end,:) = matrix(end,:) * 0;
	disp(matrix);
	fprintf("\n\n Calculo de Zj en la iteracion %d \n\n", iter);
	matrix = getZj(matrix, variablesBasic);
	disp(matrix);

	fprintf("\n\n Calculo de Cj - Zj en la iteracion %d \n\n", iter);
	cj_zj = getCjZj(matrix, cj);
	disp(cj_zj);

	fprintf("\n\n Valores del indice de la columna pivote y su respectivo valor en la iteracion %d \n\n", iter);
	[valueColPivot, indexColPivot] = getColPivot(cj_zj);
	fprintf("Value: %d     Index: %d \n\n", valueColPivot, indexColPivot);
	if(valueColPivot >= 0)
		disp("Ya no existen valores negativos en el vector Cj - Zj, se procede a terminar de iterar");
		break;
	end

	fprintf("\n\n Indice de la Fila pivote de la iteracion %d: \n\n", iter);
	indexRowPivot = getRowPivot(matrix,indexColPivot);
	disp(indexRowPivot);

	fprintf("\n\n valor del pivote:\n ");
	pivot = matrix(indexRowPivot, indexColPivot);
	disp(pivot);

	fprintf("\n\n valor del vector de las variables basicas actualizadas:\n ");
	variablesBasic = Update(variablesBasic, indexColPivot, indexRowPivot, cj);
	disp(variablesBasic);

	fprintf("\n\n Matriz despues de convertir el pivote en 1 y modificar toda su fila: \n\n");
	matrix = makePivotOne(matrix, pivot, indexRowPivot);
	disp(matrix);

	fprintf("\n\n Matriz despues de convertir la columna pivote en 0 y modificar sus filas \n\n");
	matrix = makeColumnPivotZeros(matrix, indexRowPivot, indexColPivot);
	disp(matrix);
	iter++;
end

result(matrix);