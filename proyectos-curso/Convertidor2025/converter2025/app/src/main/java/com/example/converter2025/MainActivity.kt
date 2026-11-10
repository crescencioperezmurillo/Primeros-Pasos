/*
 * Copyright (c) 2025 Crescencio Pérez Murillo
 *
 * Este software es propiedad de Crescencio Pérez Murillo
 * Queda prohibida su reproducción, distribución o modificación sin
 * la autorización expresa del titular de los derechos.
 *
 * Proyecto: Converter2025
 * Descripción: Aplicación Android para convertir euros a rupias indias
 * utilizando una tasa de conversión fija.
 */

package com.example.converter2025

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

/*
 * Clase principal de la aplicación que extiende AppCompatActivity.
 * Aquí manejamos la lógica necesaria para convertir una cantidad en euros a rupias.
 */

class MainActivity : AppCompatActivity() {

    // Tasa fija de conversión de euros a rupias (1 euro = 87.34 rupias)
    private val conversionRate = 87.34

    /*
     * Metodo onCreate, llamado cuando la actividad se crea.
     * Permite configurar la interfaz y los eventos de la aplicación.
     *
     */

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


        // Asocia el layout XML activity_main con esta actividad

        setContentView(R.layout.activity_main)

        // Declaramos las referencias a los elementos UI definidos en el XML mediante sus IDs

        val editEuroAmount = findViewById<EditText>(R.id.editEuroAmount) // Campo para ingresar euros
        val buttonConvert = findViewById<Button>(R.id.buttonConvert)     // Botón para iniciar la conversión
        val textResult = findViewById<TextView>(R.id.textResult)         // Texto para mostrar el resultado

        // Establece el comportamiento al hacer clic en el botón Convertir

        buttonConvert.setOnClickListener {

            // Obtiene el texto ingresado en el EditText como String

            val inputText = editEuroAmount.text.toString()

            // Validación: Si el campo está vacío, muestra un mensaje Toast y retorna al valor original

            if (inputText.isEmpty()) {
                Toast.makeText(this, getString(R.string.toast_empty_input), Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            try {
                // Intenta convertir el texto ingresado a un número Double (euros)

                val euros = inputText.toDouble()

                // Calcula la cantidad equivalente en rupias multiplicando por la tasa

                val rupias = euros * conversionRate

                // Actualiza el TextView con el resultado de la conversión
                // Usamos un string formateado definido en strings.xml para mejor la internacionalización (Buenas prácticas de Android)

                textResult.text = getString(R.string.conversion_result, rupias)

            } catch (e: NumberFormatException) {

                // Si el texto no es un número válido, muestra un mensaje Toast de error

                Toast.makeText(this, getString(R.string.toast_invalid_input), Toast.LENGTH_SHORT).show()
            }
        }
    }
}