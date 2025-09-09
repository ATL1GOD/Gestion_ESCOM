import 'dart:math';

import 'package:flutter/material.dart';

// Modelo para los detalles de la ESCOM
class EscomDetailModel {
  final String title;
  final String content;
  final Image? image;
  final IconData? icon;

  EscomDetailModel({
    required this.title,
    required this.content,
    this.image,
    this.icon,
  });
}

class EscomDetailListModel {
  static final List<EscomDetailModel> details = [
    EscomDetailModel(
      title: "Misión",
      content: """
      La Escuela Superior de Cómputo es una Unidad Académica líder en la formación de profesionales integrales en las áreas de Sistemas Computacionales, Inteligencia Artificial y Ciencia de Datos, con amplio sentido social, contribuyendo al desarrollo tecnológico, científico y económico del país, coadyuvando a la sustentabilidad y observando estándares internacionales de calidad educativa.
      """,
      icon: Icons.volunteer_activism_rounded,
    ),

    EscomDetailModel(
      title: "Visión",
      content: """
      La Escuela Superior de Cómputo será líder en Latinoamérica en la formación integral de profesionales en el área de la computación, con estándares internacionales de calidad educativa, promoviendo la responsabilidad en sus alumnos para con su entorno, el sentido social y el respeto a la pluralidad. Propiciando la innovación y el emprendimiento para contribuir al desarrollo económico y tecnológico del país.
      """,
      icon: Icons.visibility_sharp,
    ),
    EscomDetailModel(
      title: "Historia",
      content: """
      Después de varios intentos que se hicieron al respecto, en 1993 un grupo de trabajo integrado por la Secretaría Académica del Instituto, elaboró un proyecto en el que se propuso la creación de la Escuela Superior de Cómputo, bajo la sigla (ESCOM) y al interior de ella la carrera de Ingeniero en Sistemas Computacionales.

      Dicho documento fue presentado, en apego a la normatividad vigente, a la comisión de Planes y Programas del Consejo Nacional Consultivo del IPN, el cual fue aprobado por la misma Comisión en la sesión del 5 de agosto de 1993. Contando con la autorización, el documento fue remitido al pleno del H. Consejo General Consultivo del IPN, en donde, fue aprobado en la Sesión Ordinaria del 13 de agosto de 1993 surgiendo así la Escuela Superior de Cómputo.
      """,
      icon: Icons.history_edu_rounded,
    ),
    EscomDetailModel(
      title: "Escudo",
      content: """
      En el año de 1994, la dirección del plantel estableció un conjunto de lineamientos que debía cumplir este distintivo y demás identificadores que le sirvieran como imagen oficial. Estos lineamientos fueron:
      
      * Trazos claros y sencillos
      * Dar sensación de movimiento
      * No contener elementos tecnológicos
      * Tener posibilidad de larga vigencia
      * Retratar bien en color o en blanco y negro
      
      Dos estudiantes de la licenciatura en diseño gráfico de la UAM-Azcapotzalco, apegados a los lineamientos generaron logotipos e imágenes, resultando ganador el presentado por la C. Guadalupe Gómez Sánchez, durante el simposium Tecno-Industria ESCOM-95. Enmarzo de 2011 se incluyó la leyenda Instituto Politécnico Nacional.
      """,
      image: Image.asset('assets/images/escudo_azul.png'),
      icon: Icons.shield_sharp,
    ),
  ];
}

// Modelo para los elementos del carrusel de noticias de la ESCOM
enum InfoItem {
  mapaEscom,
  calendario,
  isc,
  iia,
  lcd,
  isa,
  redesSociales,
  desconocido,
}

class CarouselItem {
  final int id;
  final String title;
  final String imgUrl;
  final InfoItem infoItemType;
  final String category;
  final String author;

  CarouselItem({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.infoItemType,
    required this.category,
    required this.author,
  });
}

const String baseUrl =
    'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes';

List<String> _generateImageUrls(String baseUrl, int count) {
  return List.generate(count, (i) => '$baseUrl/escom${i + 1}.png');
}

final List<CarouselItem> escomNewsData = [
  CarouselItem(
    id: 1,
    title: 'Ubica los salones',
    imgUrl:
        'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes/tiburon1.png',
    infoItemType: InfoItem.mapaEscom,
    category: 'Mapa',
    author: 'ESCOM',
  ),
  CarouselItem(
    id: 2,
    title: 'Calendario Escolar',
    imgUrl: '',
    infoItemType: InfoItem.calendario,
    category: 'Semestre en curso',
    author: 'ESCOM',
  ),
  CarouselItem(
    id: 3,
    title: 'Ingeniería en Sistemas Computacionales',
    imgUrl: '',
    infoItemType: InfoItem.isc,
    category: 'ISC',
    author: 'ESCOM',
  ),
  CarouselItem(
    id: 4,
    title: 'Ingeniería en Inteligencia Artificial',
    imgUrl: '',
    infoItemType: InfoItem.iia,
    category: 'IIA',
    author: 'ESCOM',
  ),
  CarouselItem(
    id: 5,
    title: 'Licenciatura en Ciencia de Datos',
    imgUrl: '',
    infoItemType: InfoItem.lcd,
    category: 'LCD',
    author: 'ESCOM',
  ),
  CarouselItem(
    id: 6,
    title: 'Ingeniería en Sistemas Automotrices',
    imgUrl: '',
    infoItemType: InfoItem.isa,
    category: 'ISA',
    author: 'ESCOM',
  ),
  CarouselItem(
    id: 7,
    title: 'Visita nuestras redes sociales',
    imgUrl: '',
    infoItemType: InfoItem.redesSociales,
    category: 'Redes Sociales',
    author: 'ESCOM',
  ),
];

final Random random = Random();
final List<String> randomImagePool = _generateImageUrls(baseUrl, 30);

final List<CarouselItem> escomNewsWithImages = escomNewsData.map((item) {
  final imageUrl = item.imgUrl.isNotEmpty
      ? item.imgUrl
      : randomImagePool[random.nextInt(randomImagePool.length)];

  return CarouselItem(
    id: item.id,
    title: item.title,
    imgUrl: imageUrl,
    infoItemType: item.infoItemType,
    category: item.category,
    author: item.author,
  );
}).toList();

// Modelo para los elementos de la sección de carreras
class CarreraItem {
  final int id;
  final String title;
  final String objectivo;
  final String perfilIngreso;
  final String perfilEgreso;
  final String campoLaboral;
  final String planEstudiosPath;

  CarreraItem({
    required this.id,
    required this.title,
    required this.objectivo,
    required this.perfilIngreso,
    required this.perfilEgreso,
    required this.campoLaboral,
    required this.planEstudiosPath,
  });
}

// Lista de carreras
final List<CarreraItem> carrerasItems = [
  CarreraItem(
    id: 0,
    title: "Ingeniería en Sistemas Computacionales",
    objectivo:
        "Formar ingenieros en sistemas computacionales de sólida preparación científica y tecnológica en los ámbitos del desarrollo de software y hardware, que propongan, analicen, diseñen, desarrollen, implementen y gestionen sistemas computacionales a partir de tecnologías de vanguardia y metodologías, normas y estándares nacionales e internacionales de calidad; líderes de equipos de trabajo multidisciplinarios y multiculturales, con un alto sentido ético y de responsabilidad.",
    perfilIngreso:
        "Los aspirantes a estudiar este programa deberán tener conocimientos en matemáticas, física e informática. Es también conveniente que posea conocimientos de inglés. Así mismo, deberán contar con habilidades como análisis y síntesis de información, razonamiento lógico y expresión oral y escrita. Así como actitudes de respeto y responsabilidad.",
    perfilEgreso:
        "El egresado del programa académico de Ingeniería en Sistemas Computacionales podrá desempeñarse en equipos multidisciplinarios e interdisciplinarios en los ámbitos del desarrollo de software y hardware, sustentando su actuación profesional en valores éticos y de responsabilidad social, con un enfoque de liderazgo y sostenibilidad en los sectores público y privado.",
    campoLaboral:
        "El campo profesional en el que se desarrollan los egresados de este Programa Académico es muy amplio, se localiza en los sectores público y privado; en consultorías, en empresas del sector financiero, comercial, de servicios o bien en aquellas dedicadas a la innovación, en entidades federales, estatales, así como pequeño empresario creando empresas emergentes (startups).",
    planEstudiosPath: 'assets/images/planISC.png',
  ),
  CarreraItem(
    id: 1,
    title: "Ingeniería en Inteligencia Artificial",
    objectivo:
        "Formar expertos capaces de desarrollar sistemas inteligentes utilizando diferentes metodologías en las diferentes etapas de desarrollo y aplicando algoritmos en áreas como aprendizaje de máquina, procesamiento automático de lenguaje natural, visión artificial y modelos bioinspirados para atender las necesidades de los diferentes sectores de la sociedad a través de la generación de procesos y soluciones innovadoras.",
    perfilIngreso:
        "Los estudiantes que ingresen al Instituto Politécnico Nacional, en cualquiera de sus programas y niveles, deberán contar con los conocimientos y las habilidades básicas que garanticen un adecuado desempeño en el nivel al que solicitan su ingreso. Asimismo, deberán contar con las actitudes y valores necesarios para responsabilizarse de su proceso formativo y asumir una posición activa frente al estudio y al desarrollo de los proyectos y trabajos requeridos, coincidentes con el ideario y principios del IPN.",
    perfilEgreso:
        "El egresado de la Ingeniería en Inteligencia Artificial se desempeñará colaborativamente en equipos multidisciplinarios en el análisis, diseño, implementación, validación, implantación, supervisión y gestión de sistemas inteligentes, aplicando algoritmos en áreas como aprendizaje de máquina, procesamiento automático de lenguaje natural, visión artificial y modelos bioinspirados; ejerciendo su profesión con liderazgo, ética y responsabilidad social.",
    campoLaboral:
        "Este profesional podrá desempeñarse en el desarrollo y aplicación de la Inteligencia Artificial, en los ámbitos público y privado, en campos ocupacionales como los que se enlistan a continuación:",
    planEstudiosPath: 'assets/images/planIIA.png',
  ),
  CarreraItem(
    id: 2,
    title: "Licenciatura en Ciencia de Datos",
    objectivo:
        "Formar expertos capaces de extraer conocimiento implícito y complejo, potencialmente útil a partir de grandes conjuntos de datos, utilizando métodos de inteligencia artificial, aprendizaje de máquina, estadística, sistemas de bases de datos y modelos matemáticos sobre comportamientos probables, para apoyar la toma de decisiones de alta dirección.",
    perfilIngreso:
        "Los estudiantes que ingresen al Instituto Politécnico Nacional, en cualquiera de sus programas y niveles, deberán contar con los conocimientos y las habilidades básicas que garanticen un adecuado desempeño en el nivel al que solicitan su ingreso. Asimismo, deberán contar con las actitudes y valores necesarios para responsabilizarse de su proceso formativo y asumir una posición activa frente al estudio y al desarrollo de los proyectos y trabajos requeridos, coincidentes con el ideario y principios del IPN.",
    perfilEgreso:
        "El egresado de la Licenciatura de Ciencia de Datos será capaz de extraer conocimiento implícito y complejo, potencialmente útil (descubrimiento de patrones, desviaciones, anomalías, valores anómalos, situaciones interesantes, tendencias), a partir de grandes conjuntos de datos. Utiliza los métodos de la inteligencia artificial, aprendizaje de máquina, estadística y sistemas de bases de datos para la toma de decisiones de alta dirección, fundadas en los datos y modelos matemáticos sobre comportamientos probables, deseables e indeseables, participando en dinámicas de trabajo colaborativo e interdisciplinario con sentido ético y responsabilidad social.",
    campoLaboral:
        "Este profesional podrá desempeñarse en los ámbitos público y privado en campos ocupacionales como los que se enlistan a continuación:",
    planEstudiosPath: 'assets/images/planLCD.png',
  ),
  CarreraItem(
    id: 3,
    title: "Ingeniería en Sistemas Automotrices",
    objectivo:
        "Preparar ingenieros altamente especializados para atender las necesidades en ingeniería automotriz y de autopartes en sus Áreas de: manufactura, diseño, automatización, procesos, sistemas inteligentes, protección ambiental, administración e innovación tecnológica.",
    perfilIngreso:
        "El aspirante a estudiar la Carrera de Ingeniería en Sistemas Automotrices deberá haber egresado de cualquier institución pública o privada en el nivel medio superior o equivalente, dentro de alguna de las especialidades o área afines a las ciencias físico matemáticas, ello contribuirá al mejor equilibrio del conocimiento al ingreso. Aprobar el examen de admisión que el Instituto Politécnico Nacional establezca para este fin y atender los requerimientos de la convocatoria. El aspirante deberá tener los siguientes conocimientos básicos capacidades actitudes y valores: Conocimientos teóricos y prácticos de las Ciencias Físico Matemáticas. Uso de la metodología científica. Capacidades de razonamiento lógico. Actitudes de respeto y responsabilidad. Análisis y síntesis hacia la aplicación del conocimiento. Capacidad para expresarse mediante un lenguaje científico y cotidiano, tanto en forma oral como escrita. Compresión manejo y aplicación de la información a través de diversos lenguajes gráficos, computacionales y simbólicos. Habilidades manuales para el trabajo en laboratorio. Disposición para el autoaprendizaje que propicie su desarrollo intelectual, emotivo y social. Disposición a conocer la problemática nacional y participar en su solución.",
    perfilEgreso:
        "Es un profesionista que aplica conocimientos de la matemática, las ciencias naturales, las ciencias sociales, humanísticas y administrativas que ha adquirido a través del estudio, la experiencia y la práctica, al desarrollo de actividades tales como: Participación, en programas de investigación, desarrollo tecnológico e ingeniería experimental. Planeación, dirección y/o ejecución en diseños y proyectos de ingeniería. Dirección y/o ejecución de obras de construcción, instalación, producción y operación de bienes y servcios. Realización de estudios y consultoria sobre aspectos técnicos, tecnológicos y/o procesos relativos en la especialidad. Participación en los programas de elaboración de normas técnicas y de calidad para sistemas, productos, procesos y servicios. Programación y desarrollo de actividades comerciales, de gestión y periciales. Organización dirección y/o ejecución de programas de conservación y mantenimiento. Realización de funciones en docencia e instrucción en programas escolarizados, de educación continua, de especialización o posgrado. Manejo eficaz del idioma local y capacidad de comunicación en una lengua extranjera. Redacción de documentos, artículos e informes técnicos y no técnicos. Vinculación y participación en organismos gremiales, técnicos y culturales; nacionales y extranjeros. Organización y supervisión del trabajo de personal dependiente. Solución de problemas en beneficio de la persona y la sociedad en su conjunto, principalmente en las áreas de:Generación, conversión y conservación de la energía. Sistemas de propulsión, transmisión y diseño de vehículos. Seguridad. Sistemas inteligentes para guiado y supervisión de sistemas en vehículos. Producción industrial. Instalaciones, maquinaria e infraestructura. Participación en la economia del país. Producción más limpia.",
    campoLaboral:
        "El egresado de la carrera de Ingeniería en Sistemas Automotrices cuenta con una formación altamente especializada y multidisciplinaria que le permite desempeñarse profesionalmente en el Sector Automotriz y de Autopartes con una alta eficiencia, en cualquiera de las áreas siguientes: Diseño de Vehículos y sus Componentes, Manufactura de Autopartes, Control de Calidad, Ingeniería y Manufactura Asistidas por Computadora, Líneas de Ensamble, Desarrollo de Nuevas Tecnologías, Dispositivos Electrónicos, Materiales Compuestos, Áreas de Planeación, Ventas, Comercialización.",
    planEstudiosPath:
        'assets/images/planISA.png', // Se sugiere cambiar el path para que coincida con la carrera
  ),
];

// Modelo para los elementos de la sección de mapa
class MapaPhoto {
  final String imagenmapa;
  final String title;
  final String author;

  MapaPhoto({
    required this.imagenmapa,
    required this.title,
    required this.author,
  });
}

final List<MapaPhoto> photos = [
  MapaPhoto(
    imagenmapa: 'assets/images/escom_edificio0.png',
    title: 'Mapa General de ESCOM',
    author: 'ESCOM',
  ),
  MapaPhoto(
    imagenmapa: 'assets/images/escom_edificio1.png',
    title: 'Edificio 1',
    author: 'ESCOM',
  ),
  MapaPhoto(
    imagenmapa: 'assets/images/escom_edificio2.png',
    title: 'Edificio 2',
    author: 'ESCOM',
  ),
  MapaPhoto(
    imagenmapa: 'assets/images/escom_edificio3.png',
    title: 'Edificio 3',
    author: 'ESCOM',
  ),
  MapaPhoto(
    imagenmapa: 'assets/images/escom_edificio4.png',
    title: 'Edificio 4',
    author: 'ESCOM',
  ),
  MapaPhoto(
    imagenmapa: 'assets/images/escom_edificio5.png',
    title: 'Edificio 5',
    author: 'ESCOM',
  ),
];
