#ifndef _API_INCLUDE_ROLL_H_
#define _API_INCLUDE_ROLL_h_

#include "Arduino.h"

namespace prg {
class Roll {
 protected:
  int rotation_angle;  // degree (1 = 360')
  bool clockwise;

 public:
  int get_rotation_angle();
  bool get_clockwise();
  void set_rotation_angle(int rotation_angle);
  virtual void set_clockwise(bool clockwise) = 0;
  virtual void run() = 0;
};

}  // namespace prg

#endif _api_include_roll_h_
