#include "Check.h"

// #include <HX711.h>

#include "Sense.h"

static bool is_start = false;
Ticker Timer1;
float loadcell_value = 226.0;
HX711 scale;

void prg::timer_interrupt() {
  is_start = true;
  return;
}
void prg::Check::timer_init() {
  // set timer
  Timer1.attach(1, prg::timer_interrupt);  // 1 second period

  // start timer
  // Timer1.start();
  return;
}
bool prg::Check::is_there_trash(void) {
  if (is_start) {
    // start distance measurement
    digitalWrite(HC_SR04_TRIG, LOW);
    delayMicroseconds(2);
    digitalWrite(HC_SR04_TRIG, HIGH);
    delayMicroseconds(2);
    digitalWrite(HC_SR04_TRIG, LOW);

    // detact trash
    long duration = pulseIn(HC_SR04_ECHO, HIGH);
    long distance = duration * 17 / 1000;

    is_start = false;
    if (distance < 10) {
      Serial.println("detact trash");
      return true;
    } else
      return false;
  }
  return false;
}

prg::Trashs prg::Check::classify_trash(void) {
  int value = 0;

  // for(int i=0; i< 5; ++i){
  // // HC-CDSM ON
  // digitalWrite(HC_CDSM_LEDW, HIGH);
  // // led ON
  // digitalWrite(LED, HIGH);
  // // HC-CDSM reading data
  // value += analogRead(HC_CDSM_CDS);

  // delay(500);
  // // led OFF
  // digitalWrite(LED, LOW);

  // // HC-CDSM ON
  // digitalWrite(HC_CDSM_LEDW, LOW);
  // }
  // value /= 5;

  // HC-CDSM ON
  digitalWrite(HC_CDSM_LEDW, HIGH);
  // led ON
  // digitalWrite(LED, HIGH);
  // HC-CDSM reading data
  value += analogRead(HC_CDSM_CDS);

  delay(500);
  // led OFF
  // digitalWrite(LED, LOW);

  Serial.println(value);
  // classify recycling types
  if (value < 2000) {
    Serial.println("Glass");
    return prg::Trashs::Glass;
  } else {
    Serial.println("Can");
    return prg::Trashs::Can;
  }
}
int prg::Check::get_dist(const int pin_num) {
  int trig_pin = -1, echo_pin = -1;
  if (pin_num == 2) {
    trig_pin = HC_SR04_TRIG2;
    echo_pin = HC_SR04_ECHO2;
  } else if (pin_num == 3) {
    trig_pin = HC_SR04_TRIG3;
    echo_pin = HC_SR04_ECHO3;
  } else if (pin_num == 4) {
    trig_pin = HC_SR04_TRIG4;
    echo_pin = HC_SR04_ECHO4;
  } else if (pin_num == 5) {
    trig_pin = HC_SR04_TRIG5;
    echo_pin = HC_SR04_ECHO5;
  }

  digitalWrite(trig_pin, LOW);
  delayMicroseconds(2);
  digitalWrite(trig_pin, HIGH);
  delayMicroseconds(2);
  digitalWrite(trig_pin, LOW);

  // detact trash
  long duration = pulseIn(echo_pin, HIGH);
  int distance = duration * 17 / 1000;

  return distance;
}
void prg::Check::roadcell_init() {
  scale.begin(DOUT, SCK);
  scale.tare(10);
}
void prg::Check::offset_init() { scale.tare(10); }
float prg::Check::get_weight(void) {
  // CZL635 loard cell 5kg reading data
  float weight = -1.0f;
  weight = scale.get_units(5);
  return weight;
}