import 'dart:convert';

WelcomeSuccess welcomeSuccessFromJson(String str) =>
    WelcomeSuccess.fromJson(json.decode(str));

String welcomeSuccessToJson(WelcomeSuccess data) => json.encode(data.toJson());

class WelcomeSuccess {
  List<String> resultsSectionOrder;
  FindPageMeta findPageMeta;
  Results keywordResults;
  TitleResults titleResults;

  Results companyResults;

  WelcomeSuccess({
    required this.resultsSectionOrder,
    required this.findPageMeta,
    required this.keywordResults,
    required this.titleResults,
    required this.companyResults,
  });

  factory WelcomeSuccess.fromJson(Map<String, dynamic> json) => WelcomeSuccess(
        resultsSectionOrder:
            List<String>.from(json["resultsSectionOrder"].map((x) => x)),
        findPageMeta: FindPageMeta.fromJson(json["findPageMeta"]),
        keywordResults: Results.fromJson(json["keywordResults"]),
        titleResults: TitleResults.fromJson(json["titleResults"]),
        companyResults: Results.fromJson(json["companyResults"]),
      );

  Map<String, dynamic> toJson() => {
        "resultsSectionOrder":
            List<dynamic>.from(resultsSectionOrder.map((x) => x)),
        "findPageMeta": findPageMeta.toJson(),
        "keywordResults": keywordResults.toJson(),
        "titleResults": titleResults.toJson(),
        "companyResults": companyResults.toJson(),
      };
}

class Results {
  List<dynamic> results;

  Results({
    required this.results,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        results: List<dynamic>.from(json["results"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x)),
      };
}

class FindPageMeta {
  String searchTerm;
  bool includeAdult;
  bool isExactMatch;

  FindPageMeta({
    required this.searchTerm,
    required this.includeAdult,
    required this.isExactMatch,
  });

  factory FindPageMeta.fromJson(Map<String, dynamic> json) => FindPageMeta(
        searchTerm: json["searchTerm"],
        includeAdult: json["includeAdult"],
        isExactMatch: json["isExactMatch"],
      );

  Map<String, dynamic> toJson() => {
        "searchTerm": searchTerm,
        "includeAdult": includeAdult,
        "isExactMatch": isExactMatch,
      };
}

class NameResultsResult {
  String id;
  String displayNameText;
  String knownForJobCategory;
  String knownForTitleText;
  String? knownForTitleYear;
  RImageModel? avatarImageModel;

  NameResultsResult({
    required this.id,
    required this.displayNameText,
    required this.knownForJobCategory,
    required this.knownForTitleText,
    this.knownForTitleYear,
    this.avatarImageModel,
  });

  factory NameResultsResult.fromJson(Map<String, dynamic> json) =>
      NameResultsResult(
        id: json["id"] ?? 'not available',
        displayNameText: json["displayNameText"] ?? 'not available',
        knownForJobCategory: json["knownForJobCategory"] ?? 'not available',
        knownForTitleText: json["knownForTitleText"] ?? 'not available',
        knownForTitleYear: json["knownForTitleYear"] ?? 'not available',
        avatarImageModel: json["avatarImageModel"] == null
            ? null
            : RImageModel.fromJson(json["avatarImageModel"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayNameText": displayNameText,
        "knownForJobCategory": knownForJobCategory,
        "knownForTitleText": knownForTitleText,
        "knownForTitleYear": knownForTitleYear,
        "avatarImageModel": avatarImageModel?.toJson(),
      };
}

class RImageModel {
  String url;
  int maxHeight;
  int maxWidth;
  String caption;

  RImageModel({
    required this.url,
    required this.maxHeight,
    required this.maxWidth,
    required this.caption,
  });

  factory RImageModel.fromJson(Map<String, dynamic> json) => RImageModel(
        url: json["url"] ?? 'not available',
        maxHeight: json["maxHeight"] ?? 'not available',
        maxWidth: json["maxWidth"] ?? 'not available',
        caption: json["caption"] ?? 'not available',
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "maxHeight": maxHeight,
        "maxWidth": maxWidth,
        "caption": caption,
      };
}

class TitleResults {
  List<TitleResultsResult> results;
  String nextCursor;
  bool hasExactMatches;

  TitleResults({
    required this.results,
    required this.nextCursor,
    required this.hasExactMatches,
  });

  factory TitleResults.fromJson(Map<String, dynamic> json) => TitleResults(
        results: List<TitleResultsResult>.from(
            json["results"].map((x) => TitleResultsResult.fromJson(x))),
        nextCursor: json["nextCursor"],
        hasExactMatches: json["hasExactMatches"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "nextCursor": nextCursor,
        "hasExactMatches": hasExactMatches,
      };
}

class TitleResultsResult {
  String id;
  String titleNameText;
  String titleReleaseText;
  String titleTypeText;
  dynamic titlePosterImageModel;
  dynamic topCredits;
  TitleResultsResult({
    required this.id,
    required this.titleNameText,
    required this.titleReleaseText,
    required this.titleTypeText,
    required this.titlePosterImageModel,
    required this.topCredits,
  });

  factory TitleResultsResult.fromJson(Map<String, dynamic> json) =>
      TitleResultsResult(
        id: json["id"] ?? 'not available',
        titleNameText: json["titleNameText"] ?? 'not available',
        titleReleaseText: json["titleReleaseText"] ?? 'not available',
        titleTypeText: json["titleTypeText"] ?? 'not available',
        titlePosterImageModel: TitlePosterImageModel.fromJson(
            json["titlePosterImageModel"] ?? 'not available'),
        topCredits: json["topCredits"] ?? 'not available',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titleNameText": titleNameText,
        "titleReleaseText": titleReleaseText,
        "titleTypeText": titleTypeText,
        "titlePosterImageModel": titlePosterImageModel.toJson(),
        "topCredits": topCredits,
      };
}

class TitlePosterImageModel {
  String url;
  int maxHeight;
  int maxWidth;
  String caption;

  TitlePosterImageModel({
    required this.url,
    required this.maxHeight,
    required this.maxWidth,
    required this.caption,
  });

  factory TitlePosterImageModel.fromJson(Map<String, dynamic> json) =>
      TitlePosterImageModel(
        url: json["url"] ?? 'not available',
        maxHeight: json["maxHeight"] ?? 'not available',
        maxWidth: json["maxWidth"] ?? 'not available',
        caption: json["caption"] ?? 'not available',
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "maxHeight": maxHeight,
        "maxWidth": maxWidth,
        "caption": caption,
      };
}
