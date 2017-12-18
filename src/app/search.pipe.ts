import { Pipe, PipeTransform } from '@angular/core';

@Pipe( {
	name: 'SearchPipe'
})
// add to app module
export class SearchPipe implements PipeTransform {
	public transform(value, key: string, term: string) {
		return value.filter((list) => {
		  if (list.hasOwnProperty(key)) {
		    if (term) {
		      let regExp = new RegExp('\\b' + term, 'gi');
		      return regExp.test(list[key]);
		    } else {
		      return true;
		    }
		  } else {
		    return false;
		  }
		});
	}
}