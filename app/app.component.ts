import { Component } from '@angular/core';
import { HTTP_PROVIDERS } from '@angular/http';
import { RouteConfig, ROUTER_PROVIDERS, ROUTER_DIRECTIVES } from '@angular/router-deprecated';
import "rxjs/Rx"; // Load all features

import { TopNavbarComponent } from './top-navbar/top-navbar.component';

import { HomeComponent } from './home/home.component';

import { AddFideicomisoComponent } from './fideicomiso/add-fideicomiso.component';
import { EditFideicomisoComponent } from './fideicomiso/edit-fideicomiso.component';

import { FideicomisosComponent } from './fideicomisos/fideicomisos.component';

import { FideicomisoService } from './fideicomiso/fideicomiso.service';

@Component({
	selector: 'app',
	templateUrl: 'app/app.component.html',
	directives: [ROUTER_DIRECTIVES, TopNavbarComponent, HomeComponent],
	providers: [HTTP_PROVIDERS, ROUTER_PROVIDERS, FideicomisoService]
})
@RouteConfig([
	{ path: '/home', name: 'Home', component: HomeComponent, useAsDefault: true },
	{ path: '/fideicomiso/add', name: 'AddFideicomiso', component: AddFideicomisoComponent },
	{ path: '/fideicomiso/edit', name: 'EditFideicomiso', component: EditFideicomisoComponent },
	{ path: '/fideicomisos', name: 'Fideicomisos', component: FideicomisosComponent }
])
export class AppComponent { }	
