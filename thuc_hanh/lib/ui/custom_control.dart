import 'package:flutter/material.dart';
import 'package:thuc_hanh/models/lop.dart';
import 'package:thuc_hanh/models/place.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/ui/AppConstant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textButton,
    required int size,
  });
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          textButton,
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomAvatarProfile extends StatelessWidget {
  const CustomAvatarProfile({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.25),
      child: Container(
        width: 100,
        height: 100,
        child: Image.network(
          Profile().user.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController textController,
    required this.hintText,
    required this.obscureText,
  }) : _textController = textController;

  final TextEditingController _textController;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white)),
      child: TextField(
        obscureText: obscureText,
        controller: _textController,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }
}

class Applogo extends StatelessWidget {
  const Applogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.account_circle,
      size: 150,
      color: Colors.white,
    );
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white.withOpacity(0.5),
      child: const Center(
        child: Image(
          width: 100,
          image: AssetImage('assets/images/load.gif'),
        ),
      ),
    );
  }
}

class CustomInputTextFromField extends StatefulWidget {
  const CustomInputTextFromField({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
    this.type = TextInputType.text,
  });

  final double width;
  final String title;
  final String value;
  final TextInputType type;
  final Function(String output) callback;
  @override
  State<CustomInputTextFromField> createState() =>
      _CustomInputTextFromFieldState();
}

class _CustomInputTextFromFieldState extends State<CustomInputTextFromField> {
  int status = 0;
  String output = "";

  @override
  void initState() {
    output = widget.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.value == "" ? "không có" : widget.value,
                    style: AppConstant.textbody,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      width: widget.width - 60,
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        initialValue: output,
                        onChanged: (value) {
                          setState(() {
                            output = value;
                            widget.callback(output);
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          status = 0;
                          widget.callback(output);
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.save,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  const CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.callback,
    required this.list,
    required this.valueName,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Lop> list;

  final Function(int ouputId, String outputName) callback;
  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    outputId = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    outputName == "" ? "không có" : outputName,
                    style: AppConstant.textbody,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]),
                  width: widget.width - 25,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton(
                      value: outputId,
                      items: widget.list
                          .map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Container(
                                width: widget.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                child: Text(
                                  e.ten,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          outputId = value!;
                          for (var dropitem in widget.list) {
                            if (dropitem.id == outputId) {
                              outputName = dropitem.ten;
                              widget.callback(outputId, outputName);
                              break;
                            }
                          }
                          status = 0;
                        });
                      },
                    ),
                  ),
                ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class CustomPlaceDropDown extends StatefulWidget {
  const CustomPlaceDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.valueName,
    required this.callback,
    required this.list,
  });

  final double width;
  final String title;
  final int valueId;
  final String valueName;
  final List<Place> list;
  final Function(int outputId, String outputName) callback;

  @override
  State<CustomPlaceDropDown> createState() => _CustomPlaceDropDownState();
}

class _CustomPlaceDropDownState extends State<CustomPlaceDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    outputId = widget.valueId;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.valueName == "" ? "Không có" : widget.valueName,
                    style: AppConstant.textbody,
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  width: widget.width,
                  child: DropdownButton(
                    value: widget.valueId,
                    items: widget.list
                        .map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Container(
                                width: widget.width - 50,
                                child: Text(
                                  e.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppConstant.textbody,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        outputId = value!;
                        for (var dropItem in widget.list) {
                          if (dropItem.id == outputId) {
                            outputName = dropItem.name;
                            widget.callback(outputId, outputName);
                            break;
                          }
                        }
                        status = 0;
                      });
                    },
                  )),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final Dssv data;

  const StudentCard({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 253, 244, 161),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.mssv,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              data.first_name,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 109, 3, 3),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
