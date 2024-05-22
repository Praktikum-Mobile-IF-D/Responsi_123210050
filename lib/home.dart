import 'package:responsid/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsid/user_controller.dart';
import 'package:responsid/hive_database.dart';
import 'package:collection/collection.dart';
import 'package:responsid/job_service.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserController _userController;
  late Future<List<Job>> _jobsFuture;
  late List<int> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _userController = UserController(HiveDatabase.getUserBox());
    _bookmarks = _userController.getUserByUsername(widget.username)?.bookmark ?? [];
    _jobsFuture = JobService.getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<Job>>(
                future: _jobsFuture,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: $snapshot.error'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                     return Center(
                       child: Text('No job found'),
                     );
                  }
                  final jobs = snapshot.data!;

                  return ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                      final job = jobs[index];
                      final isBookmark = _bookmarks.contains(index);
                       return ListTile(
                         title: Text(job.jobTitle),
                       )

                    }
                  );
                },
              )
          )
        ],
      )
    );
  }
}