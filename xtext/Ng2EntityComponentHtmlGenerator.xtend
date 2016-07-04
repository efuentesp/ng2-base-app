package com.codebuilder.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.codebuilder.codeBuilder.Model
import com.codebuilder.codeBuilder.Entity
import com.codebuilder.codeBuilder.EntityTextField
import com.codebuilder.codeBuilder.EntityLongTextField
import com.codebuilder.codeBuilder.EntityIntegerField
import com.codebuilder.codeBuilder.EntityListField
import com.codebuilder.codeBuilder.EntityOptionField
import com.codebuilder.codeBuilder.EntityCheckboxField
import com.codebuilder.codeBuilder.EntityReferenceField
import com.codebuilder.codeBuilder.EntityFieldPanelGroup

class Ng2EntityComponentHtmlGenerator {
	
	def doGenerator(Resource resource, IFileSystemAccess2 fsa) {
 		for (model : (resource.contents.filter(typeof(Model)))) {
			for (entity : model.entities) {			
				fsa.generateFile(
					"app/" + entity.name.toFirstLower + "/add-" + entity.name.toFirstLower + ".component.html",
					entity.createNg2EntityComponentHtml("add")
				)
				fsa.generateFile(
					"app/" + entity.name.toFirstLower + "/edit-" + entity.name.toFirstLower + ".component.html",
					entity.createNg2EntityComponentHtml("edit")
				)				
			}
		}

	}

	def CharSequence createNg2EntityComponentHtml(Entity entity, String action) '''
		<!-- Component (Entity): «entity.name» -->
		<div class="row"> <!-- row -->
			<div class="col-md-12"> <!-- col-md-12 -->
				<form	[ngFormModel]="form"
						class="form-horizontal"
						(submit)="doOnSubmit($event)">
					<div class="row"> <!-- row -->
						<div class="col-md-12"> <!-- col-md-12 -->
							«FOR entity_field : entity.entity_fields»
								«entity_field.createHtmlFormField»
							«ENDFOR»
						</div> <!-- col-md-12 -->
					</div> <!-- row -->
					<div class="row"> <!-- row -->
						<div class="col-md-12"> <!-- col-md-12 -->
							<div class="form-group">
								<button type="submit"
										[disabled]="!form.valid"
										class="btn btn-primary"
										id="«entity.name.toFirstLower»_save">
											Save
								</button>
							</div> 
						</div> <!-- col-md-12 -->
					</div> <!-- row -->
				</form>
			</div> <!-- col-md-12 --> 
		</div> <!-- row -->
	'''

	def dispatch CharSequence createHtmlFormField(EntityTextField f) 
		'''
		<!-- Form Field: «f.name» -->
		<div class="form-group"> <!-- form-group -->
			<label for="«f.name»" class="col-md-2 control-label">«f.label.value»</label>
			<div class="col-md-10"> <!-- col-md-10 -->
				<input	type="text"
						id="«f.name»"
						class="form-control"
						placeholder="«f.label.value»"
						ngControl="«f.name»"
						#«f.name»="ngForm" >
				<div *ngIf="«f.name».dirty && !«f.name».valid && !«f.name».pending">
					«IF f.required != null»
						<div *ngIf="«f.name».errors.required" class="alert alert-danger" role="alert">
							<span class="sr-only">Error:</span>
							'Required field.'
						</div>
					«ENDIF»
					«IF f.max_length != null»
						<div *ngIf="«f.name».errors.maxLength" class="alert alert-danger" role="alert">
							<span class="sr-only">Error:</span>
							'Max Length is «f.max_length.value» characters.'
						</div>
					«ENDIF»
				</div>
				«IF f.help_text != null»
					<p class="help-block">«f.help_text.value»</p>
				«ENDIF»					
			</div> <!-- col-md-10 -->
		</div> <!-- form-group -->
		'''

	def dispatch CharSequence createHtmlFormField(EntityLongTextField f) 
		'''
		<!-- Form Field: «f.name» -->
		<div class="form-group"> <!-- form-group -->
			<label for="«f.name»" class="col-md-2 control-label">«f.label.value»</label>
			<div class="col-md-10"> <!-- col-md-10 -->
				<textarea	id="«f.name»"
							class="form-control"
							rows="«IF f.rows != null»«f.rows.value»«ELSE»5«ENDIF»"
							ngControl="«f.name»"
							#«f.name»="ngForm">
				</textarea>
				«IF f.help_text != null»
					<p class="help-block">«f.help_text.value»</p>
				«ENDIF»					
			</div> <!-- col-md-10 -->
		</div> <!-- form-group -->
		'''

	def dispatch CharSequence createHtmlFormField(EntityIntegerField f) 
		'''
		<!-- Form Field: «f.name» -->
		<div class="form-group"> <!-- form-group -->
			<label for="«f.name»" class="col-md-2 control-label">«f.label.value»</label>
			<div class="col-md-10"> <!-- col-md-10 -->
				<input	type="number"
						id="«f.name»"
						class="form-control"
						ngControl="«f.name»"
						#«f.name»="ngForm">
				«IF f.help_text != null»
					<p class="help-block">«f.help_text.value»</p>
				«ENDIF»					
			</div> <!-- col-md-10 -->
		</div> <!-- form-group -->
		'''

	def dispatch CharSequence createHtmlFormField(EntityListField f) 
		'''
		<!-- Form Field: «f.name» -->
		<div class="form-group"> <!-- form-group -->
			<label for="«f.name»" class="col-md-2 control-label">«f.label.value»</label>
			<div class="col-md-10"> <!-- col-md-10 -->
				<select class="form-control" id="«f.name»">
					<option value="">-- Select one --</option>
					«FOR v : f.values»
						<option value="«v.key»">«v.label»</option>
					«ENDFOR»
				</select>
				«IF f.help_text != null»
					<p class="help-block">«f.help_text.value»</p>
				«ENDIF»					
			</div> <!-- col-md-10 -->
		</div> <!-- form-group -->
		'''

	def dispatch CharSequence createHtmlFormField(EntityOptionField f) 
		'''
		<!-- Form Field: «f.name» -->
		<div class="form-group"> <!-- form-group -->
			<label for="«f.name.toFirstLower»" class="col-md-2 control-label">«f.label.value»</label>
			<div class="col-md-10"> <!-- col-md-10 -->
				«FOR v : f.values»
					<div class="radio">
					  <label>
					    <input type="radio" name="«f.name.toFirstLower»" id="option_«v.key»" value="«v.key»">
					    «v.label»
					  </label>
					</div>
				«ENDFOR»
				«IF f.help_text != null»
					<p class="help-block">«f.help_text.value»</p>
				«ENDIF»					
			</div> <!-- col-md-10 -->
		</div> <!-- form-group -->
		'''

	def dispatch CharSequence createHtmlFormField(EntityCheckboxField f) 
		'''
		<!-- Form Field: «f.name» -->
		<div class="form-group"> <!-- form-group -->
			<label for="«f.name.toFirstLower»" class="col-md-2 control-label">«f.label.value»</label>
			<div class="col-md-10"> <!-- col-md-10 -->
				«FOR v : f.values»
					<div class="checkbox">
					  <label>
					    <input type="checkbox" name="«f.name.toFirstLower»" value="«v.key»">
					    «v.label»
					  </label>
					</div>
				«ENDFOR»
				«IF f.help_text != null»
					<p class="help-block">«f.help_text.value»</p>
				«ENDIF»					
			</div> <!-- col-md-10 -->
		</div> <!-- form-group -->
		'''
	
	def dispatch CharSequence createHtmlFormField(EntityReferenceField entity_field) '''
		<p>EntityReferenceField</p>
		'''

	def dispatch CharSequence createHtmlFormField(EntityFieldPanelGroup g) '''
		<!-- Panel Group: «g.name» -->
		<div class="panel panel-default"> <!-- panel -->
			<div class="panel-heading"> <!-- panel-heading -->
				<h3 class="panel-title">«g.label.value»</h3>
			</div> <!-- panel-heading -->
			<div class="panel-body"> <!-- panel-body -->
				«FOR entity_field : g.entity_fields»
					«entity_field.createHtmlFormField»
				«ENDFOR»
			</div> <!-- panel-body -->
		</div> <!-- panel -->
	'''
	
}