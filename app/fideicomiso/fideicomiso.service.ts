import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import { Observable } from 'rxjs/Observable';

import { IFideicomiso } from './fideicomiso.interface';

@Injectable()
export class FideicomisoService {
	
	private _fideicomisoUrl;
	
	response: IFideicomiso;
	
	constructor(private _http: Http) {
		this._fideicomisoUrl = 'http://localhost:3001/fideicomiso';
	}
	
	getAllFideicomiso() : Observable<IFideicomiso[]> {
		return this._http.get(this._fideicomisoUrl)
			.map((response: Response) => <IFideicomiso[]>response.json())
			//.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);
	}

	getFideicomiso(id: number): Observable<IFideicomiso> {
		return this._http.get(this._fideicomisoUrl + '/' + id)
			.map((response: Response) => <IFideicomiso>response.json())
			//.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);									
	}

	addItem(item) : Observable<IFideicomiso[]> {
		let body = JSON.stringify(item);
		let headers = new Headers({ 'Content-Type': 'application/json' });
		let options = new RequestOptions({ headers: headers });
		
		console.log("http put: " + body);
		
		return this._http.post(this._fideicomisoUrl, body, options)
			.map(this.extractData)
			.catch(this.handleError);
	}

	updateItem(item) : Observable<IFideicomiso[]> {
		let body = JSON.stringify(item);
		let headers = new Headers({ 'Content-Type': 'application/json' });
		let options = new RequestOptions({ headers: headers });
		
		console.log("http put: " + body);
		
		return this._http.put(this._fideicomisoUrl + '/' + item.Id, body, options)
			.map(this.extractData)
			.catch(this.handleError);
	}

private extractData(res: Response) {
	let body = res.json();
	return body.data || {};
}

	private handleError(error: Response) {
		console.error(error);
		return Observable.throw(error.json().error || 'Server error');
	}
}
