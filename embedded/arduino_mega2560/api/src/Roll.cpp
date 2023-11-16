#include "Roll.h"

int prg::Roll::get_rotation_angle() { return this->rotation_angle; }
bool prg::Roll::get_clockwise() { return this->clockwise; }
void prg::Roll::set_rotation_angle(int rotation_angle) {
  this->rotation_angle = rotation_angle;
  return;
}
