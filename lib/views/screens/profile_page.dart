import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/data/models/user.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/navigation_tray.dart';

class ProfilePage extends StatefulWidget {
  final User? user;
  ProfilePage({
    this.user,
  });
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime? _birthday;
  late final TextEditingController _dateController;
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.user != null ? widget.user?.name : '');

    _locationController = TextEditingController(
        text: widget.user != null ? widget.user?.location : '');

    _dateController = TextEditingController(
        text: (widget.user != null && widget.user?.birthDate != null)
            ? DateFormat.yMMMMd('en_US')
                .format(widget.user?.birthDate as DateTime)
            : '');
  }

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state is UserLoadSuccess
                        ? S.of(context).pageProfileHeader
                        : S.of(context).pageProfileHeaderGuest,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: S.of(context).pageProfileNameLabel,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: S.of(context).pageProfileLocationLabel),
                        controller: _locationController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText:
                                  S.of(context).pageProfileDateOfBirthLabel,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var date = await showDatePicker(
                                context: context,
                                initialDate: (state is UserLoadSuccess)
                                    ? state.user.birthDate ?? DateTime(1992)
                                    : DateTime(1992),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );

                              setState(() {
                                _birthday = date;
                              });

                              _dateController.text = (date != null)
                                  ? DateFormat.yMMMMd('en_US').format(date)
                                  : '';
                            },
                            child: Container(
                              height: 70,
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (state is UserLoadSuccess) {
                                      context.read<UserBloc>().add(UserUpdated(
                                          name: _nameController.text.isNotEmpty
                                              ? _nameController.text
                                              : null,
                                          location: _locationController
                                                  .text.isNotEmpty
                                              ? _locationController.text
                                              : null,
                                          birthdate: _birthday));
                                    } else {
                                      context.read<UserBloc>().add(UserCreated(
                                          name: _nameController.text,
                                          location: _locationController.text,
                                          birthdate: _birthday));
                                    }
                                  },
                                  child: (state is UserLoadSuccess)
                                      ? Text(
                                          S.of(context).pageProfileSaveButton)
                                      : Text(S
                                          .of(context)
                                          .pageProfileCreateButton))),
                        ],
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: NavigationTray(),
    );
  }
}
