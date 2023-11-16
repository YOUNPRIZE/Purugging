class CampaignModel {
  // 생성자
  CampaignModel({
    required this.campaign_id,
    required this.member_id,
    required this.max_participant,
    required this.cur_participant,
    required this.title,
    required this.content,
    required this.date,

  });

  // 속성
  int campaign_id, member_id;
  int max_participant, cur_participant;
  String title, content;
  DateTime date;

  // 예제 생성 함수
  static Future<List<CampaignModel>> examData() async {
    // 초기 1초 지연
    await Future.delayed(const Duration(seconds: 1));
    DateTime date = DateTime.now().add(const Duration(days: 3));
    List<CampaignModel> dataList = [];
    for (int i = 1; i < 11; i++) {
      final examData = CampaignModel(
        campaign_id: i,
        member_id: 1,
        max_participant: 30,
        cur_participant: 15,
        title: "북한산 플로깅 같이 할 사람!",
        content: "11월 11일 북한산 플로깅 같이 할 사람 구해요!",
        date: date.add(Duration(days: i)),
      );
      dataList.add(examData);
    }
    return dataList;
  }
}
