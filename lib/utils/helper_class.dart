class ReturnObj<T> {
  bool status;
  String message;
  T? data;
  ReturnObj({required this.message, required this.status, this.data});
}

class StringFunctions {
  static String capitalizeFirstLetter(String? input) {
    if (input == null || input.isEmpty) {
      return "";
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static String convertToTitleCase(String? input) {
    if (input == null || input.isEmpty) {
      return "";
    }
    return input.split(" ").map((e) => capitalizeFirstLetter(e)).join(" ");
  }
}


// {_id: 6744a15afbfce5b0a6a3a291, email: deeproy8790@gmail.com, fullName: deepak singh, fatherName: ram kisbhore, phone: 9888960320, address: {street: 2312312, city: chandigarh, state: Chandigarh, pinCode: 160014}, bloodGroup: AB+, age: 21}