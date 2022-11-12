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

List<String> getRoute123() {
  return Routes;
}

List<String> getTimePickUp() {
  return timePickup;
}

List<String> timePickup = [
  //slot 1
  '05:30',
  '05:45',
  '06:00',
  '06:15',
  '06:30',
  '06:45',
  '07:00',
  //slot 2
  '08:00',
  '08:15',
  '08:30',
  '08:45',
  '09:00',
  '09:15',
  '09:30',
  //slot 3

  '11:30',
  '11:45',
  '12:00',
  '12:15',
  '12:30',
  '12:45',
  '13:00',
  //Slot 4
  '14:00',
  '14:15',
  '14:30',
  '14:45',
  '15:00',
  '15:15',
  '15:30',

  //slot 5
  '16:30',
  '16:45',
  '17:00',
  '17:15',
  '17:30',
  '17:45',
  '18:30',
];

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
