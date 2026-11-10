/*
 * Vaccine_list - Lista que contiene las vacunas utilizadas, así como dosis y fecha de administración
 *
 * Derechos de autor © 2025 Crescencio Pérez Murillo.
 * Todos los derechos reservados.
 *
 * Uso y distribución:
 * Este código fuente y cualquier archivo asociado son propiedad exclusiva de Crescencio Pérez Murillo.
 * Queda prohibida la reproducción, distribución, modificación, o cualquier uso no autorizado
 * de este código sin la autorización previa y por escrito del titular de los derechos.
 *
 * Licencia:
 * El uso de este código está sujeto a los términos y condiciones establecidos por el titular.
 * Cualquier uso comercial o integración en proyectos derivados debe contar con la licencia adecuada.
 *
 * Exención de responsabilidad:
 * Este software se proporciona sin garantía de ningún tipo, expresa o implícita,
 * incluyendo pero no limitado a garantías de comerciabilidad o idoneidad para un propósito particular.
 *
 * Contacto:
 * Para consultas sobre licencias o permisos, por favor contactar a: contacto@travelshield.com
 */

// Lista de vacunas con información detallada para planificación de viajes
final List<Map<String, dynamic>> vaccineList = [
  {
    'nombre': 'Hepatitis A', //Nombre de la vacuna
    'diasMinimos': 60, //Días neecsarios para ser administra antes del viaje
    'descripcion': 'Se recomienda la 1ª dosis al menos 2 meses antes del viaje. Refuerzo a los 6 meses.', //Recomendaciones específicas
    'dosis': 2, //número de dosis
  },
  {
    'nombre': 'Hepatitis B',
    'diasMinimos': 0,
    'descripcion': 'Serie de 3 dosis. Existen esquemas acelerados.',
    'dosis': 3,
  },
  {
    'nombre': 'Tifoidea',
    'diasMinimos': 30,
    'descripcion': 'Debe administrarse al menos 4 semanas antes del viaje.',
    'dosis': 1,
  },
  {
    'nombre': 'Tétanos/Difteria',
    'diasMinimos': 0,
    'descripcion': 'Refuerzo si no se ha aplicado en los últimos 10 años.',
    'dosis': 1,
  },
  {
    'nombre': 'Gripe',
    'diasMinimos': 14,
    'descripcion': 'Vacuna estacional, ideal al menos 2 semanas antes.',
    'dosis': 1,
  },
  {
    'nombre': 'MMR (Sarampión, etc)',
    'diasMinimos': 28,
    'descripcion': 'Requiere 2 dosis separadas 4 semanas.',
    'dosis': 2,
  },
  {
    'nombre': 'Rabia',
    'diasMinimos': 21,
    'descripcion': 'Curso de 3 dosis, días 0, 7 y 21. Solo si hay riesgo (zonas rurales, contacto con animales).',
    'dosis': 3,
  },
  {
    'nombre': 'Fiebre amarilla',
    'diasMinimos': 10,
    'descripcion': 'Obligatoria en algunos países. Debe aplicarse al menos 10 días antes del viaje.',
    'dosis': 1,
  },
  {
    'nombre': 'Encefalitis japonesa',
    'diasMinimos': 28,
    'descripcion': 'Dos dosis separadas por 28 días. Solo si viajas a zonas rurales en Asia.',
    'dosis': 2,
  },
  {
    'nombre': 'Malaria (profilaxis)',
    'diasMinimos': 0,
    'descripcion': 'Profilaxis necesaria en zonas endémicas.',
    'dosis': 1,
  },
];