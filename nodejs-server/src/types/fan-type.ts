export type FanConfiguration = {
  id?: number;        // facultatif car ID est généré par la DB
  consomation: number | [number, number];
  name: string;
};