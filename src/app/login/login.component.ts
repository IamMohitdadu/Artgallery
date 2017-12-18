import { Component, OnInit } from '@angular/core';

import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import {Observable} from "rxjs/Observable";
import { HttpClient, HttpHeaders } from '@angular/common/http';
// custom services
import { AuthService } from '../services/auth.service';
import { User } from '../models/user';

// interface List {
//   results: string;
// }

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

export class LoginComponent implements OnInit {

  loginForm: FormGroup;
  userdata:'';
  error:string;
  Userid:number;
  Name:string;
  Email:string;
  // lists$: Observable<List[]>
  // user class model instance
  user: User = new User();

  constructor(private auth:AuthService, private fb:FormBuilder, private http: HttpClient, private router: Router) {
    // check for user already login
    // this.auth.isAuthenticated();

    this.loginTemplate(); 
    // // check whether user is authenticated
    // if (this.authenticated) {
    //   // this.userProfile = JSON.parse(localStorage.getItem('profile'));
    //   this.setLoggedIn(true);
    // }

  }

  // login form generator template
  loginTemplate() {
    this.loginForm = this.fb.group({
      username: ['', [ Validators.required, Validators.minLength(5) ]],
      password: ['', [ Validators.required, Validators.minLength(5) ]],
    });
  }

  ngOnInit() {
  }

  // For login user
  login() {
    const userdata = this.loginForm.value;
    const jsondata = JSON.stringify(this.loginForm.value);

    this.http.post('http://172.16.8.146:443/usermanagement/controller/userController.cfc?method=loginUser', jsondata)
			.subscribe( (res) =>{console.log(res); this.loginValidation(res);} ,
			            (error) => { console.log('error', error) });
  } //end login 

  loginValidation(response):void{
    let result = response;
      console.log(response);
      console.log(response.SUCCESS);
      console.log(response.DATA);

    if (!result.SUCCESS) {
      this.error = response.DATA;
      this.Userid = null ;
      this.Name = "";
      this.Email = "";
    } else {
      this.error= "";
      this.userdata = response.DATA;
      this.Userid = this.userdata["USERID"];
      this.Name = this.userdata["NAME"];
      this.Email = this.userdata["EMAIL"];
      localStorage.setItem('access_token', response.TOKEN);
      localStorage.setItem("Userid", this.userdata['USERID']);
      localStorage.setItem("Name", this.userdata['NAME']);
      localStorage.setItem("Email", this.userdata['EMAIL']);
      sessionStorage.setItem("access_token", response.TOKEN);
      sessionStorage.setItem("Userid", this.userdata['USERID']);
      sessionStorage.setItem("Name", this.userdata['NAME']);
      sessionStorage.setItem("Email", this.userdata['EMAIL']);
      // navigate to home after login
      // this.router.navigateByUrl('/');
      setTimeout(function(){ 
        // window.location.reload();
        window.location.replace("http://localhost:4200/");
      }, 1200);
      // window.location.reload();

    }
  }

  // check password strength
  strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
  mediumRegex = new RegExp("^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})");
  passwordStrength = {
    "float": "left",
    "width": "100px",
    "height": "25px",
    "margin-left": "5px"
  };

  passwordAnalyze(value) {
    console.log(value);
      if(this.strongRegex.test(value)) {
          this.passwordStrength["background-color"] = "green";
      } else if(this.mediumRegex.test(value)) {
          this.passwordStrength["background-color"] = "orange";
      } else {
          this.passwordStrength["background-color"] = "red";
      }
  };


    // setLoggedIn(value: boolean) {
    //   // Update login status subject
    //   this.loggedIn$.next(value);
    //   this.loggedIn = value;
    // }

    // logout(){
    //   localStorage.removeItem('access_token');
    //   // localStorage.removeItem('id_token');
    //   localStorage.removeItem('Name');
    //   localStorage.removeItem('Email');
    //   // this.userProfile = undefined;
    //   // this.setLoggedIn(false);
    //   sessionStorage.removeItem("access_token");
    //   sessionStorage.removeItem("Name");
    //   sessionStorage.removeItem("Email");
    // }


  }

  // console.log(this.loginForm.value);
  // const jsondata = JSON.stringify(this.loginForm.value);
  // console.log(jsondata);


// }
