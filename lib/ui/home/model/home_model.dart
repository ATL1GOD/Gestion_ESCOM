import 'dart:math';

import 'package:flutter/material.dart';

class CardModel {
  final String assetPath;

  CardModel({required this.assetPath});
}

class CardListModel {
  static final List<CardModel> cards = [
    CardModel(assetPath: 'assets/images/mapa_escom.png'),
  ];
}

final random = Random();
final randomCard =
    CardListModel.cards[random.nextInt(CardListModel.cards.length)];

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
      image: Image.asset('assets/images/escudo_ESCOM_azul.png'),
      icon: Icons.shield_sharp,
    ),
  ];
}
