import { IFideicomiso } from './fideicomiso.interface';

export class Fideicomiso implements IFideicomiso {
	Id: number;
	numero: number;
	nombre: string;
	patrimonio: string;
	tipo_persona: string;
	tipo_cliente: string;
	tipo_gobierno: string;
}	
