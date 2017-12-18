import { AbstractControl } from '@angular/forms';

export class PasswordValidation {

  static MatchPassword(abs: AbstractControl) {
    let password = abs.get('password').value;
    let confirmPassword = abs.get('confirmPassword').value;
    if((password && confirmPassword) && (password != confirmPassword)) {
      // this.notMatch = "Password not matched. please enter the correct password";
      abs.get('confirmPassword').setErrors( {MathcPassword: true} );
    } else {
      return null;
    }
  }

}