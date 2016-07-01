import { Component } from '@angular/core';
import { Router, ROUTER_DIRECTIVES } from '@angular/router-deprecated';
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
	templateUrl: 'app/fideicomiso/add-fideicomiso.component.html',
	directives: [FORM_DIRECTIVES]
})
export class AddFideicomisoComponent {

	form: ControlGroup;
	
	Id: Control;
	numero: Control;
	nombre: Control;
	patrimonio: Control;
	tipo_persona: Control;
	tipo_cliente: Control;
	tipo_gobierno: Control;

	public model: any = {};

	constructor(private _builder: FormBuilder,
				private _router: Router,
				private _fideicomisoService: FideicomisoService) {
		
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
		
		this.form = _builder.group({
			Id: this.Id,
			numero: this.numero,
			nombre: this.nombre,
			patrimonio: this.patrimonio,
			tipo_persona: this.tipo_persona,
			tipo_cliente: this.tipo_cliente,
			tipo_gobierno: this.tipo_gobierno,
		});
	}
	
	addFideicomiso() {
		this._fideicomisoService.addFideicomiso(this.model);
		this.model = {};
		//this._router.navigateByUrl('/fideicomiso');
	}
}
