class Organization {
  int id = 0;
  String? name;
  String? phoneNumber;
  String? website;
  String? description;
  String? companyLogo;
  String? coverPicture;

  Organization({
    required this.id,
    this.name,
    this.phoneNumber,
    this.website,
    this.description,
    this.companyLogo,
    this.coverPicture,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    website = json['website'];
    description = json['description'];
    companyLogo = json['company_logo'];
    coverPicture = json['cover_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['website'] = website;
    data['description'] = description;
    data['company_logo'] = companyLogo;
    data['cover_picture'] = coverPicture;
    return data;
  }
}
