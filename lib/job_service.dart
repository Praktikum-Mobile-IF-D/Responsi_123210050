import 'dart:convert';
import 'package:http/http.dart' as http;

class Job {
  final String jobTitle;
  final String companyName;

  Job({
    required this.jobTitle,
    required this.companyName
});

  // factory Job.fromJson(Map<String, dynamic> json) {
  //   return Job{
  //     jobTitle: json['jobs']['jobTitle'],
  //     copanyName: json['jobs']['companyName'],
  //   };
  // }

  Map<String, dynamic> toJson() {
    return {
      'jobs': {
        'jobTitle': jobTitle,
        'companyName': companyName
      }
    };
  }
}

// class JobService {
//   static Future<List<Job>> getJobs() async {
//     final response = await http.get(Uri.parse('https://jobicy.com/api/v2/remote-jobs'));
//
//     if(response.statusCode == 200) {
//       List<dynamic> json = jsonDecode(response.body);
//       return json.map((e) => Job.fromJson(e)).toList();
//     }else {
//       throw Exception('Failed to load job');
//     }
//   }
// }