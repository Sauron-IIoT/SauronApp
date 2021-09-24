import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() =>
      _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  double initialPercentage = 0.15;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DraggableScrollableSheet(
        minChildSize: initialPercentage,
        initialChildSize: initialPercentage,
        builder: (context, scrollController) {
          return AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              double percentage = initialPercentage;
              if (scrollController.hasClients) {
                percentage = (scrollController.position.viewportDimension) /
                    (MediaQuery.of(context).size.height);
              }
              double scaledPercentage =
                  (percentage - initialPercentage) / (1 - initialPercentage);
              return Container(
                padding: const EdgeInsets.only(left: 32),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(153, 28, 209, 1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: percentage == 1 ? 1 : 0,
                      child: ListView.builder(
                        padding: EdgeInsets.only(right: 32, top: 128, bottom: 30),
                        controller: scrollController,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          Incident event = events[index % 3];
                          return IncidentItem(
                            event: event,
                            percentageCompleted: percentage,
                          );
                        },
                      ),
                    ),
                    ...events.map((event) {
                      int index = events.indexOf(event);
                      int heightPerElement = 120 + 8 + 8;
                      double widthPerElement =
                          40 + percentage * 80 + 8 * (1 - percentage);
                      double leftOffset = widthPerElement *
                          (index > 4 ? index + 2 : index) *
                          (1 - scaledPercentage);
                      return Positioned(
                        top: 44.0 +
                            scaledPercentage * (128 - 44) +
                            index * heightPerElement * scaledPercentage,
                        left: leftOffset,
                        right: 32 - leftOffset,
                        child: IgnorePointer(
                          ignoring: true,
                          child: Opacity(
                            opacity: percentage == 1 ? 0 : 1,
                            child: IncidentItem(
                              event: event,
                              percentageCompleted: percentage,
                            ),
                          ),
                        ),
                      );
                    }),
                    SheetHeader(
                      fontSize: 14 + percentage * 8,
                      topMargin:
                          16 + percentage * MediaQuery.of(context).padding.top,
                    ),
                    MenuButton(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class IncidentItem extends StatelessWidget {
  final Incident event;
  final double percentageCompleted;

  const IncidentItem({Key? key, required this.event,required  this.percentageCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
      child: Transform.scale(
        alignment: Alignment.topLeft,
        scale: 1 / 3 + 2 / 3 * percentageCompleted,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(255, 255, 255, max(0, percentageCompleted * 2 - 1))
            ),
            borderRadius: BorderRadius.all(Radius.circular(18))
          ),
          child: SizedBox(
            height: 110,
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(16),
                    right: Radius.circular(16 * (1 - percentageCompleted)),
                  ),
                  child: Image.asset(
                    'assets/images/${event.assetName}',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Opacity(
                    opacity: max(0, percentageCompleted * 2 - 1),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                        top: 8, 
                        left: 18,
                        bottom: 8
                      ),
                      child: _buildContent(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Text(event.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              'Peça: Bomba de Agua',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: <Widget>[
            Text(
              'Esteira: 3',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: <Widget>[
            Icon(Icons.calendar_today, color: Colors.grey.shade400, size: 16),
            SizedBox(width: 5,),
            Text(
              '2021-09-02 14:50',
              style: TextStyle(color: Colors.black, fontSize: 13),
            )
          ],
        )
      ],
    );
  }
}

final List<Incident> events = [
  Incident('warning.png', 'Peça furtada 1', '4.20-30'),
  Incident('warning.png', 'Peça furtada 2 ', '4.20-30'),
  Incident('warning.png', 'Peça incorreta 3', '4.28-31'),
  Incident('warning.png', 'Peça furtada', '4.20-30'),
  Incident('warning.png', 'Peça furtada', '4.20-30'),
  Incident('warning.png', 'Peça incorreta', '4.28-31'),
  Incident('warning.png', 'Peça furtada', '4.20-30'),
  Incident('warning.png', 'Peça furtada', '4.20-30'),
  Incident('warning.png', 'Peça incorreta', '4.28-31'),
  Incident('warning.png', 'Peça furtada', '4.20-30'),
];

class Incident {
  final String assetName;
  final String title;
  final String date;

  Incident(this.assetName, this.title, this.date);
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {Key? key, required this.fontSize, required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 32,
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.only(top: topMargin, bottom: 12),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(153, 28, 209, 1),
          ),
          child: Text(
            'Incidentes',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 15,
      child: Icon(
        Icons.arrow_upward,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}