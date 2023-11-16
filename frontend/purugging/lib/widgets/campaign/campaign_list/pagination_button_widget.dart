import 'package:flutter/material.dart';
import 'package:purugging/widgets/shared/elevated_button_widget.dart';

class PaginationButtonWidget extends StatelessWidget {
  const PaginationButtonWidget({
    super.key, 
    required this.page, 
    required this.maxPage, 
    required this.handlePage
  });

  final int page;
  final int maxPage;
  final Function handlePage;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 이전 페이지 이동
        Flexible(
            flex: 1,
            child: ElevatedButtonWidget(
              txtSize: 14,
              title: "<",
              handleFunc: () => handlePage(page - 1),
              color: Colors.green,
            )),
        const SizedBox(
          width: 5,
        ),
        // 왼쪽 끝
        page - 2 > 0
            ? Flexible(
                flex: 1,
                child: ElevatedButtonWidget(
                  txtSize: 14,
                  title: "${page - 2}",
                  handleFunc: () => handlePage(page - 2),
                  color: Colors.white,
                  textColor: Colors.black,
                ))
            : const SizedBox(
                width: 0,
              ),
        SizedBox(
          width: page - 2 > 0 ? 5 : 0,
        ),
        // 왼쪽
        page - 1 > 0
            ? Flexible(
                flex: 1,
                child: ElevatedButtonWidget(
                  txtSize: 14,
                  title: "${page - 1}",
                  handleFunc: () => handlePage(page - 1),
                  color: Colors.white,
                  textColor: Colors.black,
                ))
            : const SizedBox(
                width: 0,
              ),
        SizedBox(
          width: page - 1 > 0 ? 5 : 0,
        ),
        // 현재 페이지
        Flexible(
            flex: 1,
            child: ElevatedButtonWidget(
                txtSize: 14, title: "$page", handleFunc: () {})),
        const SizedBox(
          width: 5,
        ),
        // 오른쪽
        page + 1 <= maxPage?
        Flexible(
            flex: 1,
            child: ElevatedButtonWidget(
              txtSize: 14,
              title: "${page + 1}",
              handleFunc: () => handlePage(page + 1),
              color: Colors.white,
              textColor: Colors.black,
            )):
            const SizedBox(
                width: 0,
              ),
        SizedBox(
          width: page + 1 <= maxPage? 5 : 0,
        ),
        // 오른쪽 끝
        page + 2 <= maxPage?
        Flexible(
            flex: 1,
            child: ElevatedButtonWidget(
              txtSize: 14,
              title: "${page + 2}",
              handleFunc: () => handlePage(page + 2),
              color: Colors.white,
              textColor: Colors.black,
            )):
            const SizedBox(
                width: 0,
            ),
        SizedBox(
          width: page + 2 <= maxPage? 5 : 0,
        ),
        // 다음 페이지 이동
        Flexible(
            flex: 1,
            child: ElevatedButtonWidget(
              txtSize: 14,
              title: ">",
              handleFunc: () => handlePage(page + 1),
              color: Colors.green,
            )),
      ],
    );
  }
}