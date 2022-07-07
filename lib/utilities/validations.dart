String? isEmail(String? em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em ?? '') ? null : 'Please enter a valid email';
}

String? isAtleast8Chars(String? em) {
  if ((em?.length ?? 0) < 8) {
    return "Length should be at least 8 characters";
  } else {
    return null;
  }
}

String? isNotBlank(String? em) {
  if ((em?.length ?? 0) < 1 || em?.toLowerCase() == 'select') {
    return "This Field can not be left blank";
  } else {
    return null;
  }
}
