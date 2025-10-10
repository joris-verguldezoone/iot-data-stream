import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export default class ApiService {
  private apiUrl = 'http://localhost:8000'; 

  constructor(private http: HttpClient) {}

  // Récupération de données JSON
  getData(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/sensors`);
  }

  // Téléchargement fichier (exemple PDF)
  downloadFile(): Observable<Blob> {
    return this.http.get(`${this.apiUrl}/download/sensors`, {
      responseType: 'blob',
    });
  }
}
