// To parse this JSON data, do
//
//     final adsState = adsStateFromJson(jsonString);

import 'dart:convert';

AdsState adsStateFromJson(String str) => AdsState.fromJson(json.decode(str));

String adsStateToJson(AdsState data) => json.encode(data.toJson());

class AdsState {
    String message;
    Ad ad;

    AdsState({
        required this.message,
        required this.ad,
    });

    factory AdsState.fromJson(Map<String, dynamic> json) => AdsState(
        message: json["message"],
        ad: Ad.fromJson(json["ad"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "ad": ad.toJson(),
    };
}

class Ad {
    String accent;
    String content;
    int id;
    String imageUrl;
    bool isPaused;
    String plainContent;
    String publicId;
    String redirectToUrl;
    String tag;
    String title;
    String url;

    Ad({
        required this.accent,
        required this.content,
        required this.id,
        required this.imageUrl,
        required this.isPaused,
        required this.plainContent,
        required this.publicId,
        required this.redirectToUrl,
        required this.tag,
        required this.title,
        required this.url,
    });

    factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        accent: json["accent"],
        content: json["content"],
        id: json["id"],
        imageUrl: json["image_url"],
        isPaused: json["is_paused"],
        plainContent: json["plain_content"],
        publicId: json["public_id"],
        redirectToUrl: json["redirect_to_url"],
        tag: json["tag"],
        title: json["title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "accent": accent,
        "content": content,
        "id": id,
        "image_url": imageUrl,
        "is_paused": isPaused,
        "plain_content": plainContent,
        "public_id": publicId,
        "redirect_to_url": redirectToUrl,
        "tag": tag,
        "title": title,
        "url": url,
    };
}
