import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'cartmodel.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown Demo";
  @override
  DropDownState createState() => DropDownState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Phones'),
      Company(2, 'Accessories'),
      Company(3, 'Electronics'),
    ];
  }

  static List<Product> getProducts() {
    List<Product> _products = [
      Product(
          id: 1,
          title: "Laptop",
          price: 30000,
          imgUrl: "https://img.icons8.com/dusk/64/000000/laptop.png",
          qty: 1),
      Product(
          id: 2,
          title: "Pendrive",
          price: 400,
          imgUrl:
          "https://img.icons8.com/doodle/96/000000/usb-memory-stick--v1.png",
          qty: 1),
      Product(
          id: 3,
          title: "Orange",
          price: 20,
          imgUrl: "https://img.icons8.com/cotton/2x/orange.png",
          qty: 1),
      Product(
          id: 4,
          title: "Melon",
          price: 40,
          imgUrl: "https://img.icons8.com/cotton/2x/watermelon.png",
          qty: 1),
      Product(
          id: 5,
          title: "Earphones",
          price: 1000,
          imgUrl: "https://img.icons8.com/nolan/96/earbud-headphones.png",
          qty: 1),
    ];
    return _products;
  }
}

class DropDownState extends State<DropDown> {
  //
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  List<Product> _products = Company.getProducts();



  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.indigo[50],
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Filter"),
              ),
              DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    return ScopedModelDescendant<CartModel>(
                        builder: (context, child, model) {
                          return Card(
                              child: Column(children: <Widget>[
                                Image.network(
                                  _products[index].imgUrl,
                                  height: 120,
                                  width: 120,
                                ),
                                Text(
                                  _products[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("\₹" + _products[index].price.toString()),
                                OutlineButton(
                                    child: Text("Add"),
                                    onPressed: () => model.addProduct(_products[index]))
                              ]));
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
