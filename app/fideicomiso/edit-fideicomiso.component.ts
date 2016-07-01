import { Component, OnInit } from '@angular/core';
import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
import {
	Control,
	ControlGroup,
	FormBuilder,
	Validators,
	FORM_DIRECTIVES
} from '@angular/common';

//import { IFideicomiso } from './fideicomiso';
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

	public errorMessage: string;
	public model: any = {};
	private id;
	private fideicomiso;

	constructor(private builder: FormBuilder,
				private router: Router,
				private params: RouteParams,
				private _fideicomisoService: FideicomisoService) {

		this.id = params.get('id');

		this.Id = new Control(
			"",
			Validators.compose([
			])
		);
		this.numero = new Control(
			"",
			Validators.compose([
				Validators.required,
			])
		);
		this.nombre = new Control(
			"",
			Validators.compose([
				Validators.required,
			])
		);
		this.patrimonio = new Control(
			"",
			Validators.compose([
			])
		);
		this.tipo_persona = new Control(
			"",
			Validators.compose([
			])
		);
		this.tipo_cliente = new Control(
			"",
			Validators.compose([
			])
		);
		this.tipo_gobierno = new Control(
			"",
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
	
	ngOnInit() : void {
		this._fideicomisoService.getFideicomiso(this.id)
			.subscribe(
				fideicomiso => this.fideicomiso = fideicomiso,
				error => this.errorMessage = <any>error);
	}

}
