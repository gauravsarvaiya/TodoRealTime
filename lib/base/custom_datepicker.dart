part of 'base.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime) onDateSelected;

  DatePickerWidget({required this.initialDate, required this.onDateSelected,this.firstDate,this.lastDate});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate;
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 16.sp,
            runSpacing: 16.sp,
            children: List.generate(DateFuncData.dateFuncDataList.length, (index) {
              return dateButton(
                  date:DateFuncData.dateFuncDataList[index].date,
                  text: DateFuncData.dateFuncDataList[index].name,
                  index: index,
              );
            },),
          ),
          SizedBox(height: 10),
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kPrimaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: widget.firstDate ?? DateTime(2000),
              lastDate: widget.lastDate ?? DateTime(2100),
              onDateChanged: _selectDate,
            ),
          ),
          Divider(color: kTextFiledBorderColor,height: 1.sp),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 12.sp,
                  children: [
                    ImageUtil.iconImageClass.calenderIcon,
                    Text(
                      DateFormat("d MMM yyyy").format(selectedDate),
                      style: CustomTextStyle.regularFont16Style,
                    ),
                  ],
                ),
                Row(
                  spacing: 16.sp,
                  children: [
                    CustomAppBtn(
                        onTap: () => Navigator.pop(context),
                        textColor: kPrimaryColor,
                        textName: "Cancel"
                    ),

                    CustomAppBtn(
                        onTap: () {
                          widget.onDateSelected(selectedDate);
                          Navigator.pop(context);
                        },
                        textName: "Save",
                        color: kPrimaryColor
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dateButton({String? text, DateTime? date,required int index}) {
    print("selectIndex ==== ${selectIndex}");
    return  ClipRRect(
      borderRadius: BorderRadius.circular(6.sp),
      child: Material(
        color:selectIndex == index ? kPrimaryColor : kSecondaryColor,
        child: InkWell(
          splashColor: kWhiteColor.withValues(alpha: 0.2),
          onTap: (){
            _selectDate(date!);
            setState(() {
              selectIndex = index;
            });
          },
          child: Container(
            width: 176.sp,
            height: 36.sp,
            decoration: BoxDecoration(
                color: Colors.transparent
            ),
            child: Center(
              child: Text(text ?? "",
                style: CustomTextStyle.mediumFont14Style.copyWith(color: selectIndex == index ? Colors.white :kPrimaryColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DateFuncData{
  String? name;
  DateTime? date;
  DateFuncData({this.name, this.date});

  static List<DateFuncData> dateFuncDataList = [
    DateFuncData(name: "Today",date: DateTime.now()),
    DateFuncData(name: "Next Monday",date: DateTime.now().add(Duration(days: (8 - DateTime.now().weekday) % 7))),
    DateFuncData(name: "Next Tuesday",date:  DateTime.now().add(Duration(days: (9 - DateTime.now().weekday) % 7))),
    DateFuncData(name: "After 1 week",date: DateTime.now().add(Duration(days: 7))),
  ];

}
