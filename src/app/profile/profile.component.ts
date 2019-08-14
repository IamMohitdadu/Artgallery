import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { PasswordValidation } from '../services/password-validation';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {
  editForm: FormGroup;
  editDetailsTemplate() {
    this.editForm = this.fb.group({
      first_name: ['', Validators.required ],
      last_name: ['', Validators.required ],
      email: ['', Validators.required ],
      password: ['', Validators.required ],
      c_password: ['', Validators.required ],
      dob: '',
      contact: '',
      city: '',
      state: '',
      country: '',
      zip: '',
      gender: '',
      u_type: ''
    });
  }

  constructor( private fb:FormBuilder, private router: Router, private http: HttpClient) {
    this.editDetailsTemplate(); 
  }

  ngOnInit() {
  }

}

  // editDetailsTemplate() {
  //   this.editForm = this.fb.group({
  //     name: ['', [ Validators.required, Validators.minLength(5)]],
  //     email: ['', [Validators.required, Validators.minLength(5)]],
  //     password: ['', [Validators.required, Validators.minLength(5)]],
  //     confirmPassword: ['', [Validators.required, Validators.minLength(5)]]
  //   }, {
  //     validator: PasswordValidation.MatchPassword
  //   });
  // }