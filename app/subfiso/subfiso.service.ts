import { Injectable } from '@angular/core';
import { Http, Response, Headers, RequestOptions } from '@angular/http';
import { Observable } from 'rxjs/Observable';

import { ISubfiso } from './subfiso.interface';

@Injectable()
export class SubfisoService {
	
	private _subfisoUrl;
	
	response: ISubfiso;
	
	constructor(private _http: Http) {
		this._subfisoUrl = 'http://localhost:3001/subfiso';
	}
	
	getAllSubfiso() : Observable<ISubfiso[]> {
		return this._http.get(this._subfisoUrl)
			.map((response: Response) => <ISubfiso[]>response.json())
			//.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);
	}

	getSubfiso(id: number): Observable<ISubfiso> {
		return this._http.get(this._subfisoUrl + '/' + id)
			.map((response: Response) => <ISubfiso>response.json())
			//.do(data => console.log('All: ' + JSON.stringify(data)))
			.catch(this.handleError);									
	}

	addItem(item) : Observable<ISubfiso[]> {
		let body = JSON.stringify(item);
		let headers = new Headers({ 'Content-Type': 'application/json' });
		let options = new RequestOptions({ headers: headers });
		
		console.log("http put: " + body);
		
		return this._http.post(this._subfisoUrl, body, options)
			.map(this.extractData)
			.catch(this.handleError);
	}

	updateItem(item) : Observable<ISubfiso[]> {
		let body = JSON.stringify(item);
		let headers = new Headers({ 'Content-Type': 'application/json' });
		let options = new RequestOptions({ headers: headers });
		
		console.log("http put: " + body);
		
		return this._http.put(this._subfisoUrl + '/' + item.Id, body, options)
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
