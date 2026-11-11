//
//  Receta.swift
//  MisRecetas
//
//  Creado por Crescencio Pérez Murillo el 23/09/2025.
//  Copyright © 2025 Crescencio Pérez Murillo.
//  Todos los derechos reservados.
//
//  Este código forma parte del proyecto "MisRecetas".
//  Se concede únicamente para uso educativo/personal.
//  No se permite su distribución, modificación ni uso comercial sin autorización expresa.
//

import Foundation

// MARK: - Enumeración de Categorías
// Cada receta pertenece a una categoría específica.
// Con CaseIterable podemos recorrer todas las categorías.
// Con Identifiable podemos usarlas directamente en listas.
enum Categoria: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case carne = "Carne"
    case pescado = "Pescado"
    case verduras = "Verduras"
    case batidos = "Batidos"
}

// MARK: - Modelo Receta
// Representa una receta con toda la información necesaria
// para mostrarla en la aplicación.
struct Receta: Identifiable {
    let id = UUID()                // Identificador único para cada receta
    let nombre: String             // Nombre de la receta
    let descripcion: String        // Breve descripción
    let categoria: Categoria       // Categoría a la que pertenece la receta
    let ingredientes: [String]     // Lista de ingredientes
    let pasos: [String]            // Lista de pasos de preparación
}
