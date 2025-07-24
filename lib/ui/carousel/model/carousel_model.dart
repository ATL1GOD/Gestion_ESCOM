enum InfoItem { calendario, croquis, redesSociales, desconocido }

class CarouselItem {
  final int id;
  final String title;
  final String imgAssets;
  final InfoItem infoItemType;
  final String category;
  final String author;

  CarouselItem({
    required this.id,
    required this.title,
    required this.imgAssets,
    required this.infoItemType,
    required this.category,
    required this.author,
  });
}

List<CarouselItem> news = [
  CarouselItem(
    id: 1,
    title: 'Fotografias de las instalaciones',
    imgAssets: 'assets/images/escom1.png',
    infoItemType: InfoItem.desconocido,
    category: 'Fotografias',
    author: 'Estudiantes',
  ),
  CarouselItem(
    id: 2,
    title: 'Calendario Escolar ',
    imgAssets: 'assets/images/escom1.png',
    infoItemType: InfoItem.calendario,
    category: 'Semestre 2025/1',
    author: 'ESCOM',
  ),
  CarouselItem(
    id: 3,
    title: 'Becas Escolares',
    imgAssets: 'assets/images/escom2.png',
    infoItemType: InfoItem.desconocido,
    category: 'Becas',
    author: 'Departamento de Becas',
  ),
  CarouselItem(
    id: 4,
    title: 'Visita nuestras redes sociales',
    imgAssets: 'assets/images/escom2.png',
    infoItemType: InfoItem.redesSociales,
    category: 'Redes Sociales',
    author: 'ESCOM',
  ),
];
