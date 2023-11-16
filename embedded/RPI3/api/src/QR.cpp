#include "QR.h"

// QR 인식을 위한 장치 초기 설정
char device[] = "/dev/ttyAMA0";
char buffer[256];
int fd;
// MQTT 통신을 위한 초기 설정
const std::string broker_ip = "tcp://k9a310.p.ssafy.io:4883";
const std::string client_id = "rpi3";
const std::string topic = "IoT";

namespace prg {
void QR::init() {  // fd = open(device, O_RDONLY);
  return;
}
std::string QR::read_data() {
  fd = open(device, O_RDONLY);
  std::string res = "";
  while (true) {
    std::cout << "Read QR: ";
    std::getline(std::cin, res);

    std::cout << res << '\n';
    return res;
  }
}

void QR::send_data(const std::string& data) {
  std::cout << "1\n";
  MQTTClient client;
  MQTTClient_connectOptions conn_opts = MQTTClient_connectOptions_initializer;
  MQTTClient_message pubmsg = MQTTClient_message_initializer;
  MQTTClient_deliveryToken token;
  int rc;

  // MQTT 클라이언트 초기화
  if ((rc = MQTTClient_create(&client, broker_ip.c_str(), client_id.c_str(),
                              MQTTCLIENT_PERSISTENCE_NONE, NULL)) !=
      MQTTCLIENT_SUCCESS) {
    std::cerr << "Failed to create client, return code " << rc << std::endl;
    exit(EXIT_FAILURE);
  }
  std::cout << "2\n";
  conn_opts.keepAliveInterval = 20;
  conn_opts.cleansession = 1;

  // MQTT 브로커에 연결
  if ((rc = MQTTClient_connect(client, &conn_opts)) != MQTTCLIENT_SUCCESS) {
    std::cout << "Failed to connect, return code " << rc << std::endl;
    exit(EXIT_FAILURE);
  }
  std::cout << "3\n";
  // 발행할 데이터 설정
  pubmsg.payload = (void*)data.c_str();
  pubmsg.payloadlen = data.length();
  pubmsg.qos = 0;
  pubmsg.retained = 0;

  // 데이터 발행
  if ((rc = MQTTClient_publishMessage(client, topic.c_str(), &pubmsg,
                                      &token)) != MQTTCLIENT_SUCCESS) {
    std::cout << "Failed to publish message, return code " << rc << std::endl;
    exit(EXIT_FAILURE);
  }
  std::cout << "4\n";
  std::cout << "Message sent to topic: " << topic << std::endl;

  // MQTT 브로커와 연결 해제
  if ((rc = MQTTClient_disconnect(client, 10000)) != MQTTCLIENT_SUCCESS)
    std::cout << "Failed to disconnect, return code " << rc << std::endl;

  MQTTClient_destroy(&client);
}

}  // namespace prg