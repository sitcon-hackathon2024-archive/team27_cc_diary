import 'package:cc_diary/core/model/diary_m.dart';
import 'package:cc_diary/core/music_bar.dart';
import 'package:cc_diary/core/user_info.dart';
import 'package:cc_diary/features/discover/bloc/discover_bloc.dart';
import 'package:cc_diary/features/me/widgets/comment_block.dart';
import 'package:cc_diary/l10n.dart';
import 'package:cc_diary/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryDetails extends StatelessWidget {
  const DiaryDetails({super.key, required this.diary, this.showInput = false});

  final Diary diary;
  final bool showInput;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            DiaryDetailHeader(
                uploadedAt: diary.date,
                musicTitle: diary.musicTitle,
                musicPath: diary.musicPath),
            const SizedBox(height: 16),
            DiaryDetailBody(diary: diary),
            if (showInput) CommentInput(diaryId: diary.diaryId),
            DiaryComment(comment: diary.comments[0], idx: 0),
            ...diary.comments
                .sublist(1)
                .map((comment) => DiaryComment(comment: comment, idx: 1)),
          ]),
        ),
      ),
    );
  }
}

class DiaryComment extends StatelessWidget {
  const DiaryComment({super.key, required this.comment, required this.idx});

  final Comment comment;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: CommentBlock(
        comment: comment,
        isAI: idx == 0,
      ),
    );
  }
}

class DiaryDetailHeader extends StatelessWidget {
  const DiaryDetailHeader(
      {super.key,
      required this.uploadedAt,
      required this.musicTitle,
      required this.musicPath});

  final String musicTitle, musicPath;
  final DateTime uploadedAt;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      UserInfo.me(uploadedAt: uploadedAt),
      const Expanded(child: SizedBox()),
      Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 3),
          child: MusicBar(
              musicTitle: musicTitle, musicPath: musicPath, autoplay: true)),
    ]);
  }
}

class DiaryDetailBody extends StatefulWidget {
  const DiaryDetailBody({super.key, required this.diary});

  final Diary diary;

  @override
  State<DiaryDetailBody> createState() => _DiaryDetailBodyState();
}

class _DiaryDetailBodyState extends State<DiaryDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: theme().primaryColorDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Scrollbar(
        child: SingleChildScrollView(
            child: Text(widget.diary.content,
                style: const TextStyle(fontSize: 16))),
      ),
    );
  }
}

class CommentInput extends StatelessWidget {
  const CommentInput({super.key, required this.diaryId});

  final String diaryId;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(hintText: l10n(context).comment),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        onSubmitted: (comment) {
          context.read<DiscoverBloc>().add(SubmitComment(diaryId, comment));
        });
  }
}
