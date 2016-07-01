    import { bootstrap } from '@angular/platform-browser-dynamic';
    import { AppComponent } from './app.component';
    
    bootstrap(AppComponent, [])
        .then(success => console.log("Angular 2 bootstrap success"))
        .catch(error => console.log(error));