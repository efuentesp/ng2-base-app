import { Component, OnInit } from '@angular/core';
import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
import { Control, ControlGroup, FormBuilder, Validators, FORM_DIRECTIVES } from '@angular/common';

import { ISubfiso } from './subfiso.interface';
import { ISubfiso } from './subfiso.class';
import { SubfisoService } from './subfiso.service';

@Component({
	templateUrl: 'app/subfiso/add-subfiso.component.html',
	directives: [FORM_DIRECTIVES]
})
export class AddSubfisoComponent implements OnInit {

	form: ControlGroup;
	
	Id: Control;
	numero: Control;
	nombre: Control;

	private id;
	public errorMessage: string;			
	public subfiso;

	constructor(private builder: FormBuilder,
				private router: Router,
				private params: RouteParams,
				private _subfisoService: SubfisoService) {
		
		this.id = params.get('id');
	}
	
	doOnSubmit(event) {
		this._subfisoService.addSubfiso(this.form.value);
		//this._router.navigateByUrl('/subfiso');
		event.preventDefault();
	}
	
}
