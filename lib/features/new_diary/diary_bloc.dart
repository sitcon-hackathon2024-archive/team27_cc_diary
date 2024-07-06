import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'diary_event.dart';
import 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  DiaryBloc() : super(DiaryInitial()) {
    on<SaveDiary>(_onSaveDiary);
  }

  FutureOr<void> _onSaveDiary(SaveDiary event, Emitter<DiaryState> emit) {
    log(event.diaryContent);
    emit(DiarySaving());
    emit(DiarySaved(event.songId, "你嘻嘻了"));
  }
}
