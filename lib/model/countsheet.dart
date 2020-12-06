class Countsheet {
 
  String itemGroupName;
  String parentGroupName;
  String countId;

  Countsheet({this.itemGroupName, this.parentGroupName,this.countId});



  Countsheet.fromJson(Map<String,dynamic> json){
    itemGroupName = json['item_group_name'];
    parentGroupName = json['parent_group_name'];
    countId = json['cound_id'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data['item_group_name'] = itemGroupName;
    data['parent_group_name'] = parentGroupName;
    data['count_id'] = countId;

    return data;
  }



  
}