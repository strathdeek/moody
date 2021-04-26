import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/views/widgets/navigation_tray.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime? _birthday;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (context.read<UserBloc>().state is UserLoadSuccess) {
      var user = (context.read<UserBloc>().state as UserLoadSuccess).user;
      _nameController.text = user.name;
      _locationController.text = user.location ?? '';
    } else {
      _nameController.text = '';
      _locationController.text = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Moody'),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Profile'),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Location'),
                    controller: _locationController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: GestureDetector(
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
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 30,
                              child: Text(
                                _birthday != null
                                    ? DateFormat.yMMMMd('en_US')
                                        .format(_birthday!)
                                    : (state is UserLoadSuccess)
                                        ? (state.user.birthDate != null)
                                            ? DateFormat.yMMMMd('en_US')
                                                .format(state.user.birthDate!)
                                            : 'Date of birth'
                                        : 'Date of birth',
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
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
                                      location:
                                          _locationController.text.isNotEmpty
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
                                  ? Text('Save')
                                  : Text('Create profile'))),
                    ],
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoadSuccess) {
                        return Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<UserBloc>()
                                          .add(UserDeleted());
                                      setState(() {
                                        _nameController.clear();
                                        _locationController.clear();
                                        _birthday = null;
                                      });
                                    },
                                    child: Text('Delete profile'))),
                          ],
                        );
                      } else {
                        return Row();
                      }
                    },
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
