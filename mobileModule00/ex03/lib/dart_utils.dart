class DartUtils {
  static final RegExpUtils _regex = RegExpUtils();
  RegExpUtils get regex => _regex;
}

class RegExpUtils {
  // Solo lettere e numeri
  static final RegExp _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  RegExp get alphanumeric => _alphanumeric;

  // Solo lettere (maiuscole e minuscole)
  static final RegExp _lettersOnly = RegExp(r'^[a-zA-Z]+$');
  RegExp get lettersOnly => _lettersOnly;

  // Solo numeri
  static final RegExp _numbersOnly = RegExp(r'^[0-9]+$');
  RegExp get numbersOnly => _numbersOnly;

  // Indirizzo email
  static final RegExp _email = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  RegExp get email => _email;

  // Numero di telefono (formato internazionale)
  static final RegExp _phoneNumber = RegExp(r'^\+?[1-9]\d{1,14}$');
  RegExp get phoneNumber => _phoneNumber;

  // Math expression
  static final RegExp _mathExpression = RegExp(r'^[0-9+\-*/().\s]+$');
  RegExp get mathExpression => _mathExpression;

  // Math symbols
  static final RegExp _mathSymbols = RegExp(r'^[+\-*/().=\s]+$');
  RegExp get mathSymbols => _mathSymbols;

  // URL
  static final RegExp _url = RegExp(r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$');
  RegExp get url => _url;

  // Codice postale (USA)
  static final RegExp _postalCode = RegExp(r'^\d{5}(-\d{4})?$');
  RegExp get postalCode => _postalCode;

  // Data (formato YYYY-MM-DD)
  static final RegExp _date = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  RegExp get date => _date;

  // Indirizzo IP (IPv4)
  static final RegExp _ipv4 = RegExp(r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  RegExp get ipv4 => _ipv4;

  // Password (almeno 8 caratteri, una lettera maiuscola, una minuscola, un numero e un carattere speciale)
  static final RegExp _password = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  RegExp get password => _password;
}
