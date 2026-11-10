/*
 * Country_list - Lista que contiene los paises (15 en total), así como información adicional y recomendaciones sanitarias
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

// Clase que representa un país con su nombre, bandera, recomendaciones de salud y vacunas recomendadas
class Country {
  final String name;           // Nombre del país
  final String flag;           // Emoji o símbolo de la bandera del país
  final String recommendations; // Consejos o recomendaciones sanitarias para el viaje
  final String vaccines;       // Vacunas recomendadas para el país

  const Country({
    required this.name,
    required this.flag,
    required this.recommendations,
    required this.vaccines,
  });
}

//Lista de paises (15 en total)
const List<Country> countries = [
  Country(
    name: 'Argentina',
    flag: '🇦🇷',
    recommendations: 'Evitar los alimentos que contengan huevo crudo.\n Evitar el consumo de frutas y vegetales crudos.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Brasil',
    flag: '🇧🇷',
    recommendations: 'Evitar la picadura de mosquits.\nEvitar consumir agua no embotellada.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos, Malaria (profilaxis).',
  ),
  Country(
    name: 'Canadá',
    flag: '🇨🇦',
    recommendations: 'Evitar el baño en lagos.\nPrevención de las ITS.',
    vaccines: 'Gripe, Tétanos.',
  ),
  Country(
    name: 'Chile',
    flag: '🇨🇱',
    recommendations: 'Evitar comer comida callejera.\nEvitar los helados .',
    vaccines: 'Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Colombia',
    flag: '🇨🇴',
    recommendations: 'Evitar las picaduras de insectos.\nEvitar comer comida callejera',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'España',
    flag: '🇪🇸',
    recommendations: 'Mantener hidratación abundante en verano.\nPrevención de las ITS',
    vaccines: 'Tétanos, Gripe.',
  ),
  Country(
    name: 'Estados Unidos',
    flag: '🇺🇸',
    recommendations: 'Prevención de las ITS.\nMantener hidratación abundante en verano.',
    vaccines: 'Gripe, Tétanos.',
  ),
  Country(
    name: 'Francia',
    flag: '🇫🇷',
    recommendations: 'Prevención de las ITS.\nMantener hidratación abundante en verano.',
    vaccines: 'Tétanos, Gripe.',
  ),
  Country(
    name: 'Italia',
    flag: '🇮🇹',
    recommendations: 'Prevención de las ITS.\nMantener hidratación abundante en verano.',
    vaccines: 'Tétanos, Gripe.',
  ),
  Country(
    name: 'México',
    flag: '🇲🇽',
    recommendations: 'Evitar las picaduras de insectos.\nEvitar comer comida callejera',
    vaccines: 'Hepatitis A, Fiebre amarilla, Tétanos.',
  ),
  Country(
    name: 'Perú',
    flag: '🇵🇪',
    recommendations: 'Evitar las picaduras de insectos.\nEvitar agua del grifo.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Reino Unido',
    flag: '🇬🇧',
    recommendations:  'Prevención de las ITS.\nEvitar el consumo de helado .',
    vaccines: 'Gripe, Tétanos.',
  ),
  Country(
    name: 'Uruguay',
    flag: '🇺🇾',
    recommendations: 'Evitar las picaduras de insectos.\nEvitar agua del grifo.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Alemania',
    flag: '🇩🇪',
    recommendations:  'Prevención de las ITS.\nEvitar el consumo de helado .',
    vaccines: 'Gripe, Tétanos.',
  ),
  Country(
    name: 'Japón',
    flag: '🇯🇵',
    recommendations: 'Evitar el consumo de pescado crudo.\nPrevención de las ITS.',
    vaccines: 'Tétanos, Hepatitis A, Gripe',
  ),
];