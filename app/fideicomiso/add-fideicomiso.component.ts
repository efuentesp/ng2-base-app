import { Component, OnInit } from '@angular/core';
import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
import { Control, ControlGroup, FormBuilder, Validators, FORM_DIRECTIVES } from '@angular/common';

import { IFideicomiso } from './fideicomiso.interface';
import { IFideicomiso } from './fideicomiso.class';
import { FideicomisoService } from './fideicomiso.service';

@Component({
	templateUrl: 'app/fideicomiso/add-fideicomiso.component.html',
	directives: [FORM_DIRECTIVES]
})
export class AddFideicomisoComponent implements OnInit {

	form: ControlGroup;
	
	Id: Control;
	numero: Control;
	nombre: Control;
	patrimonio: Control;
	tipo_persona: Control;
	tipo_cliente: Control;
	tipo_gobierno: Control;

	private id;
	public errorMessage: string;			
	public fideicomiso;

	constructor(private builder: FormBuilder,
				private router: Router,
				private params: RouteParams,
				private _fideicomisoService: FideicomisoService) {
		
		this.id = params.get('id');
	}
	
	doOnSubmit(event) {
		this._fideicomisoService.addFideicomiso(this.form.value);
		//this._router.navigateByUrl('/fideicomiso');
		event.preventDefault();
	}
	
}
