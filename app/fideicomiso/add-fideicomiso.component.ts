import { Component, OnInit } from '@angular/core';
import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
import { Control, ControlGroup, FormBuilder, Validators, FORM_DIRECTIVES } from '@angular/common';

import { IFideicomiso } from './fideicomiso.interface';
import { Fideicomiso } from './fideicomiso.class';
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

	private _id;
	public errorMessage: string;			
	public fideicomiso;

	constructor(private builder: FormBuilder,
				private router: Router,
				private params: RouteParams,
				private _fideicomisoService: FideicomisoService) {
		
		this._id = params.get('id');
	}
	
	doOnSubmit(event) : void {
		this._fideicomisoService.addItem(this.form.value)
			.subscribe(
				data => console.log(data),
				error => console.log(error)
			);					
		//this._router.navigateByUrl('/fideicomiso');
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
		this.patrimonio = new Control(
			'',
			Validators.compose([
			])
		);
		this.tipo_persona = new Control(
			'',
			Validators.compose([
			])
		);
		this.tipo_cliente = new Control(
			'',
			Validators.compose([
			])
		);
		this.tipo_gobierno = new Control(
			'',
			Validators.compose([
			])
		);
		
		this.form = this.builder.group({
			Id: this.Id,
			numero: this.numero,
			nombre: this.nombre,
			patrimonio: this.patrimonio,
			tipo_persona: this.tipo_persona,
			tipo_cliente: this.tipo_cliente,
			tipo_gobierno: this.tipo_gobierno,
		});
	}
}
