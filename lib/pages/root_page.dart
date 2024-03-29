import 'package:flutter/material.dart';
import 'package:practice_refactoring/l10n/messages.dart';
import 'package:practice_refactoring/components/app_bar_actions.dart';
import 'package:practice_refactoring/utils/app_navigators.dart';
import 'package:practice_refactoring/utils/categories.dart';

class RootPage extends StatefulWidget {

  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _commentList = List<String>();
  String _userName;

  void _push(Categories category) async {
    final arg = category ==
      Categories.edit_name ? _userName
      : null;
    final result = await AppNavigators.push(context, category, arg: arg);
    if (result == null) return;
    switch (category) {
      case Categories.edit_name:
        setState(() {
          _userName = result is String
            ? result
            : null;
        });
        return;
      default:
        return;
    }
  }
  Widget _buildAppBar() {
    return AppBar(
      title: Text(Messages.of(context).title),
      actions: AppBarActions.root(
        context,
        onSelected: (Categories category) => _push(category),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _commentList.length,
      itemBuilder: (BuildContext context, int position) {
        return Text(_commentList[position]);
      },
    );
  }

  Widget _buildMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Messages.of(context).helloUser(_userName),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          Text(Messages.of(context).pleaseAddAnyComments),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return _commentList.length > 0
      ? _buildListView()
      : _buildMessage();
  }

  Widget _buildActionButton() {
    return FloatingActionButton(
      onPressed: () => _push(Categories.add_comment),
      tooltip: 'Add a Comment',
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildActionButton(),
    );
  }
}
