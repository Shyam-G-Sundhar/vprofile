import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'dart:js' as js;

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

bool showImage = true;

class _MobileScreenState extends State<MobileScreen> {
  final clr = const Color(0xff0B1F5B);
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'));
    _playbackicon = Icons.play_arrow;
    _initializeVideoPlayer();
  }

  late VideoPlayerController controller;
  late IconData _playbackicon;

  Future<void> _initializeVideoPlayer() async {
    await controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300, // Adjust the value for scrolling distance
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
    );
  }

  void _playPause() {
    if (controller.value.isPlaying) {
      controller.pause();
      _playbackicon = Icons.play_arrow;
    } else {
      controller.play();
      _playbackicon = Icons.pause;
    }
    setState(() {});
  }

  void _openFullScreenDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content:
                Container() //FullScreenVideoWidget(controller: controller),
            );
      },
    ).then((value) {
      setState(() {});
    });
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300, // Adjust the value for scrolling distance
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: clr,
        title: Text(
          'Visual Profile',
          style: GoogleFonts.reemKufi(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 330,
                height: 240,
                decoration: BoxDecoration(
                    color: clr, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Container(
                            width: 230,
                            height: 220,
                            decoration: BoxDecoration(
                              color: showImage ? Colors.white : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Stack(
                                children: [
                                  if (showImage)
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset(
                                        'assets/prf2.jpg',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  else
                                    GestureDetector(
                                      onTap: _playPause,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: controller.value.isInitialized
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: AspectRatio(
                                                      aspectRatio: 14 / 9,
                                                      child: VideoPlayer(
                                                          controller),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      _playbackicon,
                                                      color: Colors.white,
                                                    ),
                                                    iconSize: 25,
                                                    onPressed: _playPause,
                                                  ),
                                                  /*Positioned(
                                                    right: 0,
                                                    child: IconButton(
                                                      icon: Icon(
                                                        _isFullScreen
                                                            ? Icons
                                                                .fullscreen_exit
                                                            : Icons.fullscreen,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed:
                                                          _openFullScreenDialog,
                                                    ),
                                                  ),*/
                                                ],
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: clr,
                                                ),
                                              ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  showImage = true;
                                });
                              },
                              child: Icon(
                                Icons.image,
                                color: clr,
                              ),
                            ),
                            const SizedBox(width: 5),
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  showImage = false;
                                });
                              },
                              child: Icon(
                                Icons.play_arrow,
                                color: clr,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 800,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: Text(
                        'Agenda',
                        style: GoogleFonts.reemKufi(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 301,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Adjusted alignment
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AgendaElem(
                              iconname: Icons.mail,
                              iconsize: 25,
                              icondes: 'shyamgsundhar@gmail.com',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AgendaElem(
                              iconname: Icons.person,
                              iconsize: 25,
                              icondes: 'Male',
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Adjusted alignment
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AgendaElem(
                              iconname: Icons.call,
                              iconsize: 25,
                              icondes: '+91-9080435234',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AgendaElem(
                              iconname: Icons.radio_button_unchecked,
                              iconsize: 25,
                              icondes: 'Single',
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Adjusted alignment
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AgendaElem(
                              iconname: Icons.cake,
                              iconsize: 25,
                              icondes: '07-06-2005',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AgendaElem(
                              iconname: Icons.location_on,
                              iconsize: 25,
                              icondes: 'Erode,Tamilnadu',
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: clr, borderRadius: BorderRadius.circular(20)),
                      width: 500,
                      height: 48,
                      padding: const EdgeInsets.all(5),
                      child: const Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SocialMediaIcons(
                                url: 'www.linkedin.com',
                                imgurl: 'assets/linkedin.png',
                              ),
                              SocialMediaIcons(
                                url: 'www.threads.net',
                                imgurl: 'assets/threads.png',
                              ),
                              SocialMediaIcons(
                                url: 'www.gmail.com',
                                imgurl: 'assets/gmail.png',
                              ),
                              SocialMediaIcons(
                                url:
                                    'www.linkedin.com/in/shyam-sundhar-771a6220a/',
                                imgurl: 'assets/Facebook.png',
                              ),
                              SocialMediaIcons(
                                url: 'www.instagram.com/shyamgsundhar/',
                                imgurl: 'assets/Instagram.png',
                              ),
                              SocialMediaIcons(
                                url: 'www.twitter.com',
                                imgurl: 'assets/TwitterX.png',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 800,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      child: Text(
                        'Profile Info',
                        style: GoogleFonts.reemKufi(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 550,
                    child: Column(
                      children: [
                        ProfileInfo(
                          iconname: Icons.work,
                          clr: clr,
                          icontitle: 'Current Position',
                          icondes: 'Student',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileInfo(
                          iconname: Icons.cast_for_education,
                          clr: clr,
                          icontitle: 'Highest Qualification',
                          icondes: 'Pursuing BE',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileInfo(
                          iconname: Icons.location_city,
                          clr: clr,
                          icontitle: 'Prefered Location',
                          icondes: 'Coimbatore,TN',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileInfo(
                          iconname: Icons.interests,
                          clr: clr,
                          icontitle: 'Area Of Interest',
                          icondes: 'Machine Learning',
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 800,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: Text(
                      'Expertise',
                      style: GoogleFonts.reemKufi(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    child: SizedBox(
                      width: 800,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExpertiseElement(
                            clr: clr,
                            icondesp: 'Skills',
                            countvalue: 1,
                            id: 'Skills',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ExpertiseElement(
                            clr: clr,
                            icondesp: 'Certificates',
                            countvalue: 2,
                            id: 'Cert',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ExpertiseElement(
                            clr: clr,
                            icondesp: 'Project(s)',
                            countvalue: 3,
                            id: 'Projects',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ExpertiseElement(
                            clr: clr,
                            icondesp: 'Acheivements',
                            countvalue: 4,
                            id: 'Acheivements',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ExpertiseElement(
                            clr: clr,
                            icondesp: 'Languages',
                            countvalue: 5,
                            id: 'Languages',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ExpertiseElement(
                            clr: clr,
                            icondesp: 'Hobbies',
                            countvalue: 6,
                            id: 'Hobbies',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ExpertiseElement(
                            clr: clr,
                            icondesp: 'Goals',
                            countvalue: 7,
                            id: 'Goals',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 600,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide()),
                        ),
                        child: Text(
                          'Placement Pie',
                          style: GoogleFonts.reemKufi(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            child: DonutChart(dataValue: 340 / 360),
                          ),
                          Container(
                            width: 300,
                            height: 300,
                            child: HorizontalBarChart(data: {
                              'Sem 1': 100,
                              'Sem 2': 80,
                              'Sem 3': 0,
                              'Sem 4': 0,
                              'Sem 5': 0,
                              'Sem 6': 0,
                              'Sem 7': 0,
                              'Sem 8': 0,
                            }),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgendaElem extends StatefulWidget {
  final icondes;
  final IconData iconname;
  final double iconsize;
  AgendaElem({
    super.key,
    required this.iconname,
    this.icondes,
    required this.iconsize,
  });

  @override
  State<AgendaElem> createState() => _AgendaElemState();
}

class _AgendaElemState extends State<AgendaElem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          widget.iconname,
          size: widget.iconsize,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.icondes,
          style:
              GoogleFonts.reemKufi(fontSize: 15, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class SocialMediaIcons extends StatefulWidget {
  final url, imgurl;
  const SocialMediaIcons({
    super.key,
    this.url,
    this.imgurl,
  });

  @override
  State<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      onPressed: () {
        final url = 'https://${widget.url}'; // Replace with your desired URL
        js.context.callMethod('open', [url, '_blank']);
      },
      icon: Image.asset('${widget.imgurl}'),
    );
  }
}

class ProfileInfo extends StatefulWidget {
  final iconname, icontitle, icondes;
  const ProfileInfo({
    super.key,
    required this.clr,
    required this.iconname,
    this.icontitle,
    this.icondes,
  });

  final Color clr;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        children: [
          Icon(
            widget.iconname,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(
            width: 45,
          ),
          Column(
            children: [
              Text(
                widget.icontitle,
                style: GoogleFonts.reemKufi(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              Text(
                widget.icondes,
                style: GoogleFonts.reemKufi(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: widget.clr),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ExpertiseElement extends StatefulWidget {
  ExpertiseElement(
      {super.key,
      required this.clr,
      this.countvalue,
      this.icondesp,
      required this.id});
  final countvalue, icondesp, id;
  final Color clr;

  @override
  State<ExpertiseElement> createState() => _ExpertiseElementState();
}

class _ExpertiseElementState extends State<ExpertiseElement> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth =
            constraints.maxWidth > 290 ? 299 : constraints.maxWidth;

        return SizedBox(
          width: containerWidth,
          child: Card(
            child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: widget.clr,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Stack(
                          children: [
                            Text(
                              '${widget.countvalue}',
                              style: GoogleFonts.reemKufi(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${widget.icondesp}',
                      style: GoogleFonts.reemKufi(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                children: [
                  if (widget.id == 'Skills')
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExpertiseText(
                            textname: ' * Problem Solving',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Logical Thinking',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Good Communication',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Programming',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Designing',
                          ),
                        ],
                      ),
                    )
                  else if (widget.id == 'Cert')
                    Container(
                      child: Column(
                        children: [
                          CertLink(
                            certname: 'C For Everyone',
                            certurl: 'www.coursera.com',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CertLink(
                            certname: 'Machine Learning With Python',
                            certurl: 'www.coursera.com',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CertLink(
                            certname: 'Flutter with Dart',
                            certurl: 'www.coursera.com',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CertLink(
                            certname: 'Flutter with Fiebase',
                            certurl: 'www.coursera.com',
                          ),
                        ],
                      ),
                    )
                  else if (widget.id == 'Projects')
                    Container(
                      child: Column(
                        children: [
                          ExpertiseText(
                            textname: ' * FitCoin',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Visual Profile',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * EventSync',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * SeatSnap & HallSpot',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * MyNest',
                          ),
                        ],
                      ),
                    )
                  else if (widget.id == 'Acheivements')
                    Container(
                      child: Column(
                        children: [
                          ExpertiseText(
                            textname: ' * First Prize at Startup TN',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Participated at PSG iTech',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Participated at L&T Edutech',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  else if (widget.id == 'Languages')
                    Container(
                      child: Column(
                        children: [
                          ExpertiseText(
                            textname: ' * Tamil',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * English',
                          ),
                        ],
                      ),
                    )
                  else if (widget.id == 'Hobbies')
                    Container(
                      child: Column(
                        children: [
                          ExpertiseText(
                            textname: ' * Coding',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Designing',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  else if (widget.id == 'Goals')
                    Container(
                      child: Column(
                        children: [
                          ExpertiseText(
                            textname: ' * Startup',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ExpertiseText(
                            textname: ' * Challenging Projects',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  else
                    Container()
                ]),
          ),
        );
      },
    );
  }
}

class CertLink extends StatefulWidget {
  const CertLink({
    super.key,
    required this.certname,
    required this.certurl,
  });
  final certname, certurl;
  @override
  State<CertLink> createState() => _CertLinkState();
}

class _CertLinkState extends State<CertLink> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final url =
            'https://${widget.certurl}'; // Replace with your desired URL
        js.context.callMethod('open', [url, '_blank']);
      },
      child: Text(
        widget.certname,
        style: GoogleFonts.reemKufi(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
      ),
    );
  }
}

class ExpertiseText extends StatefulWidget {
  const ExpertiseText({super.key, required this.textname});
  final textname;
  @override
  State<ExpertiseText> createState() => _ExpertiseTextState();
}

class _ExpertiseTextState extends State<ExpertiseText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.textname,
      style: GoogleFonts.reemKufi(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
    );
  }
}

final clr = const Color(0xff0B1F5B);

class HorizontalBarChart extends StatefulWidget {
  final Map<String, double> data;
  const HorizontalBarChart({super.key, required this.data});

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        maxY: widget.data.values
            .reduce((max, value) => value > max ? value : max),
        barGroups: widget.data.entries
            .map((entry) => BarChartGroupData(
                x: widget.data.keys.toList().indexOf(entry.key) + 1,
                barRods: [BarChartRodData(toY: entry.value, color: clr)]))
            .toList()));
  }
}

class DonutChart extends StatefulWidget {
  final double dataValue;

  const DonutChart({super.key, required this.dataValue});

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  final Color clr = const Color(0xff0B1F5B);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: widget.dataValue,
                color: clr,
                titlePositionPercentageOffset: 0.5, // Center the title
                radius: 70, // Adjust the radius thickness
                title: '',
              ),
              PieChartSectionData(
                value: 1 - widget.dataValue,
                color: Colors
                    .transparent, // Transparent to create the donut effect
                title: '',
              ),
            ],
            centerSpaceRadius: 50,
            sectionsSpace: 2,
            borderData: FlBorderData(
              show: true,
            ),
          ),
        ),
        Text(
          '${(widget.dataValue * 360).toInt()}',
          style: GoogleFonts.reemKufi(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
