class IndustrialTrainingDM{
  String id,title,description,period,stipend,skillsReq,startDate,endDate,regFee;

  IndustrialTrainingDM({this.id, this.title, this.description, this.period,
    this.stipend, this.skillsReq, this.startDate, this.endDate,
    this.regFee});

  @override
  String toString() {
    return 'InternshipsDM{id: $id, title: $title, description: $description, period: $period, stipend: $stipend, skills_req: $skillsReq, start_date: $startDate, end_date: $endDate, reg_fee: $regFee}';
  }

}