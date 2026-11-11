//
//  SplashView.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/25
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Esta vista muestra la pantalla de bienvenida (Splash) de la aplicación.
//  Contiene una Pokéball centrada y el nombre "Pokédex". Tras un tiempo
//  definido (splashDuration), la vista navega automáticamente a RegionMapView.
//
//  Notas del código:
//  - @State isActive controla si la vista de regiones se muestra después del splash.
//  - ZStack se utiliza para superponer la Pokéball y el fondo blanco.
//  - DispatchQueue.main.asyncAfter se encarga de esperar splashDuration segundos.
//  - La transición .opacity suaviza la entrada de RegionMapView.
//  - Se puede personalizar la imagen "pokeball" en Assets del proyecto.
//

import SwiftUI

struct SplashView: View {
    
    // Controla si la vista de regiones se activa después del splash
    @State private var isActive = false
    
    // Duración de la pantalla splash en segundos
    private let splashDuration: Double = 4

    var body: some View {
        ZStack {
            // Fondo completamente blanco
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 50) {
                // Pokéball grande centrada
                Image("pokeball")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)

                // Nombre de la app
                Text("Pokédex")
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .foregroundColor(.red)
                    .shadow(color: .gray.opacity(0.5), radius: 3, x: 2, y: 2)
            }
        }
        .onAppear {
            // Después del splash, mostrar RegionMapView
            DispatchQueue.main.asyncAfter(deadline: .now() + splashDuration) {
                withAnimation { isActive = true }
            }
        }
        .overlay(
            Group {
                if isActive {
                    // Transición a la vista principal de regiones
                    RegionMapView()
                        .transition(.opacity)
                }
            }
        )
    }
}
