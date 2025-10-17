class Category {
  const Category({required this.id, required this.name});

  final int id;
  final String name;
}

const List<Category> mockCategories = <Category>[
  Category(id: 9, name: 'General Knowledge'),
  Category(id: 17, name: 'Science & Nature'),
  Category(id: 19, name: 'Mathematics'),
  Category(id: 23, name: 'History'),
  Category(id: 10, name: 'Books'),
];
