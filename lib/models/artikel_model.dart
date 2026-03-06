class Blog {
  String id;
  String title;
  String date;
  String image;
  String name;
  String description;

  Blog({
    required this.id,
    required this.title,
    required this.date,
    required this.image,
    required this.name,
    required this.description,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
