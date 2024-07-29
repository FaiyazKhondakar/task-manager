class Validator{
  static textFieldValidator(String? value, msg){
    if (value?.trim().isEmpty ?? true) {
      return 'Enter Your $msg';
    }
    return null;
  }


  static passwordTextFieldValidator(String? value){
    if(textFieldValidator(value, 'password') != null){
      return textFieldValidator(value, 'password');
    }
    if (value!.length <= 6) {
      return 'Password should more than 6 letter';
    }
    return null;
  }
}