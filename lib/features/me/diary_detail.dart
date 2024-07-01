import 'package:cc_diary/core/model/diary_m.dart';
import 'package:cc_diary/features/me/widgets/comment_block.dart';
import 'package:cc_diary/features/me/widgets/diary_preview.dart';
import 'package:cc_diary/features/me/widgets/music_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryDetailPage extends StatelessWidget {
  const DiaryDetailPage({super.key, required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary Detail'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(diary.date)),
                DiaryPreview(diary: diary),
                ...diary.comments.map((comment) => Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: CommentBlock(comment: comment),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
