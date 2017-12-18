import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { trigger,style,transition,animate,keyframes,
		query,stagger } from '@angular/animations';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Subscription } from 'rxjs/Subscription';
// import { DataService } from '../services/data.service';
// import { isNull, isUndefined } from 'lodash';
// import { SearchPipe } from '../search.pipe';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
  animations: [
    trigger('goals', [
      transition('* => *', [
        query(':enter', style({ opacity: 0 }), {optional: true}),
        query(':enter', stagger('300ms', [
          animate('.6s ease-in', keyframes([
            style({opacity: 0, transform: 'translateY(-75%)', offset: 0}),
            style({opacity: .5, transform: 'translateY(35px)',  offset: 0.3}),
            style({opacity: 1, transform: 'translateY(0)',     offset: 1.0}),
          ]))]), {optional: true}),
        query(':leave', stagger('300ms', [
          animate('.6s ease-out', keyframes([
            style({opacity: 1, transform: 'translateY(0)', offset: 0}),
            style({opacity: .5, transform: 'translateY(35px)',  offset: 0.3}),
            style({opacity: 0, transform: 'translateY(-75%)',     offset: 1.0}),
          ]))]), {optional: true})
      ])
    ])
  ]
  
})
export class HomeComponent implements OnInit, OnDestroy {

  userData: Subscription;
  result: {};
  user: {};
  error:string;
  search:string;
  
  constructor( private router: Router, private http: HttpClient ) {}
    
  ngOnInit() {
     // this.dataService.getArtist()
     //       .subscribe(res => { this.result=res; this.artists=this.result;},
     //                  error => this.errorMessage = <any>error );

      this.userData = this.http.get('http://172.16.8.146:443/usermanagement/controller/userDetail.cfc?method=ListUser')
                .subscribe(resp => {this.result=resp; console.log(this.result)},
                           error => this.error = <any>error);
                // .subscribe(data => { this.results = data['DATA']; },
                // error => { console.log('error', error)});
    // console.log(this.results);
    // console.log(this.results); 
    function callFn(d) {
        console.log(d);
        // return d;
        }
    // console.log(this.results);

  }

  ngOnDestroy() {
    this.userData.unsubscribe();
  }


  UserProfile(userDetails) {
    this.user = userDetails;
  }

  // search() {
  //   var input, filter, table, tr, td, i;
  //   input = document.getElementById("myInput");
  //   filter = input.value.toUpperCase();
  //   table = document.getElementById("myTable");
  //   tr = table.getElementsByTagName("tr");
  //   for (i = 0; i < tr.length; i++) {
  //     td = tr[i].getElementsByTagName("td")[0];
  //     if (td) {
  //       if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
  //         tr[i].style.display = "";
  //       } else {
  //         tr[i].style.display = "none";
  //       }
  //     }       
  //   }
  // }

}

  // addItem(){
  // 	// let myform = <HTMLElement> new FormData(document.getElementById('login-form'));
  // 	this.goals.push(this.goalText);
  // 	this.goalText = '';
  // 	this.itemCount = this.goals.length;
  // }

  // removeItem(item) {
  // 	this.goals.splice(item,1);
  // }
