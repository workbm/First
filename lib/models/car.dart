class Car {
  final int doors, id, seat;
  final String description, name, image, price, type;
  final List<String> options;
  Car({
    required this.id,
    required this.name,
    required this.image,
    required this.options,
    required this.type,
    this.doors = 4,
    this.seat = 4,
    this.description = '',
    required this.price,
  });
}
