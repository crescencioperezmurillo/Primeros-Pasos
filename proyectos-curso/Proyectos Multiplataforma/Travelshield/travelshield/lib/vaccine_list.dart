// vaccine_list.dart

final List<Map<String, dynamic>> vaccineList = [
  {
    'nombre': 'Hepatitis A',
    'diasMinimos': 60,
    'descripcion': 'Se recomienda la 1ª dosis al menos 2 meses antes del viaje. Refuerzo a los 6 meses.',
    'dosis': 2,
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
    'nombre': 'Influenza',
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
  {
    'nombre': 'Gripe',
    'diasMinimos': 0,
    'descripcion': 'Vacuna estacional recomendada.',
    'dosis': 1,
  },
];