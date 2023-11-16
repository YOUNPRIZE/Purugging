#include <ArduinoJson.h>
#include <stdio.h>

#include <string>

#include "Check.h"
#include "EspMQTTClient.h"
#include "Step.h"
#include "time.h"

// 기본 설정
// #define BROCKERIP "192.168.84.21"  // MQTT Broker server IP
#define BROCKERIP "k9a310.p.ssafy.io"
#define WIFINAME "s23+"    // WiFi name
#define WIFIPW "exur1440"  // WiFi password
#define USRNAME "ESP32"    // MQTT User name
#define USRPW "1234"       // MQTT User password
#define PORT 4883          // The MQTT port
#define TOPIC "IoT"        // MQTT publish topic

const char* ntp_server = "kr.pool.ntp.org";
const long gmtOffset_sec = 32400;
const int daylightOffset_sec = 0;

// set instance
prg::Step plastic_back_step(32, 33, 25);
prg::Step window_step(26, 27, 14);
prg::Step classify_step(18, 5, 17);

// check instace
prg::Check check;
// plastic and can count, total weight
int plastic_cnt, can_cnt;
float weight;
int flag = 0;
// Define client
EspMQTTClient client(WIFINAME, WIFIPW, BROCKERIP, USRNAME, USRPW, "ESP32",
                     PORT);

void send_status() {
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    // Serial.println("Failed to obtain time");
    return;
  }
  // Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");
  if (timeinfo.tm_hour == 12) {
    int pet = check.get_dist(2);
    int can = check.get_dist(3);
    int trash = check.get_dist(5);
    // int can = 1, trash = 1;
    char buf[400];
    // 이 부분은 하루에 한번만 보내면 되는 부분임
    if (can < 5) {
      sprintf(
          buf,
          R"({"request": "machine", "request-type": "reset", "machine-id": 1})");
    } else {
      sprintf(
          buf,
          R"({"request": "machine", "request-type": "update", "machine-id": 1, "machine-update-request-dto" : { "pet" : %d, "can" : %d, "trash" : %d}})",
          pet, can, trash);
    }
    client.publish(TOPIC, buf);
  }
}

// MQTT subscribe callback
void onConnectionEstablished() {
  client.subscribe("Server", [](const String& payload) {
    ++flag;
    // char message[128];
    int machine_id = -1;
    int member_id = -1;

    StaticJsonDocument<200> doc;
    deserializeJson(doc, payload);
    serializeJson(doc, Serial);
    member_id = doc["member-id"];
    const char* message = doc["message"];
    machine_id = doc["machine-id"];

    if (machine_id != 1) return;
    if (!strcmp(message, "initiation-success")) {
      // give plastic bag
      Serial.println("give plastic bag");
      for (int i = 0; i < 4; ++i) {
        plastic_back_step.set_rotation_angle(310);
        plastic_back_step.set_clockwise(false);
        plastic_back_step.run();
      }
    } else if (!strcmp(message, "termination-success")) {
      // open window
      Serial.println("open window");
      for (int i = 0; i < 1; ++i) {
        window_step.set_rotation_angle(720);
        window_step.set_clockwise(true);
        window_step.run();
      }
      plastic_cnt = 0;
      can_cnt = 0;
      weight = 0.0f;
      Serial.println("reset offset");
      check.offset_init();
    } else if (!strcmp(message, "pending-success")) {
      // close window
      Serial.println("close window");
      for (int i = 0; i < 1; ++i) {
        window_step.set_rotation_angle(720);
        window_step.set_clockwise(false);
        window_step.run();
      }
      weight = check.get_weight();
      if (weight < 0) {
        weight = 0.0f;
      }
      Serial.println(weight, 2);
      char buf[256];
      sprintf(
          buf,
          R"({"request": "plogging", "member-id": %d, "plogging-status": "PLOGGIGNG_COMPLETED", "machine-id": 1, "plogging-update-request-dto": {"generalTrashWeight": %f, "petCount":%d, "canCount": %d}})",
          member_id, weight, plastic_cnt, can_cnt);
      client.publish(TOPIC, buf);
    }
  });
}

void setup() {
  Serial.begin(115200);
  Serial.println("mqtt init");
  client.enableDebuggingMessages();
  client.enableHTTPWebUpdater();
  client.enableOTA();

  Serial.println("rolling system init");
  // initiate rolling system
  plastic_back_step.init();
  window_step.init();
  classify_step.init();
  delay(2000);

  Serial.println("sensing system init");
  // initiate sensing system
  check.timer_init();
  check.roadcell_init();

  // init and get the time  
  configTime(gmtOffset_sec, daylightOffset_sec, ntp_server);
}

void loop() {
  // Serial.println("start");
  client.loop();

  if (check.is_there_trash()) {
    delay(500);
    if (check.classify_trash() == prg::Trashs::Can) {
      ++can_cnt;
      for (int i = 0; i < 1; ++i) {
        classify_step.set_rotation_angle(180);
        classify_step.set_clockwise(false);
        classify_step.run();
        delay(1000);
        classify_step.set_rotation_angle(180);
        classify_step.set_clockwise(true);
        classify_step.run();
      }
    } else {
      ++plastic_cnt;
      for (int i = 0; i < 1; ++i) {
        classify_step.set_rotation_angle(180);
        classify_step.set_clockwise(true);
        classify_step.run();
        delay(1000);
        classify_step.set_rotation_angle(175);
        classify_step.set_clockwise(false);
        classify_step.run();
      }
    }
  }
  send_status();
}
