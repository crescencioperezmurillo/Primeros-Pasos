//
//  RegionMapView.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/25
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Esta vista de SwiftUI muestra todas las regiones Pokémon disponibles en la PokeAPI.
//  Cada región se muestra como una tarjeta (RegionCard) con un ícono y color asociado.
//  Al seleccionar una región, navega a PokemonListView para mostrar los Pokémon de esa región.
//
//  Notas del código:
//  - regionIcons: diccionario que asigna un ícono de SF Symbols a cada región.
//  - regionColors: diccionario que asigna un color de acento a cada región.
//  - LazyVStack dentro de ScrollView permite renderizar muchas regiones de forma eficiente.
//  - isLoading controla la visualización del ProgressView mientras se obtienen las regiones.
//  - APIService.shared.fetchRegions obtiene los datos desde la API y actualiza la UI.
//

import SwiftUI

// MARK: - Diccionarios de íconos y colores por región
let regionIcons: [String: String] = [
    "kanto": "leaf.fill",
    "johto": "star.fill",
    "hoenn": "sun.max.fill",
    "sinnoh": "snow",
    "unova": "flame.fill",
    "kalos": "crown.fill",
    "alola": "sun.and.horizon.fill",
    "galar": "wind",
    "paldea": "leaf.arrow.circlepath",
    "hisui": "moon.fill"
]

let regionColors: [String: Color] = [
    "kanto": .green,
    "johto": .yellow,
    "hoenn": .orange,
    "sinnoh": .blue,
    "unova": .red,
    "kalos": .purple,
    "alola": .pink,
    "galar": .cyan,
    "paldea": .mint,
    "hisui": .brown
]

// MARK: - RegionMapView
struct RegionMapView: View {
    
    @State private var regions: [Region] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    // Vista de carga mientras se obtienen las regiones
                    ProgressView("Cargando regiones...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .scaleEffect(1.5)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(UIColor.systemBackground))
                } else {
                    // Lista de regiones
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(regions) { region in
                                NavigationLink(destination: PokemonListView(region: region)) {
                                    RegionCard(region: region)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical)
                    }
                    .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                }
            }
            .navigationTitle("Regiones Pokémon")
            .onAppear {
                // Obtener regiones desde la API
                APIService.shared.fetchRegions { fetchedRegions in
                    withAnimation(.easeInOut) {
                        self.regions = fetchedRegions
                        self.isLoading = false
                    }
                }
            }
        }
    }
}

// MARK: - RegionCard
// Tarjeta individual que muestra el nombre y el ícono de una región
struct RegionCard: View {
    
    let region: Region
    
    var body: some View {
        HStack(spacing: 16) {
            // Icono de la región si existe
            if let iconName = regionIcons[region.name.lowercased()] {
                Image(systemName: iconName)
                    .foregroundColor(.accentColor)
                    .font(.title2)
                    .frame(width: 32, height: 32)
            }
            
            // Nombre de la región
            Text(region.name.capitalized)
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
                        .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
                )
        )
    }
}
