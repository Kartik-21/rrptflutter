// To parse this JSON data, do
//
//     final bookData = bookDataFromJson(jsonString);

import 'dart:convert';

List<BookData> bookDataFromJson(String str) => List<BookData>.from(json.decode(str).map((x) => BookData.fromJson(x)));

String bookDataToJson(List<BookData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookData {
  BookData({
    this.bookId,
    this.bookTitle,
    this.bookImageUrl,
    this.bookPdfUrl,
    this.bookLang,
    this.bookPage,
    this.bookYear,
    this.bookAuthor,
    this.date,
    this.aId,
  });

  String bookId;
  String bookTitle;
  String bookImageUrl;
  String bookPdfUrl;
  String bookLang;
  dynamic bookPage;
  String bookYear;
  String bookAuthor;
  DateTime date;
  String aId;

  factory BookData.fromJson(Map<String, dynamic> json) => BookData(
    bookId: json["book_id"],
    bookTitle: json["book_title"],
    bookImageUrl: json["book_image_url"],
    bookPdfUrl: json["book_pdf_url"],
    bookLang: json["book_lang"],
    bookPage: json["book_page"],
    bookYear: json["book_year"],
    bookAuthor: json["book_author"],
    date: DateTime.parse(json["date"]),
    aId: json["a_id"],
  );

  Map<String, dynamic> toJson() => {
    "book_id": bookId,
    "book_title": bookTitle,
    "book_image_url": bookImageUrl,
    "book_pdf_url": bookPdfUrl,
    "book_lang": bookLang,
    "book_page": bookPage,
    "book_year": bookYear,
    "book_author": bookAuthor,
    "date": date.toIso8601String(),
    "a_id": aId,
  };
}
