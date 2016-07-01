import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';

import { ISubfiso } from './subfiso';

@Injectable()
export class SubfisoService {
	
	private _subfisoUrl;
	
	constructor(private _http: Http) {
		this._subfisoUrl = 'http://localhost:3001/subfiso';
	}
	
	getAllSubfiso() : Observable<ISubfiso[]> {
		return this._http.get(this._subfisoUrl)
			.map((response: Response) => <ISubfiso[]>response.json())
			.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);
	}

	getSubfiso(id: number): Observable<ISubfiso> {
		return this._http.get(this._subfisoUrl + '/' + id)
			.map((response: Response) => <ISubfiso>response.json())
			.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);
							
		//return this.getAllSubfiso()
		//	.map((subfisoList: ISubfiso[]) => subfisoList.find(i => i.id === id));
	}

	addSubfiso(model): void {
		return;
	}

	private handleError(error: Response) {
		console.error(error);
		return Observable.throw(error.json().error || 'Server error');
	}
}
