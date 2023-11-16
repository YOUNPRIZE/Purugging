#ifndef _API_INCLUDE_CHECK_H_
#define _API_INCLUDE_CHECK_H_
#endif
#include <Ticker.h>

#include "Arduino.h"
#include "HX711.h"
#include "Sense.h"

// HC_SR04 1 - sorting
#define HC_SR04_TRIG 12  // TRIG send ultrasonic wave
#define HC_SR04_ECHO 35  // ECHO recieve ultrasonic wave
// HC_SR04 2
#define HC_SR04_TRIG2 13  // TRIG send ultrasonic wave
#define HC_SR04_ECHO2 21  // ECHO recieve ultrasonic wave
// HC_SR04 3
#define HC_SR04_TRIG3 0   // TRIG send ultrasonic wave
#define HC_SR04_ECHO3 15  // ECHO recieve ultrasonic wave
// HC_SR04 4
#define HC_SR04_TRIG4 16  // TRIG send ultrasonic wave
#define HC_SR04_ECHO4 4   // ECHO recieve ultrasonic wave
// HC_SR04 5
#define HC_SR04_TRIG5 1  // TRIG send ultrasonic wave
#define HC_SR04_ECHO5 3  // ECHO recieve ultrasonic wave

// #define LED 13           // LED cathode pin
#define HC_CDSM_CDS 34   // CDS analog pin
#define HC_CDSM_LEDW 19  // CDS digital pin
#define DOUT 23
#define SCK 22

namespace prg {
void timer_interrupt();
class Check : public prg::Sense {
 public:
  Check() {
    // init for HC_SR04
    pinMode(HC_SR04_TRIG, OUTPUT);
    pinMode(HC_SR04_ECHO, INPUT);

    pinMode(HC_SR04_TRIG2, OUTPUT);
    pinMode(HC_SR04_ECHO2, INPUT);

    pinMode(HC_SR04_TRIG3, OUTPUT);
    pinMode(HC_SR04_ECHO3, INPUT);

    pinMode(HC_SR04_TRIG4, OUTPUT);
    pinMode(HC_SR04_ECHO4, INPUT);

    pinMode(HC_SR04_TRIG5, OUTPUT);
    pinMode(HC_SR04_ECHO5, INPUT);

    // CDS
    pinMode(HC_CDSM_CDS, INPUT);  // input pin
    // pinMode(LED, OUTPUT);           // LED digital pin
    pinMode(HC_CDSM_LEDW, OUTPUT);  // CDS digital pin
  }
  void roadcell_init();
  void timer_init();
  void offset_init();
  int get_dist(const int pin_num);
  virtual bool is_there_trash(void) override;
  virtual prg::Trashs classify_trash(void) override;
  virtual float get_weight(void) override;
};

}  // namespace prg
