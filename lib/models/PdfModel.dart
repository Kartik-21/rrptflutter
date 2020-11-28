class PdfModel {
  String bookId;
  String bookTitle;
  String bookImageUrl;
  String bookPdfUrl;
  String bookLang;
  String bookYear;
  String bookAuthor;
  String date;
  String aId;

  PdfModel(
      {this.bookId,
        this.bookTitle,
        this.bookImageUrl,
        this.bookPdfUrl,
        this.bookLang,
        this.bookYear,
        this.bookAuthor,
        this.date,
        this.aId});

  PdfModel.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookTitle = json['book_title'];
    bookImageUrl = json['book_image_url'];
    bookPdfUrl = json['book_pdf_url'];
    bookLang = json['book_lang'];
    bookYear = json['book_year'];
    bookAuthor = json['book_author'];
    date = json['date'];
    aId = json['a_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_title'] = this.bookTitle;
    data['book_image_url'] = this.bookImageUrl;
    data['book_pdf_url'] = this.bookPdfUrl;
    data['book_lang'] = this.bookLang;
    data['book_year'] = this.bookYear;
    data['book_author'] = this.bookAuthor;
    data['date'] = this.date;
    data['a_id'] = this.aId;
    return data;
  }
}
