import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';
import 'dart_utils.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => CalculatorProvider(),
        child: MyApp(),
      )
    );
}

void onPressed (BuildContext context, String text) {
  final provider = Provider.of<CalculatorProvider>(context, listen: false);
  provider.updateExpCurrent(text);
  provider.updateExpTotal(text);
}


void onSpecial(String text) {
  DartUtils dartUtils = DartUtils();
	final math = dartUtils.regex.mathExpression;

	if (math.hasMatch(text))
	{
		debugPrint('Yes');
	}
	else
	{
		debugPrint('No');
	}
}


class MyApp extends StatelessWidget {
    MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: '42 Flutter ex00.1',
            theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 91, 6, 238)),
            useMaterial3: true,
            ),
            home: Calculator(),
        );
    }
}


class InputButton extends StatefulWidget {
  @override
  _InputButtonState createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton> {
  bool _isEditing = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return _isEditing ?
      TextField(
        controller: _controller,
        maxLength: 3,
        onSubmitted: (value) {
          onSpecial(value);
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        decoration: InputDecoration(
          hintText: '',
          counterText: '',
        ),
      )
      : 
      ElevatedButton(
        onPressed: () {
          setState(() {
            _isEditing = !_isEditing;
            }
          );
        }, 
        child: Text(
          'EXPR',
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      );
  }
}


class SpecialButton extends StatelessWidget {
	final String text;

	const SpecialButton ({
		super.key,
		required this.text,
	});

	@override
	Widget build(BuildContext context)
	{
		return Flexible(
			child: SizedBox(
				height: (MediaQuery.of(context).size.height / 100) * 15,
				width: MediaQuery.of(context).size.width / 5,
				child: InputButton(),
				)
		);
	}
}


class CalculatorButton extends StatelessWidget {
  
  final String text;
  
  const CalculatorButton({
    super.key,
    required this.text,
	});

  @override
  Widget build(BuildContext context)
  {
    return Flexible(
      child: SizedBox(
      height: (MediaQuery.of(context).size.height / 100) * 15,
      width: MediaQuery.of(context).size.width / 5,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
        ),
        onPressed: () { onPressed(context, text); },
        child: Text(text),
      )
      )
    );
  }
}

class CalculatorColumn extends StatelessWidget {

	final String text1, text2, text3, text4;

  const CalculatorColumn({
	super.key,
	required this.text1,
	required this.text2,
	required this.text3,
	required this.text4,
	});

  @override
  Widget build(BuildContext context)
  {
	return Column(
	  mainAxisSize: MainAxisSize.max,
	  children: [
		CalculatorButton(text: text1),
		CalculatorButton(text: text2),
		CalculatorButton(text: text3),
		if (text4 == "")
			SpecialButton(text: text4)
		else			
			CalculatorButton(text: text4),
	  ],
	);
  }
}

class CalculatorDisplay extends StatelessWidget {
  CalculatorDisplay({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final expressionCurrent = Provider.of<CalculatorProvider>(context).expressionCurrent;
    final expressionTotal = Provider.of<CalculatorProvider>(context).expressionTotal;

	return Row(
	  mainAxisAlignment: MainAxisAlignment.center,
	  children: [
		Flexible(
		  child: Container(
			height: MediaQuery.of(context).size.height * 0.4,
			width: MediaQuery.of(context).size.width,
			color: Colors.red,
			padding: const EdgeInsets.all(8.0),
			child: Column(
			  mainAxisAlignment: MainAxisAlignment.end,
			  crossAxisAlignment: CrossAxisAlignment.end,
			  children: [
				Text(
				  expressionTotal.trim(),
				  style: const TextStyle(
					fontSize: 36,
					fontWeight: FontWeight.bold,
					color: Colors.white,
				  )
				),
				Text(
				  expressionCurrent,
				  style: const TextStyle(
					fontSize: 36,
					fontWeight: FontWeight.bold,
					color: Colors.white,
				  )
				),
			  ],
			)
		  ) 
		)
	  ]
	);
  }
}


class CalculatorKeyboard extends StatelessWidget {
  CalculatorKeyboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
	return const Row(
	  mainAxisAlignment: MainAxisAlignment.center,
	  children: [
		//column widget
		CalculatorColumn(text1: "7", text2: "4", text3: "1", text4: "0"),
		CalculatorColumn(text1: "8", text2: "5", text3: "2", text4: "."),
		CalculatorColumn(text1: "9", text2: "6", text3: "3", text4: "00"),
		CalculatorColumn(text1: "C", text2: "+", text3: "*", text4: "="),
		CalculatorColumn(text1: "AC", text2: "-", text3: "/", text4: ""),
	  ],
	);
  }
}

class Calculator extends StatelessWidget {
  Calculator({super.key});

  String currentValue = "0";
  String totalExpression = "0";

  @override
  Widget build(BuildContext context)
  {
	return Scaffold(
	  appBar: AppBar(
		title: const Text('Calculator'),
	  ),
	  body: Center(
		child: Column(
		  children: [
			Flexible(
			  flex: 4,
			  child: CalculatorDisplay(),
			),
			Flexible(
			  flex: 5,
			  child: CalculatorKeyboard(),
			),
		  ]
		),
	  )
	);
  }
}