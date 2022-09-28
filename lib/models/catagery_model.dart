class CatageryModel {
  int CatageryId;
  String CatageryName;
  CatageryModel({required this.CatageryId, required this.CatageryName});
  Map<String, dynamic> fromJson() {
    return {
      'CatageryId': CatageryId,
      'CatageryName': CatageryName,
    };
  }

  CatageryModel.toJson(Map<String, dynamic> res)
      : CatageryId = res['CatageryId'],
        CatageryName = res['CatageryName'];
}
