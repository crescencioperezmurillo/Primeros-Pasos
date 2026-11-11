//
//  pokedexappApp.swift
//  PokedexApp
//
//  Creado por Crescencio Pérez Murillo el 28/8/25
//  © 2025 Crescencio Pérez Murillo. Todos los derechos reservados.
//
//  Detalle del archivo:
//  Este es el punto de entrada principal de la aplicación PokedexApp.
//  Define la estructura principal de la app utilizando SwiftUI y configura
//  la ventana inicial con ContentView.
//
//  Notas del código:
//  - @main indica que esta es la entrada principal de la aplicación.
//  - La propiedad body define la escena principal de la app.
//  - WindowGroup permite que la app soporte múltiples ventanas (en iPad o Mac).
//  - ContentView() se establece como la pantalla inicial de la app.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    // Escena principal de la aplicación
    var body: some Scene {
        WindowGroup {
            // Pantalla inicial al abrir la app
            ContentView()
        }
    }
}
