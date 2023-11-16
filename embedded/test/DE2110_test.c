#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
  int fd;
  char device[] = "/dev/ttyAMA0";  // USB 시리얼 포트 장치 파일 경로
  char buffer[256];                // 문자열을 저장할 버퍼

  // USB 시리얼 포트 열기 (읽기 전용)
  fd = open(device, O_RDONLY);
  if (fd == -1) {
    perror("장치 열기 실패");
    return 1;
  }

  printf("USB에서 데이터 수신 중...\n");

  while (1) {
    ssize_t bytesRead = read(fd, buffer, sizeof(buffer));

    if (bytesRead == -1) {
      continue;
    } else if (bytesRead == 0) {
      continue;
    }

    // 수신된 데이터를 화면에 출력
    buffer[bytesRead] = '\0';  // 문자열 끝을 표시
    printf("수신된 데이터: %s", buffer);
  }

  close(fd);

  return 0;
}