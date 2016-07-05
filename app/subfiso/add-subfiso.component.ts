import { Component, OnInit } from '@angular/core';
import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
import { Control, ControlGroup, FormBuilder, Validators, FORM_DIRECTIVES } from '@angular/common';

import { ISubfiso } from './subfiso.interface';
import { Subfiso } from './subfiso.class';
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

	private _id;
	public errorMessage: string;			
	public subfiso;

	constructor(private builder: FormBuilder,
				private router: Router,
				private params: RouteParams,
				private _subfisoService: SubfisoService) {
		
		this._id = params.get('id');
	}
	
	doOnSubmit(event) : void {
		this._subfisoService.addItem(this.form.value)
			.subscribe(
				data => console.log(data),
				error => console.log(error)
			);					
		//this._router.navigateByUrl('/subfiso');
		event.preventDefault();
	}

	ngOnInit() : void {
					
		this.Id = new Control(
			'',
			Validators.compose([
			])
		);
		this.numero = new Control(
			'',
			Validators.compose([
				Validators.required,
			])
		);
		this.nombre = new Control(
			'',
			Validators.compose([
				Validators.required,
			])
		);
		
		this.form = this.builder.group({
			Id: this.Id,
			numero: this.numero,
			nombre: this.nombre,
		});
	}
}
