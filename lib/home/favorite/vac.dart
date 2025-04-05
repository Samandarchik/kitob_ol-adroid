// import 'package:flutter/material.dart';
// import 'package:kitob_ol/home/favorite/model.dart';

// class VacancyListPage extends StatefulWidget {
//   @override
//   _VacancyListPageState createState() => _VacancyListPageState();
// }

// class _VacancyListPageState extends State<VacancyListPage> {
//   late Future<List<Vacancy>> _vacancies;

//   @override
//   void initState() {
//     super.initState();
//     _vacancies = VacancyService().fetchVacancies('YOUR_TOKEN_HERE');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vacancies List'),
//       ),
//       body: FutureBuilder<List<Vacancy>>(
//         future: _vacancies,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No vacancies available.'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final vacancy = snapshot.data![index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(vacancy.publisherImage),
//                     ),
//                     title: Text(vacancy.vacancyTitle),
//                     subtitle: Text(
//                       '${vacancy.vacancyCityName} - ${vacancy.salaryFrom} to ${vacancy.salaryTo} UZS',
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Vacancy detail page navigation
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               VacancyDetailPage(vacancy: vacancy),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class VacancyDetailPage extends StatelessWidget {
//   final Vacancy vacancy;

//   const VacancyDetailPage({required this.vacancy});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(vacancy.vacancyTitle)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Publisher: ${vacancy.vacancyPublisherName}',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Description: ${vacancy.vacancyDescription}'),
//             SizedBox(height: 8),
//             Text('Salary: ${vacancy.salaryFrom} to ${vacancy.salaryTo} UZS'),
//             SizedBox(height: 8),
//             Text(
//                 'Location: ${vacancy.vacancyCityName} - ${vacancy.vacancyDistrictName}'),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Back'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
