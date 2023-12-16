import 'package:formz/formz.dart';

// Define input validation errors
enum TextError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Text extends FormzInput<String, TextError> {

  // Call super.pure to represent an unmodified form input.
  const Text.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Text.dirty( String value ) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == TextError.empty ) return 'The field is required';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TextError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return TextError.empty;

    return null;
  }
}