import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:resumemaker/utilities/models.dart';
import 'resume_event.dart';
import 'resume_state.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final Box<Resume> resumeBox;

  ResumeBloc(this.resumeBox) : super(ResumeInitial()) {
    on<LoadResumes>(_onLoadResumes);
    on<AddResume>(_onAddResume);
    on<UpdateResume>(_onUpdateResume);
    on<DeleteResume>(_onDeleteResume);
  }

  Future<void> _onLoadResumes(
    LoadResumes event,
    Emitter<ResumeState> emit,
  ) async {
    try {
      emit(ResumeLoading());
      final resumes = resumeBox.values.toList();
      emit(ResumeLoaded(resumes));
    } catch (e) {
      emit(ResumeError(e.toString()));
    }
  }

  Future<void> _onAddResume(AddResume event, Emitter<ResumeState> emit) async {
    try {
      await resumeBox.put(event.resume.id, event.resume);
      final resumes = resumeBox.values.toList();
      emit(ResumeLoaded(resumes));
    } catch (e) {
      emit(ResumeError(e.toString()));
    }
  }

  Future<void> _onUpdateResume(
    UpdateResume event,
    Emitter<ResumeState> emit,
  ) async {
    try {
      await resumeBox.put(event.resume.id, event.resume);
      final resumes = resumeBox.values.toList();
      emit(ResumeLoaded(resumes));
    } catch (e) {
      emit(ResumeError(e.toString()));
    }
  }

  Future<void> _onDeleteResume(
    DeleteResume event,
    Emitter<ResumeState> emit,
  ) async {
    try {
      await resumeBox.delete(event.id);
      final resumes = resumeBox.values.toList();
      emit(ResumeLoaded(resumes));
    } catch (e) {
      emit(ResumeError(e.toString()));
    }
  }
}
