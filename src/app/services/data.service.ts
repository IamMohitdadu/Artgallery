import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import 'rxjs/add/observable/throw';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/map';

// import { IProduct } from './product';

@Injectable()
export class DataService {

	private name:string;
  private BASE_URL: string = 'http://172.16.8.146:443/usermanagement/controller';

  constructor(private http:HttpClient) { }

  getArtist(): Observable<any>{
  	let url:string = `${this.BASE_URL}/userDetail.cfc?method=ListUser`;
  	return this.http.get<any>(url)
  					.do(data => console.log('All:'+JSON.stringify(data)))
  					.catch(this.handleError);
  }

  private handleError(err: HttpErrorResponse) {
  	console.log(err.message);
  	return Observable.throw(err.message);
  }
  /*// in a real world app, we may send the server to some remote logging infrastructure
        // instead of just logging it to the console
        let errorMessage = '';
        if (err.error instanceof Error) {
            // A client-side or network error occurred. Handle it accordingly.
            errorMessage = `An error occurred: ${err.error.message}`;
        } else {
            // The backend returned an unsuccessful response code.
            // The response body may contain clues as to what went wrong,
            errorMessage = `Server returned code: ${err.status}, error message is: ${err.message}`;
        }
        console.error(errorMessage);
        return Observable.throw(errorMessage);
    }*/

}

