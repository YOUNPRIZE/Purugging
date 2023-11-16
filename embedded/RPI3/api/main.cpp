#include <iostream>

#include "QR.h"
#include "UserAuthentication.h"

using namespace std;

int main() {
  prg::QR qr;
  qr.init();
  std::cout << "ready\n";
  while (1) {
    // #1. qr 인식
    std::string res = qr.read_data();
    // #2. qr 데이터 전송
    qr.send_data(res);
    cout << "send data\n";
  }
  return 0;
}