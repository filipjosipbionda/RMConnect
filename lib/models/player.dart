class Player {
  String name;
  String imageUrl;
  int number;
  String position;
  bool? isTracked;
  String? documentId;

  Player({
    required this.name,
    required this.imageUrl,
    required this.number,
    required this.position,
    required this.isTracked,
    required this.documentId,
  });
}
