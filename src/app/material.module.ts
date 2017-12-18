import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { 
    MatButtonModule, 
    MatCheckboxModule,
    MatToolbarModule,
    MatCardModule,
    MatMenuModule,
    MatGridListModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatSidenavModule
    				} from '@angular/material';

@NgModule({
	imports: [     
		MatButtonModule, 
	    MatCheckboxModule,
	    MatToolbarModule,
	    MatCardModule,
	    MatMenuModule,
	    MatGridListModule,
	    MatIconModule,
	    MatProgressSpinnerModule,
	    MatSidenavModule
	],
	
	exports: [
	    MatButtonModule, 
	    MatCheckboxModule,
	    MatToolbarModule,
	    MatCardModule,
	    MatMenuModule,
	    MatGridListModule,
	    MatIconModule,
	    MatProgressSpinnerModule,
	    MatSidenavModule
    ],
})

export class MaterialModule { }