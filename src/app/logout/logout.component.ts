import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.scss']
})

export class LogoutComponent implements OnInit {

  constructor(private router: Router) {
    this.logout();
  }

  ngOnInit() {
    
  }

  logout(){
    localStorage.removeItem('access_token');
    // localStorage.removeItem('id_token');
    localStorage.removeItem("Userid");
    localStorage.removeItem('Name');  
    localStorage.removeItem('Email');
    // this.userProfile = undefined;
    // this.setLoggedIn(false);
    sessionStorage.removeItem("access_token");
    sessionStorage.removeItem("Userid");
    sessionStorage.removeItem("Name");
    sessionStorage.removeItem("Email");
    // navigate to home after logout
    window.location.reload();
    this.router.navigateByUrl('');
    // window.location.reload();
  }

}