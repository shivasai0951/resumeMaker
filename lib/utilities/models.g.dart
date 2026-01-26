// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducationAdapter extends TypeAdapter<Education> {
  @override
  final int typeId = 0;

  @override
  Education read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Education(
      institution: fields[0] as String,
      degree: fields[1] as String,
      fieldOfStudy: fields[2] as String,
      startDate: fields[3] as String,
      endDate: fields[4] as String,
      grade: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Education obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.institution)
      ..writeByte(1)
      ..write(obj.degree)
      ..writeByte(2)
      ..write(obj.fieldOfStudy)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.grade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExperienceAdapter extends TypeAdapter<Experience> {
  @override
  final int typeId = 1;

  @override
  Experience read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Experience(
      company: fields[0] as String,
      position: fields[1] as String,
      startDate: fields[2] as String,
      endDate: fields[3] as String,
      description: fields[4] as String,
      currentlyWorking: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Experience obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.company)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.currentlyWorking);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SkillAdapter extends TypeAdapter<Skill> {
  @override
  final int typeId = 2;

  @override
  Skill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Skill(
      name: fields[0] as String,
      level: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Skill obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CertificateAdapter extends TypeAdapter<Certificate> {
  @override
  final int typeId = 3;

  @override
  Certificate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Certificate(
      name: fields[0] as String,
      issuer: fields[1] as String,
      date: fields[2] as String,
      credentialId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Certificate obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.issuer)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.credentialId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResumeAdapter extends TypeAdapter<Resume> {
  @override
  final int typeId = 4;

  @override
  Resume read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resume(
      id: fields[0] as String,
      fullName: fields[1] as String,
      contact: fields[2] as String,
      address: fields[3] as String,
      linkedin: fields[4] as String,
      website: fields[5] as String,
      description: fields[6] as String,
      education: (fields[7] as List).cast<Education>(),
      experience: (fields[8] as List).cast<Experience>(),
      skills: (fields[9] as List).cast<Skill>(),
      certificates: (fields[10] as List).cast<Certificate>(),
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      email: fields[13] as String,
      attachment: fields[14] as String,
      isFresher: fields[15] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Resume obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.contact)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.linkedin)
      ..writeByte(5)
      ..write(obj.website)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.education)
      ..writeByte(8)
      ..write(obj.experience)
      ..writeByte(9)
      ..write(obj.skills)
      ..writeByte(10)
      ..write(obj.certificates)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.email)
      ..writeByte(14)
      ..write(obj.attachment)
      ..writeByte(15)
      ..write(obj.isFresher);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
