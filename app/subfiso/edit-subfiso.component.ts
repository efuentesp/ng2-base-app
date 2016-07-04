import { Component, OnInit } from '@angular/core';
import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
import { Control, ControlGroup, FormBuilder, Validators, FORM_DIRECTIVES } from '@angular/common';

import { ISubfiso } from './subfiso.interface';
import { ISubfiso } from './subfiso.class';
import { SubfisoService } from './subfiso.service';

@Component({
	templateUrl: 'app/subfiso/edit-subfiso.component.html',
	directives: [FORM_DIRECTIVES]
})
export class EditSubfisoComponent implements OnInit {

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
	}
	
	ngOnInit() : void {
		this._subfisoService.getSubfiso(this.id)
			.subscribe(
				data => {
					this.subfiso = <ISubfiso>data;
					this.id.updateValue(this.subfiso.id);
					this.numero.updateValue(this.subfiso.numero);
					this.nombre.updateValue(this.subfiso.nombre);
				},
				error => this.errorMessage = <any>error,
				() => console.log(this.this.subfiso));
				
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
		
		this.form = builder.group({
			Id: this.Id,
			numero: this.numero,
			nombre: this.nombre,
		});
	}
}
