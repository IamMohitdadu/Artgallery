import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Subscription } from 'rxjs/Subscription';

@Component({
  selector: 'app-gallery',
  templateUrl: './gallery.component.html',
  styleUrls: ['./gallery.component.scss']
})
export class GalleryComponent implements OnInit {
	artList: Subscription;
	result: {};
	user: {};
	error:string;
	searchItem:string;

	constructor( private http: HttpClient ) {
	}

	ngOnInit() {
	  this.artList = this.http.get('http://172.16.8.146:443/usermanagement/controller/artDetail.cfc?method=ListArts')
	  .subscribe(resp => {this.result=resp; console.log(this.result)},
	             error => this.error = <any>error);
  	}

}
