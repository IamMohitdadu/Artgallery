import { Component } from '@angular/core';
import { Router, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'app';
  name:string;
  shownav:boolean;

  constructor( private router: Router) {
   	this.isAuthenticated();
    this.shownav = true;
  }

  isAuthenticated(){
  	if (sessionStorage.getItem('Name')) {
  		this.name = sessionStorage.getItem('Name');
  	}
  }

}
