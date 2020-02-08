class ArticleModel {
  final String title;
  final String description;
  final String avator;
  final int reactionCount;
  final List<String> tags;

  ArticleModel.fromJSON(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        avator = json['user']['profileImage'],
        reactionCount = json['positiveReactionsCount'],
        tags = json['tags'] ?? [];
}
