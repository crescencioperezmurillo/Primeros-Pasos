//
//  Models.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/25
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Este archivo contiene todos los modelos de datos utilizados en la app PokedexApp.
//  Define estructuras que representan regiones, Pokémon, detalles de Pokémon y respuestas de la PokeAPI.
//  Los modelos son Decodable para convertir JSON en objetos Swift y algunos son Identifiable
//  para usarse fácilmente en listas de SwiftUI.
//
//  Notas del código:
//  - Region: representa una región de Pokémon y es Identifiable para listas.
//  - PokemonEntry: representa un Pokémon en lista con su nombre y sprite.
//  - PokemonDetail: contiene detalles de un Pokémon incluyendo sprites y stats.
//  - RegionResponse, RegionDetail, NamedAPIResource, PokedexResponse, PokemonEntryResponse
//    sirven para decodificar correctamente las respuestas JSON de la API.
//

import Foundation

// MARK: - Región
/// Representa una región de Pokémon
struct Region: Identifiable, Decodable {
    let name: String
    let url: String
    var id: String { name } // Identificador único para SwiftUI
}

// MARK: - Pokémon en lista
// Representa un Pokémon con su nombre y sprite
struct PokemonEntry: Identifiable {
    let name: String
    let sprite: String
    var id: String { name } // Identificador único para SwiftUI
}

// MARK: - Detalle de Pokémon
// Contiene la información completa de un Pokémon
struct PokemonDetail: Decodable {
    let name: String
    let sprites: Sprites
    let stats: [Stat]
}

// Sprites de un Pokémon
struct Sprites: Decodable {
    let front_default: String?
}

//  Estadísticas base de un Pokémon
struct Stat: Decodable {
    let base_stat: Int
    let stat: StatName
}

// Nombre de la estadística
struct StatName: Decodable {
    let name: String
}

// MARK: - Respuesta API
// Respuesta de la API para obtener regiones
struct RegionResponse: Decodable {
    let results: [Region]
}

// Detalle de una región para obtener su Pokedex
struct RegionDetail: Decodable {
    let pokedexes: [NamedAPIResource]
}

// Recurso nombrado (Pokedex o Pokémon) usado en las respuestas de la API
struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}

// Respuesta de la Pokedex con sus entradas de Pokémon
struct PokedexResponse: Decodable {
    let pokemon_entries: [PokemonEntryResponse]
}

// Entrada individual de Pokémon en la Pokedex
struct PokemonEntryResponse: Decodable {
    let entry_number: Int
    let pokemon_species: NamedAPIResource
}
