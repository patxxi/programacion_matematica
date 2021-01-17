
matrixOriginal = [1, -200, -300, 0, 0, 0, 0;             
          0,    3,    2, 1, 0, 0, 100;
          0,    2,    4, 0, 1, 0, 120;
          0,    1,    1, 0, 0, 1, 45];
numVariables = 2;

fprintf("Valores cargados de la matriz, con su respectiva funcion objetivo, restricciones y variables de holgura\n\n");
matrixOriginal;
disp(matrixOriginal);

function lowerColumnIndex = getColumnIndex(matrix)
	[value, lowerColumnIndex] = min(matrix(1,:));
end

function pivotIndexRow = getPivotRoxIndex(matrix,indexColumnPivot)
	columnPivot = matrix(2:end,indexColumnPivot);
	columnEnd = matrix(2:end,end);
	aux = abs(columnEnd ./ columnPivot);
	[value, pivotIndexRow] = min(aux);
	pivotIndexRow++;
end

function pivot = getPivot(matrix, rowIndexPivot, columnIndexPivot)
	pivot = matrix(rowIndexPivot, columnIndexPivot);
end

function matrix = makePivotOne(matrix, pivot, rowIndexPivot)
	for(i = 1: length(matrix(1,:)))
		matrix(rowIndexPivot,i) = (matrix(rowIndexPivot, i) / pivot);
	end
end

function matrix = makeColumnPivotZeros(matrix, rowIndexPivot, columnIndexPivot)
	rowPivot = matrix(rowIndexPivot, :);
	[fil, col] = size(matrix);
	
	for i = 1: fil
		if(i == rowIndexPivot)
			continue;
		end
		valueColumnPivot = matrix(i,columnIndexPivot);
		matrix(i,:) = (-valueColumnPivot * rowPivot) + matrix(i,:);
	end
end

function result(newMatrix)
	fprintf("\n\nSolucion: \n\n Z = %d \n\nX1 = %d \n\nX2 = %d\n", newMatrix(1,end), newMatrix(2,end), newMatrix(3,end));
end

newMatrix = matrixOriginal;
iter = 1;
while(newMatrix(1,2) < 0 || newMatrix(1,3) < 0)
	fprintf("\n\n indices de pivote y pivote de la iteracion: %d\n\n",iter);
	columIndex = getColumnIndex(newMatrix)
	rowIndex = getPivotRoxIndex(newMatrix,columIndex)
	pivot = getPivot(newMatrix, rowIndex, columIndex)
	newMatrix = makePivotOne(newMatrix, pivot, rowIndex);
	newMatrix = makeColumnPivotZeros(newMatrix, rowIndex, columIndex);
	fprintf("Matriz resultante despues de operar con el pivote en esta iteracion: \n\n");
	disp(newMatrix);
	iter++;
end



result(newMatrix);