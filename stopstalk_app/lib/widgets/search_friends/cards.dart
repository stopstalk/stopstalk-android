import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: null,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.grey,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            /* color: Color(0xfafafa).withOpacity(1), */
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        color: Colors.indigo.shade50,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            /* '$name', */
                            '@manav',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 25,
                              height: 1.8,
                              letterSpacing: .3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.school,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  /* institute, */
                                  'Indian Intitiute Of Technology Jodhpur',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    //fontFamily: 'Oswald',
                                    fontSize: 15,
                                    height: 1.8,
                                    letterSpacing: .3,
                                    //color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //),
        );
      },
    );
  }
}
