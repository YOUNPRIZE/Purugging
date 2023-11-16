int speaker = 9;  // 아두이노 9번 핀과 모듈 IN핀 연결

void setup() { pinMode(speaker, OUTPUT); }

void loop() {
  tone(speaker, 262);  // 스피커에 4옥타프 '도' 출력
  delay(1000);

  noTone(speaker);  // 소리 멈춤
  delay(1000);
}