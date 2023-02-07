(define
    ; Se genera el dominio del problema
    (domain TA_domain) 
    ; Se establecen los requerimientos para la solucion propuesta
    (
    :requirements :fluents :typing :negative-preconditions ) 
    ; Descripcion de los tipos
    (:types 
        ubicacion
        contenedor
        tren        
    ) 

    ; Se establecen las funciones matematicas
    (:functions 
        (maxLoad_Tren ?tren - tren) 
        (maxLoad_Ubicacion ?ubicacion - ubicacion) )

    ; Se establecen los predicados que regiran en todas las acciones
    (:predicates 
        (tren ?tren - tren) ; Generacion del objeto tren
        (caminoEntre_Pos ?initPos - ubicacion ?finalPos - ubicacion) ; Determinar el camino entre dos ubicaciones
        (enPos_Tren ?ubicacion - ubicacion ?tren - tren) ; Cuando el tren se encuentra en una posicion determinada
        (contenedorEn_Pos ?ubicacion - ubicacion ?contenedor - contenedor) ; Cuando el contenedor se encuentra en posicion para ser cargado
        (contenedorEn_Tren ?contenedor - contenedor ?tren - tren) ; Cuando el contenedor se encuentra en la caja
        (puntoProcesamiento ?ubicacion - ubicacion) ; Se les habilita la bandera a las fabricas, debido a que estas pueden generar el procesamiento
        (contenedorProcesado ?contenedor - contenedor) ; Cuando el contenedor ha sido procesado
         
    )


    ; Acciones a Realizar:
	; Son cuatro acciones: 
	; 1.- Movimiento, desplazamiento entre dos ubicaciones
	; 2.- Cargar, se hace la carga del contenedor en el tren
	; 3.- Descargar, se realiza la descarga del contenedor en los diferentes puntos habilitados
	; 4.- ProcesamientoContenedor.

    ; Generacion de la accion de cargar
    (:action cargar 
    :parameters 
        (?contenedor - contenedor ?ubicacion - ubicacion ?tren - tren) 
    :precondition 
        (and 
            (tren ?tren) ; Se observa si el objeto del tren existe
            (contenedorEn_Pos ?ubicacion ?contenedor) ; Y el contenedor se encuentre en posicion
            (enPos_Tren ?ubicacion ?tren) ; Y el tren se encuentre en Posicion
            (not (contenedorEn_Tren ?contenedor ?tren)) ; Condicion para que se cargue unicamente un contenedor
            (>= (maxLoad_Tren ?tren) 1) ; Debe de tener mas de una posicion libre el tren.
        ) 
    :effect 
        (and 
            (contenedorEn_Tren ?contenedor ?tren) ; Se coloca el contenedor en el tren
            (decrease (maxLoad_Tren ?tren) 1) ; Se decrementa la carga maxima del tren
            (increase (maxLoad_Ubicacion ?ubicacion) 1) ; Se incrementa la carga maxima de la ubicacion
        ) 
    )


    (:action descargar 
    :parameters 
        (?contenedor - contenedor ?ubicacion - ubicacion ?tren - tren)
    :precondition 
        (and 
            (tren ?tren) ; Existe un objeto tren 
            (enPos_Tren ?ubicacion ?tren) ; Y el tren se encuentra en la ubicacion
            (contenedorEn_Tren ?contenedor ?tren) ; Y El tren posee un contenedor             
            (> (maxLoad_Ubicacion ?ubicacion) 1) ; Y el puerto de descarga debe de tener al menos un espacio libre
        ) 
    :effect 
        (and 
            (not (contenedorEn_Tren ?contenedor ?tren)) ; Se quita el contenedor 
            (contenedorEn_Pos ?ubicacion ?contenedor) ; El contenedor cambia de posicion
            (increase (maxLoad_Tren ?tren) 1) ; Se incrementar la capacidad de carga del tren 
            (decrease (maxLoad_Ubicacion ?ubicacion) 1)  ; Se decrementa la capacidad de carga del puerto
        ) 
    )




    (:action movimiento 
    :parameters (?tren - tren ?initPos - ubicacion ?finalPos - ubicacion) 
    :precondition 
        (and
            (tren ?tren) ; Se observa que existe un tren
            (caminoEntre_Pos ?initPos ?finalPos) ; Se observa que existe camino entre la posicion de inicio y fin
            (enPos_Tren ?initPos ?tren) ; Se observa que el tren se encuentre en la posicion inicial.
        )
    :effect 
        (and 
            (enPos_Tren ?finalPos ?tren) ; El tren se lo coloca en la posicion final
            (not (enPos_Tren ?initPos ?tren)) ; Se niega la condicion previa preexistente
        ) 
    )

    (:action procesar 
    :parameters (?contenedor - contenedor ?ubicacion - ubicacion ?tren - tren) 
    :precondition 
        (and 
            (tren ?tren) ; Se obseva que existe un tren 
            (puntoProcesamiento ?ubicacion) ; Se encuentra en un punto habilitado para generar el procesamiento
            (contenedorEn_Pos ?ubicacion ?contenedor)  ; El contenedor se encuentra en la posicion
           ) 
           
    :effect 
        (and 
            (contenedorProcesado ?contenedor) ; Se habilita el contenedor como procesado
            (not (contenedorEn_Pos ?ubicacion ?contenedor)) ; El contenedor ya no se encuentra en la ubicacion
            (increase (maxLoad_Ubicacion ?ubicacion) 1) ; Se le agrega una posicion libre a la ubicacion 
        ) 
    )


    
)