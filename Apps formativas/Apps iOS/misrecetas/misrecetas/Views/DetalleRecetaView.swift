//
//  DetalleRecetaView.swift
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

// MARK: - Vista de detalle de receta
// Muestra los ingredientes y los pasos de la receta seleccionada
struct DetalleRecetaView: View {
    // Binding a la receta seleccionada desde la pantalla anterior
    @Binding var receta: Receta
    // Control del modo de presentación para volver atrás
    @Environment(\.presentationMode) var presentationMode
    
    // Estado de los ingredientes marcados como realizados
    @State private var ingredientesMarcados: [Bool]
    // Paso actual que se está mostrando
    @State private var pasoActual: Int = 0
    // Controla si se muestran los pasos o los ingredientes
    @State private var mostrarPasos: Bool = false
    // Controla si se muestra el mensaje final al completar la receta
    @State private var mostrarMensajeFinal: Bool = false
    
    // Inicializador para crear el estado de los checkboxes de ingredientes
    init(receta: Binding<Receta>) {
        _receta = receta
        _ingredientesMarcados = State(initialValue: Array(repeating: false, count: receta.wrappedValue.ingredientes.count))
    }
    
    var body: some View {
        VStack {
            if mostrarPasos {
                if mostrarMensajeFinal {
                    // Pantalla de felicitación al completar la receta
                    VStack(spacing: 20) {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.green)
                        
                        Text("¡Receta completada! 🎉")
                            .font(.title)
                            .bold()
                        
                        Button(action: {
                            // Vuelve a la pantalla principal de recetas
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Volver a recetas")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                } else {
                    // Pantalla de pasos de la receta
                    VStack(spacing: 20) {
                        Text("Paso \(pasoActual + 1) de \(receta.pasos.count)")
                            .font(.headline)
                        
                        // Texto del paso
                        Text(receta.pasos[pasoActual])
                            .font(.title2)
                            .padding()
                            .multilineTextAlignment(.center)
                        
                        Button(action: avanzarPaso) {
                            Text("Marcar como realizado")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                }
            } else {
                // Pantalla de ingredientes
                VStack(alignment: .leading) {
                    Text(receta.nombre)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom)
                    
                    Text("Ingredientes:")
                        .font(.title2)
                        .padding(.bottom, 5)
                    
                    // Lista de ingredientes con checkboxes
                    List {
                        ForEach(receta.ingredientes.indices, id: \.self) { index in
                            HStack {
                                Button(action: {
                                    // Marca o desmarca el ingrediente
                                    ingredientesMarcados[index].toggle()
                                }) {
                                    Image(systemName: ingredientesMarcados[index] ? "checkmark.square" : "square")
                                        .foregroundColor(ingredientesMarcados[index] ? .green : .primary)
                                }
                                
                                Text(receta.ingredientes[index])
                            }
                        }
                    }
                    
                    // Botón para empezar a mostrar los pasos
                    Button(action: {
                        mostrarPasos = true
                        pasoActual = 0
                    }) {
                        Text("Empezar receta")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ingredientesMarcados.contains(false) ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    // Solo habilitado si todos los ingredientes están marcados
                    .disabled(ingredientesMarcados.contains(false))
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    // Función que avanza al siguiente paso o muestra el mensaje final
    func avanzarPaso() {
        if pasoActual < receta.pasos.count - 1 {
            pasoActual += 1
        } else {
            mostrarMensajeFinal = true
        }
    }
}
