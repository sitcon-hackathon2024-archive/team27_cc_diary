import 'package:cc_diary/core/model/diary_m.dart';
import 'package:cc_diary/features/me/widgets/music_bar.dart';
import 'package:cc_diary/theme.dart';
import 'package:flutter/material.dart';

class DiaryPreview extends StatelessWidget {
  const DiaryPreview({super.key, required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MusicBar(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: theme().primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(diary.content),
        ),
      ],
    );
  }
}
