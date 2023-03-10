final String section = 'section';

class SectionFields {
  static final String id = '_id';
  static final String name = 'name';
}

class Section {
  final int? id;
  final String name;

  const Section({
    this.id,
    required this.name,
  });
}