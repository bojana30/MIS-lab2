class Food {
  int id;
  String name;
  String thumbnail;
  bool favorite;

  // Food({required this.id, required this.name, required this.thumbnail});
  Food({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.favorite = false,
  });

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'img': thumbnail};

  Food.fromJson(Map<String, dynamic> data)
    : id = int.parse(data['idMeal']),
      thumbnail = data['strMealThumb'],
      name = data['strMeal'],
      favorite = data['isFavorite'] ?? false;
}
