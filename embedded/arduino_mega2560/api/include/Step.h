#ifndef _API_INCLUDE_STEP_H_
#define _API_INCLUDE_STEP_H_

#include "Arduino.h"
#include "Roll.h"

namespace prg {
class Step : public ::prg::Roll {
 private:
  int dir_pin;
  int step_pin;
  int enable_pin;

 public:
  Step(int enable_pin, int dir_pin, int step_pin)
      : enable_pin(enable_pin), dir_pin(dir_pin), step_pin(step_pin) {}
  void init();
  virtual void set_clockwise(bool clockwise) override;
  virtual void run() override;
};
}  // namespace prg
#endif