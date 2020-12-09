class ParentGroup{
  String parentGroupName;
  int parentGroupCode;
  int parentGroupId;

  ParentGroup({this.parentGroupName,this.parentGroupCode,this.parentGroupId});

  ParentGroup.fromJson(Map<String,dynamic> json){
    parentGroupName= json['parent_group_name'];
    parentGroupCode = int.parse(json['parent_group_code']);
    parentGroupId = int.parse(json['parent_group_id']);

  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = Map<String,dynamic>();
    data['parent_group_name'] = parentGroupName;
    data['parent_group_code'] = parentGroupCode;
    data['parent_group_id'] = parentGroupId;

    return data;
  }

}