import 'package:equatable/equatable.dart';
import 'package:resumemaker/utilities/models.dart';

abstract class ResumeEvent extends Equatable {
  const ResumeEvent();

  @override
  List<Object?> get props => [];
}

class LoadResumes extends ResumeEvent {}

class AddResume extends ResumeEvent {
  final Resume resume;

  const AddResume(this.resume);

  @override
  List<Object?> get props => [resume];
}

class UpdateResume extends ResumeEvent {
  final Resume resume;

  const UpdateResume(this.resume);

  @override
  List<Object?> get props => [resume];
}

class DeleteResume extends ResumeEvent {
  final String id;

  const DeleteResume(this.id);

  @override
  List<Object?> get props => [id];
}
