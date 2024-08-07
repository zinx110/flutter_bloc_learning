import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_app_with_bloc/bloc/counter_bloc.dart';
import 'package:flutter_counter_app_with_bloc/cubit/counter_cubit.dart';

class IncrementDecrementPage extends StatelessWidget {
  const IncrementDecrementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
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
              tooltip: 'decrement',
              child: const Icon(Icons.minimize),
            ),
          ],
        ),
      ),
    );
  }
}
