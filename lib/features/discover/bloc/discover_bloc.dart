import 'dart:async';

import 'package:cc_diary/core/api.dart';
import 'package:cc_diary/core/model/diary_m.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverInitial()) {
    on<GetDiscover>(_onGetDiscover);
    on<SubmitComment>(_onSubmitComment);
  }

  final Dio _dio = Dio();

  FutureOr<void> _onGetDiscover(
      GetDiscover event, Emitter<DiscoverState> emit) async {
    emit(DiscoverLoading());
    // await Future.delayed(const Duration(seconds: 1));

    final response = await _dio.get("$apiUrl/explore");

    List<Diary> diaries = [];
    if (response.statusCode == 200) {
      diaries = List<Diary>.from(
          response.data['content'].map((x) => Diary.fromJson(x)));
    }

    emit(DiscoverLoaded(diaries));
  }

  FutureOr<void> _onSubmitComment(
      SubmitComment event, Emitter<DiscoverState> emit) {
    // submit comment to server
  }
}
