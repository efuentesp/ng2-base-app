/*
 * generated by Xtext 2.9.1
 */
package com.codebuilder.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import javax.inject.Inject

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class CodeBuilderGenerator extends AbstractGenerator {

	@Inject Ng2EntityComponentTsGenerator ng2EntityComponentTsGenerator
	@Inject Ng2EntityComponentHtmlGenerator ng2EntityComponentHtmlGenerator
	@Inject Ng2EntityServiceTsGenerator ng2EntityServiceTsGenerator
	
	@Inject Ng2EntityInterfaceTsGenerator ng2EntityInterfaceTsGenerator
	@Inject Ng2EntityClassTsGenerator ng2EntityClassTsGenerator
	
	@Inject Ng2ViewComponentTsGenerator ng2ViewComponentTsGenerator
	@Inject Ng2ViewComponentHtmlGenerator ng2ViewComponentHtmlGenerator

	@Inject Ng2EntitySelectComponentTsGenerator ng2EntitySelectComponentTsGenerator
	@Inject Ng2EntitySelectComponentHtmlGenerator ng2EntitySelectComponentHtmlGenerator

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		ng2EntityComponentTsGenerator.doGenerator(resource, fsa)
		ng2EntityComponentHtmlGenerator.doGenerator(resource, fsa)
		ng2EntityServiceTsGenerator.doGenerator(resource, fsa)
		
		ng2EntityInterfaceTsGenerator.doGenerator(resource, fsa)
		ng2EntityClassTsGenerator.doGenerator(resource, fsa)
		
		ng2ViewComponentTsGenerator.doGenerator(resource, fsa)
		ng2ViewComponentHtmlGenerator.doGenerator(resource, fsa)
		
		ng2EntitySelectComponentTsGenerator.doGenerator(resource, fsa)
		ng2EntitySelectComponentHtmlGenerator.doGenerator(resource, fsa)		
	}
}