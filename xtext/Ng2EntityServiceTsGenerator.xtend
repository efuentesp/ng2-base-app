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
		import { Http, Response } from '@angular/http';
		import { Observable } from 'rxjs/Observable';
		
		import { I«entity.name.toFirstUpper» } from './«entity.name.toFirstLower»';

		@Injectable()
		export class «entity.name.toFirstUpper»Service {
			
			private _«entity.name.toFirstLower»Url;
			
			constructor(private _http: Http) {
				this._«entity.name.toFirstLower»Url = 'http://localhost:3001/«entity.name.toFirstLower»';
			}
			
			getAll«entity.name.toFirstUpper»() : Observable<I«entity.name.toFirstUpper»[]> {
				return this._http.get(this._«entity.name.toFirstLower»Url)
					.map((response: Response) => <I«entity.name.toFirstUpper»[]>response.json())
					.do(data => console.log('All: ' + JSON.stringify(data)))
					.catch(this.handleError);
			}

			get«entity.name.toFirstUpper»(id: number): Observable<I«entity.name.toFirstUpper»> {
				return this._http.get(this._«entity.name.toFirstLower»Url + '/' + id)
					.map((response: Response) => <I«entity.name.toFirstUpper»>response.json())
					.do(data => console.log('All: ' + JSON.stringify(data)))
					.catch(this.handleError);
									
				//return this.getAll«entity.name.toFirstUpper»()
				//	.map((«entity.name.toFirstLower»List: I«entity.name.toFirstUpper»[]) => «entity.name.toFirstLower»List.find(i => i.«entity.entity_db_table.id_db_table» === «entity.entity_db_table.id_db_table»));
			}

			add«entity.name.toFirstUpper»(model): void {
				return;
			}

			private handleError(error: Response) {
				console.error(error);
				return Observable.throw(error.json().error || 'Server error');
			}
		}
	'''
	
	
}