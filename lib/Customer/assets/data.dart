class User {
  String name;
  String address;
  String phone;
  String avtURL;

  User(this.name, this.address, this.phone, this.avtURL);
}

List<User> getUser() {
  return <User>[
    User("Ng Van A", "quan 9", "123456789", "images/Ellipse3.png"),
  ];
}

List<String> getRoute() {
  return Routes;
}

List<String> Routes = [
  'Route 1',
  'Route 2',
  'Route 3',
  'Route 4',
];

class Slot {
  String name;
  bool isSelected;

  Slot(this.name, this.isSelected);
}

List<Slot> getSlots() {
  return <Slot>[
    Slot("7:00 - 9:15", false),
    Slot("9:30 - 11:45", false),
    Slot("12:30 - 2:45", false),
    Slot("15:00 - 17:15", false),
    Slot("7:30 - 19:45", false),
  ];
}

class From {
  String name;
  bool isSelected;

  From(this.name, this.isSelected);
}

List<From> getFroms() {
  return <From>[
    From("FPT University Main-Gateway", false),
    From("FPT University Second Gateway", false),
  ];
}

class To {
  String name;
  bool isSelected;

  To(this.name, this.isSelected);
}

List<To> getTos() {
  return <To>[
    To("VinHome S107", false),
    To("VinHome S101", false),
    To("VinHome S203", false),
    To("VinHome S205", false),
    To("VinHome S305", false),
    To("VinHome S603", false),
  ];
}

class Payment {
  String name;
  bool isSelected;

  Payment(this.name, this.isSelected);
}

List<Payment> getPayments() {
  return <Payment>[
    Payment("Cash", false),
    Payment("ZaloPay", false),
  ];
}

class Booking {
  String from;
  String to;
  String slot;
  String date;
  String cost;
  String Payment;

  Booking(this.from, this.to, this.slot, this.date, this.cost, this.Payment);
}

List<Booking> getBookings() {
  return <Booking>[
    Booking("VinHome S107", "FPT University Main-Gateway", "7:00 - 9:15",
        "10/10/2022", "20.000", "Cash"),
    Booking("VinHome S203", "FPT University Main-Gateway", "9:30 - 11:45",
        "15/10/2022", "40.000", "ZaloPay"),
    Booking("VinHome S305", "FPT University Second Gateway", "7:00 - 9:15",
        "10/10/2022", "20.000", "Cash"),
    Booking("VinHome S107", "FPT University Second Gateway", "7:00 - 9:15",
        "10/10/2022", "20.000", "Cash"),
    Booking("VinHome S603", "FPT University Main-Gateway", "7:00 - 9:15",
        "10/10/2022", "20.000", "ZaloPay"),
    Booking("VinHome S203", "FPT University Second Gateway", "7:00 - 9:15",
        "10/10/2022", "20.000", "ZaloPay"),
  ];
}
