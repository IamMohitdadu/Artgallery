import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Subscription } from 'rxjs/Subscription';
// import { DataService } from '../services/data.service';
// import { isNull, isUndefined } from 'lodash';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],  
})

export class HomeComponent implements OnInit, OnDestroy {

  userData: Subscription;
  result: {};
  user: {};
  error:string;
  searchItem:string;
  searchType:string;
  
  constructor( private router: Router, private http: HttpClient ) {
    this.searchType="NAME";
  }
    
  ngOnInit() {
     // this.dataService.getArtist()
     //       .subscribe(res => { this.result=res; this.artists=this.result;},
     //                  error => this.errorMessage = <any>error );
      this.userData = this.http.get('http://172.16.8.146:443/usermanagement/controller/userDetail.cfc?method=ListUser')
              .subscribe(resp => {this.result=resp; console.log(this.result)},
                         error => this.error = <any>error);
  }

  ngOnDestroy() {
    this.userData.unsubscribe();
  }

  UserProfile(userDetails) {
    this.user = userDetails;
  }

}