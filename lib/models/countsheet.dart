class Countsheet {
 
  String itemGroupName;
  String parentGroupName;
  String countId;
  int synced;
  String syncedDate;
  int updated;
  Countsheet({this.itemGroupName, this.parentGroupName,this.countId,this.synced,this.syncedDate,this.updated});



  Countsheet.fromJson(Map<String,dynamic> json){
    itemGroupName = json['item_group_name'];
    parentGroupName = json['parent_group_name'];
    countId = json['count_id'];
    synced = json['synced'];
    syncedDate = json['syncedDate'];
    updated = json['updated'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data['item_group_name'] = itemGroupName;
    data['parent_group_name'] = parentGroupName;
    data['count_id'] = countId;
    data['synced'] = synced;
    data['synced_date'] = syncedDate;
    data['updated'] = updated;

    return data;
  }
  


  
}