function [columnaPivote filaPivote elementoPivote] = pivote (tabla)

# Fila Pivote

# ********************************************************************************************************************************* # 
# Se selecciona el lado derecho "más negativo" lo cual indicará cuál de las actuales variables básicas deberá abandonar             # 
# la base. En el ejemplo el lado derecho más negativo se encuentra en la primera fila, por tanto S1 deja la base. Para              #
# determinar cual de las actuales variables no básicas (A, B, C) entrará a la base                                                  #
# ********************************************************************************************************************************* # 

    fprintf('\nBuscando Fila Pivote (Donde se encuentre el lado derecho mas negativo)\n')
    valor = 0
    for i = 2: size(tabla,1)
        if tabla(i,end) < valor
            valor = tabla(i,end)
            filaPivote = i
        endif
    endfor 


# Columna Pivote

# ********************************************************************************************************************************* # 
# Se busca el mínimo de {-Yj/aij} donde aij es el coeficiente de la respectiva variable no básica en la fija i  	                #
# (del lado # derecho más negativo, marcado en verde) y donde Yj es el costo reducido de la respectiva variable no básica. De esta  #
# forma se obtiene: Min {-315/-15, -110/-2, -50/-1} = 21, donde el pivote (marcado en rojo) se encuentra al hacer el                #
# primer cuociente, por tanto A entra a la base.                                                                                    #
# ********************************************************************************************************************************* #

    fprintf('\nBuscando Columna Pivote (El que tenga el cuociente mas bajo)\n')
    fprintf('NOTA = El CUOCIENTE es el resultado del elemento negativo en la fila Solucion\n Dividido entre el elemento en su misma columna\n\n')

    valor = 999999999;
    cuociente = 999999999;
        for j = 1 : 3 #size(tabla,2)
            if tabla(filaPivote,j) != 0  # Para Evitar Divisiones entre Cero (0)
                cuociente = -tabla(1,j) / tabla(filaPivote,j)
            endif
            if cuociente < valor
                valor = cuociente
                columnaPivote = j
            endif
        end

    # Elemento Pivote
    fprintf('\nGuardando Elemento Pivote...\n')
    elementoPivote = tabla(filaPivote,columnaPivote)
    fprintf('\nResumen Pivotes: \n\n')
endfunction