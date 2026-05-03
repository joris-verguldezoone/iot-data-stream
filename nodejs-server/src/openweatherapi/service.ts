import { OpenWeatherResponse } from "./interfaces";

const API_KEY = process.env.OPENWEATHER_API_KEY;
const cache: Record<string, { temp: number, expiry: number }> = {};

export async function getLiveWeather(city: string): Promise<number> {
  const now = Date.now();
  
  // Si on a la ville en cache et que ça date de moins de 30 min
  if (cache[city] && cache[city].expiry > now) {
    return cache[city].temp;
  }

  try {
    const response = await fetch(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${API_KEY}`
    );
const data = (await response.json()) as OpenWeatherResponse;    const temp = data.main.temp;

    // Mise en cache
    cache[city] = { temp, expiry: now + 30 * 60 * 1000 };
    return temp;
  } catch (error) {
    console.error(`Impossible de récupérer la météo pour ${city}, retour à 15°C`);
    return 15.0; // Valeur de secours
  }
}