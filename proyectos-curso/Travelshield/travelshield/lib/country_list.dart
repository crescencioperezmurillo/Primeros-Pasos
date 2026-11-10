class Country {
  final String name;
  final String flag; // Emoji bandera
  final String recommendations;
  final String vaccines;

  const Country({
    required this.name,
    required this.flag,
    required this.recommendations,
    required this.vaccines,
  });
}

const List<Country> countries = [
  Country(
    name: 'Argentina',
    flag: '🇦🇷',
    recommendations: 'Evitar beber agua del grifo y protegerse del sol.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Brasil',
    flag: '🇧🇷',
    recommendations: 'Precaución con la selva amazónica y evitar zonas con mosquitos.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos, Malaria (profilaxis).',
  ),
  Country(
    name: 'Canadá',
    flag: '🇨🇦',
    recommendations: 'Clima frío, llevar ropa adecuada y proteger la piel.',
    vaccines: 'Influenza, Tétanos.',
  ),
  Country(
    name: 'Chile',
    flag: '🇨🇱',
    recommendations: 'Evitar zonas con contaminación y cuidado en altura.',
    vaccines: 'Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Colombia',
    flag: '🇨🇴',
    recommendations: 'Precaución en zonas selváticas y evitar picaduras de insectos.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'España',
    flag: '🇪🇸',
    recommendations: 'Mantener hidratación y evitar el sol fuerte en verano.',
    vaccines: 'Tétanos, Gripe.',
  ),
  Country(
    name: 'Estados Unidos',
    flag: '🇺🇸',
    recommendations: 'Cuidado con la altitud y protegerse de insectos en ciertas zonas.',
    vaccines: 'Gripe, Tétanos.',
  ),
  Country(
    name: 'Francia',
    flag: '🇫🇷',
    recommendations: 'Mantener buena higiene y protegerse del sol.',
    vaccines: 'Tétanos, Gripe.',
  ),
  Country(
    name: 'Italia',
    flag: '🇮🇹',
    recommendations: 'Cuidado con las zonas turísticas concurridas y mantener hidratación.',
    vaccines: 'Tétanos, Gripe.',
  ),
  Country(
    name: 'México',
    flag: '🇲🇽',
    recommendations: 'Evitar agua no embotellada y protegerse de mosquitos.',
    vaccines: 'Hepatitis A, Fiebre amarilla, Tétanos.',
  ),
  Country(
    name: 'Perú',
    flag: '🇵🇪',
    recommendations: 'Precaución con la altura y evitar agua del grifo.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Reino Unido',
    flag: '🇬🇧',
    recommendations: 'Protegerse del frío y mantener buena higiene.',
    vaccines: 'Gripe, Tétanos.',
  ),
  Country(
    name: 'Uruguay',
    flag: '🇺🇾',
    recommendations: 'Evitar picaduras de mosquitos y cuidar la alimentación.',
    vaccines: 'Fiebre amarilla, Hepatitis A, Tétanos.',
  ),
  Country(
    name: 'Alemania',
    flag: '🇩🇪',
    recommendations: 'Mantenerse hidratado y protegerse del clima frío.',
    vaccines: 'Gripe, Tétanos.',
  ),
  Country(
    name: 'Japón',
    flag: '🇯🇵',
    recommendations: 'Protegerse del sol y evitar comida cruda sospechosa.',
    vaccines: 'Tétanos, Hepatitis A.',
  ),
];