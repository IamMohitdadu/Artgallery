import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.scss']
})
export class AboutComponent implements OnInit {

  id: number;
  userid: number;
  result: any;

  constructor(private route: ActivatedRoute, private router: Router, private http: HttpClient) { 
    // methods to get route parameters
    this.id=this.route.snapshot.params['id'];  //snapshot method
  	this.route.params.subscribe(params => { this.userid = params['id']; } ); //observable method (best)

  }

  ngOnInit() {

    if (this.id) {
      // http request to get user data
      const httpGet = this.http.post('http://172.16.8.146:443/usermanagement/controller/artDetail.cfc?method=UserArtList', this.id)
                      .subscribe( resp => {this.result=resp; console.log(this.result)}  ,
                                  (error) => { console.log('error', error) });

    }
  }

  // Send back to home
  sendMeHome() {
  	this.router.navigate(['']);
  }

}

// export class HomeComponent implements OnInit {

  // username = new FormControl();
  // loginForm = new FormGroup ({
  //   username: new FormControl(),
  //   password: new FormControl()
  // });
  // loginForm: FormGroup;
  // registrationForm: FormGroup;
  // private _host: string;
  // private _authToken: string;
  // private __headers: HttpHeaders;

  // itemCount:number;
  // btnText:string = 'Add item';
  // goalText:string = 'firstData';
  // username:string = "";
  // password:string = "";
  // error:string = "";
  // result= {};
  // goals = [];
  // goals = ['My first life goal', 'I want to climb a mountain', 'Go ice skiing'];

  // constructor( private router:Router, private http: HttpClient ) {}
  // constructor(private fb:FormBuilder, private router:Router, private http: HttpClient) {
    // this.loginTemplate(); 
    // this.registrationTemplate(); 
  // }

  // loginTemplate() {
  //   this.loginForm = this.fb.group({
  //     username: ['', Validators.required],
  //     password: ['', Validators.required],
  //   });
  // }
  // registrationTemplate() {
  //   this.registrationForm = this.fb.group({
  //     name: ['', Validators.required ],
  //     street: '',
  //     city: '',
  //     state: '',
  //     zip: '',
  //     power: '',
  //     sidekick: ''
  //   });
  // }


//    results: string[];
  
//   ngOnInit() {
//     // this.itemCount = this.goals.length; 
//     this.http.get('http://172.16.8.146:443/usermanagement/controller/userDetail.cfc?method=listUser')
//                 .subscribe(data => function (data) {
//           callFn(data);
//                 },
//                 error => { console.log('error', error)});
//     // console.log(this.results);
//   }
//   console.log('f');
// function callFn(d) {
//     console.log(d.data);
    
//   }

  // addItem(){
  //   // let myform = <HTMLElement> new FormData(document.getElementById('login-form'));
  //   this.goals.push(this.goalText);
  //   this.goalText = '';
  //   this.itemCount = this.goals.length;
  // }

  // removeItem(item) {
  //   this.goals.splice(item,1);
  // }

  // login() {
  //   console.log(this.loginForm.value);
  //   const jsondata = JSON.stringify(this.loginForm.value);
  //   console.log(jsondata);
    //     const jsdata = {
    //   "username": this.loginForm.get('username').value,
    //   "password": this.loginForm.get('password').value
    // }
    // console.log(jsdata);

    // console.log(this.username);
    // console.log(this.password);

    // if (this.username.trim() == 'admin' && this.password.trim() == 'admin') {
    //   console.log('success');
    //   const logindata = {
    //     "username": this.username,
    //     "password": this.password,
    //   };

      // const jsondata = JSON.stringify(logindata);
      // console.log(jsondata);

      // if (isNull(this.__headers)) {
      //   const __headers = new HttpHeaders()
      //      .set('Content-Type', 'application/json; charset=utf-8')
      //      .set('Authorization', this. _authToken || '');
      // }


      // this.http.post('http://172.16.8.146:443/artgallery/model/artgalleryService.cfc?method=UserLogin', result, 
    //   const log = this.http.post('http://172.16.8.146:443/usermanagement/controller/userController.cfc?method=loginUser', jsondata)
    //             .subscribe(res => console.log(res),
    //             error => { console.log('error', error)});

    //   console.log(log);
    // }
  //   else {
  //     console.log('fail');
  //     this.error = "*please enter the valid details.";
  //   }

  // }

// }
