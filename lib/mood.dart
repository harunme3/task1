import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:task1/colorconstant.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task1/moodapi.dart';

class Mood extends StatefulWidget {
  const Mood({super.key});

  @override
  State<Mood> createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  late Future<List<MoodData>> futureMoodData;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    futureMoodData = MoodAPI.mgetchardata();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: Icon(Icons.arrow_back),
        title: Text(
          'Xcellence PVT LTD Company,Lucknow',
          style: TextStyle(
            fontSize: msmallfontsize,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<MoodData>>(
        future: futureMoodData,
        builder:
            (BuildContext context, AsyncSnapshot<List<MoodData>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(color: myellow),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasData) {
                List<MoodData> data = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Header(),
                      MoodCard(size: size),
                      Divider(
                        thickness: 2.0,
                        color: Colors.grey,
                      ),
                      TeamMood(),
                      TeamMoodCard(size: size),
                      LineChartHeader(),
                      LineChart(tooltipBehavior: _tooltipBehavior, data: data),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(color: myellow),
                );
              }
          }
        },
      ),
    );
  }
}

class LineChart extends StatelessWidget {
  const LineChart({
    super.key,
    required TooltipBehavior tooltipBehavior,
    required this.data,
  }) : _tooltipBehavior = tooltipBehavior;

  final List<MoodData> data;

  final TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<MoodData, DateTime>(
            name: 'emoji_point',
            dataSource: data,
            xValueMapper: (MoodData moodData, _) => moodData.date,
            yValueMapper: (MoodData moodData, _) => moodData.emoji_point,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            enableTooltip: true,
            color: Colors.green,
            width: 4.0,
          )
        ],
        primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          intervalType: DateTimeIntervalType.days,
          dateFormat: DateFormat.yMd(),
          labelRotation: -45,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          interval: 1,
          maximum: 5,
          minimum: 1,
        ),
      ),
    );
  }
}

class LineChartHeader extends StatelessWidget {
  const LineChartHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: mdefaultpadding),
      child: Row(
        children: const [
          AnimatedEmoji(
            AnimatedEmojis.halo,
            size: miconsize,
            repeat: true,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: mdefaultpadding,
            ),
            child: Text(
              'Moodalytics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          Spacer(),
          Text(
            '(Trend chart on Mood)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

class TeamMoodCard extends StatelessWidget {
  const TeamMoodCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: mdefaultpadding),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            border: Border.all(color: myellow, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: TextSpan(
                children: const [
                  TextSpan(
                    text: "“",
                    style: TextStyle(
                        fontSize: mfontsize,
                        fontWeight: FontWeight.bold,
                        color: myellow),
                  ),
                  TextSpan(
                    text: ' The team is feeling good\n   today',
                    style: TextStyle(
                      fontSize: mfontsize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '                                ”',
                    style: TextStyle(
                        fontSize: mfontsize,
                        fontWeight: FontWeight.bold,
                        color: myellow),
                  ),
                ],
              )),
            ),
            AnimatedEmoji(
              AnimatedEmojis.halo,
              size: miconsize,
              repeat: true,
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMood extends StatelessWidget {
  const TeamMood({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: mdefaultpadding),
      child: Row(
        children: [
          SizedBox(
            height: 36,
            width: 36,
            child: Image.asset(
              'assets/img/speedometer.png',
              color: myellow,
            ),
          ),
          Text(
            '  Team Mood  ',
            style: TextStyle(
              color: Colors.white,
              fontSize: mfontsize,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 2.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class MoodCard extends StatelessWidget {
  const MoodCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: mdefaultpadding,
      ),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            border: Border.all(color: myellow, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: TextSpan(
                children: const [
                  TextSpan(
                    text: "How's the ",
                    style: TextStyle(
                      fontSize: mfontsize,
                    ),
                  ),
                  TextSpan(
                    text: 'Mood\n',
                    style: TextStyle(fontSize: mfontsize, color: myellow),
                  ),
                  TextSpan(
                    text: 'Today',
                    style: TextStyle(
                      fontSize: mfontsize,
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: mdefaultpadding,
                bottom: mdefaultpadding * 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  AnimatedEmoji(
                    AnimatedEmojis.smileWithBigEyes,
                    size: miconsize,
                    repeat: true,
                  ),
                  AnimatedEmoji(
                    AnimatedEmojis.halo,
                    size: miconsize,
                    repeat: true,
                  ),
                  AnimatedEmoji(
                    AnimatedEmojis.neutralFace,
                    size: miconsize,
                    repeat: true,
                  ),
                  AnimatedEmoji(
                    AnimatedEmojis.pensive,
                    size: miconsize,
                    repeat: true,
                  ),
                  AnimatedEmoji(
                    AnimatedEmojis.rage,
                    size: miconsize,
                    repeat: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: mdefaultpadding),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.0,
            backgroundImage: AssetImage('assets/img/profile.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Alok Maurya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mfontsize,
                  ),
                ),
                Text(
                  'Developer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: msmallfontsize,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
