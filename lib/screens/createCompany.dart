import 'package:apidemo/model/company.dart';
import 'package:apidemo/service/company_service.dart';
import 'package:flutter/material.dart';

class Createcompany extends StatefulWidget {
  final Company? company;
  const Createcompany({super.key,this.company});

  @override
  State<Createcompany> createState() => _CreatecompanyState();
}

class _CreatecompanyState extends State<Createcompany> {
 
   TextEditingController _nameController = TextEditingController();
    TextEditingController _addressController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    GlobalKey<FormState> _key = GlobalKey();

   void initState() {
    if (widget.company != null) {
      _nameController.text = widget.company!.comapnyname!;
      _addressController.text = widget.company!.companyaddress!;
      _phoneController.text = widget.company!.companyphonenumber!;
    }
    super.initState();
  }
    
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("create company"),
      ),
      body: Form(
          key: _key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Enter the name";
                    }
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                      label: Text("name"),
                      helperText: "enter name",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      label: Text("address"),
                      helperText: "enter address",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      label: Text("phonenumber"),
                      helperText: "enter phone number",
                      border: OutlineInputBorder()),
                ),
              ),
              ElevatedButton(
                  onPressed: ()async {
                    if (_key.currentState!.validate()) {
                      Company newCompany = Company(
                          comapnyname: _nameController.text,
                          companyaddress: _addressController.text,
                          companyphonenumber: _phoneController.text,
                          companylogo: "https://logo.clearbit.com/ameblo.jp");

                          if (widget.company != null) {
                          await CompanyService().updateCompany(newCompany, widget.company!.companyid!);
                        } else {
                           CompanyService().createCompany(newCompany);
                        }
                      

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("submited successfully")));

                     Navigator.pop(context, true);
                    }
                  },
                  child: Text("submit"))
            ],
          )),
    );
  }
}
