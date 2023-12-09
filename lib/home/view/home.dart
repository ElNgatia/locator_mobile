
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:locator_mobile/data/model/user.dart';
import 'package:locator_mobile/home/cubit/home_cubit.dart';
import 'package:locator_mobile/map/map.dart';
import 'package:locator_mobile/profile/view/profile.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchUsers(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: _HomeBody(),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoadedState) {
          return Stack(
            children: [
              // MapView(
              //   users: state.users,
              // ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: _UserCard(users: state.users),
                ),
              ),
            ],
          );
        } else if (state is ErrorState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Container(); // Placeholder widget when state is not recognized
        }
      },
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    final paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 165, 235, 49)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final path_0 = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.08, size.width, 0)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.9, 0, size.height)
      ..cubicTo(0, size.height * 0.79, 0, size.height * 0.625, 0, 0)
      ..close();

    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return users.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 250),
                  painter: RPSCustomPainter(),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          final userId = users[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Builder(
                                builder: (BuildContext context) {
                                  return ProfilePage(userId: userId);
                                },
                              ),
                            ),
                          );
                        },
                        child: FutureBuilder<List<Placemark>>(
                          future: placemarkFromCoordinates(
                            double.parse(users[index].currentLat),
                            double.parse(users[index].currentLon),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error fetching location');
                            } else if (snapshot.hasData) {
                              final placemarks = snapshot.data!;
                              final address = placemarks.isNotEmpty
                                  ? placemarks.first.name ?? ''
                                  : 'Unknown';
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(users[index].avatar),
                                  ),
                                  title: Text(users[index].name),
                                  subtitle: Text('Location: $address'),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
