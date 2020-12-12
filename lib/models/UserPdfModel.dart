class UserPdfModel {
  String userBookId;
  String bookTitle;
  String bookImageUrl;
  String bookPdfUrl;

  UserPdfModel(
      {this.userBookId, this.bookTitle, this.bookImageUrl, this.bookPdfUrl});

  UserPdfModel.fromJson(Map<String, dynamic> json) {
    userBookId = json['user_book_id'];
    bookTitle = json['book_title'];
    bookImageUrl = json['book_image_url'];
    bookPdfUrl = json['book_pdf_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_book_id'] = this.userBookId;
    data['book_title'] = this.bookTitle;
    data['book_image_url'] = this.bookImageUrl;
    data['book_pdf_url'] = this.bookPdfUrl;
    return data;
  }
}
