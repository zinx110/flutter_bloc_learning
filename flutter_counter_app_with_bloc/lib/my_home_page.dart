import 'package:flutter/material.dart';
import 'package:flutter_counter_app_with_bloc/bloc/counter_bloc.dart';
import 'package:flutter_counter_app_with_bloc/cubit/counter_cubit.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_counter_app_with_bloc/increment_decrement_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // final counter = counterCubit.state;
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder(
                bloc: counterCubit,
                builder: (context, counter) {
                  return Text(
                    'cubit : $counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }),
            BlocBuilder<CounterBloc, int>(builder: (context, counter) {
              return Text(
                'bloc : $counter',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // setState(() {
              //   counterCubit.increment();
              // });
              counterCubit.increment();
              counterBloc.add(CounterIncremented());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              counterCubit.decrement();

              counterBloc.add(CounterDecremented());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 213, 161, 224))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const IncrementDecrementPage(),
              ));
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Change Page",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ],
      ),
    );
  }
}
