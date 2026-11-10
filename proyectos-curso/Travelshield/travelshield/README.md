# TravelShield

---

## Descripción del Proyecto

TravelShield es una aplicación móvil multiplataforma desarrollada con Flutter, 
diseñada para asistir a los viajeros en la planificación de sus viajes y en la gestión y
protección de su salud durante el viaje. 
La aplicación combina funcionalidades de selección de destino, seguimiento histórico de viajes 
y manejo personalizado de información médica, ofreciendo una experiencia integrada y segura para 
el usuario, a la vez que permite una gestión eficaz del estado de salud antes del viaje.

---

## Objetivos del proyecto

- Facilitar la planificación de viajes seleccionando destinos y mostrando recomendaciones sanitarias.
- Permitir al usuario consultar su historial de viajes pasados y futuros.
- Ofrecer una sección para la gestión de la información médica personal, optimizando la seguridad y la salud durante los viajes.
- Proporcionar una interfaz intuitiva, visualmente atractiva y accesible.

---

## Tecnologías Utilizadas

- **Flutter**: Framework UI para construir la aplicación móvil multiplataforma.
- **Dart**: Lenguaje de programación utilizado para el desarrollo de la app.
- **Material Design**: Para la implementación de la interfaz de usuario.
- **Assets locales**: Imágenes y recursos gráficos incluidos para la experiencia visual.

---

## Estructura del Proyecto

- `lib/`
    - `home_screen/`
        - `home_screen.dart`: Pantalla principal con menú y navegación entre secciones.
        - `drawers.dart`: Widget de menú lateral (Drawer) con navegación adicional.
    - `others_screen/`
        - `country_selection.dart`: Pantalla para selección de destinos.
        - `history_screen.dart`: Pantalla para visualización del historial de viajes.
        - `checklist_screen.dart`: Pantalla para gestión de información médica personal.
    - `data/`
        - `country_list.dart`: Lista de 15 paises usados en la app
        - `vaccine_list.dart`: Lista de vacunas, fecha de administración e información adicional.
    

- `assets/images/`: Contiene imágenes usadas en la aplicación
    - `banners/`: Contiene los banners informativos de la aplicación
    - `others_images`: Contiene otras imagenes usadas en la aplicación
- `assets/icons/`: Contiene el icono de la aplicación

---

## Descripción Técnica del Código Principal (HomeScreen)

El widget `HomeScreen` es un `StatelessWidget` que actúa como la pantalla principal y
punto de entrada para las funcionalidades clave de la app. Su estructura es la siguiente:

- **AppBar personalizado:** Barra superior con color distintivo (`Color(0xFF00BFA6)`) y título centrado.
- **Drawer:** Menú lateral desplegable para navegación adicional.
- **Cuerpo (`body`):**
    - Un contenedor con una imagen de bienvenida y texto descriptivo, organizado con `Row` y `Expanded` para adaptarse a diferentes tamaños de pantalla.
    - Dos filas de botones grandes con iconos y texto para acceder a las funciones principales:
        1. Planifica tu viaje (destino).
        2. Historial de viajes.
        3. Mi salud.
    - Cada botón está implementado con el widget `LargeRoundButton`, que permite personalizar tamaño, icono, texto y acción al pulsar.
    - Texto al pie con derechos reservados.

El código define una clase privada `_HomeOption` para modelar las opciones del menú principal y facilitar la extensión o modificación futura.

---

## Funcionalidades Detalladas

1. **Planifica tu viaje**  
   Permite seleccionar un destino y consultar recomendaciones sanitarias específicas para el país elegido. También, proporciona el calendario vacunal vigente para el pais seleccionado

2. **Historial de viajes**  
   Visualiza viajes anteriores y futuros, con detalles y recomendaciones sanitarias asociadas. Permite imprimir el viaje seleccionado

3. **Mi salud**  
   Gestión completa de datos médicos personales para facilitar el cuidado durante el viaje.

---

## Uso de Widgets Personalizados

- `LargeRoundButton`:
    - Botón redondo grande con icono en centro, título y descripción.
    - Incluye sombra y color personalizado.
    - Tamaño ajustable con la propiedad `large`.
    - Detecta toques y ejecuta una función pasada por parámetro (`onTap`).

---

## Manual de Usuario

---

### Introducción

TravelShield es una app para planificar viajes y cuidar la salud del usuario durante el proceso. 
Este manual facilita su uso detallando cada funcionalidad y ofreciendo consejos para sacar el máximo provecho.

---

### Requisitos Previos

- Dispositivo móvil con Android o iOS.
- App instalada y actualizada.
- Acceso a internet para funciones que requieren datos en línea.
- Permisos básicos otorgados (almacenamiento, etc.).

---

### Navegación Principal

Al iniciar, verás:

- Imagen y texto de bienvenida.
- Tres botones principales para acceder a funcionalidades:
    1. **Planifica tu viaje**
    2. **Historial de viajes**
    3. **Mi salud**
- Menú lateral para acceso a otras opciones.

---

### Funcionalidades

#### 1. Planifica tu viaje

- Selecciona tu destino y tu fecha de viaje.
- Obtén recomendaciones sanitarias para el país elegido.
- Podrás consultar el calendario vacunal correspondiente.
- Planifica tu viaje con información relevante de salud.

#### 2. Historial de viajes

- Consulta viajes pasados y futuros.
- Revisa detalles, fechas y recomendaciones médicas.
- Puedes imprimir la información que necesites, por si no dispones de cobertura movil

#### 3. Mi salud

- Gestiona tu información médica personal: vacunas, medicamentos, etc.
- Mantén tu perfil actualizado para recibir recomendaciones personalizadas.

---

### Menú Lateral (Se accede desde la pantalla principal)

- Accede deslizando o tocando el icono menú.
- Opciones adicionales, configuraciones y soporte.
- Opciones de cierre de sesión y legal.

---

### Consejos para un Mejor Uso de la app

- Actualiza tu información médica y de viajes frecuentemente.
- Revisa el historial para planificar viajes futuros con seguridad.
- Explora todas las opciones del menú lateral.

---

### Preguntas Frecuentes

- **¿Funciona sin internet?**  
  Algunas funciones básicas sí, pero las recomendaciones y datos actualizados requieren conexión.

- **¿La información médica es segura?**  
  Sí, se almacena localmente y no se comparte sin permiso.

- **¿Cómo actualizar la app?**  
  A través de Google Play Store o Apple App Store.

---

### Soporte Técnico

- Email: soporte@travelshield.com
- Web: www.travelshield.com/support
- Opción *Ayuda y soporte* dentro de la app.

---

### Cierre

Gracias por confiar en TravelShield. Disfruta de tus viajes con la seguridad que te brinda esta herramienta.

---

## Conclusiones y Recomendaciones para el Desarrollo Futuro

- **Mejoras UI/UX:** Incluir animaciones y tutoriales interactivos para nuevos usuarios.
- **Sincronización en la nube:** Para respaldar y sincronizar información entre dispositivos.
- **Notificaciones:** Alertas personalizadas según destino y estado de salud.
- **Multilenguaje:** Soporte para múltiples idiomas.
- **Accesibilidad:** Mejoras para usuarios con discapacidades visuales o motoras.

---

## Licencia

Este proyecto está bajo licencia MIT. Consulta el archivo LICENSE para más detalles.
Todas las imágenes usadas en este proyecto se encuentran bajo la licencia CC. 

---

# Fin del documento

