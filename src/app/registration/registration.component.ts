import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { PasswordValidation } from '../services/password-validation';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.scss']
})
export class RegistrationComponent implements OnInit {
 
  registrationForm: FormGroup;
  error: string;
  
  registrationTemplate() {
    this.registrationForm = this.fb.group({
      name: ['', [ Validators.required, Validators.minLength(5)]],
      email: ['', [Validators.required, Validators.minLength(5)]],
      password: ['', [Validators.required, Validators.minLength(5)]],
      confirmPassword: ['', [Validators.required, Validators.minLength(5)]]
    }, {
      validator: PasswordValidation.MatchPassword
    });
  }

  constructor(private fb:FormBuilder, private router: Router, private http: HttpClient) {
    // check for user already login
    // this.auth.isAuthenticated();
    this.registrationTemplate(); 
  }

  ngOnInit() {
  }

  // register User
  registration() {

    if(!this.registrationForm.valid) {
      this.error = "Please enter the valid credentials!";
      return false;
    }

    const jsondata = JSON.stringify(this.registrationForm.value);

    // api request
    this.http.post('http://172.16.8.146:443/usermanagement/controller/userController.cfc?method=registerUser', jsondata)
        .subscribe( (res) =>{console.log(res); this.CheckAfterRegisteration(res);},
                  (error) => { console.log('error', error) });
    } //end registration 

    // check after getting responce from http
    CheckAfterRegisteration(response):void{
    let result = response;
      console.log(response);
      console.log(response.SUCCESS);
      console.log(response.DATA);
      this.error = response.DATA;
    }

}

/*
 registrationTemplate() {
    this.registrationForm = this.fb.group({
      first_name: ['', Validators.required ],
      last_name: ['', Validators.required ],
      email: ['', Validators.required ],
      password: ['', Validators.required ],
      c_password: ['', Validators.required ],
      dob: '',
      contact: '',
      city: '',
      state: '',
      country: '',
      zip: '',
      gender: '',
      u_type: ''
    });
  }

    registration() {
    console.log(this.registrationForm.value);
    const jsondata = JSON.stringify(this.registrationForm.value);
    console.log(jsondata);

    // this.auth.register(jsondata).then((user)=>{ 
    //   console.log(user.json());
    // });

    // this.http.post('http://172.16.8.146:443/usermanagement/controller/userController.cfc?method=loginUser', jsondata)
    //   .subscribe( (res) =>{console.log(res); this.registrationValidation(res);} ,
    //               (error) => { console.log('error', error) });
    // // this.lists$ = httpGet$;
    } //end registration 

  */