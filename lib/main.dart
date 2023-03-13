import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 10;
  double? _size = 0.4;
  AnimationController? animationController;
  Animation<double>? tween;

  Map<String, double> dataMap = {
    "Comida": 5,
    "Jogos": 3,
    "Passeios": 2,
    "Transportes": 2,
  };

  final totalDataMap = <String, double>{
    "Gastos": 4750.00,
    "Total": 5000.00,
  };

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    tween = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn));
    animationController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
      body: SafeArea(
        child: ScrollView(deviceInfo),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicial'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendário'),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  // ignore: non_constant_identifier_names
  CustomScrollView ScrollView(MediaQueryData deviceInfo) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xff344055),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: _size != null
                            ? (deviceInfo.size.height * _size!)
                            : (deviceInfo.size.height * .8) - 16,
                      ),
                      child: Material(
                        color: const Color(0xff344055),
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return Column(
                                    children: [
                                      const Divider(
                                        height: 0,
                                      ),
                                      ListTile(
                                        dense: true,
                                        title: Text('Item $index'),
                                        isThreeLine: true,
                                        textColor: Colors.white,
                                        subtitle: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '1$index/03/23',
                                              style: const TextStyle(
                                                color: Color(0xffDFC2F2),
                                              ),
                                            ),
                                            const Text(
                                              'Comida',
                                              style: TextStyle(
                                                color: Color(0xffDFC2F2),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {},
                                        trailing: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.attach_money,
                                              color: Colors.white,
                                            ),
                                            Text('$index' '0,00')
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                childCount: _counter,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(),
                          child: Material(
                            color: const Color(0xff344055),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _size = _size == .4 ? null : .4;
                                });
                              },
                              child: Center(
                                child: _size != .4
                                    ? const Text(
                                        'Ver menos',
                                        style: TextStyle(
                                          color: Color(0xffDFC2F2),
                                        ),
                                      )
                                    : const Text(
                                        'Ver mais',
                                        style: TextStyle(
                                          color: Color(0xffDFC2F2),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color(0xff344055),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PieChart(
                        dataMap: dataMap,
                        animationDuration: const Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: deviceInfo.size.width / 2.5,
                        // colorList: [],
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 30,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesOutside: true,
                          decimalPlaces: 2,
                        ),
                        baseChartColor: const Color(0xff344055),
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'R\$ 00.00',
                                    style: TextStyle(
                                      color: Color(0xff344055),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'R\$ ${totalDataMap["Total"]!.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xff344055),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Container(
                                      color: const Color.fromARGB(
                                          255, 218, 218, 218),
                                      width: constraints.maxWidth,
                                      height: 32,
                                    ),
                                    Container(
                                      color: const Color(0xff344055),
                                      width: (constraints.maxWidth - 16) *
                                          (totalDataMap["Gastos"]! /
                                              totalDataMap["Total"]!),
                                      height: 32,
                                      child: Center(
                                        child: Text(
                                          'R\$ ${totalDataMap["Gastos"]!.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
