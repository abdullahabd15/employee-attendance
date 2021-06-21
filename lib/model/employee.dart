class Employee {
  int id;
  String employeeNumber;
  String fullName;
  String position;
  String division;
  String email;
  String phoneNumber;
  String address;

  Employee(
      {this.id,
      this.employeeNumber,
      this.fullName,
      this.position,
      this.division,
      this.email,
      this.phoneNumber,
      this.address});

  Employee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    employeeNumber = map['employeeNumber'];
    fullName = map['fullName'];
    position = map['position'];
    division = map['division'];
    email = map['email'];
    phoneNumber = map['phoneNumber'];
    address = map['address'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeNumber'] = this.employeeNumber;
    data['fullName'] = this.fullName;
    data['position'] = this.position;
    data['division'] = this.division;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }

  ///dummy employee
  static Employee createEmployee() {
    return Employee(
        id: 1,
        employeeNumber: '123456',
        fullName: 'Iklimah',
        position: 'Software Engineer',
        division: 'IT',
        email: 'iklimah.abdullah22@gmail.com',
        phoneNumber: '089527762200',
        address:
            'Jln. Pakubuwono VI no 24, Kelurahan Gunung, Kecamatan Kebayoran Baru, Kota Jakarta Selatan, DKI Jakarta');
  }
}
