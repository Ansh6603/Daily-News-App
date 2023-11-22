class ArticleModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  ArticleModel({
    this.author,
    this.content,
    this.description,
    this.title,
    this.url,
    this.urlToImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      content: map['content'],
    );
  }
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
