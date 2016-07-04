package com.codebuilder.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.codebuilder.codeBuilder.Model
import com.codebuilder.codeBuilder.Entity

class Ng2EntityServiceTsGenerator {
	
	def doGenerator(Resource resource, IFileSystemAccess2 fsa) {
 		for (model : (resource.contents.filter(typeof(Model)))) {
			for (entity : model.entities) {			
				fsa.generateFile(
					"app/" + entity.name.toFirstLower + "/" + entity.name.toFirstLower + ".service.ts",
					entity.createNg2EntityServiceTs
				)
			}
		}
	}
	
	def CharSequence createNg2EntityServiceTs(Entity entity) '''
		import { Injectable } from '@angular/core';
		import { Http, Response, Headers } from '@angular/http';
		import { Observable } from 'rxjs/Observable';
		
		import { I«entity.name.toFirstUpper» } from './«entity.name.toFirstLower».interface';

		@Injectable()
		export class «entity.name.toFirstUpper»Service {
			
			private _«entity.name.toFirstLower»Url;
			private _headers = new Headers();
			
			constructor(private _http: Http) {
				this._«entity.name.toFirstLower»Url = 'http://localhost:3001/«entity.name.toFirstLower»';
				this._headers.append('Content-Type', 'application/json');
			}
			
			getAll«entity.name.toFirstUpper»() : Observable<I«entity.name.toFirstUpper»[]> {
				return this._http.get(this._«entity.name.toFirstLower»Url)
					.map((response: Response) => <I«entity.name.toFirstUpper»[]>response.json())
					//.do(data => console.log('All: ' + JSON.stringify(data)))
					.catch(this.handleError);
			}

			get«entity.name.toFirstUpper»(id: number): Observable<I«entity.name.toFirstUpper»> {
				return this._http.get(this._«entity.name.toFirstLower»Url + '/' + id)
					.map((response: Response) => <I«entity.name.toFirstUpper»>response.json())
					//.do(data => console.log('All: ' + JSON.stringify(data)))
					.catch(this.handleError);									
			}

			addItem(item): void {
				return;
			}

			updateItem(item): void {
				console.log(item);
				this._http.put(this._fideicomisoUrl + '/' + item.id, JSON.stringify(item), { headers: this._headers })
					.map((res: Response) => res.json()
					.subscribe((res: IFideicomiso) => this.putResponse = res);
				return;
			}

			private handleError(error: Response) {
				console.error(error);
				return Observable.throw(error.json().error || 'Server error');
			}
		}
	'''
	
	
}