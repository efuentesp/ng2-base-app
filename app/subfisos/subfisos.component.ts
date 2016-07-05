import { Component, OnInit } from '@angular/core';
import { ROUTER_DIRECTIVES } from '@angular/router-deprecated';

import { ISubfiso } from '../subfiso/subfiso.interface';
import { SubfisoService } from '../subfiso/subfiso.service';

@Component({
	templateUrl: 'app/subfisos/subfisos.component.html',
	directives: [ROUTER_DIRECTIVES]
})
export class SubfisosComponent implements OnInit {
	errorMessage: string;
	subfisos : ISubfiso[];
	
	constructor(private _subfisoService: SubfisoService) {}
	
	ngOnInit() : void {
		this._subfisoService.getAllSubfiso()
			.subscribe(
				data => this.subfisos = data,
				error => this.errorMessage = <any>error);
	}
}
