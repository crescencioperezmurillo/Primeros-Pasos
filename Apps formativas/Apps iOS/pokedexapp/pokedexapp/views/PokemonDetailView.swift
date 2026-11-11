//
//  PokemonDetailView.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/25
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Esta vista de SwiftUI muestra la información detallada de un Pokémon seleccionado.
//  Muestra la imagen principal, nombre y estadísticas (stats) dentro de tarjetas estilizadas.
//  La información se obtiene a través de APIService mediante la función fetchPokemonDetail.
//
//  Notas del código:
//  - Usa ScrollView para permitir desplazamiento vertical si hay muchos stats.
//  - AsyncImage se usa para cargar la imagen del Pokémon de manera asíncrona.
//  - Los stats se muestran en tarjetas con sombra y fondo para un efecto visual limpio.
//  - Se utiliza @State para almacenar los detalles y actualizar la UI cuando llegan.
//  - La animación withAnimation mejora la transición al mostrar los detalles.
//

import SwiftUI

struct PokemonDetailView: View {
    
    // Pokémon seleccionado desde la lista
    let pokemon: PokemonEntry
    
    // Detalles completos obtenidos de la API
    @State private var details: PokemonDetail?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                if let details = details {
                    // Tarjeta contenedora de detalles
                    VStack(spacing: 16) {
                        
                        // Imagen principal del Pokémon
                        AsyncImage(url: URL(string: details.sprites.front_default ?? "")) { image in
                            image.resizable()
                                 .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                        
                        // Nombre del Pokémon
                        Text(details.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        // Stats del Pokémon
                        VStack(spacing: 10) {
                            ForEach(details.stats, id: \.stat.name) { stat in
                                HStack {
                                    Text(stat.stat.name.capitalized)
                                        .font(.headline)
                                    Spacer()
                                    Text("\(stat.base_stat)")
                                        .font(.headline)
                                        .foregroundColor(.accentColor)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(UIColor.systemBackground))
                                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                                )
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(UIColor.secondarySystemBackground))
                            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                    )
                    .padding(.horizontal)
                    
                } else {
                    // Mostrar loader mientras se cargan los detalles
                    ProgressView("Cargando detalles...")
                        .onAppear {
                            APIService.shared.fetchPokemonDetail(name: pokemon.name) { result in
                                withAnimation {
                                    self.details = result
                                }
                            }
                        }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
}
