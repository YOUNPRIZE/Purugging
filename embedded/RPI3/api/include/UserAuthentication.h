#ifndef RPI3_API_INCLUDE_USERAUTHENTICATION_H_
#define RPI3_API_INCLUDE_USERAUTHENTICATION_H_

#include <string>

namespace prg {
class UserAuthentication {
 public:
  virtual std::string read_data() = 0;
  virtual void send_data() = 0;
};
}  // namespace prg

#endif