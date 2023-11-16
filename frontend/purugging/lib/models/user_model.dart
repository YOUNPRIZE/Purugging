

class UserModel {
  double cum_weight;
  int cum_pet, cum_can, plogging_cnt;
  String name, nickname, profile_image, grade;
  String? phone_number, gender, introduction;

  UserModel({
    required this.grade,
    required this.cum_weight,
    required this.cum_pet,
    required this.cum_can,
    required this.plogging_cnt,
    required this.name,
    required this.nickname,
    required this.profile_image,
    required this.phone_number,
    this.gender,
    this.introduction,
  });

  // 메서드 - 등급 한글 변환
  String getGradeKorean() {
    late String result;
    switch (grade) {
      case "SEED":
        result = "씨앗";
        break;
      case "SPROUT":
        result = "새싹";
        break;
      case "LEAF":
        result = "잎새";
        break;
      case "BRANCH":
        result = "가지";
        break;
      case "FRUIT":
        result = "열매";
        break;
      case "TREE":
        result = "나무";
        break;
    }
    return result;
  }

  // 메서드 - 등급 변환
  String getGradeIcon() {
    String iconName = "";
    switch (grade) {
      case "SEED":
        iconName = "seed_icon";
        break;
      case "SPROUT":
        iconName = "sprout_icon";
        break;
      case "LEAF":
        iconName = "leaf_icon";
        break;
      case "BRANCH":
        iconName = "branch_icon";
        break;
      case "FRUIT":
        iconName = "fruit_icon";
        break;
      case "TREE":
        iconName = "tree_icon";
        break;
    }
    return "assets/image/$iconName.png";
  }
}

enum Grade {
  SEED,
  SPROUT,
  LEAF,
  BRANCH,
  FRUIT,
  TREE,
}
