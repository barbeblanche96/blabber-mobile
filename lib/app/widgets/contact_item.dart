import 'package:blabber_mobile/app/routes/app_pages.dart';
import 'package:blabber_mobile/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactItem extends StatefulWidget{
  final String id;
  final String firstname;
  final String lastname;
  final String? imageUrl;
  final String email;
  ContactItem({super.key, required this.lastname, required this.firstname, required this.imageUrl, required this.email, required this.id});
  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.CHAT_DETAIL, arguments: {'userId' : widget.id, 'name': widget.firstname+' '+widget.lastname, 'imageUrl': widget.imageUrl});
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  widget.imageUrl != null ? CircleAvatar(
                    backgroundImage: NetworkImage(Constants.BASE_URL+widget.imageUrl!),
                    maxRadius: 30,
                  ) : CircleAvatar(
                    backgroundColor: Colors.pink,
                    maxRadius: 30,
                    child: Text(widget.lastname[0].toUpperCase()+widget.firstname[0].toUpperCase()),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.firstname + " " + widget.lastname, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.email, style: TextStyle(fontSize: 13,color: Colors.grey.shade600),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}