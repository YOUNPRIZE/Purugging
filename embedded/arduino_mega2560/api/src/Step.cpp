#include "Step.h"

void prg::Step::init() {
  pinMode(this->enable_pin, OUTPUT);
  pinMode(this->step_pin, OUTPUT);
  pinMode(this->dir_pin, OUTPUT);

  digitalWrite(this->enable_pin, LOW);
  digitalWrite(this->step_pin, LOW);
}
void prg::Step::set_clockwise(bool clockwise) {
  this->clockwise = clockwise;
  if (clockwise)
    digitalWrite(this->dir_pin, HIGH);
  else
    digitalWrite(this->dir_pin, LOW);
  return;
}
void prg::Step::run() {
  float steps_per_cycle = float(this->rotation_angle) / 360 * 200;

  for (int i = 0; i < steps_per_cycle; ++i) {
    // These four lines result in 1 step:
    digitalWrite(this->step_pin, HIGH);
    delayMicroseconds(2000);
    digitalWrite(this->step_pin, LOW);
    delayMicroseconds(2000);
  }
  return;
}