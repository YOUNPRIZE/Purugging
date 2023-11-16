void setup() {
  Serial1.begin(115200);
  Serial.begin(115200);
}

void loop() {
  while (Serial1.available()) Serial.write(Serial1.read());
  while (Serial.available()) Serial1.write(Serial.read());
}