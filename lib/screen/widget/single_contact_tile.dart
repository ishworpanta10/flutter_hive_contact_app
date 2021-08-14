import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact_model.dart';
import '../../services/hive_services_for_contact_model.dart';

class SingleContactTile extends StatefulWidget {
  const SingleContactTile({Key? key, required this.contact}) : super(key: key);
  final ContactModel contact;

  @override
  _SingleContactTileState createState() => _SingleContactTileState();
}

class _SingleContactTileState extends State<SingleContactTile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.contact.name;
    _phoneController.text = widget.contact.phone.toString();
    _emailController.text = widget.contact.email ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(widget.contact.name),
          ),
          // subtitle: contact.email!.isEmpty ? null : Text(contact.email!),
          // isThreeLine: true,
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.contact.phone.toString()),
                if (widget.contact.email != null) Text(widget.contact.email!),
              ],
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              widget.contact.isFavourite ? Icons.favorite : Icons.favorite_border,
              color: widget.contact.isFavourite ? Colors.red : null,
              size: widget.contact.isFavourite ? 30 : 25,
            ),
          ),
          onTap: () {
            _launchURL("tel:${widget.contact.phone}");
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => _showEditAlert(context, widget.contact),
            );
          },
        ),
      ),
    );
  }

  AlertDialog _showEditAlert(BuildContext context, contact) {
    return AlertDialog(
      title: const Text("Edit Contact"),
      content: StatefulBuilder(
        builder: (context, setState) => Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  return value!.trim().isEmpty ? "Name cannot be empty" : null;
                },
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "name",
                ),
              ),
              TextFormField(
                // initialValue: widget.contact.email,
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "email",
                ),
              ),
              TextFormField(
                // initialValue: widget.contact.phone.toString(),
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "phone",
                ),
                validator: (value) {
                  return value!.trim().isEmpty || int.parse(value).isNaN ? "Invalid phone number" : null;
                },
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Is Favourite'),
                value: widget.contact.isFavourite,
                onChanged: (value) {
                  setState(() {
                    widget.contact.isFavourite = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _updateContact(contact: widget.contact);
            Navigator.pop(context);
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () {
            HiveServiceForContactModel().deleteContact(oldContact: widget.contact);
            Navigator.pop(context);
          },
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  void _updateContact({required ContactModel contact}) {
    // print("Email : ${_emailController.text}");
    if (_formKey.currentState!.validate()) {
      HiveServiceForContactModel().editContact(
        oldContact: widget.contact,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        isFav: widget.contact.isFavourite,
      );
    }
  }

  void clearAllController() {
    _phoneController.clear();
    _nameController.clear();
    _emailController.clear();
  }

  Future<void> _launchURL(String url) async => await canLaunch(url) ? await launch(url) : throw Exception('Could not launch $url');
}
