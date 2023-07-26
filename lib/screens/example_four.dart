import 'package:flutter/material.dart';

class People {
  final String name;
  final String age;
  final String emoji;

  const People({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

List<People> people = const [
  People(name: 'ahmed', age: '23', emoji: '🙋‍♂️'),
  People(name: 'ali', age: '20', emoji: '👮‍♂️'),
  People(name: 'mohamed', age: '26', emoji: '🧑'),
];

class Example4 extends StatelessWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Hero Animation'),
        ),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsView(
                    people: people[index],
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(people[index].name),
              subtitle: Text(people[index].age),
              leading: Hero(
                tag: people[index].emoji,
                flightShuttleBuilder: (
                  flightContext,
                  animation,
                  flightDirection,
                  fromHeroContext,
                  toHeroContext,
                ) {
                  switch (flightDirection) {
                    case HeroFlightDirection.push:
                      return Material(
                        color: Colors.transparent,
                        child: ScaleTransition(
                          scale: animation.drive(
                            Tween<double>(begin: 0, end: 1).chain(
                              CurveTween(
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: toHeroContext.widget,
                        ),
                      );
                    case HeroFlightDirection.pop:
                      return Material(
                        color: Colors.transparent,
                        child: fromHeroContext.widget,
                      );
                  }
                },
                child: Text(
                  people[index].emoji,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.people});
  final People people;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: people.emoji,
          child: Text(
            people.emoji,
            style: const TextStyle(
              fontSize: 50,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(people.name),
            Text(people.age),
          ],
        ),
      ),
    );
  }
}
