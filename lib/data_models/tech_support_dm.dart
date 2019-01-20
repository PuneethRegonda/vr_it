class TechSupportDM{
  String id,phone,email,type,description;

  TechSupportDM({this.id, this.phone, this.email, this.type,
      this.description});

  @override
  String toString() {
    return 'TechSupportDM{id: $id, phone: $phone, email: $email, type: $type, description: $description}';
  }

}