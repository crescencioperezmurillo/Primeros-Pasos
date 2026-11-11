//
//  ContentView.swift
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

struct ContentView: View {
    // Estado de la búsqueda
    @State private var searchText = ""
    // Estado de la categoría seleccionada
    @State private var categoriaSeleccionada: Categoria? = nil
    
    // Lista de recetas
    @State private var recetas = [
        // ------------------ CARNE ------------------
        Receta(
            nombre: "Asado",
            descripcion: "Carne asada al horno.",
            categoria: .carne,
            ingredientes: ["1 kg de carne", "Sal", "Pimienta", "Ajo", "Aceite"],
            pasos: [
                "Precalentar el horno a 180°C",
                "Sazonar la carne con sal, pimienta y ajo",
                "Colocar la carne en una bandeja y añadir aceite",
                "Hornear durante 1 hora",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Estofado",
            descripcion: "Carne guisada con verduras.",
            categoria: .carne,
            ingredientes: ["500 g de carne", "Zanahoria", "Cebolla", "Patatas", "Caldo de carne"],
            pasos: [
                "Cortar la carne en trozos",
                "Saltear la carne hasta dorar",
                "Añadir verduras y caldo",
                "Cocinar a fuego lento 1 hora",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Hamburguesa",
            descripcion: "Jugosa y con queso.",
            categoria: .carne,
            ingredientes: ["500 g carne picada", "Pan de hamburguesa", "Queso", "Lechuga", "Tomate"],
            pasos: [
                "Formar las hamburguesas con la carne",
                "Cocinar a la plancha",
                "Colocar en el pan con queso, lechuga y tomate",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Pollo al horno",
            descripcion: "Delicioso pollo sazonado.",
            categoria: .carne,
            ingredientes: ["1 pollo entero", "Sal", "Pimienta", "Aceite", "Limón"],
            pasos: [
                "Precalentar el horno a 200°C",
                "Sazonar el pollo con sal, pimienta y limón",
                "Hornear durante 1 hora",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Filete a la plancha",
            descripcion: "Rápido y sabroso.",
            categoria: .carne,
            ingredientes: ["2 filetes de carne", "Sal", "Pimienta", "Aceite"],
            pasos: [
                "Sazonar los filetes",
                "Calentar la plancha con aceite",
                "Cocinar los filetes 3-5 min por lado",
                "Servir caliente"
            ]
        ),
        
        // ------------------ PESCADO ------------------
        Receta(
            nombre: "Salmón a la plancha",
            descripcion: "Salmón fresco y saludable.",
            categoria: .pescado,
            ingredientes: ["2 filetes de salmón", "Sal", "Pimienta", "Aceite"],
            pasos: [
                "Sazonar el salmón",
                "Calentar la plancha",
                "Cocinar 3-4 min por lado",
                "Servir con limón"
            ]
        ),
        Receta(
            nombre: "Atún en salsa",
            descripcion: "Atún con verduras y salsa.",
            categoria: .pescado,
            ingredientes: ["Filetes de atún", "Tomate", "Cebolla", "Aceite", "Sal"],
            pasos: [
                "Sofreír cebolla y tomate",
                "Añadir el atún y cocinar 5 min",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Merluza al horno",
            descripcion: "Ligera y deliciosa.",
            categoria: .pescado,
            ingredientes: ["Filetes de merluza", "Limón", "Aceite", "Sal", "Pimienta"],
            pasos: [
                "Precalentar horno a 180°C",
                "Colocar la merluza en bandeja",
                "Rociar con limón y aceite",
                "Hornear 15-20 min",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Bacalao gratinado",
            descripcion: "Con un toque de queso.",
            categoria: .pescado,
            ingredientes: ["Filetes de bacalao", "Queso rallado", "Aceite", "Sal", "Pimienta"],
            pasos: [
                "Precalentar horno a 180°C",
                "Colocar el bacalao en bandeja",
                "Cubrir con queso rallado",
                "Hornear 15-20 min",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Sopa de pescado",
            descripcion: "Perfecta para días fríos.",
            categoria: .pescado,
            ingredientes: ["Pescado variado", "Cebolla", "Zanahoria", "Patata", "Caldo de pescado"],
            pasos: [
                "Picar verduras",
                "Añadir pescado y verduras al caldo",
                "Cocinar 20-25 min",
                "Servir caliente"
            ]
        ),
        
        // ------------------ VERDURAS ------------------
        Receta(
            nombre: "Ensalada mixta",
            descripcion: "Fresca y saludable.",
            categoria: .verduras,
            ingredientes: ["Lechuga", "Tomate", "Pepino", "Aceite", "Sal"],
            pasos: [
                "Lavar y cortar verduras",
                "Mezclar en un bol",
                "Aliñar con aceite y sal",
                "Servir fresca"
            ]
        ),
        Receta(
            nombre: "Crema de calabaza",
            descripcion: "Suave y deliciosa.",
            categoria: .verduras,
            ingredientes: ["Calabaza", "Cebolla", "Patata", "Aceite", "Sal"],
            pasos: [
                "Picar verduras",
                "Sofreír cebolla y añadir calabaza y patata",
                "Añadir agua y cocer 20 min",
                "Triturar y servir"
            ]
        ),
        Receta(
            nombre: "Verduras al vapor",
            descripcion: "Rápido y nutritivo.",
            categoria: .verduras,
            ingredientes: ["Brócoli", "Zanahoria", "Judías verdes", "Sal"],
            pasos: [
                "Lavar y cortar verduras",
                "Cocer al vapor 10-15 min",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Pisto",
            descripcion: "Verduras guisadas.",
            categoria: .verduras,
            ingredientes: ["Calabacín", "Pimiento", "Tomate", "Cebolla", "Aceite"],
            pasos: [
                "Picar verduras",
                "Sofreír cebolla y añadir resto de verduras",
                "Cocinar 20 min a fuego lento",
                "Servir caliente"
            ]
        ),
        Receta(
            nombre: "Brochetas de verduras",
            descripcion: "Ideal para barbacoas.",
            categoria: .verduras,
            ingredientes: ["Pimiento", "Calabacín", "Champiñones", "Aceite", "Sal"],
            pasos: [
                "Cortar verduras en trozos",
                "Montar en brochetas",
                "Asar a la parrilla 10-15 min",
                "Servir caliente"
            ]
        ),
        
        // ------------------ BATIDOS ------------------
        Receta(
            nombre: "Batido de fresa",
            descripcion: "Dulce y refrescante.",
            categoria: .batidos,
            ingredientes: ["Fresas", "Leche", "Azúcar"],
            pasos: [
                "Lavar fresas",
                "Mezclar con leche y azúcar en licuadora",
                "Servir frío"
            ]
        ),
        Receta(
            nombre: "Batido de plátano",
            descripcion: "Suave y cremoso.",
            categoria: .batidos,
            ingredientes: ["Plátano", "Leche", "Miel"],
            pasos: [
                "Pelar el plátano",
                "Mezclar con leche y miel en licuadora",
                "Servir frío"
            ]
        ),
        Receta(
            nombre: "Batido verde",
            descripcion: "Energía natural.",
            categoria: .batidos,
            ingredientes: ["Espinaca", "Plátano", "Leche", "Miel"],
            pasos: [
                "Lavar espinaca",
                "Mezclar todos los ingredientes en licuadora",
                "Servir frío"
            ]
        ),
        Receta(
            nombre: "Batido de mango",
            descripcion: "Tropical y delicioso.",
            categoria: .batidos,
            ingredientes: ["Mango", "Leche", "Azúcar"],
            pasos: [
                "Pelar y cortar mango",
                "Mezclar con leche y azúcar en licuadora",
                "Servir frío"
            ]
        ),
        Receta(
            nombre: "Batido de frutos rojos",
            descripcion: "Antioxidante y sabroso.",
            categoria: .batidos,
            ingredientes: ["Frutos rojos", "Leche", "Miel"],
            pasos: [
                "Lavar frutos rojos",
                "Mezclar con leche y miel en licuadora",
                "Servir frío"
            ]
        ),
    ]
    
    // MARK: - Filtrado de recetas según categoría y búsqueda
    var recetasFiltradas: [Receta] {
        if searchText.isEmpty && categoriaSeleccionada == nil {
            return []
        }
        
        if let categoria = categoriaSeleccionada {
            if searchText.isEmpty {
                return recetas.filter { $0.categoria == categoria }
            } else {
                return recetas.filter { $0.categoria == categoria && $0.nombre.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        return recetas.filter { $0.nombre.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView { // Scroll vertical
                VStack(spacing: 10) {
                    // Título principal
                    Text("🍴 Recetario")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // Barra de búsqueda
                    TextField("Buscar receta...", text: $searchText)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // Desplegable horizontal de categorías
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(Categoria.allCases) { categoria in
                                Button(action: {
                                    if categoriaSeleccionada == categoria {
                                        categoriaSeleccionada = nil
                                    } else {
                                        categoriaSeleccionada = categoria
                                    }
                                }) {
                                    Text(categoria.rawValue)
                                        .lineLimit(1) // Evita que el texto se rompa
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(categoriaSeleccionada == categoria ? Color.orange : Color.gray.opacity(0.3))
                                        .foregroundColor(categoriaSeleccionada == categoria ? .white : .black)
                                        .cornerRadius(20)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Mensaje si no hay recetas que mostrar
                    if recetasFiltradas.isEmpty {
                        Text(searchText.isEmpty && categoriaSeleccionada == nil ? "Selecciona una categoría o busca una receta" : "No se encontraron recetas")
                            .foregroundColor(.gray)
                            .italic()
                            .padding(.top, 50)
                    } else {
                        LazyVStack(spacing: 0) { // Lista adaptativa
                            ForEach(recetasFiltradas.indices, id: \.self) { index in
                                NavigationLink(destination: DetalleRecetaView(receta: $recetas[recetas.firstIndex(where: { $0.id == recetasFiltradas[index].id })!])) {
                                    HStack {
                                        Text(recetasFiltradas[index].nombre)
                                            .font(.headline)
                                            .padding()
                                        Spacer()
                                    }
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
