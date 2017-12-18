import { Pipe, PipeTransform } from '@angular/core';

@Pipe( {
	name: 'convertToSpace'
})
// add to app module
export class ConvertToSpacePipe implements PipeTransform {
	transform(value: string, character: string): string {
		return value.replace(character, ' ');
	}
}