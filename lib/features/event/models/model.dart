class SocialPost {
  final String user;
  final String time;
  final String content;
  final int likes;
  final int comments;
  final bool isLiked;

  SocialPost({
    required this.user,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    this.isLiked = false,
  });

  SocialPost copyWith({bool? isLiked, int? likes}) {
    return SocialPost(
      user: user,
      time: time,
      content: content,
      likes: likes ?? this.likes,
      comments: comments,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
