//
//  ContentView.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/2025
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Esta es la vista principal de la aplicación. Contiene la raíz de la UI
//  y actualmente muestra la pantalla de Splash (SplashView).
//  Desde aquí se pueden conectar otras vistas de navegación como la lista de regiones
//  o la lista de Pokémon.
//
//  Notas del código:
//  - SwiftUI se encarga de renderizar la vista declarativamente.
//  - La propiedad `body` define la vista que se muestra al iniciar la app.
//

import SwiftUI

struct ContentView: View {
    
    // Vista principal que se muestra al iniciar la aplicación
    var body: some View {
        // SplashView es la primera pantalla que ve el usuario
        SplashView()
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
