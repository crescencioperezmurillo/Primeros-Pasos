//
//  SplashView.swift
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


import SwiftUI

struct SplashView: View {
    // Estado para controlar la transición a ContentView
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            // Cuando termina el splash, mostrar la pantalla principal
            ContentView()
        } else {
            ZStack {
                // Imagen de fondo
                Image("pan")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    // Texto grande encima de la imagen
                    Text("Las Recetas \nExpress\n de Chencho\n\n Tu aliado en\n la cocina\n y el de toda \nla familia")
                        .font(.system(size: 38, weight: .bold)) // Tamaño grande
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.7), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .italic()
                    
                    Spacer()
                    
                    // Indicador de carga
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                        .scaleEffect(1.5)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                // Cambiar a la pantalla principal después de 2.5 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
