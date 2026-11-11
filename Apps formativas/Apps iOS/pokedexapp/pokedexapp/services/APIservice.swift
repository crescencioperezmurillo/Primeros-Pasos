
//
//  APIService.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/2025
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Este archivo contiene la clase APIService, un singleton responsable de manejar
//  todas las llamadas a la PokeAPI para la app PokedexApp.
//  Proporciona funciones para:
//    - Obtener la lista de regiones
//    - Obtener los Pokémon de una región específica
//    - Obtener el detalle completo de un Pokémon
//
//  Cada función utiliza URLSession para peticiones asíncronas y decodifica
//  las respuestas JSON en objetos Swift, listos para usar en SwiftUI.
//

import Foundation

// Clase singleton que maneja todas las llamadas a la PokeAPI
class APIService {
    
    // Instancia compartida para uso global
    static let shared = APIService()
    
    // Previene la creación de múltiples instancias
    private init() {}
    
    // MARK: - Obtener todas las regiones
    // Realiza una petición a la PokeAPI para traer la lista de regiones
    // Parameter completion: Closure que retorna un array de Region
    func fetchRegions(completion: @escaping ([Region]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/region/") else { return }
        
        // Petición asíncrona usando URLSession
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            // Decodificar JSON a RegionResponse
            if let decoded = try? JSONDecoder().decode(RegionResponse.self, from: data) {
                // Retornar la lista de regiones en el hilo principal para actualizar UI
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            }
        }.resume()
    }
    
    // MARK: - Obtener Pokémon de una región
    // Obtiene todos los Pokémon de la región seleccionada y asigna los sprites correctos
    // Parameters:
    //   region: Región seleccionada
    //   completion: Closure que retorna un array de PokemonEntry
    func fetchPokemonsByRegion(region: Region, completion: @escaping ([PokemonEntry]) -> Void) {
        guard let url = URL(string: region.url) else { return }
        
        // Primer request: obtener detalles de la región
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            if let decodedRegion = try? JSONDecoder().decode(RegionDetail.self, from: data),
               let firstPokedexURL = decodedRegion.pokedexes.first?.url {
                
                guard let pokedexURL = URL(string: firstPokedexURL) else { return }
                
                // Segundo request: obtener Pokémon de la Pokedex
                URLSession.shared.dataTask(with: pokedexURL) { data, _, _ in
                    guard let data = data else { return }
                    
                    if let decodedPokedex = try? JSONDecoder().decode(PokedexResponse.self, from: data) {
                        let pokemons = decodedPokedex.pokemon_entries.map { entry in
                            
                            // Extraer ID real del Pokémon desde su URL
                            let urlComponents = entry.pokemon_species.url.split(separator: "/")
                            let id = urlComponents.last(where: { !$0.isEmpty }).flatMap { Int($0) } ?? 0
                            
                            return PokemonEntry(
                                name: entry.pokemon_species.name,
                                sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
                            )
                        }
                        // Retornar lista de Pokémon en hilo principal
                        DispatchQueue.main.async {
                            completion(pokemons)
                        }
                    }
                }.resume()
            }
        }.resume()
    }
    
    // MARK: - Obtener detalle de un Pokémon
    // Trae la información completa de un Pokémon por su nombre
    //  Parameters:
    //    name: Nombre del Pokémon
    //    completion: Closure que retorna un objeto PokemonDetail
    func fetchPokemonDetail(name: String, completion: @escaping (PokemonDetail?) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            if let decoded = try? JSONDecoder().decode(PokemonDetail.self, from: data) {
                DispatchQueue.main.async {
                    completion(decoded)
                }
            }
        }.resume()
    }
}
