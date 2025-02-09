import 'package:flutter/material.dart';
import 'dart_utils.dart';


class Symbol {
  static const int ADDITION = 0;
  static const int SUBTRACTION = 1;
  static const int DIVISION = 2;
  static const int MULTIPLICATION = 3;
  static const int OPEN_PARENTHESIS = 4;
  static const int CLOSE_PARENTHESIS = 5;
  static const int DOT = 6;
  static const int EQUALS = 7;
}

num doOperationRecursive(List<String> values, int lock, num result)
{
	if (values.length == 1)
	{
		return num.parse(values[0]);
	}

	num a = num.parse(values[0]);
	String op = values[1];
	num b = num.parse(values[2]);

	if (op == '+' && lock == 0) {
		result = a + b;
	} else if (op == '-' && lock == 0) {
		result = a - b;
	} else if (op == '*') {
		result = a * b;
    lock--;
	} else if (op == '/') {
		result = a / b;
    lock--;
	}

  if ((op == '+' || op == '-') && lock != 0)
  {
    if (a > 0)
    {
      values.add("+");
    }
    else
    {
      values.add("-");
    }
    values.add(values[0]);

    if (op == '-')
    {
      values[2] = '-' + values[2];
    }
    values.removeRange(0, 2);
  }
  else
  {
    values = values.sublist(3);
    values.insert(0, result.toString());
  }

	return doOperationRecursive(values, lock, result);
}


int countPriorityExpression(String expression)
{
  int counter = 0;

  for (int i = 0; i < expression.length; i++)
  {
    if (expression[i] == '*' || expression[i] == '/')
    {
      counter++;
    }
  }
  return counter;
}


num doOperation(String expression)
{
  int result = 0;
	List<String> values = expression.split(' ');
  int lock = countPriorityExpression(expression);
	return doOperationRecursive(values, lock, result);
}


class CalculatorProvider extends ChangeNotifier {
  RegExpUtils regex = RegExpUtils();

  num currentValue = 0;
  int currentOperation = 0;

  int decimalPrecision = 0;
  int direction = 1;

  String _expressionCurrent = '0';
  String _expressionTotal = '0';

  String get expressionCurrent => _expressionCurrent;
  String get expressionTotal => _expressionTotal;

  void updateExpCurrent(String value) 
  {

    debugPrint("Value: $value");
    debugPrint("Precision: $decimalPrecision");
    if (_expressionTotal.isNotEmpty)
    {
      if (value == "AC")
      {
          _expressionCurrent = '0';
          _expressionTotal = '0';
      }
      else if (value == "C")
      {
        if (_expressionCurrent.isNotEmpty && _expressionCurrent[_expressionCurrent.length - 1] != ' ')
        {
          _expressionCurrent = _expressionCurrent.substring(0, _expressionCurrent.length - 1);
          _expressionTotal = _expressionTotal.substring(0, _expressionTotal.length - 1);
        }
        if (_expressionCurrent.isEmpty)
        {
          _expressionCurrent = '0';
          _expressionTotal = '0';
        }
        // _expressionTotal = _expressionTotal.substring(_expressionTotal.length - 2);
      }
      else if (value == '00')
      {

        if (decimalPrecision > 4 || decimalPrecision < 0)
        {
          direction *= -1;
        }
        decimalPrecision += direction;
      }
      // last char is a number
      else if (regex.numbersOnly.hasMatch(_expressionTotal[_expressionTotal.length - 1]))
      {
        // insert number after number
        if (regex.numbersOnly.hasMatch(value))
        {
          if (_expressionCurrent == '0')
          {
            _expressionCurrent = value;
            _expressionTotal = value;
          }
          else
          {
            _expressionCurrent += value;
            _expressionTotal += value;
          }
        }
        // insert a simbol after a number
        else if (regex.mathSymbols.hasMatch(value))
        {
          //math operations
          if (value == '+')
          {
            _expressionCurrent += ' + ';
            _expressionTotal += ' + ';
            currentOperation = Symbol.ADDITION;
          }
          else if (value == '-')
          {
            _expressionCurrent += ' - ';
            _expressionTotal += ' - ';
            currentOperation = Symbol.SUBTRACTION;
          }
          else if (value == '/')
          {
            _expressionCurrent += ' / ';
            _expressionTotal += ' / ';
            currentOperation = Symbol.DIVISION;
          }
          else if (value == '*')
          {
            _expressionCurrent += ' * ';
            _expressionTotal += ' * ';
            currentOperation = Symbol.MULTIPLICATION;
          }
          // dot for decimals
          else if (value == '.')
          {
            _expressionCurrent += '.';
            _expressionTotal += '.';
          }
          else if (value == '=')
          {
            _expressionCurrent = doOperation(
              _expressionCurrent)
              .toStringAsFixed(decimalPrecision);
          }
        }
      }
      // l'ultimo carattere è un simbolo
      else if (regex.mathSymbols.hasMatch(_expressionTotal[_expressionTotal.length - 1]))
      {
        // insert number after symbol
        if (regex.numbersOnly.hasMatch(value))
        {
          // _expressionCurrent = doOperation(_expressionCurrent + value).toString();
          _expressionCurrent += value;
          _expressionTotal += value;
        }
        // symbol after symbol
        else if (regex.mathSymbols.hasMatch(value))
        {
          //math operations
          if (value == '+')
          {
            _expressionCurrent = _expressionCurrent.replaceRange(_expressionCurrent.length - 1, _expressionCurrent.length, value);
            _expressionTotal = _expressionTotal.replaceRange(_expressionTotal.length - 1, _expressionTotal.length, value);
            currentOperation = Symbol.ADDITION;
          }
          else if (value == '-')
          {
            _expressionCurrent += '-';
            _expressionTotal = _expressionTotal.replaceRange(_expressionTotal.length - 1, _expressionTotal.length, value);
            currentOperation = Symbol.SUBTRACTION;
          }
          else if (value == '/')
          {
            _expressionTotal = _expressionTotal.replaceRange(_expressionTotal.length - 1, _expressionTotal.length, value);
            _expressionCurrent = _expressionCurrent.replaceRange(_expressionCurrent.length - 1, _expressionCurrent.length, value);
            currentOperation = Symbol.DIVISION;
          }
          else if (value == '*')
          {
            _expressionCurrent = _expressionCurrent.replaceRange(_expressionCurrent.length - 1, _expressionCurrent.length, value);
            _expressionTotal = _expressionTotal.replaceRange(_expressionTotal.length - 1, _expressionTotal.length, value);
            currentOperation = Symbol.MULTIPLICATION;
          }
        }
      }
    }
	notifyListeners();
  }

	void updateExpTotal(String value) {
		// _expressionTotal += value; 
	}

	notifyListeners();
  }