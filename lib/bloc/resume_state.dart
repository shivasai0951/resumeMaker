import 'package:equatable/equatable.dart';
import 'package:resumemaker/utilities/models.dart';

abstract class ResumeState extends Equatable {
  const ResumeState();

  @override
  List<Object?> get props => [];
}

class ResumeInitial extends ResumeState {}

class ResumeLoading extends ResumeState {}

class ResumeLoaded extends ResumeState {
  final List<Resume> resumes;

  const ResumeLoaded(this.resumes);

  @override
  List<Object?> get props => [resumes];
}

class ResumeError extends ResumeState {
  final String message;

  const ResumeError(this.message);

  @override
  List<Object?> get props => [message];
}
