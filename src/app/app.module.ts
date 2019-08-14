import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
// ==========
// ==========
import { FormsModule } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
// ==========
import { AppRoutingModule } from './app-routing.module';
import { RouterModule, Routes } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
// import {HttpModule} from '@angular/http';
import { HTTP_INTERCEPTORS } from '@angular/common/http';
// ==========
import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { AboutComponent } from './about/about.component';
import { LoginComponent } from './login/login.component';
import { LogoutComponent } from './logout/logout.component';
import { RegistrationComponent } from './registration/registration.component';
import { PageNotFoundComponent } from './not-found.component';
import { AuthService } from './services/auth.service';
// ==========
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialModule } from './material.module';
// import 'hammerjs';
// ==========
import { BsDropdownModule } from 'ngx-bootstrap/dropdown';
import { TooltipModule } from 'ngx-bootstrap/tooltip';
import { ModalModule } from 'ngx-bootstrap/modal';
// ==========
// custom pipe
import { ConvertToSpacePipe } from './convert-to-space.pipe';
import { SearchPipe } from './search.pipe';
import { GalleryComponent } from './gallery/gallery.component';
import { ProfileComponent } from './profile/profile.component';
import { MyartsComponent } from './myarts/myarts.component';

// ==========

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    AboutComponent,
    LoginComponent,
    RegistrationComponent,
    LogoutComponent,
    PageNotFoundComponent,
    SearchPipe,
    GalleryComponent,
    ProfileComponent,
    MyartsComponent,
  ],

  imports: [
    BrowserModule,
    BsDropdownModule.forRoot(),
    TooltipModule.forRoot(),
    ModalModule.forRoot(),
    HttpClientModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    MaterialModule
  ],

  providers: [AuthService],
  //   providers: [{
  //   provide: HTTP_INTERCEPTORS,
  //   useClass: GlobalIntercept,
  //   multi: true,
  // }],

  bootstrap: [AppComponent]
})
export class AppModule { }
