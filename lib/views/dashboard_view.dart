import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/dashboard/dashboard_cubit.dart';
import 'package:svojasweb/models/customer.dart';
import 'package:svojasweb/views/drawer_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/DashboardView';
  final String title;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<Customer> customers = [];
  @override
  void initState() {
    super.initState();
    GetIt.I<DashboardCubit>().load();
    colors.shuffle();
  }

  List<Color> colors = [
    Colors.blue,
    Colors.amber,
    Colors.pink,
    Colors.blueGrey
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocBuilder<DashboardCubit, DashboardState>(
                bloc: GetIt.I<DashboardCubit>(),
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    );
                  }
                  if (state is DashboardFailed) {
                    return Text(state.errorMessage!);
                  }
                  if (state is DashboardSuccess) {
                    final List<Widget> cards =
                        List<Widget>.generate(10, (index) {
                      return Container(
                        margin: const EdgeInsets.all(18),
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 4 - 60,
                        decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            borderRadius: BorderRadius.circular(14)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(
                              child: Icon(Icons.data_exploration),
                            ),
                            Text(
                              state.statistics!
                                  .toJson()
                                  .values
                                  .toList()[index]
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              state.statistics!.toJson().keys.toList()[index],
                              style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    });

                    return Wrap(children: cards);
                  }
                  return const SizedBox(
                    height: 0,
                  );
                }),
          ),
        ),
      ),
      drawer: const DrawerView(),
    );
  }
}
