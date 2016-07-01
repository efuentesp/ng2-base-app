import { Component, OnInit } from '@angular/core';
import { ROUTER_DIRECTIVES } from '@angular/router-deprecated';

import { IFideicomiso } from '../fideicomiso/fideicomiso';
import { FideicomisoService } from '../fideicomiso/fideicomiso.service';

@Component({
	templateUrl: 'app/fideicomisos/fideicomisos.component.html',
	directives: [ROUTER_DIRECTIVES]
})
export class FideicomisosComponent implements OnInit {
	errorMessage: string;
	fideicomisos : IFideicomiso[];
	
	constructor(private _fideicomisoService: FideicomisoService) {}
	
	ngOnInit() : void {
		this._fideicomisoService.getAllFideicomiso()
			.subscribe(
				fideicomisos => this.fideicomisos = fideicomisos,
				error => this.errorMessage = <any>error);
	}
}
