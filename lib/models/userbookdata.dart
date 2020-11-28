// To parse this JSON data, do
//
//     final userBookData = userBookDataFromJson(jsonString);

import 'dart:convert';

List<UserBookData> userBookDataFromJson(String str) => List<UserBookData>.from(json.decode(str).map((x) => UserBookData.fromJson(x)));

String userBookDataToJson(List<UserBookData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserBookData {
  UserBookData({
    this.userBookId,
    this.bookTitle,
    this.bookImageUrl,
    this.bookPdfUrl,
  });

  String userBookId;
  String bookTitle;
  String bookImageUrl;
  String bookPdfUrl;

  factory UserBookData.fromJson(Map<String, dynamic> json) => UserBookData(
    userBookId: json["user_book_id"],
    bookTitle: json["book_title"],
    bookImageUrl: json["book_image_url"],
    bookPdfUrl: json["book_pdf_url"],
  );

  Map<String, dynamic> toJson() => {
    "user_book_id": userBookId,
    "book_title": bookTitle,
    "book_image_url": bookImageUrl,
    "book_pdf_url": bookPdfUrl,
  };
}
