entity Fideicomiso {
	title "Fideicomiso"
	db_table {
		name "CONTRATO"
		id Id
	}
	fields {
		Integer Id {
			label "ID"
			db_field "ID"
		}
		Panel panel_01 {
			label "Panel 1"
			fields {
				Integer numero {
					label "Número"
					db_field "CTO_NUM_CONTRATO"
					required
					cardinality 1
				}
		
				Text nombre {
					label "Nombre"
					default_value "Default value text"
					db_field "CTO_NOMBRE_CONTRATO"
					required
					cardinality 1
				}
			}
		}
		
		Panel panel_02 {
			label "Panel 2"
			fields {
				LongText patrimonio {
					label "Patrimonio"
					default_value "Default value"
					field_rows 3
					help_text "This is a help text.."
				}				
			}
		}
		
		Panel tipo_cliente {
			label "Tipo de Cliente"
			fields {
				List tipo_persona {
					label "Tipo de Persona"
					values {
						FISICA	| "Física"
						MORAL	| "Moral"
					}
				}
				Option tipo_cliente {
					label "Tipo de Cliente"
					values {
						PUBLICO	| "Público"
						PRIVADO	| "Privado"
					}
				}
				Checkbox tipo_gobierno {
					label "Tipo de Gobierno"
					values {
						FEDERAL		| "Federal"
						PARAESTATAL	| "Paraestatal"
						ESTATAL		| "Estatal"
						MUNICIPAL	| "Municipal"
					}
				}							
			}
		}
	}
}

entity Subfiso {
    title "Sub Fiso"
    db_table {
    	name "SUBCONT"
    	id Id
    } 
    fields {
		Integer Id {
			label "ID"
			db_field "ID"
		}
		
		Panel panel_01 {
			label "Panel 1"
			fields {
		        Fideicomiso fideicomiso {
		            label "Fideicomiso"
		            widget SearchFideicomisos
		            db_field "SCT_NUM_CONTRATO"
		            required
		        }
		        
		        Integer numero {
		            label "Número"
		            db_field "SCT_SUB_CONTRATO"
		            required
		            cardinality 1
		        }
		        
		        Text nombre {
		            label "Nombre"
		            db_field "SCT_NOM_SUB_CTO"
		            required
		            cardinality 1
		        }
		    }
		 }        
    }
}

view Fideicomisos {
	base_entity Fideicomiso
	fields {
		numero {
			label "Número"
		}
		nombre {
			label "Nombre"
		}
		tipo_persona {
			label "Tipo de Persona"
		}
		add_link
		show_link
		edit_link
		delete_link
	}
	exposed_filter_criterias {
		numero {
			label "Número"
		}		
	}
}

view Subfisos {
	base_entity Subfiso
	fields {
		fideicomiso {
			label "Fideicomiso"
		}	
		numero {
			label "Número"
		}
		nombre {
			label "Nombre"
		}
		add_link
		show_link
		edit_link
		delete_link
	}
	exposed_filter_criterias {
		numero {
			label "Número"
		}		
	}
}

entity_select SearchFideicomisos {
	base_entity Fideicomiso
	selected_field nombre
	fields {
		numero {
			label "Número"
		}
		nombre {
			label "Nombre"
		}
		tipo_persona {
			label "Tipo de Persona"
		}
	}
}