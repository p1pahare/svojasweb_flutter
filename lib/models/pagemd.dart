class PageMD {
  PageMD({
    required this.count,
    required this.currentPage,
    required this.lastPage,
  });
  late final int count;
  late final int currentPage;
  late final int lastPage;

  PageMD.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['current_page'] = currentPage;
    _data['last_page'] = lastPage;
    return _data;
  }
}
