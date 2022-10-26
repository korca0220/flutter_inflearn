import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/colors.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage;
  final List<Image> images;

  // 별점
  final int rating;

  // 이메일
  final String email;

  // 리뷰 내용
  final String content;
  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _Header(
        avatarImage: avatarImage,
        email: email,
        rating: rating,
      ),
      const SizedBox(height: 8),
      _Body(content: content),
      _Images(),
    ]);
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;
  const _Header({
    required this.avatarImage,
    required this.email,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: avatarImage,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => index < rating
              ? Icon(
                  Icons.star,
                  color: PRIMARY_COLOR,
                )
              : Icon(
                  Icons.star_border_outlined,
                ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;
  const _Body({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14.0,
              color: BODY_TEXT_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
