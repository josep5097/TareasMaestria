(define 
    (problem TA_parte2) 
    (:domain TA_domain) 
    (:objects 
        ; Se establecen las ubicaciones del problema
        puerto - ubicacion
        almacen - ubicacion 
        fabrica_1 - ubicacion
        fabrica_2 - ubicacion 
        ; Se establecen los 8 contenedores del problema
        contenedor1 - contenedor 
        contenedor2 - contenedor 
        contenedor3 - contenedor 
        contenedor4 - contenedor 
        contenedor5 - contenedor 
        contenedor6 - contenedor 
        contenedor7 - contenedor 
        contenedor8 - contenedor 
        ; Se genera el tren
        tren1 - tren 
    )


    (:init 
        ; Se establece el objeto tren
        (tren tren1) 
        ; Se establecen los caminoEntre_Pos 
		; caminoEntre_Pos en un sentido
		(caminoEntre_Pos almacen puerto)
		(caminoEntre_Pos puerto fabrica_2)
		(caminoEntre_Pos fabrica_2 fabrica_1)
		(caminoEntre_Pos fabrica_1 almacen)
        ; Se generan la condicion inicial del tren en el almacen
		(enPos_Tren almacen tren1)
        ; Las 8 cajas sin procesar se encuentra en el puerto
        (contenedorEn_Pos puerto contenedor1) 
        (contenedorEn_Pos puerto contenedor2) 
        (contenedorEn_Pos puerto contenedor3)
        (contenedorEn_Pos puerto contenedor4)
        (contenedorEn_Pos puerto contenedor5) 
        (contenedorEn_Pos puerto contenedor6) 
        (contenedorEn_Pos puerto contenedor7) 
        (contenedorEn_Pos puerto contenedor8) 
        ; Se establecen las condiciones de las ubicaciones y del tren. La posicion que no tiene limitaciones es el puerto segun el problema
        (= (maxLoad_Ubicacion puerto) 500)
        ; Debido a que no se tienen tantas repetiones que generar se puede indicar que la limitacion del puerto sea 200.
        ; Las siguientes condiciones son para las que poseen limitaciones:
        (= (maxLoad_Tren tren1) 4) ; Condicion del tren:
        (= (maxLoad_Ubicacion almacen) 3) ; Condicion del almacen
        (= (maxLoad_Ubicacion fabrica_1) 2) ; Condicion de la fabrica 1
        (= (maxLoad_Ubicacion fabrica_2) 1) ; Condicion de la fabrica 2
        
        ; Se establecen los puntos que pueden generar el procesamiento
        ; Las unicas posiciones que pueden realizar el procesamiento son las fabricas
        (puntoProcesamiento fabrica_1) 
        (puntoProcesamiento fabrica_2) 
    )

    ; Establecer la meta, que todas las cajas sean procesadas
    (:goal 
        (and 
            (contenedorProcesado contenedor1) 
            (contenedorProcesado contenedor2) 
            (contenedorProcesado contenedor3) 
            (contenedorProcesado contenedor4) 
            (contenedorProcesado contenedor5)
            (contenedorProcesado contenedor6) 
            (contenedorProcesado contenedor7)
            (contenedorProcesado contenedor8) 
        ) 
    )

)