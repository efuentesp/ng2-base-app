package com.softtek.codegen.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2

import com.softtek.codegen.entity.Model
import com.softtek.codegen.entity.Entity
import com.softtek.codegen.entity.EntityTextField
import com.softtek.codegen.entity.EntityLongTextField
import com.softtek.codegen.entity.EntityIntegerField
import com.softtek.codegen.entity.EntityListField
import com.softtek.codegen.entity.EntityOptionField
import com.softtek.codegen.entity.EntityCheckboxField
import com.softtek.codegen.entity.EntityReferenceField
import com.softtek.codegen.entity.EntityFieldPanelGroup

class Ng2EntityComponentTsGenerator {
	
	def doGenerator(Resource resource, IFileSystemAccess2 fsa) {
 		for (model : (resource.contents.filter(typeof(Model)))) {
			for (entity : model.entities) {			
				fsa.generateFile(
					"app/" + entity.name.toFirstLower + "/add-" + entity.name.toFirstLower + ".component.ts",
					entity.createEntityComponentTs("add")
				)
				fsa.generateFile(
					"app/" + entity.name.toFirstLower + "/edit-" + entity.name.toFirstLower + ".component.ts",
					entity.createEntityComponentTs("edit")
				)				
			}
		}
	}

	def CharSequence createEntityComponentTs(Entity entity, String action) '''
		import { Component } from '@angular/core';
		import { Router, ROUTER_DIRECTIVES, ROUTER_PROVIDERS, RouteConfig, RouteParams } from '@angular/router-deprecated';
		import { Control, ControlGroup, FormBuilder, Validators, FORM_DIRECTIVES } from '@angular/common';
		
		//import { I«entity.name.toFirstUpper» } from './«entity.name.toFirstLower»';
		import { «entity.name.toFirstUpper»Service } from './«entity.name.toFirstLower».service';
		
		@Component({
			templateUrl: 'app/«entity.name.toFirstLower»/«action»-«entity.name.toFirstLower».component.html',
			directives: [FORM_DIRECTIVES]
		})
		export class «action.toFirstUpper»«entity.name.toFirstUpper»Component {

			form: ControlGroup;
			
			«FOR f : entity.entity_fields»
				«f.createNg2ComponentControlDefinition»
			«ENDFOR»

			//public model: any = {};
			private id;
			public errorMessage: string;			
			public «entity.name.toFirstLower»;

			constructor(private builder: FormBuilder,
						private router: Router,
						private params: RouteParams,
						private _«entity.name.toFirstLower»Service: «entity.name.toFirstUpper»Service) {
				
				this.id = params.get('id');
				
				«FOR f : entity.entity_fields»
					«f.createNg2ComponentControlItem»
				«ENDFOR»
				
				this.form = builder.group({
					«FOR f : entity.entity_fields»
						«f.createNg2ComponentControlGroupItem»
					«ENDFOR»
				});
			}
			
			«IF action=='add'»
				add«entity.name.toFirstUpper»() {
					this._«entity.name.toFirstLower»Service.add«entity.name.toFirstUpper»(this.model);
					//this.model = {};
					//this._router.navigateByUrl('/«entity.name.toFirstLower»');
				}
			«ENDIF»
			
			«IF action=='edit'»
				this._«entity.name.toFirstLower»Service.get«entity.name.toFirstUpper»(this.id)
					.subscribe(
						data => this.«entity.name.toFirstLower» = data,
						error => this.errorMessage = <any>error);
			«ENDIF»
		}
	'''


	def dispatch CharSequence createNg2ComponentControlDefinition(EntityTextField f) '''
		«f.name»: Control;
	'''

	def dispatch CharSequence createNg2ComponentControlDefinition(EntityLongTextField f) '''
		«f.name»: Control;
	'''	

	def dispatch CharSequence createNg2ComponentControlDefinition(EntityIntegerField f) '''
		«f.name»: Control;
	'''

	def dispatch CharSequence createNg2ComponentControlDefinition(EntityListField f) '''
		«f.name»: Control;
	'''		

	def dispatch CharSequence createNg2ComponentControlDefinition(EntityOptionField f) '''
		«f.name»: Control;
	'''

	def dispatch CharSequence createNg2ComponentControlDefinition(EntityCheckboxField f) '''
		«f.name»: Control;
	'''	

	def dispatch CharSequence createNg2ComponentControlDefinition(EntityReferenceField f) '''
	'''

	def dispatch CharSequence createNg2ComponentControlDefinition(EntityFieldPanelGroup g) '''
		«FOR f : g.entity_fields»
			«f.createNg2ComponentControlDefinition»
		«ENDFOR»
	'''
	
	
		
	def dispatch CharSequence createNg2ComponentControlItem(EntityTextField f) '''
		this.«f.name» = new Control(
			"",
			Validators.compose([
				«f.requiredValidator»
				«f.maxLenghtValidator»
			])
		);
	'''

	def dispatch CharSequence createNg2ComponentControlItem(EntityLongTextField f) '''
		this.«f.name» = new Control(
			"",
			Validators.compose([
				«f.requiredValidator»
			])
		);
	'''	

	def dispatch CharSequence createNg2ComponentControlItem(EntityIntegerField f) '''
		this.«f.name» = new Control(
			"",
			Validators.compose([
				«f.requiredValidator»
			])
		);
	'''

	def dispatch CharSequence createNg2ComponentControlItem(EntityListField f) '''
		this.«f.name» = new Control(
			"",
			Validators.compose([
				«f.requiredValidator»
			])
		);
	'''	

	def dispatch CharSequence createNg2ComponentControlItem(EntityOptionField f) '''
		this.«f.name» = new Control(
			"",
			Validators.compose([
				«f.requiredValidator»
			])
		);
	'''

	def dispatch CharSequence createNg2ComponentControlItem(EntityCheckboxField f) '''
		this.«f.name» = new Control(
			"",
			Validators.compose([
				«f.requiredValidator»
			])
		);
	'''	

	def dispatch CharSequence createNg2ComponentControlItem(EntityReferenceField f) '''
	'''

	def dispatch CharSequence createNg2ComponentControlItem(EntityFieldPanelGroup g) '''
		«FOR f : g.entity_fields»
			«f.createNg2ComponentControlItem»
		«ENDFOR»
	'''	
	
	
		
	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityTextField f) '''
		«f.name»: this.«f.name»,
	'''
	
	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityLongTextField f) '''
		«f.name»: this.«f.name»,
	'''

	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityIntegerField f) '''
		«f.name»: this.«f.name»,
	'''
	
	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityListField f) '''
		«f.name»: this.«f.name»,
	'''
	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityOptionField f) '''
		«f.name»: this.«f.name»,
	'''
	
	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityCheckboxField f) '''
		«f.name»: this.«f.name»,
	'''
	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityReferenceField f) '''
	'''
	
	def dispatch CharSequence createNg2ComponentControlGroupItem(EntityFieldPanelGroup g) '''
		«FOR f : g.entity_fields»
			«f.createNg2ComponentControlGroupItem»
		«ENDFOR»
	'''

	def dispatch CharSequence maxLenghtValidator(EntityTextField f) '''
		«IF f.max_length != null»
			Validators.maxLength(«f.max_length.value»),
		«ENDIF»		
	'''

	def dispatch CharSequence maxLenghtValidator(EntityLongTextField f) '''
	'''
	
	def dispatch CharSequence maxLenghtValidator(EntityIntegerField f) '''
	'''
	
	def dispatch CharSequence maxLenghtValidator(EntityListField f) '''
	'''
	
	def dispatch CharSequence maxLenghtValidator(EntityOptionField f) '''
	'''
	
	def dispatch CharSequence maxLenghtValidator(EntityCheckboxField f) '''
	'''
	
	def dispatch CharSequence maxLenghtValidator(EntityReferenceField f) '''
	'''
	
	def dispatch CharSequence maxLenghtValidator(EntityFieldPanelGroup g) '''
		«FOR f : g.entity_fields»
			«f.maxLenghtValidator»
		«ENDFOR»	
	'''
	
	
	
	def dispatch CharSequence requiredValidator(EntityTextField f) '''
		«IF f.required != null»
			Validators.required,
		«ENDIF»	
	'''

	def dispatch CharSequence requiredValidator(EntityLongTextField f) '''
		«IF f.required != null»
			Validators.required,
		«ENDIF»	
	'''
	
	def dispatch CharSequence requiredValidator(EntityIntegerField f) '''
		«IF f.required != null»
			Validators.required,
		«ENDIF»	
	'''

	def dispatch CharSequence requiredValidator(EntityListField f) '''
		«IF f.required != null»
			Validators.required,
		«ENDIF»	
	'''
	
	def dispatch CharSequence requiredValidator(EntityOptionField f) '''
		«IF f.required != null»
			Validators.required,
		«ENDIF»	
	'''

	def dispatch CharSequence requiredValidator(EntityCheckboxField f) '''
		«IF f.required != null»
			Validators.required,
		«ENDIF»	
	'''
	
	def dispatch CharSequence requiredValidator(EntityReferenceField f) '''
	'''
	
	def dispatch CharSequence requiredValidator(EntityFieldPanelGroup g) '''
		«FOR f : g.entity_fields»
			«f.requiredValidator»
		«ENDFOR»	
	'''

	
}