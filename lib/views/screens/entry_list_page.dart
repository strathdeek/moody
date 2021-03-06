import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/mood_list_entry.dart';

class EntryListPage extends StatefulWidget {
  @override
  _EntryListPageState createState() => _EntryListPageState();
}

class _EntryListPageState extends State<EntryListPage> {
  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.of(context).pushNamed(SettingsPageRoute))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Expanding SliverAppBar to enable one handed use on big smartphones.
          SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            snap: false,
            pinned: true,
            floating: false,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.headline4?.color,
                  ),
                  onPressed: () {
                    setState(() {
                      _date = DateTime(_date.year, _date.month - 1);
                    });
                  },
                ),
                Text(
                  DateFormat.yMMMM(S.of(context).localeKey).format(_date),
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).textTheme.headline4?.color ??
                        Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _date = DateTime(_date.year, _date.month + 1);
                    });
                  },
                ),
              ],
            ),
          ),

          BlocBuilder<MoodBloc, MoodState>(
            builder: (context, state) {
              if (state is MoodLoadSuccess) {
                var tiles = <Widget>[];
                state.moodEntries.sort((a, b) => b.date.compareTo(a.date));
                for (var mood in state.moodEntries.where((element) =>
                    element.date.month == _date.month &&
                    element.date.year == _date.year)) {
                  tiles.add(
                    ListTile(
                      title: MoodListEntry(mood: mood),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildListDelegate(tiles),
                );
              } else {
                return SliverToBoxAdapter(
                    child: Text(S.of(context).pageEntryListNoData));
              }
            },
          ),
        ],
      ),
    );
  }
}
