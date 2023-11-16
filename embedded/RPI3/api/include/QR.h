#ifndef RPI3_API_INCLUDE_QR_H_
#define RPI3_API_INCLUDE_QR_H_

#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

#include <iostream>
#include <string>

#include "MQTTClient.h"
#include "UserAuthentication.h"

namespace prg {
class QR : public UserAuthentication {
 public:
  void init();
  std::string read_data() override;
  void send_data() override;
};
}  // namespace prg

#endif