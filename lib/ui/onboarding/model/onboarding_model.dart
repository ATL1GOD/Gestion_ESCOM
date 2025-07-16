class OnboardingContents {
  final String? title;
  final String image;
  final String desc;

  OnboardingContents({this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Todos somos ESCOM",
    image: "assets/images/onboarding4.svg",
    desc: "Queremos hacerte sentir parte de la escomunidad.",
  ),
  OnboardingContents(
    title: "Conocenos mejor",
    image: "assets/images/onboarding2.svg",
    desc: "Conecta con tus profesores y personal de la escuela.",
  ),
  OnboardingContents(
    title: "Bienvenido a ESCOM",
    image: "assets/images/onboarding5.svg",
    desc:
        "Te damos la bienvenida a la comunidad de ESCOM, donde la innovación y el aprendizaje se unen.",
  ),
];
