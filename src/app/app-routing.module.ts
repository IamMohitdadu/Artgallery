import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { AboutComponent } from './about/about.component';
import { LoginComponent } from './login/login.component';
import { RegistrationComponent } from './registration/registration.component';
import { LogoutComponent } from './logout/logout.component';
import { PageNotFoundComponent } from './not-found.component';

const routes: Routes = [
  {
    path: '',
    // redirectTo: 'home',
    component: HomeComponent,
    // pathMatch: 'full'
  },
  // {
  //   path: 'home',
  //   component: HomeComponent
  // },
  // {
  //   path: 'about',
  //   // canActivate: [AuthguardGuard],
  //   component: AboutComponent
  // },
  {
    path: 'about/:id',
    // canActivate: [AuthguardGuard],
    component: AboutComponent
  },
  {
    path: 'login',
    component: LoginComponent
  },
  {
    path: 'registration',
    component: RegistrationComponent,
  },
  {
    path: 'logout',
    component: LogoutComponent
  },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [
            RouterModule.forRoot(
              routes,
              // { enableTracing: true }
             )
           ],

  exports: [
            RouterModule
           ]
})
export class AppRoutingModule { }
