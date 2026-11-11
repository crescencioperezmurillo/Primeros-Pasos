//
//  PokemonListView.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/25
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Esta vista de SwiftUI muestra la lista de Pokémon de una región seleccionada.
//  Utiliza LazyVStack dentro de ScrollView para mostrar tarjetas de Pokémon (PokemonCard).
//  Cada tarjeta permite navegar a la vista de detalle del Pokémon (PokemonDetailView).
//
//  Notas del código:
//  - Se utiliza ZStack para colocar el fondo y la vista de carga (ProgressView).
//  - isLoading controla si se muestra la animación de carga o la lista de Pokémon.
//  - APIService.fetchPokemonsByRegion obtiene los Pokémon de la región seleccionada.
//  - withAnimation suaviza la transición de carga a lista.
//  - AsyncImage carga las imágenes de manera asíncrona y muestra un ProgressView mientras carga.
//

import SwiftUI

struct PokemonListView: View {
    
    // Región seleccionada
    let region: Region
    
    // Lista de Pokémon de la región
    @State private var pokemons: [PokemonEntry] = []
    
    // Controla si se está cargando la información
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            // Fondo neutro
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            
            if isLoading {
                // Vista de carga
                ProgressView("Cargando Pokémon...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .scaleEffect(1.5)
                    .bold()
            } else {
                // Lista de Pokémon
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(pokemons) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonCard(pokemon: pokemon)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle(region.name.capitalized)
        .onAppear {
            // Obtener Pokémon de la región
            APIService.shared.fetchPokemonsByRegion(region: region) { list in
                withAnimation(.easeInOut) {
                    self.pokemons = list
                    self.isLoading = false
                }
            }
        }
    }
}

// MARK: - PokemonCard
// Tarjeta individual que muestra nombre y sprite de un Pokémon
struct PokemonCard: View {
    
    let pokemon: PokemonEntry
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Imagen del Pokémon
            AsyncImage(url: URL(string: pokemon.sprite)) { image in
                image.resizable()
                     .scaledToFit()
                     .frame(width: 50, height: 50)
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            
            // Nombre del Pokémon
            Text(pokemon.name.capitalized)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        )
    }
}
