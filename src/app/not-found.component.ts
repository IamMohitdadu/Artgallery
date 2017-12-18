import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Router } from '@angular/router';

@Component({
  template: `<h2>Page not found</h2>
  			 <p>
  				<a href="" (click)='sendMeHome'>go back</a>
  			</p>`
})
export class PageNotFoundComponent {

  shownav:boolean;
  constructor(private route: ActivatedRoute, private router: Router){
  	this.shownav = false;
  }
	
  sendMeHome() {
  	this.router.navigate(['']);
  }

}