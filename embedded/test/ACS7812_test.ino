int val;
float amp;
const int LED = 13;
void setup() {
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(LED, OUTPUT);
}

void loop() {
  val = analogRead(A0);
  amp = (((val - 511) * 5 / 0.185) / 1024) * 1000;
  digitalWrite(LED, 1);
  Serial.print(amp);
  Serial.println(" mA");
  delay(250);
}