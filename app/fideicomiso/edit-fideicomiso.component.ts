import { Component, OnInit } from '@angular/core';
import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
import { Control, ControlGroup, FormBuilder, Validators, FORM_DIRECTIVES } from '@angular/common';

import { IFideicomiso } from './fideicomiso.interface';
import { IFideicomiso } from './fideicomiso.class';
import { FideicomisoService } from './fideicomiso.service';

@Component({
	templateUrl: 'app/fideicomiso/edit-fideicomiso.component.html',
	directives: [FORM_DIRECTIVES]
})
export class EditFideicomisoComponent implements OnInit {

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
	}
	
	ngOnInit() : void {
		this._fideicomisoService.getFideicomiso(this.id)
			.subscribe(
				data => {
					this.fideicomiso = <IFideicomiso>data;
					this.id.updateValue(this.fideicomiso.id);
					this.numero.updateValue(this.fideicomiso.numero);
					this.nombre.updateValue(this.fideicomiso.nombre);
					this.patrimonio.updateValue(this.fideicomiso.patrimonio);
					this.tipo_persona.updateValue(this.fideicomiso.tipo_persona);
					this.tipo_cliente.updateValue(this.fideicomiso.tipo_cliente);
					this.tipo_gobierno.updateValue(this.fideicomiso.tipo_gobierno);
				},
				error => this.errorMessage = <any>error,
				() => console.log(this.this.fideicomiso));
				
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
		
		this.form = builder.group({
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
