# SSAFY 9기 자율프로젝트

# 푸르깅(Purgging)

## **0️⃣ 프로젝트 개요**

🎈 프로젝트명 : 푸르깅

📌 프로젝트 주제 : 플로깅은 '플라스틱(Plogging)'과 '종달리기(Jogging)'의 합성어로, 운동하면서 쓰레기를 줍는 환경보호 활동을 말합니다. 본 프로젝트는 IoT를 활용해 플로깅 활동을 더 효율적이고 재미있게 만드는 웹 기반 서비스를 제안합니다. 사용자의 플로깅 경로, 쓰레기 수거량 등을 실시간으로 기록하고 공유함으로써 환경보호 의식을 높이고 커뮤니티 참여를 유도합니다.

📌 프로젝트 배경 : 환경 문제는 현재 우리 세대가 직면한 중대한 이슈 중 하나입니다. 특히 플라스틱 쓰레기는 바다와 육지에서 발견되며, 그 영향은 환경 뿐만 아니라 인간의 건강에도 큰 위협을 미칩니다. 이에 따라 플로깅이라는 활동이 전 세계적으로 주목받기 시작했습니다. 그러나 많은 사람들이 플로깅 활동에 참여하고 싶어해도 시작하기 어려워하며, 자신의 활동을 기록하거나 공유할 수단이 부족합니다. 따라서 IoT 기술을 활용해 이러한 문제를 해결하고, 더 많은 사람들이 플로깅에 참여할 수 있도록 돕는 것이 필요하다고 판단하였습니다. 이 프로젝트를 통해 환경 보호 활동에 더 많은 사람들이 참여할 수 있게 되길 희망합니다.

🛠 개발 기간 : 23.10.10 ~ 23.11.17 (6주)

🧑🏻 팀원 : 김한주, 손세이, 인정환, 조윤상, 채현종, 하정호

## **1️⃣ 서비스 대표 기능**

<h4>Web</h4>

| 기능               | 세부기능                                                     |
| ------------------ | ------------------------------------------------------------ |
| 회원 기능          | 소셜 로그인 / 회원정보 수정 / 회원 탈퇴 / 로그아웃 / 마이페이지 |
| 플로깅 실행        | QR 생성 및 실행 / 지도 표시 / 완료사진 등록 / 주변 인원 알림 |
| 플로깅 로그          | 플로깅 로그 리스트 / 시간 조회 / 거리 조회 / 쓰레기통 정보 조회 / 사진 및 마무리 결과 조회 / 플로깅 기록 |
| 커뮤니티      | 사용자 개최 모임 / 캠페인 조회, 추가, 수정, 삭제 / 타인 프로필 / 채팅 기능 |
| 쓰레기통         | 쓰레기통 포화상태 확인 / 재활용 쓰레기 개수 확인 / 지역별 비닐양 확인 |
| 알림 기능 | 캠페인 알림 / 플로깅 종료 알림 | 
| 데이터 시각화          | 추가 예정 |


<h4>Trash Can</h4>

| 기능             | 세부기능                                      |
| ---------------- | --------------------------------------------- |
| 사용자 인증      | QR인식 / 서버 통신                          |
| 자동 봉투 제공 | 인증된 사용자에게 쓰레기 봉투 자동 지급 |
| 자동 재활용품 분류 | 캔과 패트병 자동 분류 |
| 쓰레기통 상태정보 송신 | 재활용품 개수, 쓰레기 무게, 봉투 재고 및 쓰레기통 포화상태 송신 |