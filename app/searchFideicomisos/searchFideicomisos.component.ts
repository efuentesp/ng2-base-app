import { Component, ViewChild, OnInit } from '@angular/core';
import { ROUTER_DIRECTIVES } from '@angular/router-deprecated';

import { MODAL_DIRECTIVES, ModalComponent } from 'ng2-bs3-modal/ng2-bs3-modal';

import { IFideicomiso } from '../fideicomiso/fideicomiso.interface';
import { FideicomisoService } from '../fideicomiso/fideicomiso.service';

@Component({
	selector: 'SearchFideicomisos',
	templateUrl: 'app/searchFideicomisos/searchFideicomisos.component.html',
	directives: [ROUTER_DIRECTIVES, MODAL_DIRECTIVES]
})
export class SearchFideicomisosComponent implements OnInit {
	@ViewChild('modal')
	modal: ModalComponent;
	
	errorMessage: string;
	searchFideicomisos : IFideicomiso[];
	
	modalSelected: any = {};
	selected: any = {};
	
	animationEnabled: boolean = true;
	
	constructor(private _fideicomisoService: FideicomisoService) {}
	
	ngOnInit() : void {
		this._fideicomisoService.getAllFideicomiso()
			.subscribe(
				data => this.searchFideicomisos = data,
				error => this.errorMessage = <any>error);
	}
	
	onClose() {
		this.modalSelected = this.selected;
	}
	
	onOpenDialog(event) {
		this.modal.open('lg');
		event.preventDefault();
	}
	
	onSelection(item) {
		this.selected = item;
	}
}
