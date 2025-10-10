import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import ApiService from './api.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './app.html',
  styleUrls: ['./app.css']
})

export default class AppComponent {
  jsonData: any[] = [];

  constructor(private api: ApiService) {}

  fetchData() {
    this.api.getData().subscribe({
      next: (res) => {
        this.jsonData = Array.isArray(res) ? res : [res];
      },
      error: (err) => console.error('Erreur API:', err),
    });
  }

  download() {
    this.api.downloadFile().subscribe({
      next: (blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'fichier.pdf';
        a.click();
        window.URL.revokeObjectURL(url);
      },
      error: (err) => console.error('Erreur téléchargement:', err),
    });
  }

  getTemperatureClass(temp: number): string {
     if (temp < 20) return 'temp-cold';        
    if (temp < 35) return 'temp-normal';        
    if (temp < 50) return 'temp-warning';       
    if (temp < 65) return 'temp-hot';           
    if (temp < 80) return 'temp-critical';      
    return 'temp-critical-max'; 
    }
  
}
