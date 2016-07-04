package com.codebuilder.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.codebuilder.codeBuilder.Model
import com.codebuilder.codeBuilder.View

class Ng2ViewComponentHtmlGenerator {

	def doGenerator(Resource resource, IFileSystemAccess2 fsa) {
 		for (model : (resource.contents.filter(typeof(Model)))) {
			for (view : model.views) {
				fsa.generateFile(
					"app/" + view.name.toFirstLower + "/" + view.name.toFirstLower + ".component.html",
					view.createNg2ViewComponentHtml
				)				
			}
		}
	}

	def CharSequence createNg2ViewComponentHtml(View view) '''
		<!-- Component (View): «view.name» -->
		«IF view.exposed_filter.size > 0»
			<div class="row"> <!-- row -->
				<div class="col-md-12"> <!-- col-md-12 -->				
					<div class="panel panel-default"> <!-- panel -->
						<div class="panel-heading"> <!-- panel-heading -->
							<div class="row">
								<div class="col-md-6">
									<h3 class="panel-title">Search Criterias</h3>
								</div>
							</div>
						</div> <!-- panel-heading -->
						<div class="panel-body"> <!-- panel-body -->
							<form class="form-horizontal">
								<div class="row"> <!-- row -->
									<div class="col-md-12"> <!-- col-md-12 -->
										«FOR f : view.exposed_filter»
											<div class="form-group">
												<label for="«f.name»" class="col-md-2 control-label">«f.label»</label>
												<div class="col-md-10">
													<input type="text" id="«f.name»" class="form-control">				
												</div>
											</div>
										«ENDFOR»
									</div> <!-- col-md-12 -->
								</div> <!-- row -->
								<div class="row pull-right"> <!-- row -->
									<div class="col-md-12"> <!-- col-md-12 -->
										<button type="submit" class="btn btn-default">Clear</button>
										<button type="submit" class="btn btn-primary">Search</button>
									</div> <!-- col-md-12 -->
								</div> <!-- row -->
							</form>
						</div> <!-- panel-body -->
					</div> <!-- panel -->
				</div> <!-- col-md-12 -->
			</div> <!-- row -->
		«ENDIF»
		<div class="row"> <!-- row -->
			<div class="col-md-12"> <!-- col-md-12 -->
				<div class="panel panel-default panel-table"> <!-- panel -->
					<div class="panel-heading"> <!-- panel-heading -->
						<div class="row">
							<div class="col-md-6">
								<h3 class="panel-title">Search Results</h3>
							</div>
							«IF view.add_link != null»
								<div class="col-md-6 text-right">
									<a	[routerLink]="['Add«view.base_entity.name.toFirstUpper»']"
										class="btn btn-primary btn-create">
											Create New
									</a>
								</div>
							«ENDIF»
						</div>
					</div> <!-- panel-heading -->
					<div class="panel-body"> <!-- panel-body -->
						<table class="table table-bordered" *ngIf='«view.name.toFirstLower» && «view.name.toFirstLower».length'> <!-- table -->
							<thead>
								<tr>
									«FOR f : view.fields»
										<th>«f.label»</th>
									«ENDFOR»
									«IF view.show_link != null || view.edit_link != null || view.delete_link != null»
										<th>Actions</th>
									«ENDIF»
								</tr>
							</thead>
							<tbody>
								<tr *ngFor="let item of «view.name.toFirstLower»">
									«FOR f : view.fields»
										<td>{{item.«f.name.toFirstLower»}}</td>
									«ENDFOR»
									«IF view.show_link != null || view.edit_link != null || view.delete_link  != null»
										<td>
											«IF view.show_link != null»
												<button type="submit" class="btn btn-sm btn-default">Show</button>
											«ENDIF»
											«IF view.edit_link != null»
												<a [routerLink]="['Edit«view.base_entity.name.toFirstUpper»', {id: item.«view.base_entity.entity_db_table.id_db_table»}]" class="btn btn-sm btn-success">Edit</a>
											«ENDIF»
											«IF view.delete_link != null»
												<button type="submit" class="btn btn-sm btn-danger">Delete</button>
											«ENDIF»
										</td>
									«ENDIF»
								</tr>
							</tbody>
						</table> <!-- table -->
					</div> <!-- panel-body -->
					<div class="panel-footer"> <!-- panel-footer -->
						
					</div> <!-- panel-footer -->
				</div> <!-- panel -->
			</div> <!-- col-md-12 -->
		</div> <!-- row -->
	'''

}