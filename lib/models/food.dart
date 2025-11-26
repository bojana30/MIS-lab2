class Food {
  int id;
  String name;
  String thumbnail;

  Food({required this.id, required this.name, required this.thumbnail});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'img': thumbnail};

  Food.fromJson(Map<String, dynamic> data)
    : id = int.parse(data['idMeal']),
      thumbnail = data['strMealThumb'],
      name = data['strMeal'];
}
