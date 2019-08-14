import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-myarts',
  templateUrl: './myarts.component.html',
  styleUrls: ['./myarts.component.scss']
})
export class MyartsComponent implements OnInit {
      
	id:string;
	result:any;

  constructor( private http: HttpClient, private router: Router ) { }

  ngOnInit() {

  	if (window.sessionStorage) {
	  	this.id = sessionStorage.getItem("Userid");
  	
  	  if (this.id) {
  	  	const data =  {
  	  		id: this.id
  	  	}
	      // http request to get user data
	      const httpGet = this.http.post('http://172.16.8.146:443/usermanagement/controller/artDetail.cfc?method=UserArtList', JSON.stringify(data))
                      .subscribe( resp => {this.result=resp; console.log(this.result)}  ,
                                  (error) => { console.log('error', error) });
      }
    } else {
	    this.router.navigateByUrl('/logout');
    }

  }

}
