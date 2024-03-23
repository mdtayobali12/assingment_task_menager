class FromValidator {
  static String? emailValidetor(String?value) {
    if(value!.trim().isEmpty){
      return "Enter Your email";
    }
    return null ;
  }
  static String? fatNamelValidetor(String?value) {
    if(value!.trim().isEmpty){
      return "Enter Your First Name";
    }
    return null ;
  }
  static String? lastNameValidetor(String?value) {
    if( value!.trim().isEmpty){
      return "Enter Your Last Name";
    }
    return null ;
  }
  static String? mobileNoValidetor(String?value) {
    if(value!.trim().isEmpty){
      return "Enter Your Mobile";
    }
    return null ;
  }
  static String? passwordValidetor(String?value) {
    if (value
        ?.trim()
        .isEmpty ?? true) {
      return "Enter Your password";
    }
    if (value!.length <= 6) {
      return "Password should more then 6 letter";
    }
    return null;
  }
  static String? titleValidetor(String? value){
    if(value!.trim().isEmpty){
      return "Enter Your Title";
    }
    return null;
  }
  static String? descriptionValidetor(String? value){
    if(value!.trim().isEmpty){
      return "Enter Your Description";
    }
    return null;
  }
}