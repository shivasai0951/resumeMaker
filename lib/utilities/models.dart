import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class Education extends HiveObject {
  @HiveField(0)
  String institution;

  @HiveField(1)
  String degree;

  @HiveField(2)
  String fieldOfStudy;

  @HiveField(3)
  String startDate;

  @HiveField(4)
  String endDate;

  @HiveField(5)
  String grade;

  Education({
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
    this.grade = '',
  });

  Map<String, dynamic> toJson() => {
    'institution': institution,
    'degree': degree,
    'fieldOfStudy': fieldOfStudy,
    'startDate': startDate,
    'endDate': endDate,
    'grade': grade,
  };

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    institution: json['institution'] ?? '',
    degree: json['degree'] ?? '',
    fieldOfStudy: json['fieldOfStudy'] ?? '',
    startDate: json['startDate'] ?? '',
    endDate: json['endDate'] ?? '',
    grade: json['grade'] ?? '',
  );
}

@HiveType(typeId: 1)
class Experience extends HiveObject {
  @HiveField(0)
  String company;

  @HiveField(1)
  String position;

  @HiveField(2)
  String startDate;

  @HiveField(3)
  String endDate;

  @HiveField(4)
  String description;

  @HiveField(5)
  bool currentlyWorking;

  Experience({
    required this.company,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.currentlyWorking = false,
  });

  Map<String, dynamic> toJson() => {
    'company': company,
    'position': position,
    'startDate': startDate,
    'endDate': endDate,
    'description': description,
    'currentlyWorking': currentlyWorking,
  };

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    company: json['company'] ?? '',
    position: json['position'] ?? '',
    startDate: json['startDate'] ?? '',
    endDate: json['endDate'] ?? '',
    description: json['description'] ?? '',
    currentlyWorking: json['currentlyWorking'] ?? false,
  );
}

@HiveType(typeId: 2)
class Skill extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String level;

  Skill({required this.name, this.level = 'Intermediate'});

  Map<String, dynamic> toJson() => {'name': name, 'level': level};

  factory Skill.fromJson(Map<String, dynamic> json) =>
      Skill(name: json['name'] ?? '', level: json['level'] ?? 'Intermediate');
}

@HiveType(typeId: 3)
class Certificate extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String issuer;

  @HiveField(2)
  String date;

  @HiveField(3)
  String credentialId;

  Certificate({
    required this.name,
    required this.issuer,
    required this.date,
    this.credentialId = '',
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'issuer': issuer,
    'date': date,
    'credentialId': credentialId,
  };

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    name: json['name'] ?? '',
    issuer: json['issuer'] ?? '',
    date: json['date'] ?? '',
    credentialId: json['credentialId'] ?? '',
  );
}

@HiveType(typeId: 4)
class Resume extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String fullName;

  @HiveField(2)
  String contact;

  @HiveField(3)
  String address;

  @HiveField(4)
  String linkedin;

  @HiveField(5)
  String website;

  @HiveField(6)
  String description;

  @HiveField(7)
  List<Education> education;

  @HiveField(8)
  List<Experience> experience;

  @HiveField(9)
  List<Skill> skills;

  @HiveField(10)
  List<Certificate> certificates;

  @HiveField(11)
  DateTime createdAt;

  @HiveField(12)
  DateTime updatedAt;

  @HiveField(13)
  String email;

  @HiveField(14)
  String attachment;

  @HiveField(15)
  bool isFresher;

  Resume({
    required this.id,
    required this.fullName,
    required this.contact,
    required this.address,
    this.linkedin = '',
    this.website = '',
    required this.description,
    required this.education,
    required this.experience,
    required this.skills,
    required this.certificates,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    this.attachment = '',
    this.isFresher = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'contact': contact,
    'address': address,
    'linkedin': linkedin,
    'website': website,
    'description': description,
    'education': education.map((e) => e.toJson()).toList(),
    'experience': experience.map((e) => e.toJson()).toList(),
    'skills': skills.map((e) => e.toJson()).toList(),
    'certificates': certificates.map((e) => e.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'email': email,
    'attachment': attachment,
    'isFresher': isFresher,
  };

  factory Resume.fromJson(Map<String, dynamic> json) => Resume(
    id: json['id'] ?? '',
    fullName: json['fullName'] ?? '',
    contact: json['contact'] ?? '',
    address: json['address'] ?? '',
    linkedin: json['linkedin'] ?? '',
    website: json['website'] ?? '',
    description: json['description'] ?? '',
    education:
        (json['education'] as List?)
            ?.map((e) => Education.fromJson(e))
            .toList() ??
        [],
    experience:
        (json['experience'] as List?)
            ?.map((e) => Experience.fromJson(e))
            .toList() ??
        [],
    skills:
        (json['skills'] as List?)?.map((e) => Skill.fromJson(e)).toList() ?? [],
    certificates:
        (json['certificates'] as List?)
            ?.map((e) => Certificate.fromJson(e))
            .toList() ??
        [],
    createdAt: DateTime.parse(
      json['createdAt'] ?? DateTime.now().toIso8601String(),
    ),
    updatedAt: DateTime.parse(
      json['updatedAt'] ?? DateTime.now().toIso8601String(),
    ),
    email: json['email'] ?? '',
    attachment: json['attachment'] ?? '',
    isFresher: json['isFresher'] ?? false,
  );
}
