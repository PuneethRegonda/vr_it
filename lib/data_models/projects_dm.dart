class ProjectsDM{
  String id,title,description,std,requirements,cost,type;

  ProjectsDM({this.id, this.title, this.description, this.std, this.requirements,
      this.cost, this.type});

  @override
  String toString() {
    return 'ProjectsDM{id: $id, title: $title, description: $description, std: $std, requirements: $requirements, cost: $cost, type: $type}';
  }

}