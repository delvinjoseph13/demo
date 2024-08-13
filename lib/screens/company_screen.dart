import 'package:apidemo/model/company.dart';
import 'package:apidemo/screens/createCompany.dart';
import 'package:apidemo/service/company_service.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("company"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CompanyService().getAllCompany(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error occured"),
            );
          }
          if (snapshot.hasData) {
            List<Company> data = snapshot.data as List<Company>;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.maxFinite,
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    color: Colors.red,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data[index].companylogo!),
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Text(data[index].comapnyname!),
                                Text(data[index].companyaddress!),
                                Text(data[index].companyaddress!)
                              ],
                            )),
                        Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    bool? isUpdated = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            Createcompany(company: data[index]),
                                      ),
                                    );

                                    if (isUpdated == true) {
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Are you sure you want tot delete "),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await CompanyService()
                                                        .deleteCompany(
                                                            data[index]
                                                                .companyid!);
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Text("yes")),
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text("no")),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isCreated = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Createcompany()),
          );
          if (isCreated == true) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
