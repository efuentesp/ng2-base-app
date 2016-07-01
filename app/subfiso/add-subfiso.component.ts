import { Component } from '@angular/core';
import { Router, ROUTER_DIRECTIVES } from '@angular/router-deprecated';
import {
	Control,
	ControlGroup,
	FormBuilder,
	Validators,
	FORM_DIRECTIVES
} from '@angular/common';

//import { ISubfiso } from './subfiso';
import { SubfisoService } from './subfiso.service';

@Component({
	templateUrl: 'app/subfiso/add-subfiso.component.html',
	directives: [FORM_DIRECTIVES]
})
export class AddSubfisoComponent {

	form: ControlGroup;
	
	Id: Control;
	numero: Control;
	nombre: Control;

	public model: any = {};

	constructor(private _builder: FormBuilder,
				private _router: Router,
				private _subfisoService: SubfisoService) {
		
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
		
		this.form = _builder.group({
			Id: this.Id,
			numero: this.numero,
			nombre: this.nombre,
		});
	}
	
	addSubfiso() {
		this._subfisoService.addSubfiso(this.model);
		this.model = {};
		//this._router.navigateByUrl('/subfiso');
	}
}
