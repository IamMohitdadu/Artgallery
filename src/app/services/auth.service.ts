import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
// import { Headers, Http } from '@angular/http';
import { User } from '../models/user';
import { Router } from '@angular/router';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';

import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/toPromise';
import 'rxjs/add/observable/throw';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/map';


@Injectable()
export class AuthService {

  private name:string;
  private BASE_URL: string = 'http://172.16.8.146:443/usermanagement/controller';
  private headers: HttpHeaders = new HttpHeaders({'Content-Type': 'application/json'});	
  private loggedIn = new BehaviorSubject<boolean>(false); // {1}
  
  // check for user logged in
  get isLoggedIn() {
    return this.loggedIn.asObservable(); // {2}
  }
  
  constructor( private http: HttpClient, private router: Router) { }

  loginuser(jsondata): Observable<any>{
    console.log(jsondata);
    let url:string = `${this.BASE_URL}/userController.cfc?method=loginUser'`;
    return this.http.post<any>(url, jsondata)
            .do(data => console.log('All:'+JSON.stringify(data)))
            .catch(this.handleError);
  }
  private handleError(err: HttpErrorResponse) {
    console.log(err.message);
    return Observable.throw(err.message);
  }

  // login(user: User): Promise<any> {
  login(user): Promise<any> {
  	let url:string = `${this.BASE_URL}/userController.cfc?method=loginUser`;
  	return this.http.post(url, user, {headers: this.headers}).toPromise();
  }

  register(user): Promise<any> {
  	let url:string = `${this.BASE_URL}/userController.cfc?method=registerUser`;
  	return this.http.post(url, user, {headers: this.headers}).toPromise();
  }

  ensureAuthentication(token): Promise<any> {
    let url:string = `${this.BASE_URL}/userController.cfc?method=loginUser`;
    let headers: HttpHeaders = new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    });  
    return this.http.get(url, {headers: headers}).toPromise();

  }

  // Check user login status
  isAuthenticated(){
    if (sessionStorage.getItem('Name')) {
        this.router.navigateByUrl('home');
    }
  }

}
