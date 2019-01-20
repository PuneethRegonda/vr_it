class MobileAppsDM{
  String id,name,description,rating,link,logoUrl;

  MobileAppsDM({this.id, this.name, this.description, this.rating, this.link,
      this.logoUrl});

  @override
  String toString() {
    return 'MobileAppsDM{id: $id, name: $name, description: $description, rating: $rating, link: $link, logoUrl: $logoUrl}';
  }


}