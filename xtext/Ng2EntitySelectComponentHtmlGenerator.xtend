package com.codebuilder.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.codebuilder.codeBuilder.Model
import com.codebuilder.codeBuilder.EntitySelect

class Ng2EntitySelectComponentHtmlGenerator {

	def doGenerator(Resource resource, IFileSystemAccess2 fsa) {
 		for (model : (resource.contents.filter(typeof(Model)))) {
			for (view : model.entity_select) {
				fsa.generateFile(
					"app/" + view.name.toFirstLower + "/" + view.name.toFirstLower + ".component.html",
					view.createNg2ViewComponentHtml
				)				
			}
		}
	}

	def CharSequence createNg2ViewComponentHtml(EntitySelect view) '''
		<div class="input-group"> <!-- input-group -->
			<input	type="text"
					id="«view.name»"
					class="form-control"
					placeholder="«view.base_entity.entity_title.entity_title»"
					value="{{modalSelected.«view.selected_field»}}">
			<span class="input-group-btn">
				<button class="btn btn-info" (click)="onOpenDialog($event)">...</button>
			</span>
		</div> <!-- input-group -->
		
		<!-- Component (View): «view.name» -->
		<modal [animation]="animationEnabled" [backdrop]="'static'" (onClose)="onClose()" #modal>
			
			<modal-header [show-close]="true"> <!-- modal-header -->
				<h4 class="modal-title">Search Fideicomisos</h4>
			</modal-header> <!-- modal-header -->
			
			<modal-body> <!-- modal-body -->
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
									<div class="col-md-6 text-right">
									</div>
								</div>
							</div> <!-- panel-heading -->
							<div class="panel-body"> <!-- panel-body -->
								<table class="table table-bordered" *ngIf='«view.name.toFirstLower» && «view.name.toFirstLower».length'> <!-- table -->
									<thead>
										<tr>
											<th></th>
											«FOR f : view.fields»
												<th>«f.label»</th>
											«ENDFOR»
										</tr>
									</thead>
									<tbody>
										<tr *ngFor="let item of «view.name.toFirstLower»">
											<td>
												<input	type="radio"
														(click)="onSelection(item)"
														name="selected_item"
														id="selected_item_">
											</td>
											«FOR f : view.fields»
												<td>{{item.«f.name.toFirstLower»}}</td>
											«ENDFOR»
										</tr>
									</tbody>
								</table> <!-- table -->
							</div> <!-- panel-body -->
							<div class="panel-footer"> <!-- panel-footer -->
								
							</div> <!-- panel-footer -->
						</div> <!-- panel -->
					</div> <!-- col-md-12 -->
				</div> <!-- row -->
			</modal-body> <!-- modal-body -->
			
			<modal-footer> <!-- modal-footer -->
				<button type="button" class="btn btn-default" data-dismiss="modal" (click)="modal.dismiss()">Cancel</button>
				<button type="button" class="btn btn-primary" (click)="modal.close()">Select</button>
			</modal-footer> <!-- modal-footer -->
			
		</modal>				
	'''

}