import 'package:incosys/src/apis/articles/model/article.data.model.dart';

class ArticleResponse {
  ArticleResponse({
    required this.resultado,
    required this.data,
  });

  final String resultado;
  final List<ArticleData>? data;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      ArticleResponse(
        resultado: json["resultado"],
        data: json["data"] != null
            ? List<ArticleData>.from(
                json["data"].map((x) => ArticleData.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
