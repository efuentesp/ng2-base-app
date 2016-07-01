import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';

import { IFideicomiso } from './fideicomiso';

@Injectable()
export class FideicomisoService {
	
	private _fideicomisoUrl;
	
	constructor(private _http: Http) {
		this._fideicomisoUrl = 'http://localhost:3001/fideicomiso';
	}
	
	getAllFideicomiso() : Observable<IFideicomiso[]> {
		return this._http.get(this._fideicomisoUrl)
			.map((response: Response) => <IFideicomiso[]>response.json())
			.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);
	}

	getFideicomiso(id: number): Observable<IFideicomiso> {
		let editUrl = this._fideicomisoUrl + '/' + id;
		console.log(editUrl);
		return this._http.get(editUrl)
			.map((response: Response) => <IFideicomiso>response.json())
			.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);
							
		//return this.getAllFideicomiso()
		//	.map((fideicomisoList: IFideicomiso[]) => fideicomisoList.find(i => i.id === id));
	}

	addFideicomiso(model): void {
		return;
	}

	private handleError(error: Response) {
		console.error(error);
		return Observable.throw(error.json().error || 'Server error');
	}
}
