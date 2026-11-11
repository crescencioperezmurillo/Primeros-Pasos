//
//  Item.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/25
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Este archivo define el modelo de datos `Item` utilizando SwiftData.
//  Representa un objeto que puede almacenarse en la base de datos local de la app.
//  Actualmente solo contiene un timestamp, pero se puede ampliar con más propiedades.
//
//  Notas del código:
//  - `@Model` indica que esta clase es un modelo gestionado por SwiftData.
//  - `final` evita que la clase sea heredada, lo cual es recomendable para modelos.
//  - El timestamp se inicializa al crear una instancia de Item.
//

import Foundation
import SwiftData

@Model
final class Item {
    
    // Fecha y hora de creación del objeto
    var timestamp: Date
    
    // Inicializador del modelo
    // Parameter timestamp: fecha y hora a asignar
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
