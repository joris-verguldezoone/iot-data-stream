
/**
 * Client
**/

import * as runtime from './runtime/client.js';
import $Types = runtime.Types // general types
import $Public = runtime.Types.Public
import $Utils = runtime.Types.Utils
import $Extensions = runtime.Types.Extensions
import $Result = runtime.Types.Result

export type PrismaPromise<T> = $Public.PrismaPromise<T>


/**
 * Model ClusterLocation
 * 
 */
export type ClusterLocation = $Result.DefaultSelection<Prisma.$ClusterLocationPayload>
/**
 * Model LoadProfile
 * 
 */
export type LoadProfile = $Result.DefaultSelection<Prisma.$LoadProfilePayload>
/**
 * Model FanConfiguration
 * 
 */
export type FanConfiguration = $Result.DefaultSelection<Prisma.$FanConfigurationPayload>
/**
 * Model FanCatalog
 * 
 */
export type FanCatalog = $Result.DefaultSelection<Prisma.$FanCatalogPayload>
/**
 * Model CpuCoolerCatalog
 * 
 */
export type CpuCoolerCatalog = $Result.DefaultSelection<Prisma.$CpuCoolerCatalogPayload>
/**
 * Model ClusterConfiguration
 * 
 */
export type ClusterConfiguration = $Result.DefaultSelection<Prisma.$ClusterConfigurationPayload>
/**
 * Model Cluster
 * 
 */
export type Cluster = $Result.DefaultSelection<Prisma.$ClusterPayload>
/**
 * Model Server
 * 
 */
export type Server = $Result.DefaultSelection<Prisma.$ServerPayload>
/**
 * Model Fan
 * 
 */
export type Fan = $Result.DefaultSelection<Prisma.$FanPayload>
/**
 * Model Sensor
 * 
 */
export type Sensor = $Result.DefaultSelection<Prisma.$SensorPayload>
/**
 * Model SensorData
 * 
 */
export type SensorData = $Result.DefaultSelection<Prisma.$SensorDataPayload>

/**
 * ##  Prisma Client ʲˢ
 *
 * Type-safe database client for TypeScript & Node.js
 * @example
 * ```
 * const prisma = new PrismaClient({
 *   adapter: new PrismaPg({ connectionString: process.env.DATABASE_URL })
 * })
 * // Fetch zero or more ClusterLocations
 * const clusterLocations = await prisma.clusterLocation.findMany()
 * ```
 *
 *
 * Read more in our [docs](https://pris.ly/d/client).
 */
export class PrismaClient<
  ClientOptions extends Prisma.PrismaClientOptions = Prisma.PrismaClientOptions,
  const U = 'log' extends keyof ClientOptions ? ClientOptions['log'] extends Array<Prisma.LogLevel | Prisma.LogDefinition> ? Prisma.GetEvents<ClientOptions['log']> : never : never,
  ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs
> {
  [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['other'] }

    /**
   * ##  Prisma Client ʲˢ
   *
   * Type-safe database client for TypeScript & Node.js
   * @example
   * ```
   * const prisma = new PrismaClient({
   *   adapter: new PrismaPg({ connectionString: process.env.DATABASE_URL })
   * })
   * // Fetch zero or more ClusterLocations
   * const clusterLocations = await prisma.clusterLocation.findMany()
   * ```
   *
   *
   * Read more in our [docs](https://pris.ly/d/client).
   */

  constructor(optionsArg ?: Prisma.Subset<ClientOptions, Prisma.PrismaClientOptions>);
  $on<V extends U>(eventType: V, callback: (event: V extends 'query' ? Prisma.QueryEvent : Prisma.LogEvent) => void): PrismaClient;

  /**
   * Connect with the database
   */
  $connect(): $Utils.JsPromise<void>;

  /**
   * Disconnect from the database
   */
  $disconnect(): $Utils.JsPromise<void>;

/**
   * Executes a prepared raw query and returns the number of affected rows.
   * @example
   * ```
   * const result = await prisma.$executeRaw`UPDATE User SET cool = ${true} WHERE email = ${'user@email.com'};`
   * ```
   *
   * Read more in our [docs](https://pris.ly/d/raw-queries).
   */
  $executeRaw<T = unknown>(query: TemplateStringsArray | Prisma.Sql, ...values: any[]): Prisma.PrismaPromise<number>;

  /**
   * Executes a raw query and returns the number of affected rows.
   * Susceptible to SQL injections, see documentation.
   * @example
   * ```
   * const result = await prisma.$executeRawUnsafe('UPDATE User SET cool = $1 WHERE email = $2 ;', true, 'user@email.com')
   * ```
   *
   * Read more in our [docs](https://pris.ly/d/raw-queries).
   */
  $executeRawUnsafe<T = unknown>(query: string, ...values: any[]): Prisma.PrismaPromise<number>;

  /**
   * Performs a prepared raw query and returns the `SELECT` data.
   * @example
   * ```
   * const result = await prisma.$queryRaw`SELECT * FROM User WHERE id = ${1} OR email = ${'user@email.com'};`
   * ```
   *
   * Read more in our [docs](https://pris.ly/d/raw-queries).
   */
  $queryRaw<T = unknown>(query: TemplateStringsArray | Prisma.Sql, ...values: any[]): Prisma.PrismaPromise<T>;

  /**
   * Performs a raw query and returns the `SELECT` data.
   * Susceptible to SQL injections, see documentation.
   * @example
   * ```
   * const result = await prisma.$queryRawUnsafe('SELECT * FROM User WHERE id = $1 OR email = $2;', 1, 'user@email.com')
   * ```
   *
   * Read more in our [docs](https://pris.ly/d/raw-queries).
   */
  $queryRawUnsafe<T = unknown>(query: string, ...values: any[]): Prisma.PrismaPromise<T>;


  /**
   * Allows the running of a sequence of read/write operations that are guaranteed to either succeed or fail as a whole.
   * @example
   * ```
   * const [george, bob, alice] = await prisma.$transaction([
   *   prisma.user.create({ data: { name: 'George' } }),
   *   prisma.user.create({ data: { name: 'Bob' } }),
   *   prisma.user.create({ data: { name: 'Alice' } }),
   * ])
   * ```
   * 
   * Read more in our [docs](https://www.prisma.io/docs/orm/prisma-client/queries/transactions).
   */
  $transaction<P extends Prisma.PrismaPromise<any>[]>(arg: [...P], options?: { maxWait?: number, timeout?: number, isolationLevel?: Prisma.TransactionIsolationLevel }): $Utils.JsPromise<runtime.Types.Utils.UnwrapTuple<P>>

  $transaction<R>(fn: (prisma: Omit<PrismaClient, runtime.ITXClientDenyList>) => $Utils.JsPromise<R>, options?: { maxWait?: number, timeout?: number, isolationLevel?: Prisma.TransactionIsolationLevel }): $Utils.JsPromise<R>

  $extends: $Extensions.ExtendsHook<"extends", Prisma.TypeMapCb<ClientOptions>, ExtArgs, $Utils.Call<Prisma.TypeMapCb<ClientOptions>, {
    extArgs: ExtArgs
  }>>

      /**
   * `prisma.clusterLocation`: Exposes CRUD operations for the **ClusterLocation** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more ClusterLocations
    * const clusterLocations = await prisma.clusterLocation.findMany()
    * ```
    */
  get clusterLocation(): Prisma.ClusterLocationDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.loadProfile`: Exposes CRUD operations for the **LoadProfile** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more LoadProfiles
    * const loadProfiles = await prisma.loadProfile.findMany()
    * ```
    */
  get loadProfile(): Prisma.LoadProfileDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.fanConfiguration`: Exposes CRUD operations for the **FanConfiguration** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more FanConfigurations
    * const fanConfigurations = await prisma.fanConfiguration.findMany()
    * ```
    */
  get fanConfiguration(): Prisma.FanConfigurationDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.fanCatalog`: Exposes CRUD operations for the **FanCatalog** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more FanCatalogs
    * const fanCatalogs = await prisma.fanCatalog.findMany()
    * ```
    */
  get fanCatalog(): Prisma.FanCatalogDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.cpuCoolerCatalog`: Exposes CRUD operations for the **CpuCoolerCatalog** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more CpuCoolerCatalogs
    * const cpuCoolerCatalogs = await prisma.cpuCoolerCatalog.findMany()
    * ```
    */
  get cpuCoolerCatalog(): Prisma.CpuCoolerCatalogDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.clusterConfiguration`: Exposes CRUD operations for the **ClusterConfiguration** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more ClusterConfigurations
    * const clusterConfigurations = await prisma.clusterConfiguration.findMany()
    * ```
    */
  get clusterConfiguration(): Prisma.ClusterConfigurationDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.cluster`: Exposes CRUD operations for the **Cluster** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more Clusters
    * const clusters = await prisma.cluster.findMany()
    * ```
    */
  get cluster(): Prisma.ClusterDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.server`: Exposes CRUD operations for the **Server** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more Servers
    * const servers = await prisma.server.findMany()
    * ```
    */
  get server(): Prisma.ServerDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.fan`: Exposes CRUD operations for the **Fan** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more Fans
    * const fans = await prisma.fan.findMany()
    * ```
    */
  get fan(): Prisma.FanDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.sensor`: Exposes CRUD operations for the **Sensor** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more Sensors
    * const sensors = await prisma.sensor.findMany()
    * ```
    */
  get sensor(): Prisma.SensorDelegate<ExtArgs, ClientOptions>;

  /**
   * `prisma.sensorData`: Exposes CRUD operations for the **SensorData** model.
    * Example usage:
    * ```ts
    * // Fetch zero or more SensorData
    * const sensorData = await prisma.sensorData.findMany()
    * ```
    */
  get sensorData(): Prisma.SensorDataDelegate<ExtArgs, ClientOptions>;
}

export namespace Prisma {
  export import DMMF = runtime.DMMF

  export type PrismaPromise<T> = $Public.PrismaPromise<T>

  /**
   * Validator
   */
  export import validator = runtime.Public.validator

  /**
   * Prisma Errors
   */
  export import PrismaClientKnownRequestError = runtime.PrismaClientKnownRequestError
  export import PrismaClientUnknownRequestError = runtime.PrismaClientUnknownRequestError
  export import PrismaClientRustPanicError = runtime.PrismaClientRustPanicError
  export import PrismaClientInitializationError = runtime.PrismaClientInitializationError
  export import PrismaClientValidationError = runtime.PrismaClientValidationError

  /**
   * Re-export of sql-template-tag
   */
  export import sql = runtime.sqltag
  export import empty = runtime.empty
  export import join = runtime.join
  export import raw = runtime.raw
  export import Sql = runtime.Sql



  /**
   * Decimal.js
   */
  export import Decimal = runtime.Decimal

  export type DecimalJsLike = runtime.DecimalJsLike

  /**
  * Extensions
  */
  export import Extension = $Extensions.UserArgs
  export import getExtensionContext = runtime.Extensions.getExtensionContext
  export import Args = $Public.Args
  export import Payload = $Public.Payload
  export import Result = $Public.Result
  export import Exact = $Public.Exact

  /**
   * Prisma Client JS version: 7.8.0
   * Query Engine version: 3c6e192761c0362d496ed980de936e2f3cebcd3a
   */
  export type PrismaVersion = {
    client: string
    engine: string
  }

  export const prismaVersion: PrismaVersion

  /**
   * Utility Types
   */


  export import Bytes = runtime.Bytes
  export import JsonObject = runtime.JsonObject
  export import JsonArray = runtime.JsonArray
  export import JsonValue = runtime.JsonValue
  export import InputJsonObject = runtime.InputJsonObject
  export import InputJsonArray = runtime.InputJsonArray
  export import InputJsonValue = runtime.InputJsonValue

  /**
   * Types of the values used to represent different kinds of `null` values when working with JSON fields.
   *
   * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
   */
  namespace NullTypes {
    /**
    * Type of `Prisma.DbNull`.
    *
    * You cannot use other instances of this class. Please use the `Prisma.DbNull` value.
    *
    * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
    */
    class DbNull {
      private DbNull: never
      private constructor()
    }

    /**
    * Type of `Prisma.JsonNull`.
    *
    * You cannot use other instances of this class. Please use the `Prisma.JsonNull` value.
    *
    * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
    */
    class JsonNull {
      private JsonNull: never
      private constructor()
    }

    /**
    * Type of `Prisma.AnyNull`.
    *
    * You cannot use other instances of this class. Please use the `Prisma.AnyNull` value.
    *
    * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
    */
    class AnyNull {
      private AnyNull: never
      private constructor()
    }
  }

  /**
   * Helper for filtering JSON entries that have `null` on the database (empty on the db)
   *
   * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
   */
  export const DbNull: NullTypes.DbNull

  /**
   * Helper for filtering JSON entries that have JSON `null` values (not empty on the db)
   *
   * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
   */
  export const JsonNull: NullTypes.JsonNull

  /**
   * Helper for filtering JSON entries that are `Prisma.DbNull` or `Prisma.JsonNull`
   *
   * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
   */
  export const AnyNull: NullTypes.AnyNull

  type SelectAndInclude = {
    select: any
    include: any
  }

  type SelectAndOmit = {
    select: any
    omit: any
  }

  /**
   * Get the type of the value, that the Promise holds.
   */
  export type PromiseType<T extends PromiseLike<any>> = T extends PromiseLike<infer U> ? U : T;

  /**
   * Get the return type of a function which returns a Promise.
   */
  export type PromiseReturnType<T extends (...args: any) => $Utils.JsPromise<any>> = PromiseType<ReturnType<T>>

  /**
   * From T, pick a set of properties whose keys are in the union K
   */
  type Prisma__Pick<T, K extends keyof T> = {
      [P in K]: T[P];
  };


  export type Enumerable<T> = T | Array<T>;

  export type RequiredKeys<T> = {
    [K in keyof T]-?: {} extends Prisma__Pick<T, K> ? never : K
  }[keyof T]

  export type TruthyKeys<T> = keyof {
    [K in keyof T as T[K] extends false | undefined | null ? never : K]: K
  }

  export type TrueKeys<T> = TruthyKeys<Prisma__Pick<T, RequiredKeys<T>>>

  /**
   * Subset
   * @desc From `T` pick properties that exist in `U`. Simple version of Intersection
   */
  export type Subset<T, U> = {
    [key in keyof T]: key extends keyof U ? T[key] : never;
  };

  /**
   * SelectSubset
   * @desc From `T` pick properties that exist in `U`. Simple version of Intersection.
   * Additionally, it validates, if both select and include are present. If the case, it errors.
   */
  export type SelectSubset<T, U> = {
    [key in keyof T]: key extends keyof U ? T[key] : never
  } &
    (T extends SelectAndInclude
      ? 'Please either choose `select` or `include`.'
      : T extends SelectAndOmit
        ? 'Please either choose `select` or `omit`.'
        : {})

  /**
   * Subset + Intersection
   * @desc From `T` pick properties that exist in `U` and intersect `K`
   */
  export type SubsetIntersection<T, U, K> = {
    [key in keyof T]: key extends keyof U ? T[key] : never
  } &
    K

  type Without<T, U> = { [P in Exclude<keyof T, keyof U>]?: never };

  /**
   * XOR is needed to have a real mutually exclusive union type
   * https://stackoverflow.com/questions/42123407/does-typescript-support-mutually-exclusive-types
   */
  type XOR<T, U> =
    T extends object ?
    U extends object ?
      (Without<T, U> & U) | (Without<U, T> & T)
    : U : T


  /**
   * Is T a Record?
   */
  type IsObject<T extends any> = T extends Array<any>
  ? False
  : T extends Date
  ? False
  : T extends Uint8Array
  ? False
  : T extends BigInt
  ? False
  : T extends object
  ? True
  : False


  /**
   * If it's T[], return T
   */
  export type UnEnumerate<T extends unknown> = T extends Array<infer U> ? U : T

  /**
   * From ts-toolbelt
   */

  type __Either<O extends object, K extends Key> = Omit<O, K> &
    {
      // Merge all but K
      [P in K]: Prisma__Pick<O, P & keyof O> // With K possibilities
    }[K]

  type EitherStrict<O extends object, K extends Key> = Strict<__Either<O, K>>

  type EitherLoose<O extends object, K extends Key> = ComputeRaw<__Either<O, K>>

  type _Either<
    O extends object,
    K extends Key,
    strict extends Boolean
  > = {
    1: EitherStrict<O, K>
    0: EitherLoose<O, K>
  }[strict]

  type Either<
    O extends object,
    K extends Key,
    strict extends Boolean = 1
  > = O extends unknown ? _Either<O, K, strict> : never

  export type Union = any

  type PatchUndefined<O extends object, O1 extends object> = {
    [K in keyof O]: O[K] extends undefined ? At<O1, K> : O[K]
  } & {}

  /** Helper Types for "Merge" **/
  export type IntersectOf<U extends Union> = (
    U extends unknown ? (k: U) => void : never
  ) extends (k: infer I) => void
    ? I
    : never

  export type Overwrite<O extends object, O1 extends object> = {
      [K in keyof O]: K extends keyof O1 ? O1[K] : O[K];
  } & {};

  type _Merge<U extends object> = IntersectOf<Overwrite<U, {
      [K in keyof U]-?: At<U, K>;
  }>>;

  type Key = string | number | symbol;
  type AtBasic<O extends object, K extends Key> = K extends keyof O ? O[K] : never;
  type AtStrict<O extends object, K extends Key> = O[K & keyof O];
  type AtLoose<O extends object, K extends Key> = O extends unknown ? AtStrict<O, K> : never;
  export type At<O extends object, K extends Key, strict extends Boolean = 1> = {
      1: AtStrict<O, K>;
      0: AtLoose<O, K>;
  }[strict];

  export type ComputeRaw<A extends any> = A extends Function ? A : {
    [K in keyof A]: A[K];
  } & {};

  export type OptionalFlat<O> = {
    [K in keyof O]?: O[K];
  } & {};

  type _Record<K extends keyof any, T> = {
    [P in K]: T;
  };

  // cause typescript not to expand types and preserve names
  type NoExpand<T> = T extends unknown ? T : never;

  // this type assumes the passed object is entirely optional
  type AtLeast<O extends object, K extends string> = NoExpand<
    O extends unknown
    ? | (K extends keyof O ? { [P in K]: O[P] } & O : O)
      | {[P in keyof O as P extends K ? P : never]-?: O[P]} & O
    : never>;

  type _Strict<U, _U = U> = U extends unknown ? U & OptionalFlat<_Record<Exclude<Keys<_U>, keyof U>, never>> : never;

  export type Strict<U extends object> = ComputeRaw<_Strict<U>>;
  /** End Helper Types for "Merge" **/

  export type Merge<U extends object> = ComputeRaw<_Merge<Strict<U>>>;

  /**
  A [[Boolean]]
  */
  export type Boolean = True | False

  // /**
  // 1
  // */
  export type True = 1

  /**
  0
  */
  export type False = 0

  export type Not<B extends Boolean> = {
    0: 1
    1: 0
  }[B]

  export type Extends<A1 extends any, A2 extends any> = [A1] extends [never]
    ? 0 // anything `never` is false
    : A1 extends A2
    ? 1
    : 0

  export type Has<U extends Union, U1 extends Union> = Not<
    Extends<Exclude<U1, U>, U1>
  >

  export type Or<B1 extends Boolean, B2 extends Boolean> = {
    0: {
      0: 0
      1: 1
    }
    1: {
      0: 1
      1: 1
    }
  }[B1][B2]

  export type Keys<U extends Union> = U extends unknown ? keyof U : never

  type Cast<A, B> = A extends B ? A : B;

  export const type: unique symbol;



  /**
   * Used by group by
   */

  export type GetScalarType<T, O> = O extends object ? {
    [P in keyof T]: P extends keyof O
      ? O[P]
      : never
  } : never

  type FieldPaths<
    T,
    U = Omit<T, '_avg' | '_sum' | '_count' | '_min' | '_max'>
  > = IsObject<T> extends True ? U : T

  type GetHavingFields<T> = {
    [K in keyof T]: Or<
      Or<Extends<'OR', K>, Extends<'AND', K>>,
      Extends<'NOT', K>
    > extends True
      ? // infer is only needed to not hit TS limit
        // based on the brilliant idea of Pierre-Antoine Mills
        // https://github.com/microsoft/TypeScript/issues/30188#issuecomment-478938437
        T[K] extends infer TK
        ? GetHavingFields<UnEnumerate<TK> extends object ? Merge<UnEnumerate<TK>> : never>
        : never
      : {} extends FieldPaths<T[K]>
      ? never
      : K
  }[keyof T]

  /**
   * Convert tuple to union
   */
  type _TupleToUnion<T> = T extends (infer E)[] ? E : never
  type TupleToUnion<K extends readonly any[]> = _TupleToUnion<K>
  type MaybeTupleToUnion<T> = T extends any[] ? TupleToUnion<T> : T

  /**
   * Like `Pick`, but additionally can also accept an array of keys
   */
  type PickEnumerable<T, K extends Enumerable<keyof T> | keyof T> = Prisma__Pick<T, MaybeTupleToUnion<K>>

  /**
   * Exclude all keys with underscores
   */
  type ExcludeUnderscoreKeys<T extends string> = T extends `_${string}` ? never : T


  export type FieldRef<Model, FieldType> = runtime.FieldRef<Model, FieldType>

  type FieldRefInputType<Model, FieldType> = Model extends never ? never : FieldRef<Model, FieldType>


  export const ModelName: {
    ClusterLocation: 'ClusterLocation',
    LoadProfile: 'LoadProfile',
    FanConfiguration: 'FanConfiguration',
    FanCatalog: 'FanCatalog',
    CpuCoolerCatalog: 'CpuCoolerCatalog',
    ClusterConfiguration: 'ClusterConfiguration',
    Cluster: 'Cluster',
    Server: 'Server',
    Fan: 'Fan',
    Sensor: 'Sensor',
    SensorData: 'SensorData'
  };

  export type ModelName = (typeof ModelName)[keyof typeof ModelName]



  interface TypeMapCb<ClientOptions = {}> extends $Utils.Fn<{extArgs: $Extensions.InternalArgs }, $Utils.Record<string, any>> {
    returns: Prisma.TypeMap<this['params']['extArgs'], ClientOptions extends { omit: infer OmitOptions } ? OmitOptions : {}>
  }

  export type TypeMap<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> = {
    globalOmitOptions: {
      omit: GlobalOmitOptions
    }
    meta: {
      modelProps: "clusterLocation" | "loadProfile" | "fanConfiguration" | "fanCatalog" | "cpuCoolerCatalog" | "clusterConfiguration" | "cluster" | "server" | "fan" | "sensor" | "sensorData"
      txIsolationLevel: Prisma.TransactionIsolationLevel
    }
    model: {
      ClusterLocation: {
        payload: Prisma.$ClusterLocationPayload<ExtArgs>
        fields: Prisma.ClusterLocationFieldRefs
        operations: {
          findUnique: {
            args: Prisma.ClusterLocationFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.ClusterLocationFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>
          }
          findFirst: {
            args: Prisma.ClusterLocationFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.ClusterLocationFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>
          }
          findMany: {
            args: Prisma.ClusterLocationFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>[]
          }
          create: {
            args: Prisma.ClusterLocationCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>
          }
          createMany: {
            args: Prisma.ClusterLocationCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.ClusterLocationCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>[]
          }
          delete: {
            args: Prisma.ClusterLocationDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>
          }
          update: {
            args: Prisma.ClusterLocationUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>
          }
          deleteMany: {
            args: Prisma.ClusterLocationDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.ClusterLocationUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.ClusterLocationUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>[]
          }
          upsert: {
            args: Prisma.ClusterLocationUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterLocationPayload>
          }
          aggregate: {
            args: Prisma.ClusterLocationAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateClusterLocation>
          }
          groupBy: {
            args: Prisma.ClusterLocationGroupByArgs<ExtArgs>
            result: $Utils.Optional<ClusterLocationGroupByOutputType>[]
          }
          count: {
            args: Prisma.ClusterLocationCountArgs<ExtArgs>
            result: $Utils.Optional<ClusterLocationCountAggregateOutputType> | number
          }
        }
      }
      LoadProfile: {
        payload: Prisma.$LoadProfilePayload<ExtArgs>
        fields: Prisma.LoadProfileFieldRefs
        operations: {
          findUnique: {
            args: Prisma.LoadProfileFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.LoadProfileFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>
          }
          findFirst: {
            args: Prisma.LoadProfileFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.LoadProfileFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>
          }
          findMany: {
            args: Prisma.LoadProfileFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>[]
          }
          create: {
            args: Prisma.LoadProfileCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>
          }
          createMany: {
            args: Prisma.LoadProfileCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.LoadProfileCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>[]
          }
          delete: {
            args: Prisma.LoadProfileDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>
          }
          update: {
            args: Prisma.LoadProfileUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>
          }
          deleteMany: {
            args: Prisma.LoadProfileDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.LoadProfileUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.LoadProfileUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>[]
          }
          upsert: {
            args: Prisma.LoadProfileUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$LoadProfilePayload>
          }
          aggregate: {
            args: Prisma.LoadProfileAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateLoadProfile>
          }
          groupBy: {
            args: Prisma.LoadProfileGroupByArgs<ExtArgs>
            result: $Utils.Optional<LoadProfileGroupByOutputType>[]
          }
          count: {
            args: Prisma.LoadProfileCountArgs<ExtArgs>
            result: $Utils.Optional<LoadProfileCountAggregateOutputType> | number
          }
        }
      }
      FanConfiguration: {
        payload: Prisma.$FanConfigurationPayload<ExtArgs>
        fields: Prisma.FanConfigurationFieldRefs
        operations: {
          findUnique: {
            args: Prisma.FanConfigurationFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.FanConfigurationFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>
          }
          findFirst: {
            args: Prisma.FanConfigurationFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.FanConfigurationFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>
          }
          findMany: {
            args: Prisma.FanConfigurationFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>[]
          }
          create: {
            args: Prisma.FanConfigurationCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>
          }
          createMany: {
            args: Prisma.FanConfigurationCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.FanConfigurationCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>[]
          }
          delete: {
            args: Prisma.FanConfigurationDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>
          }
          update: {
            args: Prisma.FanConfigurationUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>
          }
          deleteMany: {
            args: Prisma.FanConfigurationDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.FanConfigurationUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.FanConfigurationUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>[]
          }
          upsert: {
            args: Prisma.FanConfigurationUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanConfigurationPayload>
          }
          aggregate: {
            args: Prisma.FanConfigurationAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateFanConfiguration>
          }
          groupBy: {
            args: Prisma.FanConfigurationGroupByArgs<ExtArgs>
            result: $Utils.Optional<FanConfigurationGroupByOutputType>[]
          }
          count: {
            args: Prisma.FanConfigurationCountArgs<ExtArgs>
            result: $Utils.Optional<FanConfigurationCountAggregateOutputType> | number
          }
        }
      }
      FanCatalog: {
        payload: Prisma.$FanCatalogPayload<ExtArgs>
        fields: Prisma.FanCatalogFieldRefs
        operations: {
          findUnique: {
            args: Prisma.FanCatalogFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.FanCatalogFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>
          }
          findFirst: {
            args: Prisma.FanCatalogFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.FanCatalogFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>
          }
          findMany: {
            args: Prisma.FanCatalogFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>[]
          }
          create: {
            args: Prisma.FanCatalogCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>
          }
          createMany: {
            args: Prisma.FanCatalogCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.FanCatalogCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>[]
          }
          delete: {
            args: Prisma.FanCatalogDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>
          }
          update: {
            args: Prisma.FanCatalogUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>
          }
          deleteMany: {
            args: Prisma.FanCatalogDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.FanCatalogUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.FanCatalogUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>[]
          }
          upsert: {
            args: Prisma.FanCatalogUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanCatalogPayload>
          }
          aggregate: {
            args: Prisma.FanCatalogAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateFanCatalog>
          }
          groupBy: {
            args: Prisma.FanCatalogGroupByArgs<ExtArgs>
            result: $Utils.Optional<FanCatalogGroupByOutputType>[]
          }
          count: {
            args: Prisma.FanCatalogCountArgs<ExtArgs>
            result: $Utils.Optional<FanCatalogCountAggregateOutputType> | number
          }
        }
      }
      CpuCoolerCatalog: {
        payload: Prisma.$CpuCoolerCatalogPayload<ExtArgs>
        fields: Prisma.CpuCoolerCatalogFieldRefs
        operations: {
          findUnique: {
            args: Prisma.CpuCoolerCatalogFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.CpuCoolerCatalogFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>
          }
          findFirst: {
            args: Prisma.CpuCoolerCatalogFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.CpuCoolerCatalogFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>
          }
          findMany: {
            args: Prisma.CpuCoolerCatalogFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>[]
          }
          create: {
            args: Prisma.CpuCoolerCatalogCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>
          }
          createMany: {
            args: Prisma.CpuCoolerCatalogCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.CpuCoolerCatalogCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>[]
          }
          delete: {
            args: Prisma.CpuCoolerCatalogDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>
          }
          update: {
            args: Prisma.CpuCoolerCatalogUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>
          }
          deleteMany: {
            args: Prisma.CpuCoolerCatalogDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.CpuCoolerCatalogUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.CpuCoolerCatalogUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>[]
          }
          upsert: {
            args: Prisma.CpuCoolerCatalogUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$CpuCoolerCatalogPayload>
          }
          aggregate: {
            args: Prisma.CpuCoolerCatalogAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateCpuCoolerCatalog>
          }
          groupBy: {
            args: Prisma.CpuCoolerCatalogGroupByArgs<ExtArgs>
            result: $Utils.Optional<CpuCoolerCatalogGroupByOutputType>[]
          }
          count: {
            args: Prisma.CpuCoolerCatalogCountArgs<ExtArgs>
            result: $Utils.Optional<CpuCoolerCatalogCountAggregateOutputType> | number
          }
        }
      }
      ClusterConfiguration: {
        payload: Prisma.$ClusterConfigurationPayload<ExtArgs>
        fields: Prisma.ClusterConfigurationFieldRefs
        operations: {
          findUnique: {
            args: Prisma.ClusterConfigurationFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.ClusterConfigurationFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>
          }
          findFirst: {
            args: Prisma.ClusterConfigurationFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.ClusterConfigurationFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>
          }
          findMany: {
            args: Prisma.ClusterConfigurationFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>[]
          }
          create: {
            args: Prisma.ClusterConfigurationCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>
          }
          createMany: {
            args: Prisma.ClusterConfigurationCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.ClusterConfigurationCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>[]
          }
          delete: {
            args: Prisma.ClusterConfigurationDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>
          }
          update: {
            args: Prisma.ClusterConfigurationUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>
          }
          deleteMany: {
            args: Prisma.ClusterConfigurationDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.ClusterConfigurationUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.ClusterConfigurationUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>[]
          }
          upsert: {
            args: Prisma.ClusterConfigurationUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterConfigurationPayload>
          }
          aggregate: {
            args: Prisma.ClusterConfigurationAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateClusterConfiguration>
          }
          groupBy: {
            args: Prisma.ClusterConfigurationGroupByArgs<ExtArgs>
            result: $Utils.Optional<ClusterConfigurationGroupByOutputType>[]
          }
          count: {
            args: Prisma.ClusterConfigurationCountArgs<ExtArgs>
            result: $Utils.Optional<ClusterConfigurationCountAggregateOutputType> | number
          }
        }
      }
      Cluster: {
        payload: Prisma.$ClusterPayload<ExtArgs>
        fields: Prisma.ClusterFieldRefs
        operations: {
          findUnique: {
            args: Prisma.ClusterFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.ClusterFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>
          }
          findFirst: {
            args: Prisma.ClusterFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.ClusterFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>
          }
          findMany: {
            args: Prisma.ClusterFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>[]
          }
          create: {
            args: Prisma.ClusterCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>
          }
          createMany: {
            args: Prisma.ClusterCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.ClusterCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>[]
          }
          delete: {
            args: Prisma.ClusterDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>
          }
          update: {
            args: Prisma.ClusterUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>
          }
          deleteMany: {
            args: Prisma.ClusterDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.ClusterUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.ClusterUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>[]
          }
          upsert: {
            args: Prisma.ClusterUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ClusterPayload>
          }
          aggregate: {
            args: Prisma.ClusterAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateCluster>
          }
          groupBy: {
            args: Prisma.ClusterGroupByArgs<ExtArgs>
            result: $Utils.Optional<ClusterGroupByOutputType>[]
          }
          count: {
            args: Prisma.ClusterCountArgs<ExtArgs>
            result: $Utils.Optional<ClusterCountAggregateOutputType> | number
          }
        }
      }
      Server: {
        payload: Prisma.$ServerPayload<ExtArgs>
        fields: Prisma.ServerFieldRefs
        operations: {
          findUnique: {
            args: Prisma.ServerFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.ServerFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>
          }
          findFirst: {
            args: Prisma.ServerFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.ServerFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>
          }
          findMany: {
            args: Prisma.ServerFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>[]
          }
          create: {
            args: Prisma.ServerCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>
          }
          createMany: {
            args: Prisma.ServerCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.ServerCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>[]
          }
          delete: {
            args: Prisma.ServerDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>
          }
          update: {
            args: Prisma.ServerUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>
          }
          deleteMany: {
            args: Prisma.ServerDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.ServerUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.ServerUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>[]
          }
          upsert: {
            args: Prisma.ServerUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$ServerPayload>
          }
          aggregate: {
            args: Prisma.ServerAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateServer>
          }
          groupBy: {
            args: Prisma.ServerGroupByArgs<ExtArgs>
            result: $Utils.Optional<ServerGroupByOutputType>[]
          }
          count: {
            args: Prisma.ServerCountArgs<ExtArgs>
            result: $Utils.Optional<ServerCountAggregateOutputType> | number
          }
        }
      }
      Fan: {
        payload: Prisma.$FanPayload<ExtArgs>
        fields: Prisma.FanFieldRefs
        operations: {
          findUnique: {
            args: Prisma.FanFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.FanFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>
          }
          findFirst: {
            args: Prisma.FanFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.FanFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>
          }
          findMany: {
            args: Prisma.FanFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>[]
          }
          create: {
            args: Prisma.FanCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>
          }
          createMany: {
            args: Prisma.FanCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.FanCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>[]
          }
          delete: {
            args: Prisma.FanDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>
          }
          update: {
            args: Prisma.FanUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>
          }
          deleteMany: {
            args: Prisma.FanDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.FanUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.FanUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>[]
          }
          upsert: {
            args: Prisma.FanUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$FanPayload>
          }
          aggregate: {
            args: Prisma.FanAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateFan>
          }
          groupBy: {
            args: Prisma.FanGroupByArgs<ExtArgs>
            result: $Utils.Optional<FanGroupByOutputType>[]
          }
          count: {
            args: Prisma.FanCountArgs<ExtArgs>
            result: $Utils.Optional<FanCountAggregateOutputType> | number
          }
        }
      }
      Sensor: {
        payload: Prisma.$SensorPayload<ExtArgs>
        fields: Prisma.SensorFieldRefs
        operations: {
          findUnique: {
            args: Prisma.SensorFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.SensorFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>
          }
          findFirst: {
            args: Prisma.SensorFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.SensorFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>
          }
          findMany: {
            args: Prisma.SensorFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>[]
          }
          create: {
            args: Prisma.SensorCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>
          }
          createMany: {
            args: Prisma.SensorCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.SensorCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>[]
          }
          delete: {
            args: Prisma.SensorDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>
          }
          update: {
            args: Prisma.SensorUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>
          }
          deleteMany: {
            args: Prisma.SensorDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.SensorUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.SensorUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>[]
          }
          upsert: {
            args: Prisma.SensorUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorPayload>
          }
          aggregate: {
            args: Prisma.SensorAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateSensor>
          }
          groupBy: {
            args: Prisma.SensorGroupByArgs<ExtArgs>
            result: $Utils.Optional<SensorGroupByOutputType>[]
          }
          count: {
            args: Prisma.SensorCountArgs<ExtArgs>
            result: $Utils.Optional<SensorCountAggregateOutputType> | number
          }
        }
      }
      SensorData: {
        payload: Prisma.$SensorDataPayload<ExtArgs>
        fields: Prisma.SensorDataFieldRefs
        operations: {
          findUnique: {
            args: Prisma.SensorDataFindUniqueArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload> | null
          }
          findUniqueOrThrow: {
            args: Prisma.SensorDataFindUniqueOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>
          }
          findFirst: {
            args: Prisma.SensorDataFindFirstArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload> | null
          }
          findFirstOrThrow: {
            args: Prisma.SensorDataFindFirstOrThrowArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>
          }
          findMany: {
            args: Prisma.SensorDataFindManyArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>[]
          }
          create: {
            args: Prisma.SensorDataCreateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>
          }
          createMany: {
            args: Prisma.SensorDataCreateManyArgs<ExtArgs>
            result: BatchPayload
          }
          createManyAndReturn: {
            args: Prisma.SensorDataCreateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>[]
          }
          delete: {
            args: Prisma.SensorDataDeleteArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>
          }
          update: {
            args: Prisma.SensorDataUpdateArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>
          }
          deleteMany: {
            args: Prisma.SensorDataDeleteManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateMany: {
            args: Prisma.SensorDataUpdateManyArgs<ExtArgs>
            result: BatchPayload
          }
          updateManyAndReturn: {
            args: Prisma.SensorDataUpdateManyAndReturnArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>[]
          }
          upsert: {
            args: Prisma.SensorDataUpsertArgs<ExtArgs>
            result: $Utils.PayloadToResult<Prisma.$SensorDataPayload>
          }
          aggregate: {
            args: Prisma.SensorDataAggregateArgs<ExtArgs>
            result: $Utils.Optional<AggregateSensorData>
          }
          groupBy: {
            args: Prisma.SensorDataGroupByArgs<ExtArgs>
            result: $Utils.Optional<SensorDataGroupByOutputType>[]
          }
          count: {
            args: Prisma.SensorDataCountArgs<ExtArgs>
            result: $Utils.Optional<SensorDataCountAggregateOutputType> | number
          }
        }
      }
    }
  } & {
    other: {
      payload: any
      operations: {
        $executeRaw: {
          args: [query: TemplateStringsArray | Prisma.Sql, ...values: any[]],
          result: any
        }
        $executeRawUnsafe: {
          args: [query: string, ...values: any[]],
          result: any
        }
        $queryRaw: {
          args: [query: TemplateStringsArray | Prisma.Sql, ...values: any[]],
          result: any
        }
        $queryRawUnsafe: {
          args: [query: string, ...values: any[]],
          result: any
        }
      }
    }
  }
  export const defineExtension: $Extensions.ExtendsHook<"define", Prisma.TypeMapCb, $Extensions.DefaultArgs>
  export type DefaultPrismaClient = PrismaClient
  export type ErrorFormat = 'pretty' | 'colorless' | 'minimal'
  export interface PrismaClientOptions {
    /**
     * @default "colorless"
     */
    errorFormat?: ErrorFormat
    /**
     * @example
     * ```
     * // Shorthand for `emit: 'stdout'`
     * log: ['query', 'info', 'warn', 'error']
     * 
     * // Emit as events only
     * log: [
     *   { emit: 'event', level: 'query' },
     *   { emit: 'event', level: 'info' },
     *   { emit: 'event', level: 'warn' }
     *   { emit: 'event', level: 'error' }
     * ]
     * 
     * / Emit as events and log to stdout
     * og: [
     *  { emit: 'stdout', level: 'query' },
     *  { emit: 'stdout', level: 'info' },
     *  { emit: 'stdout', level: 'warn' }
     *  { emit: 'stdout', level: 'error' }
     * 
     * ```
     * Read more in our [docs](https://pris.ly/d/logging).
     */
    log?: (LogLevel | LogDefinition)[]
    /**
     * The default values for transactionOptions
     * maxWait ?= 2000
     * timeout ?= 5000
     */
    transactionOptions?: {
      maxWait?: number
      timeout?: number
      isolationLevel?: Prisma.TransactionIsolationLevel
    }
    /**
     * Instance of a Driver Adapter, e.g., like one provided by `@prisma/adapter-planetscale`
     */
    adapter?: runtime.SqlDriverAdapterFactory
    /**
     * Prisma Accelerate URL allowing the client to connect through Accelerate instead of a direct database.
     */
    accelerateUrl?: string
    /**
     * Global configuration for omitting model fields by default.
     * 
     * @example
     * ```
     * const prisma = new PrismaClient({
     *   omit: {
     *     user: {
     *       password: true
     *     }
     *   }
     * })
     * ```
     */
    omit?: Prisma.GlobalOmitConfig
    /**
     * SQL commenter plugins that add metadata to SQL queries as comments.
     * Comments follow the sqlcommenter format: https://google.github.io/sqlcommenter/
     * 
     * @example
     * ```
     * const prisma = new PrismaClient({
     *   adapter,
     *   comments: [
     *     traceContext(),
     *     queryInsights(),
     *   ],
     * })
     * ```
     */
    comments?: runtime.SqlCommenterPlugin[]
  }
  export type GlobalOmitConfig = {
    clusterLocation?: ClusterLocationOmit
    loadProfile?: LoadProfileOmit
    fanConfiguration?: FanConfigurationOmit
    fanCatalog?: FanCatalogOmit
    cpuCoolerCatalog?: CpuCoolerCatalogOmit
    clusterConfiguration?: ClusterConfigurationOmit
    cluster?: ClusterOmit
    server?: ServerOmit
    fan?: FanOmit
    sensor?: SensorOmit
    sensorData?: SensorDataOmit
  }

  /* Types for Logging */
  export type LogLevel = 'info' | 'query' | 'warn' | 'error'
  export type LogDefinition = {
    level: LogLevel
    emit: 'stdout' | 'event'
  }

  export type CheckIsLogLevel<T> = T extends LogLevel ? T : never;

  export type GetLogType<T> = CheckIsLogLevel<
    T extends LogDefinition ? T['level'] : T
  >;

  export type GetEvents<T extends any[]> = T extends Array<LogLevel | LogDefinition>
    ? GetLogType<T[number]>
    : never;

  export type QueryEvent = {
    timestamp: Date
    query: string
    params: string
    duration: number
    target: string
  }

  export type LogEvent = {
    timestamp: Date
    message: string
    target: string
  }
  /* End Types for Logging */


  export type PrismaAction =
    | 'findUnique'
    | 'findUniqueOrThrow'
    | 'findMany'
    | 'findFirst'
    | 'findFirstOrThrow'
    | 'create'
    | 'createMany'
    | 'createManyAndReturn'
    | 'update'
    | 'updateMany'
    | 'updateManyAndReturn'
    | 'upsert'
    | 'delete'
    | 'deleteMany'
    | 'executeRaw'
    | 'queryRaw'
    | 'aggregate'
    | 'count'
    | 'runCommandRaw'
    | 'findRaw'
    | 'groupBy'

  // tested in getLogLevel.test.ts
  export function getLogLevel(log: Array<LogLevel | LogDefinition>): LogLevel | undefined;

  /**
   * `PrismaClient` proxy available in interactive transactions.
   */
  export type TransactionClient = Omit<Prisma.DefaultPrismaClient, runtime.ITXClientDenyList>

  export type Datasource = {
    url?: string
  }

  /**
   * Count Types
   */


  /**
   * Count Type ClusterLocationCountOutputType
   */

  export type ClusterLocationCountOutputType = {
    cluster_configurations: number
    clusters: number
  }

  export type ClusterLocationCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | ClusterLocationCountOutputTypeCountCluster_configurationsArgs
    clusters?: boolean | ClusterLocationCountOutputTypeCountClustersArgs
  }

  // Custom InputTypes
  /**
   * ClusterLocationCountOutputType without action
   */
  export type ClusterLocationCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocationCountOutputType
     */
    select?: ClusterLocationCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * ClusterLocationCountOutputType without action
   */
  export type ClusterLocationCountOutputTypeCountCluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterConfigurationWhereInput
  }

  /**
   * ClusterLocationCountOutputType without action
   */
  export type ClusterLocationCountOutputTypeCountClustersArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterWhereInput
  }


  /**
   * Count Type LoadProfileCountOutputType
   */

  export type LoadProfileCountOutputType = {
    cluster_configurations: number
  }

  export type LoadProfileCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | LoadProfileCountOutputTypeCountCluster_configurationsArgs
  }

  // Custom InputTypes
  /**
   * LoadProfileCountOutputType without action
   */
  export type LoadProfileCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfileCountOutputType
     */
    select?: LoadProfileCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * LoadProfileCountOutputType without action
   */
  export type LoadProfileCountOutputTypeCountCluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterConfigurationWhereInput
  }


  /**
   * Count Type FanConfigurationCountOutputType
   */

  export type FanConfigurationCountOutputType = {
    cluster_configurations: number
    fans: number
  }

  export type FanConfigurationCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | FanConfigurationCountOutputTypeCountCluster_configurationsArgs
    fans?: boolean | FanConfigurationCountOutputTypeCountFansArgs
  }

  // Custom InputTypes
  /**
   * FanConfigurationCountOutputType without action
   */
  export type FanConfigurationCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfigurationCountOutputType
     */
    select?: FanConfigurationCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * FanConfigurationCountOutputType without action
   */
  export type FanConfigurationCountOutputTypeCountCluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterConfigurationWhereInput
  }

  /**
   * FanConfigurationCountOutputType without action
   */
  export type FanConfigurationCountOutputTypeCountFansArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: FanWhereInput
  }


  /**
   * Count Type FanCatalogCountOutputType
   */

  export type FanCatalogCountOutputType = {
    cluster_configurations: number
    fans: number
  }

  export type FanCatalogCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | FanCatalogCountOutputTypeCountCluster_configurationsArgs
    fans?: boolean | FanCatalogCountOutputTypeCountFansArgs
  }

  // Custom InputTypes
  /**
   * FanCatalogCountOutputType without action
   */
  export type FanCatalogCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalogCountOutputType
     */
    select?: FanCatalogCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * FanCatalogCountOutputType without action
   */
  export type FanCatalogCountOutputTypeCountCluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterConfigurationWhereInput
  }

  /**
   * FanCatalogCountOutputType without action
   */
  export type FanCatalogCountOutputTypeCountFansArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: FanWhereInput
  }


  /**
   * Count Type CpuCoolerCatalogCountOutputType
   */

  export type CpuCoolerCatalogCountOutputType = {
    cluster_configs: number
  }

  export type CpuCoolerCatalogCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configs?: boolean | CpuCoolerCatalogCountOutputTypeCountCluster_configsArgs
  }

  // Custom InputTypes
  /**
   * CpuCoolerCatalogCountOutputType without action
   */
  export type CpuCoolerCatalogCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalogCountOutputType
     */
    select?: CpuCoolerCatalogCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * CpuCoolerCatalogCountOutputType without action
   */
  export type CpuCoolerCatalogCountOutputTypeCountCluster_configsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterConfigurationWhereInput
  }


  /**
   * Count Type ClusterConfigurationCountOutputType
   */

  export type ClusterConfigurationCountOutputType = {
    servers: number
  }

  export type ClusterConfigurationCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    servers?: boolean | ClusterConfigurationCountOutputTypeCountServersArgs
  }

  // Custom InputTypes
  /**
   * ClusterConfigurationCountOutputType without action
   */
  export type ClusterConfigurationCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfigurationCountOutputType
     */
    select?: ClusterConfigurationCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * ClusterConfigurationCountOutputType without action
   */
  export type ClusterConfigurationCountOutputTypeCountServersArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ServerWhereInput
  }


  /**
   * Count Type ClusterCountOutputType
   */

  export type ClusterCountOutputType = {
    servers: number
  }

  export type ClusterCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    servers?: boolean | ClusterCountOutputTypeCountServersArgs
  }

  // Custom InputTypes
  /**
   * ClusterCountOutputType without action
   */
  export type ClusterCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterCountOutputType
     */
    select?: ClusterCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * ClusterCountOutputType without action
   */
  export type ClusterCountOutputTypeCountServersArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ServerWhereInput
  }


  /**
   * Count Type ServerCountOutputType
   */

  export type ServerCountOutputType = {
    sensors: number
    fans: number
  }

  export type ServerCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    sensors?: boolean | ServerCountOutputTypeCountSensorsArgs
    fans?: boolean | ServerCountOutputTypeCountFansArgs
  }

  // Custom InputTypes
  /**
   * ServerCountOutputType without action
   */
  export type ServerCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ServerCountOutputType
     */
    select?: ServerCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * ServerCountOutputType without action
   */
  export type ServerCountOutputTypeCountSensorsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: SensorWhereInput
  }

  /**
   * ServerCountOutputType without action
   */
  export type ServerCountOutputTypeCountFansArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: FanWhereInput
  }


  /**
   * Count Type SensorCountOutputType
   */

  export type SensorCountOutputType = {
    data: number
  }

  export type SensorCountOutputTypeSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    data?: boolean | SensorCountOutputTypeCountDataArgs
  }

  // Custom InputTypes
  /**
   * SensorCountOutputType without action
   */
  export type SensorCountOutputTypeDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorCountOutputType
     */
    select?: SensorCountOutputTypeSelect<ExtArgs> | null
  }

  /**
   * SensorCountOutputType without action
   */
  export type SensorCountOutputTypeCountDataArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: SensorDataWhereInput
  }


  /**
   * Models
   */

  /**
   * Model ClusterLocation
   */

  export type AggregateClusterLocation = {
    _count: ClusterLocationCountAggregateOutputType | null
    _avg: ClusterLocationAvgAggregateOutputType | null
    _sum: ClusterLocationSumAggregateOutputType | null
    _min: ClusterLocationMinAggregateOutputType | null
    _max: ClusterLocationMaxAggregateOutputType | null
  }

  export type ClusterLocationAvgAggregateOutputType = {
    location_id: number | null
    env_factor: number | null
    cluster_count: number | null
  }

  export type ClusterLocationSumAggregateOutputType = {
    location_id: number | null
    env_factor: number | null
    cluster_count: number | null
  }

  export type ClusterLocationMinAggregateOutputType = {
    location_id: number | null
    name: string | null
    location: string | null
    env_factor: number | null
    cluster_count: number | null
    created_at: Date | null
  }

  export type ClusterLocationMaxAggregateOutputType = {
    location_id: number | null
    name: string | null
    location: string | null
    env_factor: number | null
    cluster_count: number | null
    created_at: Date | null
  }

  export type ClusterLocationCountAggregateOutputType = {
    location_id: number
    name: number
    location: number
    env_factor: number
    cluster_count: number
    created_at: number
    _all: number
  }


  export type ClusterLocationAvgAggregateInputType = {
    location_id?: true
    env_factor?: true
    cluster_count?: true
  }

  export type ClusterLocationSumAggregateInputType = {
    location_id?: true
    env_factor?: true
    cluster_count?: true
  }

  export type ClusterLocationMinAggregateInputType = {
    location_id?: true
    name?: true
    location?: true
    env_factor?: true
    cluster_count?: true
    created_at?: true
  }

  export type ClusterLocationMaxAggregateInputType = {
    location_id?: true
    name?: true
    location?: true
    env_factor?: true
    cluster_count?: true
    created_at?: true
  }

  export type ClusterLocationCountAggregateInputType = {
    location_id?: true
    name?: true
    location?: true
    env_factor?: true
    cluster_count?: true
    created_at?: true
    _all?: true
  }

  export type ClusterLocationAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which ClusterLocation to aggregate.
     */
    where?: ClusterLocationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterLocations to fetch.
     */
    orderBy?: ClusterLocationOrderByWithRelationInput | ClusterLocationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: ClusterLocationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterLocations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterLocations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned ClusterLocations
    **/
    _count?: true | ClusterLocationCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: ClusterLocationAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: ClusterLocationSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: ClusterLocationMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: ClusterLocationMaxAggregateInputType
  }

  export type GetClusterLocationAggregateType<T extends ClusterLocationAggregateArgs> = {
        [P in keyof T & keyof AggregateClusterLocation]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateClusterLocation[P]>
      : GetScalarType<T[P], AggregateClusterLocation[P]>
  }




  export type ClusterLocationGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterLocationWhereInput
    orderBy?: ClusterLocationOrderByWithAggregationInput | ClusterLocationOrderByWithAggregationInput[]
    by: ClusterLocationScalarFieldEnum[] | ClusterLocationScalarFieldEnum
    having?: ClusterLocationScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: ClusterLocationCountAggregateInputType | true
    _avg?: ClusterLocationAvgAggregateInputType
    _sum?: ClusterLocationSumAggregateInputType
    _min?: ClusterLocationMinAggregateInputType
    _max?: ClusterLocationMaxAggregateInputType
  }

  export type ClusterLocationGroupByOutputType = {
    location_id: number
    name: string
    location: string | null
    env_factor: number
    cluster_count: number
    created_at: Date
    _count: ClusterLocationCountAggregateOutputType | null
    _avg: ClusterLocationAvgAggregateOutputType | null
    _sum: ClusterLocationSumAggregateOutputType | null
    _min: ClusterLocationMinAggregateOutputType | null
    _max: ClusterLocationMaxAggregateOutputType | null
  }

  type GetClusterLocationGroupByPayload<T extends ClusterLocationGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<ClusterLocationGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof ClusterLocationGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], ClusterLocationGroupByOutputType[P]>
            : GetScalarType<T[P], ClusterLocationGroupByOutputType[P]>
        }
      >
    >


  export type ClusterLocationSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    location_id?: boolean
    name?: boolean
    location?: boolean
    env_factor?: boolean
    cluster_count?: boolean
    created_at?: boolean
    cluster_configurations?: boolean | ClusterLocation$cluster_configurationsArgs<ExtArgs>
    clusters?: boolean | ClusterLocation$clustersArgs<ExtArgs>
    _count?: boolean | ClusterLocationCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["clusterLocation"]>

  export type ClusterLocationSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    location_id?: boolean
    name?: boolean
    location?: boolean
    env_factor?: boolean
    cluster_count?: boolean
    created_at?: boolean
  }, ExtArgs["result"]["clusterLocation"]>

  export type ClusterLocationSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    location_id?: boolean
    name?: boolean
    location?: boolean
    env_factor?: boolean
    cluster_count?: boolean
    created_at?: boolean
  }, ExtArgs["result"]["clusterLocation"]>

  export type ClusterLocationSelectScalar = {
    location_id?: boolean
    name?: boolean
    location?: boolean
    env_factor?: boolean
    cluster_count?: boolean
    created_at?: boolean
  }

  export type ClusterLocationOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"location_id" | "name" | "location" | "env_factor" | "cluster_count" | "created_at", ExtArgs["result"]["clusterLocation"]>
  export type ClusterLocationInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | ClusterLocation$cluster_configurationsArgs<ExtArgs>
    clusters?: boolean | ClusterLocation$clustersArgs<ExtArgs>
    _count?: boolean | ClusterLocationCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type ClusterLocationIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}
  export type ClusterLocationIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}

  export type $ClusterLocationPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "ClusterLocation"
    objects: {
      cluster_configurations: Prisma.$ClusterConfigurationPayload<ExtArgs>[]
      clusters: Prisma.$ClusterPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      location_id: number
      name: string
      location: string | null
      env_factor: number
      cluster_count: number
      created_at: Date
    }, ExtArgs["result"]["clusterLocation"]>
    composites: {}
  }

  type ClusterLocationGetPayload<S extends boolean | null | undefined | ClusterLocationDefaultArgs> = $Result.GetResult<Prisma.$ClusterLocationPayload, S>

  type ClusterLocationCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<ClusterLocationFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: ClusterLocationCountAggregateInputType | true
    }

  export interface ClusterLocationDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['ClusterLocation'], meta: { name: 'ClusterLocation' } }
    /**
     * Find zero or one ClusterLocation that matches the filter.
     * @param {ClusterLocationFindUniqueArgs} args - Arguments to find a ClusterLocation
     * @example
     * // Get one ClusterLocation
     * const clusterLocation = await prisma.clusterLocation.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends ClusterLocationFindUniqueArgs>(args: SelectSubset<T, ClusterLocationFindUniqueArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one ClusterLocation that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {ClusterLocationFindUniqueOrThrowArgs} args - Arguments to find a ClusterLocation
     * @example
     * // Get one ClusterLocation
     * const clusterLocation = await prisma.clusterLocation.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends ClusterLocationFindUniqueOrThrowArgs>(args: SelectSubset<T, ClusterLocationFindUniqueOrThrowArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first ClusterLocation that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterLocationFindFirstArgs} args - Arguments to find a ClusterLocation
     * @example
     * // Get one ClusterLocation
     * const clusterLocation = await prisma.clusterLocation.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends ClusterLocationFindFirstArgs>(args?: SelectSubset<T, ClusterLocationFindFirstArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first ClusterLocation that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterLocationFindFirstOrThrowArgs} args - Arguments to find a ClusterLocation
     * @example
     * // Get one ClusterLocation
     * const clusterLocation = await prisma.clusterLocation.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends ClusterLocationFindFirstOrThrowArgs>(args?: SelectSubset<T, ClusterLocationFindFirstOrThrowArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more ClusterLocations that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterLocationFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all ClusterLocations
     * const clusterLocations = await prisma.clusterLocation.findMany()
     * 
     * // Get first 10 ClusterLocations
     * const clusterLocations = await prisma.clusterLocation.findMany({ take: 10 })
     * 
     * // Only select the `location_id`
     * const clusterLocationWithLocation_idOnly = await prisma.clusterLocation.findMany({ select: { location_id: true } })
     * 
     */
    findMany<T extends ClusterLocationFindManyArgs>(args?: SelectSubset<T, ClusterLocationFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a ClusterLocation.
     * @param {ClusterLocationCreateArgs} args - Arguments to create a ClusterLocation.
     * @example
     * // Create one ClusterLocation
     * const ClusterLocation = await prisma.clusterLocation.create({
     *   data: {
     *     // ... data to create a ClusterLocation
     *   }
     * })
     * 
     */
    create<T extends ClusterLocationCreateArgs>(args: SelectSubset<T, ClusterLocationCreateArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many ClusterLocations.
     * @param {ClusterLocationCreateManyArgs} args - Arguments to create many ClusterLocations.
     * @example
     * // Create many ClusterLocations
     * const clusterLocation = await prisma.clusterLocation.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends ClusterLocationCreateManyArgs>(args?: SelectSubset<T, ClusterLocationCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many ClusterLocations and returns the data saved in the database.
     * @param {ClusterLocationCreateManyAndReturnArgs} args - Arguments to create many ClusterLocations.
     * @example
     * // Create many ClusterLocations
     * const clusterLocation = await prisma.clusterLocation.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many ClusterLocations and only return the `location_id`
     * const clusterLocationWithLocation_idOnly = await prisma.clusterLocation.createManyAndReturn({
     *   select: { location_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends ClusterLocationCreateManyAndReturnArgs>(args?: SelectSubset<T, ClusterLocationCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a ClusterLocation.
     * @param {ClusterLocationDeleteArgs} args - Arguments to delete one ClusterLocation.
     * @example
     * // Delete one ClusterLocation
     * const ClusterLocation = await prisma.clusterLocation.delete({
     *   where: {
     *     // ... filter to delete one ClusterLocation
     *   }
     * })
     * 
     */
    delete<T extends ClusterLocationDeleteArgs>(args: SelectSubset<T, ClusterLocationDeleteArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one ClusterLocation.
     * @param {ClusterLocationUpdateArgs} args - Arguments to update one ClusterLocation.
     * @example
     * // Update one ClusterLocation
     * const clusterLocation = await prisma.clusterLocation.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends ClusterLocationUpdateArgs>(args: SelectSubset<T, ClusterLocationUpdateArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more ClusterLocations.
     * @param {ClusterLocationDeleteManyArgs} args - Arguments to filter ClusterLocations to delete.
     * @example
     * // Delete a few ClusterLocations
     * const { count } = await prisma.clusterLocation.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends ClusterLocationDeleteManyArgs>(args?: SelectSubset<T, ClusterLocationDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more ClusterLocations.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterLocationUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many ClusterLocations
     * const clusterLocation = await prisma.clusterLocation.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends ClusterLocationUpdateManyArgs>(args: SelectSubset<T, ClusterLocationUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more ClusterLocations and returns the data updated in the database.
     * @param {ClusterLocationUpdateManyAndReturnArgs} args - Arguments to update many ClusterLocations.
     * @example
     * // Update many ClusterLocations
     * const clusterLocation = await prisma.clusterLocation.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more ClusterLocations and only return the `location_id`
     * const clusterLocationWithLocation_idOnly = await prisma.clusterLocation.updateManyAndReturn({
     *   select: { location_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends ClusterLocationUpdateManyAndReturnArgs>(args: SelectSubset<T, ClusterLocationUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one ClusterLocation.
     * @param {ClusterLocationUpsertArgs} args - Arguments to update or create a ClusterLocation.
     * @example
     * // Update or create a ClusterLocation
     * const clusterLocation = await prisma.clusterLocation.upsert({
     *   create: {
     *     // ... data to create a ClusterLocation
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the ClusterLocation we want to update
     *   }
     * })
     */
    upsert<T extends ClusterLocationUpsertArgs>(args: SelectSubset<T, ClusterLocationUpsertArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of ClusterLocations.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterLocationCountArgs} args - Arguments to filter ClusterLocations to count.
     * @example
     * // Count the number of ClusterLocations
     * const count = await prisma.clusterLocation.count({
     *   where: {
     *     // ... the filter for the ClusterLocations we want to count
     *   }
     * })
    **/
    count<T extends ClusterLocationCountArgs>(
      args?: Subset<T, ClusterLocationCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], ClusterLocationCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a ClusterLocation.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterLocationAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends ClusterLocationAggregateArgs>(args: Subset<T, ClusterLocationAggregateArgs>): Prisma.PrismaPromise<GetClusterLocationAggregateType<T>>

    /**
     * Group by ClusterLocation.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterLocationGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends ClusterLocationGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: ClusterLocationGroupByArgs['orderBy'] }
        : { orderBy?: ClusterLocationGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, ClusterLocationGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetClusterLocationGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the ClusterLocation model
   */
  readonly fields: ClusterLocationFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for ClusterLocation.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__ClusterLocationClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    cluster_configurations<T extends ClusterLocation$cluster_configurationsArgs<ExtArgs> = {}>(args?: Subset<T, ClusterLocation$cluster_configurationsArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    clusters<T extends ClusterLocation$clustersArgs<ExtArgs> = {}>(args?: Subset<T, ClusterLocation$clustersArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the ClusterLocation model
   */
  interface ClusterLocationFieldRefs {
    readonly location_id: FieldRef<"ClusterLocation", 'Int'>
    readonly name: FieldRef<"ClusterLocation", 'String'>
    readonly location: FieldRef<"ClusterLocation", 'String'>
    readonly env_factor: FieldRef<"ClusterLocation", 'Float'>
    readonly cluster_count: FieldRef<"ClusterLocation", 'Int'>
    readonly created_at: FieldRef<"ClusterLocation", 'DateTime'>
  }
    

  // Custom InputTypes
  /**
   * ClusterLocation findUnique
   */
  export type ClusterLocationFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterLocation to fetch.
     */
    where: ClusterLocationWhereUniqueInput
  }

  /**
   * ClusterLocation findUniqueOrThrow
   */
  export type ClusterLocationFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterLocation to fetch.
     */
    where: ClusterLocationWhereUniqueInput
  }

  /**
   * ClusterLocation findFirst
   */
  export type ClusterLocationFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterLocation to fetch.
     */
    where?: ClusterLocationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterLocations to fetch.
     */
    orderBy?: ClusterLocationOrderByWithRelationInput | ClusterLocationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for ClusterLocations.
     */
    cursor?: ClusterLocationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterLocations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterLocations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of ClusterLocations.
     */
    distinct?: ClusterLocationScalarFieldEnum | ClusterLocationScalarFieldEnum[]
  }

  /**
   * ClusterLocation findFirstOrThrow
   */
  export type ClusterLocationFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterLocation to fetch.
     */
    where?: ClusterLocationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterLocations to fetch.
     */
    orderBy?: ClusterLocationOrderByWithRelationInput | ClusterLocationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for ClusterLocations.
     */
    cursor?: ClusterLocationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterLocations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterLocations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of ClusterLocations.
     */
    distinct?: ClusterLocationScalarFieldEnum | ClusterLocationScalarFieldEnum[]
  }

  /**
   * ClusterLocation findMany
   */
  export type ClusterLocationFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterLocations to fetch.
     */
    where?: ClusterLocationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterLocations to fetch.
     */
    orderBy?: ClusterLocationOrderByWithRelationInput | ClusterLocationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing ClusterLocations.
     */
    cursor?: ClusterLocationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterLocations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterLocations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of ClusterLocations.
     */
    distinct?: ClusterLocationScalarFieldEnum | ClusterLocationScalarFieldEnum[]
  }

  /**
   * ClusterLocation create
   */
  export type ClusterLocationCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * The data needed to create a ClusterLocation.
     */
    data: XOR<ClusterLocationCreateInput, ClusterLocationUncheckedCreateInput>
  }

  /**
   * ClusterLocation createMany
   */
  export type ClusterLocationCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many ClusterLocations.
     */
    data: ClusterLocationCreateManyInput | ClusterLocationCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * ClusterLocation createManyAndReturn
   */
  export type ClusterLocationCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * The data used to create many ClusterLocations.
     */
    data: ClusterLocationCreateManyInput | ClusterLocationCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * ClusterLocation update
   */
  export type ClusterLocationUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * The data needed to update a ClusterLocation.
     */
    data: XOR<ClusterLocationUpdateInput, ClusterLocationUncheckedUpdateInput>
    /**
     * Choose, which ClusterLocation to update.
     */
    where: ClusterLocationWhereUniqueInput
  }

  /**
   * ClusterLocation updateMany
   */
  export type ClusterLocationUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update ClusterLocations.
     */
    data: XOR<ClusterLocationUpdateManyMutationInput, ClusterLocationUncheckedUpdateManyInput>
    /**
     * Filter which ClusterLocations to update
     */
    where?: ClusterLocationWhereInput
    /**
     * Limit how many ClusterLocations to update.
     */
    limit?: number
  }

  /**
   * ClusterLocation updateManyAndReturn
   */
  export type ClusterLocationUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * The data used to update ClusterLocations.
     */
    data: XOR<ClusterLocationUpdateManyMutationInput, ClusterLocationUncheckedUpdateManyInput>
    /**
     * Filter which ClusterLocations to update
     */
    where?: ClusterLocationWhereInput
    /**
     * Limit how many ClusterLocations to update.
     */
    limit?: number
  }

  /**
   * ClusterLocation upsert
   */
  export type ClusterLocationUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * The filter to search for the ClusterLocation to update in case it exists.
     */
    where: ClusterLocationWhereUniqueInput
    /**
     * In case the ClusterLocation found by the `where` argument doesn't exist, create a new ClusterLocation with this data.
     */
    create: XOR<ClusterLocationCreateInput, ClusterLocationUncheckedCreateInput>
    /**
     * In case the ClusterLocation was found with the provided `where` argument, update it with this data.
     */
    update: XOR<ClusterLocationUpdateInput, ClusterLocationUncheckedUpdateInput>
  }

  /**
   * ClusterLocation delete
   */
  export type ClusterLocationDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    /**
     * Filter which ClusterLocation to delete.
     */
    where: ClusterLocationWhereUniqueInput
  }

  /**
   * ClusterLocation deleteMany
   */
  export type ClusterLocationDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which ClusterLocations to delete
     */
    where?: ClusterLocationWhereInput
    /**
     * Limit how many ClusterLocations to delete.
     */
    limit?: number
  }

  /**
   * ClusterLocation.cluster_configurations
   */
  export type ClusterLocation$cluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    where?: ClusterConfigurationWhereInput
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    cursor?: ClusterConfigurationWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * ClusterLocation.clusters
   */
  export type ClusterLocation$clustersArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    where?: ClusterWhereInput
    orderBy?: ClusterOrderByWithRelationInput | ClusterOrderByWithRelationInput[]
    cursor?: ClusterWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ClusterScalarFieldEnum | ClusterScalarFieldEnum[]
  }

  /**
   * ClusterLocation without action
   */
  export type ClusterLocationDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
  }


  /**
   * Model LoadProfile
   */

  export type AggregateLoadProfile = {
    _count: LoadProfileCountAggregateOutputType | null
    _avg: LoadProfileAvgAggregateOutputType | null
    _sum: LoadProfileSumAggregateOutputType | null
    _min: LoadProfileMinAggregateOutputType | null
    _max: LoadProfileMaxAggregateOutputType | null
  }

  export type LoadProfileAvgAggregateOutputType = {
    id: number | null
    hour: number | null
    expected_load_percent: number | null
    target_temp_celsius: number | null
  }

  export type LoadProfileSumAggregateOutputType = {
    id: number | null
    hour: number | null
    expected_load_percent: number | null
    target_temp_celsius: number | null
  }

  export type LoadProfileMinAggregateOutputType = {
    id: number | null
    name: string | null
    hour: number | null
    expected_load_percent: number | null
    target_temp_celsius: number | null
    standard_fan_speed: string | null
  }

  export type LoadProfileMaxAggregateOutputType = {
    id: number | null
    name: string | null
    hour: number | null
    expected_load_percent: number | null
    target_temp_celsius: number | null
    standard_fan_speed: string | null
  }

  export type LoadProfileCountAggregateOutputType = {
    id: number
    name: number
    hour: number
    expected_load_percent: number
    target_temp_celsius: number
    standard_fan_speed: number
    _all: number
  }


  export type LoadProfileAvgAggregateInputType = {
    id?: true
    hour?: true
    expected_load_percent?: true
    target_temp_celsius?: true
  }

  export type LoadProfileSumAggregateInputType = {
    id?: true
    hour?: true
    expected_load_percent?: true
    target_temp_celsius?: true
  }

  export type LoadProfileMinAggregateInputType = {
    id?: true
    name?: true
    hour?: true
    expected_load_percent?: true
    target_temp_celsius?: true
    standard_fan_speed?: true
  }

  export type LoadProfileMaxAggregateInputType = {
    id?: true
    name?: true
    hour?: true
    expected_load_percent?: true
    target_temp_celsius?: true
    standard_fan_speed?: true
  }

  export type LoadProfileCountAggregateInputType = {
    id?: true
    name?: true
    hour?: true
    expected_load_percent?: true
    target_temp_celsius?: true
    standard_fan_speed?: true
    _all?: true
  }

  export type LoadProfileAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which LoadProfile to aggregate.
     */
    where?: LoadProfileWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of LoadProfiles to fetch.
     */
    orderBy?: LoadProfileOrderByWithRelationInput | LoadProfileOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: LoadProfileWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` LoadProfiles from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` LoadProfiles.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned LoadProfiles
    **/
    _count?: true | LoadProfileCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: LoadProfileAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: LoadProfileSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: LoadProfileMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: LoadProfileMaxAggregateInputType
  }

  export type GetLoadProfileAggregateType<T extends LoadProfileAggregateArgs> = {
        [P in keyof T & keyof AggregateLoadProfile]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateLoadProfile[P]>
      : GetScalarType<T[P], AggregateLoadProfile[P]>
  }




  export type LoadProfileGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: LoadProfileWhereInput
    orderBy?: LoadProfileOrderByWithAggregationInput | LoadProfileOrderByWithAggregationInput[]
    by: LoadProfileScalarFieldEnum[] | LoadProfileScalarFieldEnum
    having?: LoadProfileScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: LoadProfileCountAggregateInputType | true
    _avg?: LoadProfileAvgAggregateInputType
    _sum?: LoadProfileSumAggregateInputType
    _min?: LoadProfileMinAggregateInputType
    _max?: LoadProfileMaxAggregateInputType
  }

  export type LoadProfileGroupByOutputType = {
    id: number
    name: string
    hour: number
    expected_load_percent: number
    target_temp_celsius: number
    standard_fan_speed: string
    _count: LoadProfileCountAggregateOutputType | null
    _avg: LoadProfileAvgAggregateOutputType | null
    _sum: LoadProfileSumAggregateOutputType | null
    _min: LoadProfileMinAggregateOutputType | null
    _max: LoadProfileMaxAggregateOutputType | null
  }

  type GetLoadProfileGroupByPayload<T extends LoadProfileGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<LoadProfileGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof LoadProfileGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], LoadProfileGroupByOutputType[P]>
            : GetScalarType<T[P], LoadProfileGroupByOutputType[P]>
        }
      >
    >


  export type LoadProfileSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    id?: boolean
    name?: boolean
    hour?: boolean
    expected_load_percent?: boolean
    target_temp_celsius?: boolean
    standard_fan_speed?: boolean
    cluster_configurations?: boolean | LoadProfile$cluster_configurationsArgs<ExtArgs>
    _count?: boolean | LoadProfileCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["loadProfile"]>

  export type LoadProfileSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    id?: boolean
    name?: boolean
    hour?: boolean
    expected_load_percent?: boolean
    target_temp_celsius?: boolean
    standard_fan_speed?: boolean
  }, ExtArgs["result"]["loadProfile"]>

  export type LoadProfileSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    id?: boolean
    name?: boolean
    hour?: boolean
    expected_load_percent?: boolean
    target_temp_celsius?: boolean
    standard_fan_speed?: boolean
  }, ExtArgs["result"]["loadProfile"]>

  export type LoadProfileSelectScalar = {
    id?: boolean
    name?: boolean
    hour?: boolean
    expected_load_percent?: boolean
    target_temp_celsius?: boolean
    standard_fan_speed?: boolean
  }

  export type LoadProfileOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"id" | "name" | "hour" | "expected_load_percent" | "target_temp_celsius" | "standard_fan_speed", ExtArgs["result"]["loadProfile"]>
  export type LoadProfileInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | LoadProfile$cluster_configurationsArgs<ExtArgs>
    _count?: boolean | LoadProfileCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type LoadProfileIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}
  export type LoadProfileIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}

  export type $LoadProfilePayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "LoadProfile"
    objects: {
      cluster_configurations: Prisma.$ClusterConfigurationPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      id: number
      name: string
      hour: number
      expected_load_percent: number
      target_temp_celsius: number
      standard_fan_speed: string
    }, ExtArgs["result"]["loadProfile"]>
    composites: {}
  }

  type LoadProfileGetPayload<S extends boolean | null | undefined | LoadProfileDefaultArgs> = $Result.GetResult<Prisma.$LoadProfilePayload, S>

  type LoadProfileCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<LoadProfileFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: LoadProfileCountAggregateInputType | true
    }

  export interface LoadProfileDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['LoadProfile'], meta: { name: 'LoadProfile' } }
    /**
     * Find zero or one LoadProfile that matches the filter.
     * @param {LoadProfileFindUniqueArgs} args - Arguments to find a LoadProfile
     * @example
     * // Get one LoadProfile
     * const loadProfile = await prisma.loadProfile.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends LoadProfileFindUniqueArgs>(args: SelectSubset<T, LoadProfileFindUniqueArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one LoadProfile that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {LoadProfileFindUniqueOrThrowArgs} args - Arguments to find a LoadProfile
     * @example
     * // Get one LoadProfile
     * const loadProfile = await prisma.loadProfile.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends LoadProfileFindUniqueOrThrowArgs>(args: SelectSubset<T, LoadProfileFindUniqueOrThrowArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first LoadProfile that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {LoadProfileFindFirstArgs} args - Arguments to find a LoadProfile
     * @example
     * // Get one LoadProfile
     * const loadProfile = await prisma.loadProfile.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends LoadProfileFindFirstArgs>(args?: SelectSubset<T, LoadProfileFindFirstArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first LoadProfile that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {LoadProfileFindFirstOrThrowArgs} args - Arguments to find a LoadProfile
     * @example
     * // Get one LoadProfile
     * const loadProfile = await prisma.loadProfile.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends LoadProfileFindFirstOrThrowArgs>(args?: SelectSubset<T, LoadProfileFindFirstOrThrowArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more LoadProfiles that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {LoadProfileFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all LoadProfiles
     * const loadProfiles = await prisma.loadProfile.findMany()
     * 
     * // Get first 10 LoadProfiles
     * const loadProfiles = await prisma.loadProfile.findMany({ take: 10 })
     * 
     * // Only select the `id`
     * const loadProfileWithIdOnly = await prisma.loadProfile.findMany({ select: { id: true } })
     * 
     */
    findMany<T extends LoadProfileFindManyArgs>(args?: SelectSubset<T, LoadProfileFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a LoadProfile.
     * @param {LoadProfileCreateArgs} args - Arguments to create a LoadProfile.
     * @example
     * // Create one LoadProfile
     * const LoadProfile = await prisma.loadProfile.create({
     *   data: {
     *     // ... data to create a LoadProfile
     *   }
     * })
     * 
     */
    create<T extends LoadProfileCreateArgs>(args: SelectSubset<T, LoadProfileCreateArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many LoadProfiles.
     * @param {LoadProfileCreateManyArgs} args - Arguments to create many LoadProfiles.
     * @example
     * // Create many LoadProfiles
     * const loadProfile = await prisma.loadProfile.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends LoadProfileCreateManyArgs>(args?: SelectSubset<T, LoadProfileCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many LoadProfiles and returns the data saved in the database.
     * @param {LoadProfileCreateManyAndReturnArgs} args - Arguments to create many LoadProfiles.
     * @example
     * // Create many LoadProfiles
     * const loadProfile = await prisma.loadProfile.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many LoadProfiles and only return the `id`
     * const loadProfileWithIdOnly = await prisma.loadProfile.createManyAndReturn({
     *   select: { id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends LoadProfileCreateManyAndReturnArgs>(args?: SelectSubset<T, LoadProfileCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a LoadProfile.
     * @param {LoadProfileDeleteArgs} args - Arguments to delete one LoadProfile.
     * @example
     * // Delete one LoadProfile
     * const LoadProfile = await prisma.loadProfile.delete({
     *   where: {
     *     // ... filter to delete one LoadProfile
     *   }
     * })
     * 
     */
    delete<T extends LoadProfileDeleteArgs>(args: SelectSubset<T, LoadProfileDeleteArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one LoadProfile.
     * @param {LoadProfileUpdateArgs} args - Arguments to update one LoadProfile.
     * @example
     * // Update one LoadProfile
     * const loadProfile = await prisma.loadProfile.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends LoadProfileUpdateArgs>(args: SelectSubset<T, LoadProfileUpdateArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more LoadProfiles.
     * @param {LoadProfileDeleteManyArgs} args - Arguments to filter LoadProfiles to delete.
     * @example
     * // Delete a few LoadProfiles
     * const { count } = await prisma.loadProfile.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends LoadProfileDeleteManyArgs>(args?: SelectSubset<T, LoadProfileDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more LoadProfiles.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {LoadProfileUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many LoadProfiles
     * const loadProfile = await prisma.loadProfile.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends LoadProfileUpdateManyArgs>(args: SelectSubset<T, LoadProfileUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more LoadProfiles and returns the data updated in the database.
     * @param {LoadProfileUpdateManyAndReturnArgs} args - Arguments to update many LoadProfiles.
     * @example
     * // Update many LoadProfiles
     * const loadProfile = await prisma.loadProfile.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more LoadProfiles and only return the `id`
     * const loadProfileWithIdOnly = await prisma.loadProfile.updateManyAndReturn({
     *   select: { id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends LoadProfileUpdateManyAndReturnArgs>(args: SelectSubset<T, LoadProfileUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one LoadProfile.
     * @param {LoadProfileUpsertArgs} args - Arguments to update or create a LoadProfile.
     * @example
     * // Update or create a LoadProfile
     * const loadProfile = await prisma.loadProfile.upsert({
     *   create: {
     *     // ... data to create a LoadProfile
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the LoadProfile we want to update
     *   }
     * })
     */
    upsert<T extends LoadProfileUpsertArgs>(args: SelectSubset<T, LoadProfileUpsertArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of LoadProfiles.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {LoadProfileCountArgs} args - Arguments to filter LoadProfiles to count.
     * @example
     * // Count the number of LoadProfiles
     * const count = await prisma.loadProfile.count({
     *   where: {
     *     // ... the filter for the LoadProfiles we want to count
     *   }
     * })
    **/
    count<T extends LoadProfileCountArgs>(
      args?: Subset<T, LoadProfileCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], LoadProfileCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a LoadProfile.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {LoadProfileAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends LoadProfileAggregateArgs>(args: Subset<T, LoadProfileAggregateArgs>): Prisma.PrismaPromise<GetLoadProfileAggregateType<T>>

    /**
     * Group by LoadProfile.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {LoadProfileGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends LoadProfileGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: LoadProfileGroupByArgs['orderBy'] }
        : { orderBy?: LoadProfileGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, LoadProfileGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetLoadProfileGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the LoadProfile model
   */
  readonly fields: LoadProfileFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for LoadProfile.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__LoadProfileClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    cluster_configurations<T extends LoadProfile$cluster_configurationsArgs<ExtArgs> = {}>(args?: Subset<T, LoadProfile$cluster_configurationsArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the LoadProfile model
   */
  interface LoadProfileFieldRefs {
    readonly id: FieldRef<"LoadProfile", 'Int'>
    readonly name: FieldRef<"LoadProfile", 'String'>
    readonly hour: FieldRef<"LoadProfile", 'Int'>
    readonly expected_load_percent: FieldRef<"LoadProfile", 'Float'>
    readonly target_temp_celsius: FieldRef<"LoadProfile", 'Float'>
    readonly standard_fan_speed: FieldRef<"LoadProfile", 'String'>
  }
    

  // Custom InputTypes
  /**
   * LoadProfile findUnique
   */
  export type LoadProfileFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * Filter, which LoadProfile to fetch.
     */
    where: LoadProfileWhereUniqueInput
  }

  /**
   * LoadProfile findUniqueOrThrow
   */
  export type LoadProfileFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * Filter, which LoadProfile to fetch.
     */
    where: LoadProfileWhereUniqueInput
  }

  /**
   * LoadProfile findFirst
   */
  export type LoadProfileFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * Filter, which LoadProfile to fetch.
     */
    where?: LoadProfileWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of LoadProfiles to fetch.
     */
    orderBy?: LoadProfileOrderByWithRelationInput | LoadProfileOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for LoadProfiles.
     */
    cursor?: LoadProfileWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` LoadProfiles from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` LoadProfiles.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of LoadProfiles.
     */
    distinct?: LoadProfileScalarFieldEnum | LoadProfileScalarFieldEnum[]
  }

  /**
   * LoadProfile findFirstOrThrow
   */
  export type LoadProfileFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * Filter, which LoadProfile to fetch.
     */
    where?: LoadProfileWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of LoadProfiles to fetch.
     */
    orderBy?: LoadProfileOrderByWithRelationInput | LoadProfileOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for LoadProfiles.
     */
    cursor?: LoadProfileWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` LoadProfiles from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` LoadProfiles.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of LoadProfiles.
     */
    distinct?: LoadProfileScalarFieldEnum | LoadProfileScalarFieldEnum[]
  }

  /**
   * LoadProfile findMany
   */
  export type LoadProfileFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * Filter, which LoadProfiles to fetch.
     */
    where?: LoadProfileWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of LoadProfiles to fetch.
     */
    orderBy?: LoadProfileOrderByWithRelationInput | LoadProfileOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing LoadProfiles.
     */
    cursor?: LoadProfileWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` LoadProfiles from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` LoadProfiles.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of LoadProfiles.
     */
    distinct?: LoadProfileScalarFieldEnum | LoadProfileScalarFieldEnum[]
  }

  /**
   * LoadProfile create
   */
  export type LoadProfileCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * The data needed to create a LoadProfile.
     */
    data: XOR<LoadProfileCreateInput, LoadProfileUncheckedCreateInput>
  }

  /**
   * LoadProfile createMany
   */
  export type LoadProfileCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many LoadProfiles.
     */
    data: LoadProfileCreateManyInput | LoadProfileCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * LoadProfile createManyAndReturn
   */
  export type LoadProfileCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * The data used to create many LoadProfiles.
     */
    data: LoadProfileCreateManyInput | LoadProfileCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * LoadProfile update
   */
  export type LoadProfileUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * The data needed to update a LoadProfile.
     */
    data: XOR<LoadProfileUpdateInput, LoadProfileUncheckedUpdateInput>
    /**
     * Choose, which LoadProfile to update.
     */
    where: LoadProfileWhereUniqueInput
  }

  /**
   * LoadProfile updateMany
   */
  export type LoadProfileUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update LoadProfiles.
     */
    data: XOR<LoadProfileUpdateManyMutationInput, LoadProfileUncheckedUpdateManyInput>
    /**
     * Filter which LoadProfiles to update
     */
    where?: LoadProfileWhereInput
    /**
     * Limit how many LoadProfiles to update.
     */
    limit?: number
  }

  /**
   * LoadProfile updateManyAndReturn
   */
  export type LoadProfileUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * The data used to update LoadProfiles.
     */
    data: XOR<LoadProfileUpdateManyMutationInput, LoadProfileUncheckedUpdateManyInput>
    /**
     * Filter which LoadProfiles to update
     */
    where?: LoadProfileWhereInput
    /**
     * Limit how many LoadProfiles to update.
     */
    limit?: number
  }

  /**
   * LoadProfile upsert
   */
  export type LoadProfileUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * The filter to search for the LoadProfile to update in case it exists.
     */
    where: LoadProfileWhereUniqueInput
    /**
     * In case the LoadProfile found by the `where` argument doesn't exist, create a new LoadProfile with this data.
     */
    create: XOR<LoadProfileCreateInput, LoadProfileUncheckedCreateInput>
    /**
     * In case the LoadProfile was found with the provided `where` argument, update it with this data.
     */
    update: XOR<LoadProfileUpdateInput, LoadProfileUncheckedUpdateInput>
  }

  /**
   * LoadProfile delete
   */
  export type LoadProfileDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    /**
     * Filter which LoadProfile to delete.
     */
    where: LoadProfileWhereUniqueInput
  }

  /**
   * LoadProfile deleteMany
   */
  export type LoadProfileDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which LoadProfiles to delete
     */
    where?: LoadProfileWhereInput
    /**
     * Limit how many LoadProfiles to delete.
     */
    limit?: number
  }

  /**
   * LoadProfile.cluster_configurations
   */
  export type LoadProfile$cluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    where?: ClusterConfigurationWhereInput
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    cursor?: ClusterConfigurationWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * LoadProfile without action
   */
  export type LoadProfileDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
  }


  /**
   * Model FanConfiguration
   */

  export type AggregateFanConfiguration = {
    _count: FanConfigurationCountAggregateOutputType | null
    _avg: FanConfigurationAvgAggregateOutputType | null
    _sum: FanConfigurationSumAggregateOutputType | null
    _min: FanConfigurationMinAggregateOutputType | null
    _max: FanConfigurationMaxAggregateOutputType | null
  }

  export type FanConfigurationAvgAggregateOutputType = {
    fan_id: number | null
    consomation: number | null
  }

  export type FanConfigurationSumAggregateOutputType = {
    fan_id: number | null
    consomation: number | null
  }

  export type FanConfigurationMinAggregateOutputType = {
    fan_id: number | null
    name: string | null
    consomation: number | null
  }

  export type FanConfigurationMaxAggregateOutputType = {
    fan_id: number | null
    name: string | null
    consomation: number | null
  }

  export type FanConfigurationCountAggregateOutputType = {
    fan_id: number
    name: number
    consomation: number
    _all: number
  }


  export type FanConfigurationAvgAggregateInputType = {
    fan_id?: true
    consomation?: true
  }

  export type FanConfigurationSumAggregateInputType = {
    fan_id?: true
    consomation?: true
  }

  export type FanConfigurationMinAggregateInputType = {
    fan_id?: true
    name?: true
    consomation?: true
  }

  export type FanConfigurationMaxAggregateInputType = {
    fan_id?: true
    name?: true
    consomation?: true
  }

  export type FanConfigurationCountAggregateInputType = {
    fan_id?: true
    name?: true
    consomation?: true
    _all?: true
  }

  export type FanConfigurationAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which FanConfiguration to aggregate.
     */
    where?: FanConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanConfigurations to fetch.
     */
    orderBy?: FanConfigurationOrderByWithRelationInput | FanConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: FanConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned FanConfigurations
    **/
    _count?: true | FanConfigurationCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: FanConfigurationAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: FanConfigurationSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: FanConfigurationMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: FanConfigurationMaxAggregateInputType
  }

  export type GetFanConfigurationAggregateType<T extends FanConfigurationAggregateArgs> = {
        [P in keyof T & keyof AggregateFanConfiguration]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateFanConfiguration[P]>
      : GetScalarType<T[P], AggregateFanConfiguration[P]>
  }




  export type FanConfigurationGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: FanConfigurationWhereInput
    orderBy?: FanConfigurationOrderByWithAggregationInput | FanConfigurationOrderByWithAggregationInput[]
    by: FanConfigurationScalarFieldEnum[] | FanConfigurationScalarFieldEnum
    having?: FanConfigurationScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: FanConfigurationCountAggregateInputType | true
    _avg?: FanConfigurationAvgAggregateInputType
    _sum?: FanConfigurationSumAggregateInputType
    _min?: FanConfigurationMinAggregateInputType
    _max?: FanConfigurationMaxAggregateInputType
  }

  export type FanConfigurationGroupByOutputType = {
    fan_id: number
    name: string
    consomation: number | null
    _count: FanConfigurationCountAggregateOutputType | null
    _avg: FanConfigurationAvgAggregateOutputType | null
    _sum: FanConfigurationSumAggregateOutputType | null
    _min: FanConfigurationMinAggregateOutputType | null
    _max: FanConfigurationMaxAggregateOutputType | null
  }

  type GetFanConfigurationGroupByPayload<T extends FanConfigurationGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<FanConfigurationGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof FanConfigurationGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], FanConfigurationGroupByOutputType[P]>
            : GetScalarType<T[P], FanConfigurationGroupByOutputType[P]>
        }
      >
    >


  export type FanConfigurationSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_id?: boolean
    name?: boolean
    consomation?: boolean
    cluster_configurations?: boolean | FanConfiguration$cluster_configurationsArgs<ExtArgs>
    fans?: boolean | FanConfiguration$fansArgs<ExtArgs>
    _count?: boolean | FanConfigurationCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["fanConfiguration"]>

  export type FanConfigurationSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_id?: boolean
    name?: boolean
    consomation?: boolean
  }, ExtArgs["result"]["fanConfiguration"]>

  export type FanConfigurationSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_id?: boolean
    name?: boolean
    consomation?: boolean
  }, ExtArgs["result"]["fanConfiguration"]>

  export type FanConfigurationSelectScalar = {
    fan_id?: boolean
    name?: boolean
    consomation?: boolean
  }

  export type FanConfigurationOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"fan_id" | "name" | "consomation", ExtArgs["result"]["fanConfiguration"]>
  export type FanConfigurationInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | FanConfiguration$cluster_configurationsArgs<ExtArgs>
    fans?: boolean | FanConfiguration$fansArgs<ExtArgs>
    _count?: boolean | FanConfigurationCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type FanConfigurationIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}
  export type FanConfigurationIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}

  export type $FanConfigurationPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "FanConfiguration"
    objects: {
      cluster_configurations: Prisma.$ClusterConfigurationPayload<ExtArgs>[]
      fans: Prisma.$FanPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      fan_id: number
      name: string
      consomation: number | null
    }, ExtArgs["result"]["fanConfiguration"]>
    composites: {}
  }

  type FanConfigurationGetPayload<S extends boolean | null | undefined | FanConfigurationDefaultArgs> = $Result.GetResult<Prisma.$FanConfigurationPayload, S>

  type FanConfigurationCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<FanConfigurationFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: FanConfigurationCountAggregateInputType | true
    }

  export interface FanConfigurationDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['FanConfiguration'], meta: { name: 'FanConfiguration' } }
    /**
     * Find zero or one FanConfiguration that matches the filter.
     * @param {FanConfigurationFindUniqueArgs} args - Arguments to find a FanConfiguration
     * @example
     * // Get one FanConfiguration
     * const fanConfiguration = await prisma.fanConfiguration.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends FanConfigurationFindUniqueArgs>(args: SelectSubset<T, FanConfigurationFindUniqueArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one FanConfiguration that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {FanConfigurationFindUniqueOrThrowArgs} args - Arguments to find a FanConfiguration
     * @example
     * // Get one FanConfiguration
     * const fanConfiguration = await prisma.fanConfiguration.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends FanConfigurationFindUniqueOrThrowArgs>(args: SelectSubset<T, FanConfigurationFindUniqueOrThrowArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first FanConfiguration that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanConfigurationFindFirstArgs} args - Arguments to find a FanConfiguration
     * @example
     * // Get one FanConfiguration
     * const fanConfiguration = await prisma.fanConfiguration.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends FanConfigurationFindFirstArgs>(args?: SelectSubset<T, FanConfigurationFindFirstArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first FanConfiguration that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanConfigurationFindFirstOrThrowArgs} args - Arguments to find a FanConfiguration
     * @example
     * // Get one FanConfiguration
     * const fanConfiguration = await prisma.fanConfiguration.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends FanConfigurationFindFirstOrThrowArgs>(args?: SelectSubset<T, FanConfigurationFindFirstOrThrowArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more FanConfigurations that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanConfigurationFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all FanConfigurations
     * const fanConfigurations = await prisma.fanConfiguration.findMany()
     * 
     * // Get first 10 FanConfigurations
     * const fanConfigurations = await prisma.fanConfiguration.findMany({ take: 10 })
     * 
     * // Only select the `fan_id`
     * const fanConfigurationWithFan_idOnly = await prisma.fanConfiguration.findMany({ select: { fan_id: true } })
     * 
     */
    findMany<T extends FanConfigurationFindManyArgs>(args?: SelectSubset<T, FanConfigurationFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a FanConfiguration.
     * @param {FanConfigurationCreateArgs} args - Arguments to create a FanConfiguration.
     * @example
     * // Create one FanConfiguration
     * const FanConfiguration = await prisma.fanConfiguration.create({
     *   data: {
     *     // ... data to create a FanConfiguration
     *   }
     * })
     * 
     */
    create<T extends FanConfigurationCreateArgs>(args: SelectSubset<T, FanConfigurationCreateArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many FanConfigurations.
     * @param {FanConfigurationCreateManyArgs} args - Arguments to create many FanConfigurations.
     * @example
     * // Create many FanConfigurations
     * const fanConfiguration = await prisma.fanConfiguration.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends FanConfigurationCreateManyArgs>(args?: SelectSubset<T, FanConfigurationCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many FanConfigurations and returns the data saved in the database.
     * @param {FanConfigurationCreateManyAndReturnArgs} args - Arguments to create many FanConfigurations.
     * @example
     * // Create many FanConfigurations
     * const fanConfiguration = await prisma.fanConfiguration.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many FanConfigurations and only return the `fan_id`
     * const fanConfigurationWithFan_idOnly = await prisma.fanConfiguration.createManyAndReturn({
     *   select: { fan_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends FanConfigurationCreateManyAndReturnArgs>(args?: SelectSubset<T, FanConfigurationCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a FanConfiguration.
     * @param {FanConfigurationDeleteArgs} args - Arguments to delete one FanConfiguration.
     * @example
     * // Delete one FanConfiguration
     * const FanConfiguration = await prisma.fanConfiguration.delete({
     *   where: {
     *     // ... filter to delete one FanConfiguration
     *   }
     * })
     * 
     */
    delete<T extends FanConfigurationDeleteArgs>(args: SelectSubset<T, FanConfigurationDeleteArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one FanConfiguration.
     * @param {FanConfigurationUpdateArgs} args - Arguments to update one FanConfiguration.
     * @example
     * // Update one FanConfiguration
     * const fanConfiguration = await prisma.fanConfiguration.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends FanConfigurationUpdateArgs>(args: SelectSubset<T, FanConfigurationUpdateArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more FanConfigurations.
     * @param {FanConfigurationDeleteManyArgs} args - Arguments to filter FanConfigurations to delete.
     * @example
     * // Delete a few FanConfigurations
     * const { count } = await prisma.fanConfiguration.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends FanConfigurationDeleteManyArgs>(args?: SelectSubset<T, FanConfigurationDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more FanConfigurations.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanConfigurationUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many FanConfigurations
     * const fanConfiguration = await prisma.fanConfiguration.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends FanConfigurationUpdateManyArgs>(args: SelectSubset<T, FanConfigurationUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more FanConfigurations and returns the data updated in the database.
     * @param {FanConfigurationUpdateManyAndReturnArgs} args - Arguments to update many FanConfigurations.
     * @example
     * // Update many FanConfigurations
     * const fanConfiguration = await prisma.fanConfiguration.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more FanConfigurations and only return the `fan_id`
     * const fanConfigurationWithFan_idOnly = await prisma.fanConfiguration.updateManyAndReturn({
     *   select: { fan_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends FanConfigurationUpdateManyAndReturnArgs>(args: SelectSubset<T, FanConfigurationUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one FanConfiguration.
     * @param {FanConfigurationUpsertArgs} args - Arguments to update or create a FanConfiguration.
     * @example
     * // Update or create a FanConfiguration
     * const fanConfiguration = await prisma.fanConfiguration.upsert({
     *   create: {
     *     // ... data to create a FanConfiguration
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the FanConfiguration we want to update
     *   }
     * })
     */
    upsert<T extends FanConfigurationUpsertArgs>(args: SelectSubset<T, FanConfigurationUpsertArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of FanConfigurations.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanConfigurationCountArgs} args - Arguments to filter FanConfigurations to count.
     * @example
     * // Count the number of FanConfigurations
     * const count = await prisma.fanConfiguration.count({
     *   where: {
     *     // ... the filter for the FanConfigurations we want to count
     *   }
     * })
    **/
    count<T extends FanConfigurationCountArgs>(
      args?: Subset<T, FanConfigurationCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], FanConfigurationCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a FanConfiguration.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanConfigurationAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends FanConfigurationAggregateArgs>(args: Subset<T, FanConfigurationAggregateArgs>): Prisma.PrismaPromise<GetFanConfigurationAggregateType<T>>

    /**
     * Group by FanConfiguration.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanConfigurationGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends FanConfigurationGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: FanConfigurationGroupByArgs['orderBy'] }
        : { orderBy?: FanConfigurationGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, FanConfigurationGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetFanConfigurationGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the FanConfiguration model
   */
  readonly fields: FanConfigurationFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for FanConfiguration.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__FanConfigurationClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    cluster_configurations<T extends FanConfiguration$cluster_configurationsArgs<ExtArgs> = {}>(args?: Subset<T, FanConfiguration$cluster_configurationsArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    fans<T extends FanConfiguration$fansArgs<ExtArgs> = {}>(args?: Subset<T, FanConfiguration$fansArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the FanConfiguration model
   */
  interface FanConfigurationFieldRefs {
    readonly fan_id: FieldRef<"FanConfiguration", 'Int'>
    readonly name: FieldRef<"FanConfiguration", 'String'>
    readonly consomation: FieldRef<"FanConfiguration", 'Float'>
  }
    

  // Custom InputTypes
  /**
   * FanConfiguration findUnique
   */
  export type FanConfigurationFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which FanConfiguration to fetch.
     */
    where: FanConfigurationWhereUniqueInput
  }

  /**
   * FanConfiguration findUniqueOrThrow
   */
  export type FanConfigurationFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which FanConfiguration to fetch.
     */
    where: FanConfigurationWhereUniqueInput
  }

  /**
   * FanConfiguration findFirst
   */
  export type FanConfigurationFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which FanConfiguration to fetch.
     */
    where?: FanConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanConfigurations to fetch.
     */
    orderBy?: FanConfigurationOrderByWithRelationInput | FanConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for FanConfigurations.
     */
    cursor?: FanConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of FanConfigurations.
     */
    distinct?: FanConfigurationScalarFieldEnum | FanConfigurationScalarFieldEnum[]
  }

  /**
   * FanConfiguration findFirstOrThrow
   */
  export type FanConfigurationFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which FanConfiguration to fetch.
     */
    where?: FanConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanConfigurations to fetch.
     */
    orderBy?: FanConfigurationOrderByWithRelationInput | FanConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for FanConfigurations.
     */
    cursor?: FanConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of FanConfigurations.
     */
    distinct?: FanConfigurationScalarFieldEnum | FanConfigurationScalarFieldEnum[]
  }

  /**
   * FanConfiguration findMany
   */
  export type FanConfigurationFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which FanConfigurations to fetch.
     */
    where?: FanConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanConfigurations to fetch.
     */
    orderBy?: FanConfigurationOrderByWithRelationInput | FanConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing FanConfigurations.
     */
    cursor?: FanConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of FanConfigurations.
     */
    distinct?: FanConfigurationScalarFieldEnum | FanConfigurationScalarFieldEnum[]
  }

  /**
   * FanConfiguration create
   */
  export type FanConfigurationCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * The data needed to create a FanConfiguration.
     */
    data: XOR<FanConfigurationCreateInput, FanConfigurationUncheckedCreateInput>
  }

  /**
   * FanConfiguration createMany
   */
  export type FanConfigurationCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many FanConfigurations.
     */
    data: FanConfigurationCreateManyInput | FanConfigurationCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * FanConfiguration createManyAndReturn
   */
  export type FanConfigurationCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * The data used to create many FanConfigurations.
     */
    data: FanConfigurationCreateManyInput | FanConfigurationCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * FanConfiguration update
   */
  export type FanConfigurationUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * The data needed to update a FanConfiguration.
     */
    data: XOR<FanConfigurationUpdateInput, FanConfigurationUncheckedUpdateInput>
    /**
     * Choose, which FanConfiguration to update.
     */
    where: FanConfigurationWhereUniqueInput
  }

  /**
   * FanConfiguration updateMany
   */
  export type FanConfigurationUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update FanConfigurations.
     */
    data: XOR<FanConfigurationUpdateManyMutationInput, FanConfigurationUncheckedUpdateManyInput>
    /**
     * Filter which FanConfigurations to update
     */
    where?: FanConfigurationWhereInput
    /**
     * Limit how many FanConfigurations to update.
     */
    limit?: number
  }

  /**
   * FanConfiguration updateManyAndReturn
   */
  export type FanConfigurationUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * The data used to update FanConfigurations.
     */
    data: XOR<FanConfigurationUpdateManyMutationInput, FanConfigurationUncheckedUpdateManyInput>
    /**
     * Filter which FanConfigurations to update
     */
    where?: FanConfigurationWhereInput
    /**
     * Limit how many FanConfigurations to update.
     */
    limit?: number
  }

  /**
   * FanConfiguration upsert
   */
  export type FanConfigurationUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * The filter to search for the FanConfiguration to update in case it exists.
     */
    where: FanConfigurationWhereUniqueInput
    /**
     * In case the FanConfiguration found by the `where` argument doesn't exist, create a new FanConfiguration with this data.
     */
    create: XOR<FanConfigurationCreateInput, FanConfigurationUncheckedCreateInput>
    /**
     * In case the FanConfiguration was found with the provided `where` argument, update it with this data.
     */
    update: XOR<FanConfigurationUpdateInput, FanConfigurationUncheckedUpdateInput>
  }

  /**
   * FanConfiguration delete
   */
  export type FanConfigurationDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    /**
     * Filter which FanConfiguration to delete.
     */
    where: FanConfigurationWhereUniqueInput
  }

  /**
   * FanConfiguration deleteMany
   */
  export type FanConfigurationDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which FanConfigurations to delete
     */
    where?: FanConfigurationWhereInput
    /**
     * Limit how many FanConfigurations to delete.
     */
    limit?: number
  }

  /**
   * FanConfiguration.cluster_configurations
   */
  export type FanConfiguration$cluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    where?: ClusterConfigurationWhereInput
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    cursor?: ClusterConfigurationWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * FanConfiguration.fans
   */
  export type FanConfiguration$fansArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    where?: FanWhereInput
    orderBy?: FanOrderByWithRelationInput | FanOrderByWithRelationInput[]
    cursor?: FanWhereUniqueInput
    take?: number
    skip?: number
    distinct?: FanScalarFieldEnum | FanScalarFieldEnum[]
  }

  /**
   * FanConfiguration without action
   */
  export type FanConfigurationDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
  }


  /**
   * Model FanCatalog
   */

  export type AggregateFanCatalog = {
    _count: FanCatalogCountAggregateOutputType | null
    _avg: FanCatalogAvgAggregateOutputType | null
    _sum: FanCatalogSumAggregateOutputType | null
    _min: FanCatalogMinAggregateOutputType | null
    _max: FanCatalogMaxAggregateOutputType | null
  }

  export type FanCatalogAvgAggregateOutputType = {
    fan_catalog_id: number | null
    consomation: number | null
  }

  export type FanCatalogSumAggregateOutputType = {
    fan_catalog_id: number | null
    consomation: number | null
  }

  export type FanCatalogMinAggregateOutputType = {
    fan_catalog_id: number | null
    model_name: string | null
    consomation: number | null
  }

  export type FanCatalogMaxAggregateOutputType = {
    fan_catalog_id: number | null
    model_name: string | null
    consomation: number | null
  }

  export type FanCatalogCountAggregateOutputType = {
    fan_catalog_id: number
    model_name: number
    consomation: number
    _all: number
  }


  export type FanCatalogAvgAggregateInputType = {
    fan_catalog_id?: true
    consomation?: true
  }

  export type FanCatalogSumAggregateInputType = {
    fan_catalog_id?: true
    consomation?: true
  }

  export type FanCatalogMinAggregateInputType = {
    fan_catalog_id?: true
    model_name?: true
    consomation?: true
  }

  export type FanCatalogMaxAggregateInputType = {
    fan_catalog_id?: true
    model_name?: true
    consomation?: true
  }

  export type FanCatalogCountAggregateInputType = {
    fan_catalog_id?: true
    model_name?: true
    consomation?: true
    _all?: true
  }

  export type FanCatalogAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which FanCatalog to aggregate.
     */
    where?: FanCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanCatalogs to fetch.
     */
    orderBy?: FanCatalogOrderByWithRelationInput | FanCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: FanCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned FanCatalogs
    **/
    _count?: true | FanCatalogCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: FanCatalogAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: FanCatalogSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: FanCatalogMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: FanCatalogMaxAggregateInputType
  }

  export type GetFanCatalogAggregateType<T extends FanCatalogAggregateArgs> = {
        [P in keyof T & keyof AggregateFanCatalog]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateFanCatalog[P]>
      : GetScalarType<T[P], AggregateFanCatalog[P]>
  }




  export type FanCatalogGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: FanCatalogWhereInput
    orderBy?: FanCatalogOrderByWithAggregationInput | FanCatalogOrderByWithAggregationInput[]
    by: FanCatalogScalarFieldEnum[] | FanCatalogScalarFieldEnum
    having?: FanCatalogScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: FanCatalogCountAggregateInputType | true
    _avg?: FanCatalogAvgAggregateInputType
    _sum?: FanCatalogSumAggregateInputType
    _min?: FanCatalogMinAggregateInputType
    _max?: FanCatalogMaxAggregateInputType
  }

  export type FanCatalogGroupByOutputType = {
    fan_catalog_id: number
    model_name: string
    consomation: number | null
    _count: FanCatalogCountAggregateOutputType | null
    _avg: FanCatalogAvgAggregateOutputType | null
    _sum: FanCatalogSumAggregateOutputType | null
    _min: FanCatalogMinAggregateOutputType | null
    _max: FanCatalogMaxAggregateOutputType | null
  }

  type GetFanCatalogGroupByPayload<T extends FanCatalogGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<FanCatalogGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof FanCatalogGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], FanCatalogGroupByOutputType[P]>
            : GetScalarType<T[P], FanCatalogGroupByOutputType[P]>
        }
      >
    >


  export type FanCatalogSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_catalog_id?: boolean
    model_name?: boolean
    consomation?: boolean
    cluster_configurations?: boolean | FanCatalog$cluster_configurationsArgs<ExtArgs>
    fans?: boolean | FanCatalog$fansArgs<ExtArgs>
    _count?: boolean | FanCatalogCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["fanCatalog"]>

  export type FanCatalogSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_catalog_id?: boolean
    model_name?: boolean
    consomation?: boolean
  }, ExtArgs["result"]["fanCatalog"]>

  export type FanCatalogSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_catalog_id?: boolean
    model_name?: boolean
    consomation?: boolean
  }, ExtArgs["result"]["fanCatalog"]>

  export type FanCatalogSelectScalar = {
    fan_catalog_id?: boolean
    model_name?: boolean
    consomation?: boolean
  }

  export type FanCatalogOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"fan_catalog_id" | "model_name" | "consomation", ExtArgs["result"]["fanCatalog"]>
  export type FanCatalogInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configurations?: boolean | FanCatalog$cluster_configurationsArgs<ExtArgs>
    fans?: boolean | FanCatalog$fansArgs<ExtArgs>
    _count?: boolean | FanCatalogCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type FanCatalogIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}
  export type FanCatalogIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}

  export type $FanCatalogPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "FanCatalog"
    objects: {
      cluster_configurations: Prisma.$ClusterConfigurationPayload<ExtArgs>[]
      fans: Prisma.$FanPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      fan_catalog_id: number
      model_name: string
      consomation: number | null
    }, ExtArgs["result"]["fanCatalog"]>
    composites: {}
  }

  type FanCatalogGetPayload<S extends boolean | null | undefined | FanCatalogDefaultArgs> = $Result.GetResult<Prisma.$FanCatalogPayload, S>

  type FanCatalogCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<FanCatalogFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: FanCatalogCountAggregateInputType | true
    }

  export interface FanCatalogDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['FanCatalog'], meta: { name: 'FanCatalog' } }
    /**
     * Find zero or one FanCatalog that matches the filter.
     * @param {FanCatalogFindUniqueArgs} args - Arguments to find a FanCatalog
     * @example
     * // Get one FanCatalog
     * const fanCatalog = await prisma.fanCatalog.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends FanCatalogFindUniqueArgs>(args: SelectSubset<T, FanCatalogFindUniqueArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one FanCatalog that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {FanCatalogFindUniqueOrThrowArgs} args - Arguments to find a FanCatalog
     * @example
     * // Get one FanCatalog
     * const fanCatalog = await prisma.fanCatalog.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends FanCatalogFindUniqueOrThrowArgs>(args: SelectSubset<T, FanCatalogFindUniqueOrThrowArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first FanCatalog that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCatalogFindFirstArgs} args - Arguments to find a FanCatalog
     * @example
     * // Get one FanCatalog
     * const fanCatalog = await prisma.fanCatalog.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends FanCatalogFindFirstArgs>(args?: SelectSubset<T, FanCatalogFindFirstArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first FanCatalog that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCatalogFindFirstOrThrowArgs} args - Arguments to find a FanCatalog
     * @example
     * // Get one FanCatalog
     * const fanCatalog = await prisma.fanCatalog.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends FanCatalogFindFirstOrThrowArgs>(args?: SelectSubset<T, FanCatalogFindFirstOrThrowArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more FanCatalogs that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCatalogFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all FanCatalogs
     * const fanCatalogs = await prisma.fanCatalog.findMany()
     * 
     * // Get first 10 FanCatalogs
     * const fanCatalogs = await prisma.fanCatalog.findMany({ take: 10 })
     * 
     * // Only select the `fan_catalog_id`
     * const fanCatalogWithFan_catalog_idOnly = await prisma.fanCatalog.findMany({ select: { fan_catalog_id: true } })
     * 
     */
    findMany<T extends FanCatalogFindManyArgs>(args?: SelectSubset<T, FanCatalogFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a FanCatalog.
     * @param {FanCatalogCreateArgs} args - Arguments to create a FanCatalog.
     * @example
     * // Create one FanCatalog
     * const FanCatalog = await prisma.fanCatalog.create({
     *   data: {
     *     // ... data to create a FanCatalog
     *   }
     * })
     * 
     */
    create<T extends FanCatalogCreateArgs>(args: SelectSubset<T, FanCatalogCreateArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many FanCatalogs.
     * @param {FanCatalogCreateManyArgs} args - Arguments to create many FanCatalogs.
     * @example
     * // Create many FanCatalogs
     * const fanCatalog = await prisma.fanCatalog.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends FanCatalogCreateManyArgs>(args?: SelectSubset<T, FanCatalogCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many FanCatalogs and returns the data saved in the database.
     * @param {FanCatalogCreateManyAndReturnArgs} args - Arguments to create many FanCatalogs.
     * @example
     * // Create many FanCatalogs
     * const fanCatalog = await prisma.fanCatalog.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many FanCatalogs and only return the `fan_catalog_id`
     * const fanCatalogWithFan_catalog_idOnly = await prisma.fanCatalog.createManyAndReturn({
     *   select: { fan_catalog_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends FanCatalogCreateManyAndReturnArgs>(args?: SelectSubset<T, FanCatalogCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a FanCatalog.
     * @param {FanCatalogDeleteArgs} args - Arguments to delete one FanCatalog.
     * @example
     * // Delete one FanCatalog
     * const FanCatalog = await prisma.fanCatalog.delete({
     *   where: {
     *     // ... filter to delete one FanCatalog
     *   }
     * })
     * 
     */
    delete<T extends FanCatalogDeleteArgs>(args: SelectSubset<T, FanCatalogDeleteArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one FanCatalog.
     * @param {FanCatalogUpdateArgs} args - Arguments to update one FanCatalog.
     * @example
     * // Update one FanCatalog
     * const fanCatalog = await prisma.fanCatalog.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends FanCatalogUpdateArgs>(args: SelectSubset<T, FanCatalogUpdateArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more FanCatalogs.
     * @param {FanCatalogDeleteManyArgs} args - Arguments to filter FanCatalogs to delete.
     * @example
     * // Delete a few FanCatalogs
     * const { count } = await prisma.fanCatalog.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends FanCatalogDeleteManyArgs>(args?: SelectSubset<T, FanCatalogDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more FanCatalogs.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCatalogUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many FanCatalogs
     * const fanCatalog = await prisma.fanCatalog.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends FanCatalogUpdateManyArgs>(args: SelectSubset<T, FanCatalogUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more FanCatalogs and returns the data updated in the database.
     * @param {FanCatalogUpdateManyAndReturnArgs} args - Arguments to update many FanCatalogs.
     * @example
     * // Update many FanCatalogs
     * const fanCatalog = await prisma.fanCatalog.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more FanCatalogs and only return the `fan_catalog_id`
     * const fanCatalogWithFan_catalog_idOnly = await prisma.fanCatalog.updateManyAndReturn({
     *   select: { fan_catalog_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends FanCatalogUpdateManyAndReturnArgs>(args: SelectSubset<T, FanCatalogUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one FanCatalog.
     * @param {FanCatalogUpsertArgs} args - Arguments to update or create a FanCatalog.
     * @example
     * // Update or create a FanCatalog
     * const fanCatalog = await prisma.fanCatalog.upsert({
     *   create: {
     *     // ... data to create a FanCatalog
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the FanCatalog we want to update
     *   }
     * })
     */
    upsert<T extends FanCatalogUpsertArgs>(args: SelectSubset<T, FanCatalogUpsertArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of FanCatalogs.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCatalogCountArgs} args - Arguments to filter FanCatalogs to count.
     * @example
     * // Count the number of FanCatalogs
     * const count = await prisma.fanCatalog.count({
     *   where: {
     *     // ... the filter for the FanCatalogs we want to count
     *   }
     * })
    **/
    count<T extends FanCatalogCountArgs>(
      args?: Subset<T, FanCatalogCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], FanCatalogCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a FanCatalog.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCatalogAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends FanCatalogAggregateArgs>(args: Subset<T, FanCatalogAggregateArgs>): Prisma.PrismaPromise<GetFanCatalogAggregateType<T>>

    /**
     * Group by FanCatalog.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCatalogGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends FanCatalogGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: FanCatalogGroupByArgs['orderBy'] }
        : { orderBy?: FanCatalogGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, FanCatalogGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetFanCatalogGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the FanCatalog model
   */
  readonly fields: FanCatalogFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for FanCatalog.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__FanCatalogClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    cluster_configurations<T extends FanCatalog$cluster_configurationsArgs<ExtArgs> = {}>(args?: Subset<T, FanCatalog$cluster_configurationsArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    fans<T extends FanCatalog$fansArgs<ExtArgs> = {}>(args?: Subset<T, FanCatalog$fansArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the FanCatalog model
   */
  interface FanCatalogFieldRefs {
    readonly fan_catalog_id: FieldRef<"FanCatalog", 'Int'>
    readonly model_name: FieldRef<"FanCatalog", 'String'>
    readonly consomation: FieldRef<"FanCatalog", 'Float'>
  }
    

  // Custom InputTypes
  /**
   * FanCatalog findUnique
   */
  export type FanCatalogFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * Filter, which FanCatalog to fetch.
     */
    where: FanCatalogWhereUniqueInput
  }

  /**
   * FanCatalog findUniqueOrThrow
   */
  export type FanCatalogFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * Filter, which FanCatalog to fetch.
     */
    where: FanCatalogWhereUniqueInput
  }

  /**
   * FanCatalog findFirst
   */
  export type FanCatalogFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * Filter, which FanCatalog to fetch.
     */
    where?: FanCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanCatalogs to fetch.
     */
    orderBy?: FanCatalogOrderByWithRelationInput | FanCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for FanCatalogs.
     */
    cursor?: FanCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of FanCatalogs.
     */
    distinct?: FanCatalogScalarFieldEnum | FanCatalogScalarFieldEnum[]
  }

  /**
   * FanCatalog findFirstOrThrow
   */
  export type FanCatalogFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * Filter, which FanCatalog to fetch.
     */
    where?: FanCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanCatalogs to fetch.
     */
    orderBy?: FanCatalogOrderByWithRelationInput | FanCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for FanCatalogs.
     */
    cursor?: FanCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of FanCatalogs.
     */
    distinct?: FanCatalogScalarFieldEnum | FanCatalogScalarFieldEnum[]
  }

  /**
   * FanCatalog findMany
   */
  export type FanCatalogFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * Filter, which FanCatalogs to fetch.
     */
    where?: FanCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of FanCatalogs to fetch.
     */
    orderBy?: FanCatalogOrderByWithRelationInput | FanCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing FanCatalogs.
     */
    cursor?: FanCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` FanCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` FanCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of FanCatalogs.
     */
    distinct?: FanCatalogScalarFieldEnum | FanCatalogScalarFieldEnum[]
  }

  /**
   * FanCatalog create
   */
  export type FanCatalogCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * The data needed to create a FanCatalog.
     */
    data: XOR<FanCatalogCreateInput, FanCatalogUncheckedCreateInput>
  }

  /**
   * FanCatalog createMany
   */
  export type FanCatalogCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many FanCatalogs.
     */
    data: FanCatalogCreateManyInput | FanCatalogCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * FanCatalog createManyAndReturn
   */
  export type FanCatalogCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * The data used to create many FanCatalogs.
     */
    data: FanCatalogCreateManyInput | FanCatalogCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * FanCatalog update
   */
  export type FanCatalogUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * The data needed to update a FanCatalog.
     */
    data: XOR<FanCatalogUpdateInput, FanCatalogUncheckedUpdateInput>
    /**
     * Choose, which FanCatalog to update.
     */
    where: FanCatalogWhereUniqueInput
  }

  /**
   * FanCatalog updateMany
   */
  export type FanCatalogUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update FanCatalogs.
     */
    data: XOR<FanCatalogUpdateManyMutationInput, FanCatalogUncheckedUpdateManyInput>
    /**
     * Filter which FanCatalogs to update
     */
    where?: FanCatalogWhereInput
    /**
     * Limit how many FanCatalogs to update.
     */
    limit?: number
  }

  /**
   * FanCatalog updateManyAndReturn
   */
  export type FanCatalogUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * The data used to update FanCatalogs.
     */
    data: XOR<FanCatalogUpdateManyMutationInput, FanCatalogUncheckedUpdateManyInput>
    /**
     * Filter which FanCatalogs to update
     */
    where?: FanCatalogWhereInput
    /**
     * Limit how many FanCatalogs to update.
     */
    limit?: number
  }

  /**
   * FanCatalog upsert
   */
  export type FanCatalogUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * The filter to search for the FanCatalog to update in case it exists.
     */
    where: FanCatalogWhereUniqueInput
    /**
     * In case the FanCatalog found by the `where` argument doesn't exist, create a new FanCatalog with this data.
     */
    create: XOR<FanCatalogCreateInput, FanCatalogUncheckedCreateInput>
    /**
     * In case the FanCatalog was found with the provided `where` argument, update it with this data.
     */
    update: XOR<FanCatalogUpdateInput, FanCatalogUncheckedUpdateInput>
  }

  /**
   * FanCatalog delete
   */
  export type FanCatalogDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    /**
     * Filter which FanCatalog to delete.
     */
    where: FanCatalogWhereUniqueInput
  }

  /**
   * FanCatalog deleteMany
   */
  export type FanCatalogDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which FanCatalogs to delete
     */
    where?: FanCatalogWhereInput
    /**
     * Limit how many FanCatalogs to delete.
     */
    limit?: number
  }

  /**
   * FanCatalog.cluster_configurations
   */
  export type FanCatalog$cluster_configurationsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    where?: ClusterConfigurationWhereInput
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    cursor?: ClusterConfigurationWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * FanCatalog.fans
   */
  export type FanCatalog$fansArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    where?: FanWhereInput
    orderBy?: FanOrderByWithRelationInput | FanOrderByWithRelationInput[]
    cursor?: FanWhereUniqueInput
    take?: number
    skip?: number
    distinct?: FanScalarFieldEnum | FanScalarFieldEnum[]
  }

  /**
   * FanCatalog without action
   */
  export type FanCatalogDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
  }


  /**
   * Model CpuCoolerCatalog
   */

  export type AggregateCpuCoolerCatalog = {
    _count: CpuCoolerCatalogCountAggregateOutputType | null
    _avg: CpuCoolerCatalogAvgAggregateOutputType | null
    _sum: CpuCoolerCatalogSumAggregateOutputType | null
    _min: CpuCoolerCatalogMinAggregateOutputType | null
    _max: CpuCoolerCatalogMaxAggregateOutputType | null
  }

  export type CpuCoolerCatalogAvgAggregateOutputType = {
    cpu_cooler_catalog_id: number | null
    thermal_capacity: number | null
  }

  export type CpuCoolerCatalogSumAggregateOutputType = {
    cpu_cooler_catalog_id: number | null
    thermal_capacity: number | null
  }

  export type CpuCoolerCatalogMinAggregateOutputType = {
    cpu_cooler_catalog_id: number | null
    model_name: string | null
    type: string | null
    thermal_capacity: number | null
  }

  export type CpuCoolerCatalogMaxAggregateOutputType = {
    cpu_cooler_catalog_id: number | null
    model_name: string | null
    type: string | null
    thermal_capacity: number | null
  }

  export type CpuCoolerCatalogCountAggregateOutputType = {
    cpu_cooler_catalog_id: number
    model_name: number
    type: number
    thermal_capacity: number
    _all: number
  }


  export type CpuCoolerCatalogAvgAggregateInputType = {
    cpu_cooler_catalog_id?: true
    thermal_capacity?: true
  }

  export type CpuCoolerCatalogSumAggregateInputType = {
    cpu_cooler_catalog_id?: true
    thermal_capacity?: true
  }

  export type CpuCoolerCatalogMinAggregateInputType = {
    cpu_cooler_catalog_id?: true
    model_name?: true
    type?: true
    thermal_capacity?: true
  }

  export type CpuCoolerCatalogMaxAggregateInputType = {
    cpu_cooler_catalog_id?: true
    model_name?: true
    type?: true
    thermal_capacity?: true
  }

  export type CpuCoolerCatalogCountAggregateInputType = {
    cpu_cooler_catalog_id?: true
    model_name?: true
    type?: true
    thermal_capacity?: true
    _all?: true
  }

  export type CpuCoolerCatalogAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which CpuCoolerCatalog to aggregate.
     */
    where?: CpuCoolerCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of CpuCoolerCatalogs to fetch.
     */
    orderBy?: CpuCoolerCatalogOrderByWithRelationInput | CpuCoolerCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: CpuCoolerCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` CpuCoolerCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` CpuCoolerCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned CpuCoolerCatalogs
    **/
    _count?: true | CpuCoolerCatalogCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: CpuCoolerCatalogAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: CpuCoolerCatalogSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: CpuCoolerCatalogMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: CpuCoolerCatalogMaxAggregateInputType
  }

  export type GetCpuCoolerCatalogAggregateType<T extends CpuCoolerCatalogAggregateArgs> = {
        [P in keyof T & keyof AggregateCpuCoolerCatalog]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateCpuCoolerCatalog[P]>
      : GetScalarType<T[P], AggregateCpuCoolerCatalog[P]>
  }




  export type CpuCoolerCatalogGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: CpuCoolerCatalogWhereInput
    orderBy?: CpuCoolerCatalogOrderByWithAggregationInput | CpuCoolerCatalogOrderByWithAggregationInput[]
    by: CpuCoolerCatalogScalarFieldEnum[] | CpuCoolerCatalogScalarFieldEnum
    having?: CpuCoolerCatalogScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: CpuCoolerCatalogCountAggregateInputType | true
    _avg?: CpuCoolerCatalogAvgAggregateInputType
    _sum?: CpuCoolerCatalogSumAggregateInputType
    _min?: CpuCoolerCatalogMinAggregateInputType
    _max?: CpuCoolerCatalogMaxAggregateInputType
  }

  export type CpuCoolerCatalogGroupByOutputType = {
    cpu_cooler_catalog_id: number
    model_name: string
    type: string
    thermal_capacity: number
    _count: CpuCoolerCatalogCountAggregateOutputType | null
    _avg: CpuCoolerCatalogAvgAggregateOutputType | null
    _sum: CpuCoolerCatalogSumAggregateOutputType | null
    _min: CpuCoolerCatalogMinAggregateOutputType | null
    _max: CpuCoolerCatalogMaxAggregateOutputType | null
  }

  type GetCpuCoolerCatalogGroupByPayload<T extends CpuCoolerCatalogGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<CpuCoolerCatalogGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof CpuCoolerCatalogGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], CpuCoolerCatalogGroupByOutputType[P]>
            : GetScalarType<T[P], CpuCoolerCatalogGroupByOutputType[P]>
        }
      >
    >


  export type CpuCoolerCatalogSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cpu_cooler_catalog_id?: boolean
    model_name?: boolean
    type?: boolean
    thermal_capacity?: boolean
    cluster_configs?: boolean | CpuCoolerCatalog$cluster_configsArgs<ExtArgs>
    _count?: boolean | CpuCoolerCatalogCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["cpuCoolerCatalog"]>

  export type CpuCoolerCatalogSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cpu_cooler_catalog_id?: boolean
    model_name?: boolean
    type?: boolean
    thermal_capacity?: boolean
  }, ExtArgs["result"]["cpuCoolerCatalog"]>

  export type CpuCoolerCatalogSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cpu_cooler_catalog_id?: boolean
    model_name?: boolean
    type?: boolean
    thermal_capacity?: boolean
  }, ExtArgs["result"]["cpuCoolerCatalog"]>

  export type CpuCoolerCatalogSelectScalar = {
    cpu_cooler_catalog_id?: boolean
    model_name?: boolean
    type?: boolean
    thermal_capacity?: boolean
  }

  export type CpuCoolerCatalogOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"cpu_cooler_catalog_id" | "model_name" | "type" | "thermal_capacity", ExtArgs["result"]["cpuCoolerCatalog"]>
  export type CpuCoolerCatalogInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster_configs?: boolean | CpuCoolerCatalog$cluster_configsArgs<ExtArgs>
    _count?: boolean | CpuCoolerCatalogCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type CpuCoolerCatalogIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}
  export type CpuCoolerCatalogIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {}

  export type $CpuCoolerCatalogPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "CpuCoolerCatalog"
    objects: {
      cluster_configs: Prisma.$ClusterConfigurationPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      cpu_cooler_catalog_id: number
      model_name: string
      type: string
      thermal_capacity: number
    }, ExtArgs["result"]["cpuCoolerCatalog"]>
    composites: {}
  }

  type CpuCoolerCatalogGetPayload<S extends boolean | null | undefined | CpuCoolerCatalogDefaultArgs> = $Result.GetResult<Prisma.$CpuCoolerCatalogPayload, S>

  type CpuCoolerCatalogCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<CpuCoolerCatalogFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: CpuCoolerCatalogCountAggregateInputType | true
    }

  export interface CpuCoolerCatalogDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['CpuCoolerCatalog'], meta: { name: 'CpuCoolerCatalog' } }
    /**
     * Find zero or one CpuCoolerCatalog that matches the filter.
     * @param {CpuCoolerCatalogFindUniqueArgs} args - Arguments to find a CpuCoolerCatalog
     * @example
     * // Get one CpuCoolerCatalog
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends CpuCoolerCatalogFindUniqueArgs>(args: SelectSubset<T, CpuCoolerCatalogFindUniqueArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one CpuCoolerCatalog that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {CpuCoolerCatalogFindUniqueOrThrowArgs} args - Arguments to find a CpuCoolerCatalog
     * @example
     * // Get one CpuCoolerCatalog
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends CpuCoolerCatalogFindUniqueOrThrowArgs>(args: SelectSubset<T, CpuCoolerCatalogFindUniqueOrThrowArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first CpuCoolerCatalog that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {CpuCoolerCatalogFindFirstArgs} args - Arguments to find a CpuCoolerCatalog
     * @example
     * // Get one CpuCoolerCatalog
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends CpuCoolerCatalogFindFirstArgs>(args?: SelectSubset<T, CpuCoolerCatalogFindFirstArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first CpuCoolerCatalog that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {CpuCoolerCatalogFindFirstOrThrowArgs} args - Arguments to find a CpuCoolerCatalog
     * @example
     * // Get one CpuCoolerCatalog
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends CpuCoolerCatalogFindFirstOrThrowArgs>(args?: SelectSubset<T, CpuCoolerCatalogFindFirstOrThrowArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more CpuCoolerCatalogs that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {CpuCoolerCatalogFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all CpuCoolerCatalogs
     * const cpuCoolerCatalogs = await prisma.cpuCoolerCatalog.findMany()
     * 
     * // Get first 10 CpuCoolerCatalogs
     * const cpuCoolerCatalogs = await prisma.cpuCoolerCatalog.findMany({ take: 10 })
     * 
     * // Only select the `cpu_cooler_catalog_id`
     * const cpuCoolerCatalogWithCpu_cooler_catalog_idOnly = await prisma.cpuCoolerCatalog.findMany({ select: { cpu_cooler_catalog_id: true } })
     * 
     */
    findMany<T extends CpuCoolerCatalogFindManyArgs>(args?: SelectSubset<T, CpuCoolerCatalogFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a CpuCoolerCatalog.
     * @param {CpuCoolerCatalogCreateArgs} args - Arguments to create a CpuCoolerCatalog.
     * @example
     * // Create one CpuCoolerCatalog
     * const CpuCoolerCatalog = await prisma.cpuCoolerCatalog.create({
     *   data: {
     *     // ... data to create a CpuCoolerCatalog
     *   }
     * })
     * 
     */
    create<T extends CpuCoolerCatalogCreateArgs>(args: SelectSubset<T, CpuCoolerCatalogCreateArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many CpuCoolerCatalogs.
     * @param {CpuCoolerCatalogCreateManyArgs} args - Arguments to create many CpuCoolerCatalogs.
     * @example
     * // Create many CpuCoolerCatalogs
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends CpuCoolerCatalogCreateManyArgs>(args?: SelectSubset<T, CpuCoolerCatalogCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many CpuCoolerCatalogs and returns the data saved in the database.
     * @param {CpuCoolerCatalogCreateManyAndReturnArgs} args - Arguments to create many CpuCoolerCatalogs.
     * @example
     * // Create many CpuCoolerCatalogs
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many CpuCoolerCatalogs and only return the `cpu_cooler_catalog_id`
     * const cpuCoolerCatalogWithCpu_cooler_catalog_idOnly = await prisma.cpuCoolerCatalog.createManyAndReturn({
     *   select: { cpu_cooler_catalog_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends CpuCoolerCatalogCreateManyAndReturnArgs>(args?: SelectSubset<T, CpuCoolerCatalogCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a CpuCoolerCatalog.
     * @param {CpuCoolerCatalogDeleteArgs} args - Arguments to delete one CpuCoolerCatalog.
     * @example
     * // Delete one CpuCoolerCatalog
     * const CpuCoolerCatalog = await prisma.cpuCoolerCatalog.delete({
     *   where: {
     *     // ... filter to delete one CpuCoolerCatalog
     *   }
     * })
     * 
     */
    delete<T extends CpuCoolerCatalogDeleteArgs>(args: SelectSubset<T, CpuCoolerCatalogDeleteArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one CpuCoolerCatalog.
     * @param {CpuCoolerCatalogUpdateArgs} args - Arguments to update one CpuCoolerCatalog.
     * @example
     * // Update one CpuCoolerCatalog
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends CpuCoolerCatalogUpdateArgs>(args: SelectSubset<T, CpuCoolerCatalogUpdateArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more CpuCoolerCatalogs.
     * @param {CpuCoolerCatalogDeleteManyArgs} args - Arguments to filter CpuCoolerCatalogs to delete.
     * @example
     * // Delete a few CpuCoolerCatalogs
     * const { count } = await prisma.cpuCoolerCatalog.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends CpuCoolerCatalogDeleteManyArgs>(args?: SelectSubset<T, CpuCoolerCatalogDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more CpuCoolerCatalogs.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {CpuCoolerCatalogUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many CpuCoolerCatalogs
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends CpuCoolerCatalogUpdateManyArgs>(args: SelectSubset<T, CpuCoolerCatalogUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more CpuCoolerCatalogs and returns the data updated in the database.
     * @param {CpuCoolerCatalogUpdateManyAndReturnArgs} args - Arguments to update many CpuCoolerCatalogs.
     * @example
     * // Update many CpuCoolerCatalogs
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more CpuCoolerCatalogs and only return the `cpu_cooler_catalog_id`
     * const cpuCoolerCatalogWithCpu_cooler_catalog_idOnly = await prisma.cpuCoolerCatalog.updateManyAndReturn({
     *   select: { cpu_cooler_catalog_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends CpuCoolerCatalogUpdateManyAndReturnArgs>(args: SelectSubset<T, CpuCoolerCatalogUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one CpuCoolerCatalog.
     * @param {CpuCoolerCatalogUpsertArgs} args - Arguments to update or create a CpuCoolerCatalog.
     * @example
     * // Update or create a CpuCoolerCatalog
     * const cpuCoolerCatalog = await prisma.cpuCoolerCatalog.upsert({
     *   create: {
     *     // ... data to create a CpuCoolerCatalog
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the CpuCoolerCatalog we want to update
     *   }
     * })
     */
    upsert<T extends CpuCoolerCatalogUpsertArgs>(args: SelectSubset<T, CpuCoolerCatalogUpsertArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of CpuCoolerCatalogs.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {CpuCoolerCatalogCountArgs} args - Arguments to filter CpuCoolerCatalogs to count.
     * @example
     * // Count the number of CpuCoolerCatalogs
     * const count = await prisma.cpuCoolerCatalog.count({
     *   where: {
     *     // ... the filter for the CpuCoolerCatalogs we want to count
     *   }
     * })
    **/
    count<T extends CpuCoolerCatalogCountArgs>(
      args?: Subset<T, CpuCoolerCatalogCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], CpuCoolerCatalogCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a CpuCoolerCatalog.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {CpuCoolerCatalogAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends CpuCoolerCatalogAggregateArgs>(args: Subset<T, CpuCoolerCatalogAggregateArgs>): Prisma.PrismaPromise<GetCpuCoolerCatalogAggregateType<T>>

    /**
     * Group by CpuCoolerCatalog.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {CpuCoolerCatalogGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends CpuCoolerCatalogGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: CpuCoolerCatalogGroupByArgs['orderBy'] }
        : { orderBy?: CpuCoolerCatalogGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, CpuCoolerCatalogGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetCpuCoolerCatalogGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the CpuCoolerCatalog model
   */
  readonly fields: CpuCoolerCatalogFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for CpuCoolerCatalog.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__CpuCoolerCatalogClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    cluster_configs<T extends CpuCoolerCatalog$cluster_configsArgs<ExtArgs> = {}>(args?: Subset<T, CpuCoolerCatalog$cluster_configsArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the CpuCoolerCatalog model
   */
  interface CpuCoolerCatalogFieldRefs {
    readonly cpu_cooler_catalog_id: FieldRef<"CpuCoolerCatalog", 'Int'>
    readonly model_name: FieldRef<"CpuCoolerCatalog", 'String'>
    readonly type: FieldRef<"CpuCoolerCatalog", 'String'>
    readonly thermal_capacity: FieldRef<"CpuCoolerCatalog", 'Int'>
  }
    

  // Custom InputTypes
  /**
   * CpuCoolerCatalog findUnique
   */
  export type CpuCoolerCatalogFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * Filter, which CpuCoolerCatalog to fetch.
     */
    where: CpuCoolerCatalogWhereUniqueInput
  }

  /**
   * CpuCoolerCatalog findUniqueOrThrow
   */
  export type CpuCoolerCatalogFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * Filter, which CpuCoolerCatalog to fetch.
     */
    where: CpuCoolerCatalogWhereUniqueInput
  }

  /**
   * CpuCoolerCatalog findFirst
   */
  export type CpuCoolerCatalogFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * Filter, which CpuCoolerCatalog to fetch.
     */
    where?: CpuCoolerCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of CpuCoolerCatalogs to fetch.
     */
    orderBy?: CpuCoolerCatalogOrderByWithRelationInput | CpuCoolerCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for CpuCoolerCatalogs.
     */
    cursor?: CpuCoolerCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` CpuCoolerCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` CpuCoolerCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of CpuCoolerCatalogs.
     */
    distinct?: CpuCoolerCatalogScalarFieldEnum | CpuCoolerCatalogScalarFieldEnum[]
  }

  /**
   * CpuCoolerCatalog findFirstOrThrow
   */
  export type CpuCoolerCatalogFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * Filter, which CpuCoolerCatalog to fetch.
     */
    where?: CpuCoolerCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of CpuCoolerCatalogs to fetch.
     */
    orderBy?: CpuCoolerCatalogOrderByWithRelationInput | CpuCoolerCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for CpuCoolerCatalogs.
     */
    cursor?: CpuCoolerCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` CpuCoolerCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` CpuCoolerCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of CpuCoolerCatalogs.
     */
    distinct?: CpuCoolerCatalogScalarFieldEnum | CpuCoolerCatalogScalarFieldEnum[]
  }

  /**
   * CpuCoolerCatalog findMany
   */
  export type CpuCoolerCatalogFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * Filter, which CpuCoolerCatalogs to fetch.
     */
    where?: CpuCoolerCatalogWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of CpuCoolerCatalogs to fetch.
     */
    orderBy?: CpuCoolerCatalogOrderByWithRelationInput | CpuCoolerCatalogOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing CpuCoolerCatalogs.
     */
    cursor?: CpuCoolerCatalogWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` CpuCoolerCatalogs from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` CpuCoolerCatalogs.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of CpuCoolerCatalogs.
     */
    distinct?: CpuCoolerCatalogScalarFieldEnum | CpuCoolerCatalogScalarFieldEnum[]
  }

  /**
   * CpuCoolerCatalog create
   */
  export type CpuCoolerCatalogCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * The data needed to create a CpuCoolerCatalog.
     */
    data: XOR<CpuCoolerCatalogCreateInput, CpuCoolerCatalogUncheckedCreateInput>
  }

  /**
   * CpuCoolerCatalog createMany
   */
  export type CpuCoolerCatalogCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many CpuCoolerCatalogs.
     */
    data: CpuCoolerCatalogCreateManyInput | CpuCoolerCatalogCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * CpuCoolerCatalog createManyAndReturn
   */
  export type CpuCoolerCatalogCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * The data used to create many CpuCoolerCatalogs.
     */
    data: CpuCoolerCatalogCreateManyInput | CpuCoolerCatalogCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * CpuCoolerCatalog update
   */
  export type CpuCoolerCatalogUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * The data needed to update a CpuCoolerCatalog.
     */
    data: XOR<CpuCoolerCatalogUpdateInput, CpuCoolerCatalogUncheckedUpdateInput>
    /**
     * Choose, which CpuCoolerCatalog to update.
     */
    where: CpuCoolerCatalogWhereUniqueInput
  }

  /**
   * CpuCoolerCatalog updateMany
   */
  export type CpuCoolerCatalogUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update CpuCoolerCatalogs.
     */
    data: XOR<CpuCoolerCatalogUpdateManyMutationInput, CpuCoolerCatalogUncheckedUpdateManyInput>
    /**
     * Filter which CpuCoolerCatalogs to update
     */
    where?: CpuCoolerCatalogWhereInput
    /**
     * Limit how many CpuCoolerCatalogs to update.
     */
    limit?: number
  }

  /**
   * CpuCoolerCatalog updateManyAndReturn
   */
  export type CpuCoolerCatalogUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * The data used to update CpuCoolerCatalogs.
     */
    data: XOR<CpuCoolerCatalogUpdateManyMutationInput, CpuCoolerCatalogUncheckedUpdateManyInput>
    /**
     * Filter which CpuCoolerCatalogs to update
     */
    where?: CpuCoolerCatalogWhereInput
    /**
     * Limit how many CpuCoolerCatalogs to update.
     */
    limit?: number
  }

  /**
   * CpuCoolerCatalog upsert
   */
  export type CpuCoolerCatalogUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * The filter to search for the CpuCoolerCatalog to update in case it exists.
     */
    where: CpuCoolerCatalogWhereUniqueInput
    /**
     * In case the CpuCoolerCatalog found by the `where` argument doesn't exist, create a new CpuCoolerCatalog with this data.
     */
    create: XOR<CpuCoolerCatalogCreateInput, CpuCoolerCatalogUncheckedCreateInput>
    /**
     * In case the CpuCoolerCatalog was found with the provided `where` argument, update it with this data.
     */
    update: XOR<CpuCoolerCatalogUpdateInput, CpuCoolerCatalogUncheckedUpdateInput>
  }

  /**
   * CpuCoolerCatalog delete
   */
  export type CpuCoolerCatalogDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
    /**
     * Filter which CpuCoolerCatalog to delete.
     */
    where: CpuCoolerCatalogWhereUniqueInput
  }

  /**
   * CpuCoolerCatalog deleteMany
   */
  export type CpuCoolerCatalogDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which CpuCoolerCatalogs to delete
     */
    where?: CpuCoolerCatalogWhereInput
    /**
     * Limit how many CpuCoolerCatalogs to delete.
     */
    limit?: number
  }

  /**
   * CpuCoolerCatalog.cluster_configs
   */
  export type CpuCoolerCatalog$cluster_configsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    where?: ClusterConfigurationWhereInput
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    cursor?: ClusterConfigurationWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * CpuCoolerCatalog without action
   */
  export type CpuCoolerCatalogDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the CpuCoolerCatalog
     */
    select?: CpuCoolerCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the CpuCoolerCatalog
     */
    omit?: CpuCoolerCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: CpuCoolerCatalogInclude<ExtArgs> | null
  }


  /**
   * Model ClusterConfiguration
   */

  export type AggregateClusterConfiguration = {
    _count: ClusterConfigurationCountAggregateOutputType | null
    _avg: ClusterConfigurationAvgAggregateOutputType | null
    _sum: ClusterConfigurationSumAggregateOutputType | null
    _min: ClusterConfigurationMinAggregateOutputType | null
    _max: ClusterConfigurationMaxAggregateOutputType | null
  }

  export type ClusterConfigurationAvgAggregateOutputType = {
    cluster_config_id: number | null
    master: number | null
    worker: number | null
    consomation_per_master: number | null
    consomation_per_worker: number | null
    pue: number | null
    location_id: number | null
    fan_id: number | null
    fan_count: number | null
    cpu_cooler_catalog_id: number | null
    fan_catalog_id: number | null
    load_profile_id: number | null
  }

  export type ClusterConfigurationSumAggregateOutputType = {
    cluster_config_id: number | null
    master: number | null
    worker: number | null
    consomation_per_master: number | null
    consomation_per_worker: number | null
    pue: number | null
    location_id: number | null
    fan_id: number | null
    fan_count: number | null
    cpu_cooler_catalog_id: number | null
    fan_catalog_id: number | null
    load_profile_id: number | null
  }

  export type ClusterConfigurationMinAggregateOutputType = {
    cluster_config_id: number | null
    name: string | null
    master: number | null
    worker: number | null
    consomation_per_master: number | null
    consomation_per_worker: number | null
    hardware_per_master: string | null
    hardware_per_worker: string | null
    pue: number | null
    location_id: number | null
    fan_id: number | null
    fan_count: number | null
    cpu_cooler_catalog_id: number | null
    fan_catalog_id: number | null
    load_profile_id: number | null
  }

  export type ClusterConfigurationMaxAggregateOutputType = {
    cluster_config_id: number | null
    name: string | null
    master: number | null
    worker: number | null
    consomation_per_master: number | null
    consomation_per_worker: number | null
    hardware_per_master: string | null
    hardware_per_worker: string | null
    pue: number | null
    location_id: number | null
    fan_id: number | null
    fan_count: number | null
    cpu_cooler_catalog_id: number | null
    fan_catalog_id: number | null
    load_profile_id: number | null
  }

  export type ClusterConfigurationCountAggregateOutputType = {
    cluster_config_id: number
    name: number
    master: number
    worker: number
    consomation_per_master: number
    consomation_per_worker: number
    hardware_per_master: number
    hardware_per_worker: number
    pue: number
    location_id: number
    fan_id: number
    fan_count: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id: number
    _all: number
  }


  export type ClusterConfigurationAvgAggregateInputType = {
    cluster_config_id?: true
    master?: true
    worker?: true
    consomation_per_master?: true
    consomation_per_worker?: true
    pue?: true
    location_id?: true
    fan_id?: true
    fan_count?: true
    cpu_cooler_catalog_id?: true
    fan_catalog_id?: true
    load_profile_id?: true
  }

  export type ClusterConfigurationSumAggregateInputType = {
    cluster_config_id?: true
    master?: true
    worker?: true
    consomation_per_master?: true
    consomation_per_worker?: true
    pue?: true
    location_id?: true
    fan_id?: true
    fan_count?: true
    cpu_cooler_catalog_id?: true
    fan_catalog_id?: true
    load_profile_id?: true
  }

  export type ClusterConfigurationMinAggregateInputType = {
    cluster_config_id?: true
    name?: true
    master?: true
    worker?: true
    consomation_per_master?: true
    consomation_per_worker?: true
    hardware_per_master?: true
    hardware_per_worker?: true
    pue?: true
    location_id?: true
    fan_id?: true
    fan_count?: true
    cpu_cooler_catalog_id?: true
    fan_catalog_id?: true
    load_profile_id?: true
  }

  export type ClusterConfigurationMaxAggregateInputType = {
    cluster_config_id?: true
    name?: true
    master?: true
    worker?: true
    consomation_per_master?: true
    consomation_per_worker?: true
    hardware_per_master?: true
    hardware_per_worker?: true
    pue?: true
    location_id?: true
    fan_id?: true
    fan_count?: true
    cpu_cooler_catalog_id?: true
    fan_catalog_id?: true
    load_profile_id?: true
  }

  export type ClusterConfigurationCountAggregateInputType = {
    cluster_config_id?: true
    name?: true
    master?: true
    worker?: true
    consomation_per_master?: true
    consomation_per_worker?: true
    hardware_per_master?: true
    hardware_per_worker?: true
    pue?: true
    location_id?: true
    fan_id?: true
    fan_count?: true
    cpu_cooler_catalog_id?: true
    fan_catalog_id?: true
    load_profile_id?: true
    _all?: true
  }

  export type ClusterConfigurationAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which ClusterConfiguration to aggregate.
     */
    where?: ClusterConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterConfigurations to fetch.
     */
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: ClusterConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned ClusterConfigurations
    **/
    _count?: true | ClusterConfigurationCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: ClusterConfigurationAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: ClusterConfigurationSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: ClusterConfigurationMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: ClusterConfigurationMaxAggregateInputType
  }

  export type GetClusterConfigurationAggregateType<T extends ClusterConfigurationAggregateArgs> = {
        [P in keyof T & keyof AggregateClusterConfiguration]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateClusterConfiguration[P]>
      : GetScalarType<T[P], AggregateClusterConfiguration[P]>
  }




  export type ClusterConfigurationGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterConfigurationWhereInput
    orderBy?: ClusterConfigurationOrderByWithAggregationInput | ClusterConfigurationOrderByWithAggregationInput[]
    by: ClusterConfigurationScalarFieldEnum[] | ClusterConfigurationScalarFieldEnum
    having?: ClusterConfigurationScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: ClusterConfigurationCountAggregateInputType | true
    _avg?: ClusterConfigurationAvgAggregateInputType
    _sum?: ClusterConfigurationSumAggregateInputType
    _min?: ClusterConfigurationMinAggregateInputType
    _max?: ClusterConfigurationMaxAggregateInputType
  }

  export type ClusterConfigurationGroupByOutputType = {
    cluster_config_id: number
    name: string
    master: number
    worker: number
    consomation_per_master: number | null
    consomation_per_worker: number | null
    hardware_per_master: string | null
    hardware_per_worker: string | null
    pue: number | null
    location_id: number | null
    fan_id: number | null
    fan_count: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id: number | null
    _count: ClusterConfigurationCountAggregateOutputType | null
    _avg: ClusterConfigurationAvgAggregateOutputType | null
    _sum: ClusterConfigurationSumAggregateOutputType | null
    _min: ClusterConfigurationMinAggregateOutputType | null
    _max: ClusterConfigurationMaxAggregateOutputType | null
  }

  type GetClusterConfigurationGroupByPayload<T extends ClusterConfigurationGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<ClusterConfigurationGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof ClusterConfigurationGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], ClusterConfigurationGroupByOutputType[P]>
            : GetScalarType<T[P], ClusterConfigurationGroupByOutputType[P]>
        }
      >
    >


  export type ClusterConfigurationSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cluster_config_id?: boolean
    name?: boolean
    master?: boolean
    worker?: boolean
    consomation_per_master?: boolean
    consomation_per_worker?: boolean
    hardware_per_master?: boolean
    hardware_per_worker?: boolean
    pue?: boolean
    location_id?: boolean
    fan_id?: boolean
    fan_count?: boolean
    cpu_cooler_catalog_id?: boolean
    fan_catalog_id?: boolean
    load_profile_id?: boolean
    load_profile?: boolean | ClusterConfiguration$load_profileArgs<ExtArgs>
    cooler_model?: boolean | CpuCoolerCatalogDefaultArgs<ExtArgs>
    fan_model?: boolean | ClusterConfiguration$fan_modelArgs<ExtArgs>
    location?: boolean | ClusterConfiguration$locationArgs<ExtArgs>
    fan_config?: boolean | ClusterConfiguration$fan_configArgs<ExtArgs>
    servers?: boolean | ClusterConfiguration$serversArgs<ExtArgs>
    _count?: boolean | ClusterConfigurationCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["clusterConfiguration"]>

  export type ClusterConfigurationSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cluster_config_id?: boolean
    name?: boolean
    master?: boolean
    worker?: boolean
    consomation_per_master?: boolean
    consomation_per_worker?: boolean
    hardware_per_master?: boolean
    hardware_per_worker?: boolean
    pue?: boolean
    location_id?: boolean
    fan_id?: boolean
    fan_count?: boolean
    cpu_cooler_catalog_id?: boolean
    fan_catalog_id?: boolean
    load_profile_id?: boolean
    load_profile?: boolean | ClusterConfiguration$load_profileArgs<ExtArgs>
    cooler_model?: boolean | CpuCoolerCatalogDefaultArgs<ExtArgs>
    fan_model?: boolean | ClusterConfiguration$fan_modelArgs<ExtArgs>
    location?: boolean | ClusterConfiguration$locationArgs<ExtArgs>
    fan_config?: boolean | ClusterConfiguration$fan_configArgs<ExtArgs>
  }, ExtArgs["result"]["clusterConfiguration"]>

  export type ClusterConfigurationSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cluster_config_id?: boolean
    name?: boolean
    master?: boolean
    worker?: boolean
    consomation_per_master?: boolean
    consomation_per_worker?: boolean
    hardware_per_master?: boolean
    hardware_per_worker?: boolean
    pue?: boolean
    location_id?: boolean
    fan_id?: boolean
    fan_count?: boolean
    cpu_cooler_catalog_id?: boolean
    fan_catalog_id?: boolean
    load_profile_id?: boolean
    load_profile?: boolean | ClusterConfiguration$load_profileArgs<ExtArgs>
    cooler_model?: boolean | CpuCoolerCatalogDefaultArgs<ExtArgs>
    fan_model?: boolean | ClusterConfiguration$fan_modelArgs<ExtArgs>
    location?: boolean | ClusterConfiguration$locationArgs<ExtArgs>
    fan_config?: boolean | ClusterConfiguration$fan_configArgs<ExtArgs>
  }, ExtArgs["result"]["clusterConfiguration"]>

  export type ClusterConfigurationSelectScalar = {
    cluster_config_id?: boolean
    name?: boolean
    master?: boolean
    worker?: boolean
    consomation_per_master?: boolean
    consomation_per_worker?: boolean
    hardware_per_master?: boolean
    hardware_per_worker?: boolean
    pue?: boolean
    location_id?: boolean
    fan_id?: boolean
    fan_count?: boolean
    cpu_cooler_catalog_id?: boolean
    fan_catalog_id?: boolean
    load_profile_id?: boolean
  }

  export type ClusterConfigurationOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"cluster_config_id" | "name" | "master" | "worker" | "consomation_per_master" | "consomation_per_worker" | "hardware_per_master" | "hardware_per_worker" | "pue" | "location_id" | "fan_id" | "fan_count" | "cpu_cooler_catalog_id" | "fan_catalog_id" | "load_profile_id", ExtArgs["result"]["clusterConfiguration"]>
  export type ClusterConfigurationInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    load_profile?: boolean | ClusterConfiguration$load_profileArgs<ExtArgs>
    cooler_model?: boolean | CpuCoolerCatalogDefaultArgs<ExtArgs>
    fan_model?: boolean | ClusterConfiguration$fan_modelArgs<ExtArgs>
    location?: boolean | ClusterConfiguration$locationArgs<ExtArgs>
    fan_config?: boolean | ClusterConfiguration$fan_configArgs<ExtArgs>
    servers?: boolean | ClusterConfiguration$serversArgs<ExtArgs>
    _count?: boolean | ClusterConfigurationCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type ClusterConfigurationIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    load_profile?: boolean | ClusterConfiguration$load_profileArgs<ExtArgs>
    cooler_model?: boolean | CpuCoolerCatalogDefaultArgs<ExtArgs>
    fan_model?: boolean | ClusterConfiguration$fan_modelArgs<ExtArgs>
    location?: boolean | ClusterConfiguration$locationArgs<ExtArgs>
    fan_config?: boolean | ClusterConfiguration$fan_configArgs<ExtArgs>
  }
  export type ClusterConfigurationIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    load_profile?: boolean | ClusterConfiguration$load_profileArgs<ExtArgs>
    cooler_model?: boolean | CpuCoolerCatalogDefaultArgs<ExtArgs>
    fan_model?: boolean | ClusterConfiguration$fan_modelArgs<ExtArgs>
    location?: boolean | ClusterConfiguration$locationArgs<ExtArgs>
    fan_config?: boolean | ClusterConfiguration$fan_configArgs<ExtArgs>
  }

  export type $ClusterConfigurationPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "ClusterConfiguration"
    objects: {
      load_profile: Prisma.$LoadProfilePayload<ExtArgs> | null
      cooler_model: Prisma.$CpuCoolerCatalogPayload<ExtArgs>
      fan_model: Prisma.$FanCatalogPayload<ExtArgs> | null
      location: Prisma.$ClusterLocationPayload<ExtArgs> | null
      fan_config: Prisma.$FanConfigurationPayload<ExtArgs> | null
      servers: Prisma.$ServerPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      cluster_config_id: number
      name: string
      master: number
      worker: number
      consomation_per_master: number | null
      consomation_per_worker: number | null
      hardware_per_master: string | null
      hardware_per_worker: string | null
      pue: number | null
      location_id: number | null
      fan_id: number | null
      fan_count: number
      cpu_cooler_catalog_id: number
      fan_catalog_id: number
      load_profile_id: number | null
    }, ExtArgs["result"]["clusterConfiguration"]>
    composites: {}
  }

  type ClusterConfigurationGetPayload<S extends boolean | null | undefined | ClusterConfigurationDefaultArgs> = $Result.GetResult<Prisma.$ClusterConfigurationPayload, S>

  type ClusterConfigurationCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<ClusterConfigurationFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: ClusterConfigurationCountAggregateInputType | true
    }

  export interface ClusterConfigurationDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['ClusterConfiguration'], meta: { name: 'ClusterConfiguration' } }
    /**
     * Find zero or one ClusterConfiguration that matches the filter.
     * @param {ClusterConfigurationFindUniqueArgs} args - Arguments to find a ClusterConfiguration
     * @example
     * // Get one ClusterConfiguration
     * const clusterConfiguration = await prisma.clusterConfiguration.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends ClusterConfigurationFindUniqueArgs>(args: SelectSubset<T, ClusterConfigurationFindUniqueArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one ClusterConfiguration that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {ClusterConfigurationFindUniqueOrThrowArgs} args - Arguments to find a ClusterConfiguration
     * @example
     * // Get one ClusterConfiguration
     * const clusterConfiguration = await prisma.clusterConfiguration.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends ClusterConfigurationFindUniqueOrThrowArgs>(args: SelectSubset<T, ClusterConfigurationFindUniqueOrThrowArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first ClusterConfiguration that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterConfigurationFindFirstArgs} args - Arguments to find a ClusterConfiguration
     * @example
     * // Get one ClusterConfiguration
     * const clusterConfiguration = await prisma.clusterConfiguration.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends ClusterConfigurationFindFirstArgs>(args?: SelectSubset<T, ClusterConfigurationFindFirstArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first ClusterConfiguration that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterConfigurationFindFirstOrThrowArgs} args - Arguments to find a ClusterConfiguration
     * @example
     * // Get one ClusterConfiguration
     * const clusterConfiguration = await prisma.clusterConfiguration.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends ClusterConfigurationFindFirstOrThrowArgs>(args?: SelectSubset<T, ClusterConfigurationFindFirstOrThrowArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more ClusterConfigurations that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterConfigurationFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all ClusterConfigurations
     * const clusterConfigurations = await prisma.clusterConfiguration.findMany()
     * 
     * // Get first 10 ClusterConfigurations
     * const clusterConfigurations = await prisma.clusterConfiguration.findMany({ take: 10 })
     * 
     * // Only select the `cluster_config_id`
     * const clusterConfigurationWithCluster_config_idOnly = await prisma.clusterConfiguration.findMany({ select: { cluster_config_id: true } })
     * 
     */
    findMany<T extends ClusterConfigurationFindManyArgs>(args?: SelectSubset<T, ClusterConfigurationFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a ClusterConfiguration.
     * @param {ClusterConfigurationCreateArgs} args - Arguments to create a ClusterConfiguration.
     * @example
     * // Create one ClusterConfiguration
     * const ClusterConfiguration = await prisma.clusterConfiguration.create({
     *   data: {
     *     // ... data to create a ClusterConfiguration
     *   }
     * })
     * 
     */
    create<T extends ClusterConfigurationCreateArgs>(args: SelectSubset<T, ClusterConfigurationCreateArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many ClusterConfigurations.
     * @param {ClusterConfigurationCreateManyArgs} args - Arguments to create many ClusterConfigurations.
     * @example
     * // Create many ClusterConfigurations
     * const clusterConfiguration = await prisma.clusterConfiguration.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends ClusterConfigurationCreateManyArgs>(args?: SelectSubset<T, ClusterConfigurationCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many ClusterConfigurations and returns the data saved in the database.
     * @param {ClusterConfigurationCreateManyAndReturnArgs} args - Arguments to create many ClusterConfigurations.
     * @example
     * // Create many ClusterConfigurations
     * const clusterConfiguration = await prisma.clusterConfiguration.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many ClusterConfigurations and only return the `cluster_config_id`
     * const clusterConfigurationWithCluster_config_idOnly = await prisma.clusterConfiguration.createManyAndReturn({
     *   select: { cluster_config_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends ClusterConfigurationCreateManyAndReturnArgs>(args?: SelectSubset<T, ClusterConfigurationCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a ClusterConfiguration.
     * @param {ClusterConfigurationDeleteArgs} args - Arguments to delete one ClusterConfiguration.
     * @example
     * // Delete one ClusterConfiguration
     * const ClusterConfiguration = await prisma.clusterConfiguration.delete({
     *   where: {
     *     // ... filter to delete one ClusterConfiguration
     *   }
     * })
     * 
     */
    delete<T extends ClusterConfigurationDeleteArgs>(args: SelectSubset<T, ClusterConfigurationDeleteArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one ClusterConfiguration.
     * @param {ClusterConfigurationUpdateArgs} args - Arguments to update one ClusterConfiguration.
     * @example
     * // Update one ClusterConfiguration
     * const clusterConfiguration = await prisma.clusterConfiguration.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends ClusterConfigurationUpdateArgs>(args: SelectSubset<T, ClusterConfigurationUpdateArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more ClusterConfigurations.
     * @param {ClusterConfigurationDeleteManyArgs} args - Arguments to filter ClusterConfigurations to delete.
     * @example
     * // Delete a few ClusterConfigurations
     * const { count } = await prisma.clusterConfiguration.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends ClusterConfigurationDeleteManyArgs>(args?: SelectSubset<T, ClusterConfigurationDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more ClusterConfigurations.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterConfigurationUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many ClusterConfigurations
     * const clusterConfiguration = await prisma.clusterConfiguration.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends ClusterConfigurationUpdateManyArgs>(args: SelectSubset<T, ClusterConfigurationUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more ClusterConfigurations and returns the data updated in the database.
     * @param {ClusterConfigurationUpdateManyAndReturnArgs} args - Arguments to update many ClusterConfigurations.
     * @example
     * // Update many ClusterConfigurations
     * const clusterConfiguration = await prisma.clusterConfiguration.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more ClusterConfigurations and only return the `cluster_config_id`
     * const clusterConfigurationWithCluster_config_idOnly = await prisma.clusterConfiguration.updateManyAndReturn({
     *   select: { cluster_config_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends ClusterConfigurationUpdateManyAndReturnArgs>(args: SelectSubset<T, ClusterConfigurationUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one ClusterConfiguration.
     * @param {ClusterConfigurationUpsertArgs} args - Arguments to update or create a ClusterConfiguration.
     * @example
     * // Update or create a ClusterConfiguration
     * const clusterConfiguration = await prisma.clusterConfiguration.upsert({
     *   create: {
     *     // ... data to create a ClusterConfiguration
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the ClusterConfiguration we want to update
     *   }
     * })
     */
    upsert<T extends ClusterConfigurationUpsertArgs>(args: SelectSubset<T, ClusterConfigurationUpsertArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of ClusterConfigurations.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterConfigurationCountArgs} args - Arguments to filter ClusterConfigurations to count.
     * @example
     * // Count the number of ClusterConfigurations
     * const count = await prisma.clusterConfiguration.count({
     *   where: {
     *     // ... the filter for the ClusterConfigurations we want to count
     *   }
     * })
    **/
    count<T extends ClusterConfigurationCountArgs>(
      args?: Subset<T, ClusterConfigurationCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], ClusterConfigurationCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a ClusterConfiguration.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterConfigurationAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends ClusterConfigurationAggregateArgs>(args: Subset<T, ClusterConfigurationAggregateArgs>): Prisma.PrismaPromise<GetClusterConfigurationAggregateType<T>>

    /**
     * Group by ClusterConfiguration.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterConfigurationGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends ClusterConfigurationGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: ClusterConfigurationGroupByArgs['orderBy'] }
        : { orderBy?: ClusterConfigurationGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, ClusterConfigurationGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetClusterConfigurationGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the ClusterConfiguration model
   */
  readonly fields: ClusterConfigurationFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for ClusterConfiguration.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__ClusterConfigurationClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    load_profile<T extends ClusterConfiguration$load_profileArgs<ExtArgs> = {}>(args?: Subset<T, ClusterConfiguration$load_profileArgs<ExtArgs>>): Prisma__LoadProfileClient<$Result.GetResult<Prisma.$LoadProfilePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>
    cooler_model<T extends CpuCoolerCatalogDefaultArgs<ExtArgs> = {}>(args?: Subset<T, CpuCoolerCatalogDefaultArgs<ExtArgs>>): Prisma__CpuCoolerCatalogClient<$Result.GetResult<Prisma.$CpuCoolerCatalogPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>
    fan_model<T extends ClusterConfiguration$fan_modelArgs<ExtArgs> = {}>(args?: Subset<T, ClusterConfiguration$fan_modelArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>
    location<T extends ClusterConfiguration$locationArgs<ExtArgs> = {}>(args?: Subset<T, ClusterConfiguration$locationArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>
    fan_config<T extends ClusterConfiguration$fan_configArgs<ExtArgs> = {}>(args?: Subset<T, ClusterConfiguration$fan_configArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>
    servers<T extends ClusterConfiguration$serversArgs<ExtArgs> = {}>(args?: Subset<T, ClusterConfiguration$serversArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the ClusterConfiguration model
   */
  interface ClusterConfigurationFieldRefs {
    readonly cluster_config_id: FieldRef<"ClusterConfiguration", 'Int'>
    readonly name: FieldRef<"ClusterConfiguration", 'String'>
    readonly master: FieldRef<"ClusterConfiguration", 'Int'>
    readonly worker: FieldRef<"ClusterConfiguration", 'Int'>
    readonly consomation_per_master: FieldRef<"ClusterConfiguration", 'Float'>
    readonly consomation_per_worker: FieldRef<"ClusterConfiguration", 'Float'>
    readonly hardware_per_master: FieldRef<"ClusterConfiguration", 'String'>
    readonly hardware_per_worker: FieldRef<"ClusterConfiguration", 'String'>
    readonly pue: FieldRef<"ClusterConfiguration", 'Float'>
    readonly location_id: FieldRef<"ClusterConfiguration", 'Int'>
    readonly fan_id: FieldRef<"ClusterConfiguration", 'Int'>
    readonly fan_count: FieldRef<"ClusterConfiguration", 'Int'>
    readonly cpu_cooler_catalog_id: FieldRef<"ClusterConfiguration", 'Int'>
    readonly fan_catalog_id: FieldRef<"ClusterConfiguration", 'Int'>
    readonly load_profile_id: FieldRef<"ClusterConfiguration", 'Int'>
  }
    

  // Custom InputTypes
  /**
   * ClusterConfiguration findUnique
   */
  export type ClusterConfigurationFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterConfiguration to fetch.
     */
    where: ClusterConfigurationWhereUniqueInput
  }

  /**
   * ClusterConfiguration findUniqueOrThrow
   */
  export type ClusterConfigurationFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterConfiguration to fetch.
     */
    where: ClusterConfigurationWhereUniqueInput
  }

  /**
   * ClusterConfiguration findFirst
   */
  export type ClusterConfigurationFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterConfiguration to fetch.
     */
    where?: ClusterConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterConfigurations to fetch.
     */
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for ClusterConfigurations.
     */
    cursor?: ClusterConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of ClusterConfigurations.
     */
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * ClusterConfiguration findFirstOrThrow
   */
  export type ClusterConfigurationFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterConfiguration to fetch.
     */
    where?: ClusterConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterConfigurations to fetch.
     */
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for ClusterConfigurations.
     */
    cursor?: ClusterConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of ClusterConfigurations.
     */
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * ClusterConfiguration findMany
   */
  export type ClusterConfigurationFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * Filter, which ClusterConfigurations to fetch.
     */
    where?: ClusterConfigurationWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of ClusterConfigurations to fetch.
     */
    orderBy?: ClusterConfigurationOrderByWithRelationInput | ClusterConfigurationOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing ClusterConfigurations.
     */
    cursor?: ClusterConfigurationWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` ClusterConfigurations from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` ClusterConfigurations.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of ClusterConfigurations.
     */
    distinct?: ClusterConfigurationScalarFieldEnum | ClusterConfigurationScalarFieldEnum[]
  }

  /**
   * ClusterConfiguration create
   */
  export type ClusterConfigurationCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * The data needed to create a ClusterConfiguration.
     */
    data: XOR<ClusterConfigurationCreateInput, ClusterConfigurationUncheckedCreateInput>
  }

  /**
   * ClusterConfiguration createMany
   */
  export type ClusterConfigurationCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many ClusterConfigurations.
     */
    data: ClusterConfigurationCreateManyInput | ClusterConfigurationCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * ClusterConfiguration createManyAndReturn
   */
  export type ClusterConfigurationCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * The data used to create many ClusterConfigurations.
     */
    data: ClusterConfigurationCreateManyInput | ClusterConfigurationCreateManyInput[]
    skipDuplicates?: boolean
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationIncludeCreateManyAndReturn<ExtArgs> | null
  }

  /**
   * ClusterConfiguration update
   */
  export type ClusterConfigurationUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * The data needed to update a ClusterConfiguration.
     */
    data: XOR<ClusterConfigurationUpdateInput, ClusterConfigurationUncheckedUpdateInput>
    /**
     * Choose, which ClusterConfiguration to update.
     */
    where: ClusterConfigurationWhereUniqueInput
  }

  /**
   * ClusterConfiguration updateMany
   */
  export type ClusterConfigurationUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update ClusterConfigurations.
     */
    data: XOR<ClusterConfigurationUpdateManyMutationInput, ClusterConfigurationUncheckedUpdateManyInput>
    /**
     * Filter which ClusterConfigurations to update
     */
    where?: ClusterConfigurationWhereInput
    /**
     * Limit how many ClusterConfigurations to update.
     */
    limit?: number
  }

  /**
   * ClusterConfiguration updateManyAndReturn
   */
  export type ClusterConfigurationUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * The data used to update ClusterConfigurations.
     */
    data: XOR<ClusterConfigurationUpdateManyMutationInput, ClusterConfigurationUncheckedUpdateManyInput>
    /**
     * Filter which ClusterConfigurations to update
     */
    where?: ClusterConfigurationWhereInput
    /**
     * Limit how many ClusterConfigurations to update.
     */
    limit?: number
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationIncludeUpdateManyAndReturn<ExtArgs> | null
  }

  /**
   * ClusterConfiguration upsert
   */
  export type ClusterConfigurationUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * The filter to search for the ClusterConfiguration to update in case it exists.
     */
    where: ClusterConfigurationWhereUniqueInput
    /**
     * In case the ClusterConfiguration found by the `where` argument doesn't exist, create a new ClusterConfiguration with this data.
     */
    create: XOR<ClusterConfigurationCreateInput, ClusterConfigurationUncheckedCreateInput>
    /**
     * In case the ClusterConfiguration was found with the provided `where` argument, update it with this data.
     */
    update: XOR<ClusterConfigurationUpdateInput, ClusterConfigurationUncheckedUpdateInput>
  }

  /**
   * ClusterConfiguration delete
   */
  export type ClusterConfigurationDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    /**
     * Filter which ClusterConfiguration to delete.
     */
    where: ClusterConfigurationWhereUniqueInput
  }

  /**
   * ClusterConfiguration deleteMany
   */
  export type ClusterConfigurationDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which ClusterConfigurations to delete
     */
    where?: ClusterConfigurationWhereInput
    /**
     * Limit how many ClusterConfigurations to delete.
     */
    limit?: number
  }

  /**
   * ClusterConfiguration.load_profile
   */
  export type ClusterConfiguration$load_profileArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the LoadProfile
     */
    select?: LoadProfileSelect<ExtArgs> | null
    /**
     * Omit specific fields from the LoadProfile
     */
    omit?: LoadProfileOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: LoadProfileInclude<ExtArgs> | null
    where?: LoadProfileWhereInput
  }

  /**
   * ClusterConfiguration.fan_model
   */
  export type ClusterConfiguration$fan_modelArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    where?: FanCatalogWhereInput
  }

  /**
   * ClusterConfiguration.location
   */
  export type ClusterConfiguration$locationArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterLocation
     */
    select?: ClusterLocationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterLocation
     */
    omit?: ClusterLocationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterLocationInclude<ExtArgs> | null
    where?: ClusterLocationWhereInput
  }

  /**
   * ClusterConfiguration.fan_config
   */
  export type ClusterConfiguration$fan_configArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    where?: FanConfigurationWhereInput
  }

  /**
   * ClusterConfiguration.servers
   */
  export type ClusterConfiguration$serversArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    where?: ServerWhereInput
    orderBy?: ServerOrderByWithRelationInput | ServerOrderByWithRelationInput[]
    cursor?: ServerWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ServerScalarFieldEnum | ServerScalarFieldEnum[]
  }

  /**
   * ClusterConfiguration without action
   */
  export type ClusterConfigurationDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
  }


  /**
   * Model Cluster
   */

  export type AggregateCluster = {
    _count: ClusterCountAggregateOutputType | null
    _avg: ClusterAvgAggregateOutputType | null
    _sum: ClusterSumAggregateOutputType | null
    _min: ClusterMinAggregateOutputType | null
    _max: ClusterMaxAggregateOutputType | null
  }

  export type ClusterAvgAggregateOutputType = {
    cluster_id: number | null
    cluster_location_id: number | null
  }

  export type ClusterSumAggregateOutputType = {
    cluster_id: number | null
    cluster_location_id: number | null
  }

  export type ClusterMinAggregateOutputType = {
    cluster_id: number | null
    name: string | null
    created_at: Date | null
    cluster_location_id: number | null
  }

  export type ClusterMaxAggregateOutputType = {
    cluster_id: number | null
    name: string | null
    created_at: Date | null
    cluster_location_id: number | null
  }

  export type ClusterCountAggregateOutputType = {
    cluster_id: number
    name: number
    created_at: number
    cluster_location_id: number
    _all: number
  }


  export type ClusterAvgAggregateInputType = {
    cluster_id?: true
    cluster_location_id?: true
  }

  export type ClusterSumAggregateInputType = {
    cluster_id?: true
    cluster_location_id?: true
  }

  export type ClusterMinAggregateInputType = {
    cluster_id?: true
    name?: true
    created_at?: true
    cluster_location_id?: true
  }

  export type ClusterMaxAggregateInputType = {
    cluster_id?: true
    name?: true
    created_at?: true
    cluster_location_id?: true
  }

  export type ClusterCountAggregateInputType = {
    cluster_id?: true
    name?: true
    created_at?: true
    cluster_location_id?: true
    _all?: true
  }

  export type ClusterAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Cluster to aggregate.
     */
    where?: ClusterWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Clusters to fetch.
     */
    orderBy?: ClusterOrderByWithRelationInput | ClusterOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: ClusterWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Clusters from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Clusters.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned Clusters
    **/
    _count?: true | ClusterCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: ClusterAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: ClusterSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: ClusterMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: ClusterMaxAggregateInputType
  }

  export type GetClusterAggregateType<T extends ClusterAggregateArgs> = {
        [P in keyof T & keyof AggregateCluster]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateCluster[P]>
      : GetScalarType<T[P], AggregateCluster[P]>
  }




  export type ClusterGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ClusterWhereInput
    orderBy?: ClusterOrderByWithAggregationInput | ClusterOrderByWithAggregationInput[]
    by: ClusterScalarFieldEnum[] | ClusterScalarFieldEnum
    having?: ClusterScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: ClusterCountAggregateInputType | true
    _avg?: ClusterAvgAggregateInputType
    _sum?: ClusterSumAggregateInputType
    _min?: ClusterMinAggregateInputType
    _max?: ClusterMaxAggregateInputType
  }

  export type ClusterGroupByOutputType = {
    cluster_id: number
    name: string
    created_at: Date
    cluster_location_id: number
    _count: ClusterCountAggregateOutputType | null
    _avg: ClusterAvgAggregateOutputType | null
    _sum: ClusterSumAggregateOutputType | null
    _min: ClusterMinAggregateOutputType | null
    _max: ClusterMaxAggregateOutputType | null
  }

  type GetClusterGroupByPayload<T extends ClusterGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<ClusterGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof ClusterGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], ClusterGroupByOutputType[P]>
            : GetScalarType<T[P], ClusterGroupByOutputType[P]>
        }
      >
    >


  export type ClusterSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cluster_id?: boolean
    name?: boolean
    created_at?: boolean
    cluster_location_id?: boolean
    clusterLocation?: boolean | ClusterLocationDefaultArgs<ExtArgs>
    servers?: boolean | Cluster$serversArgs<ExtArgs>
    _count?: boolean | ClusterCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["cluster"]>

  export type ClusterSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cluster_id?: boolean
    name?: boolean
    created_at?: boolean
    cluster_location_id?: boolean
    clusterLocation?: boolean | ClusterLocationDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["cluster"]>

  export type ClusterSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    cluster_id?: boolean
    name?: boolean
    created_at?: boolean
    cluster_location_id?: boolean
    clusterLocation?: boolean | ClusterLocationDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["cluster"]>

  export type ClusterSelectScalar = {
    cluster_id?: boolean
    name?: boolean
    created_at?: boolean
    cluster_location_id?: boolean
  }

  export type ClusterOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"cluster_id" | "name" | "created_at" | "cluster_location_id", ExtArgs["result"]["cluster"]>
  export type ClusterInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    clusterLocation?: boolean | ClusterLocationDefaultArgs<ExtArgs>
    servers?: boolean | Cluster$serversArgs<ExtArgs>
    _count?: boolean | ClusterCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type ClusterIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    clusterLocation?: boolean | ClusterLocationDefaultArgs<ExtArgs>
  }
  export type ClusterIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    clusterLocation?: boolean | ClusterLocationDefaultArgs<ExtArgs>
  }

  export type $ClusterPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "Cluster"
    objects: {
      clusterLocation: Prisma.$ClusterLocationPayload<ExtArgs>
      servers: Prisma.$ServerPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      cluster_id: number
      name: string
      created_at: Date
      cluster_location_id: number
    }, ExtArgs["result"]["cluster"]>
    composites: {}
  }

  type ClusterGetPayload<S extends boolean | null | undefined | ClusterDefaultArgs> = $Result.GetResult<Prisma.$ClusterPayload, S>

  type ClusterCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<ClusterFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: ClusterCountAggregateInputType | true
    }

  export interface ClusterDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['Cluster'], meta: { name: 'Cluster' } }
    /**
     * Find zero or one Cluster that matches the filter.
     * @param {ClusterFindUniqueArgs} args - Arguments to find a Cluster
     * @example
     * // Get one Cluster
     * const cluster = await prisma.cluster.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends ClusterFindUniqueArgs>(args: SelectSubset<T, ClusterFindUniqueArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one Cluster that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {ClusterFindUniqueOrThrowArgs} args - Arguments to find a Cluster
     * @example
     * // Get one Cluster
     * const cluster = await prisma.cluster.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends ClusterFindUniqueOrThrowArgs>(args: SelectSubset<T, ClusterFindUniqueOrThrowArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Cluster that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterFindFirstArgs} args - Arguments to find a Cluster
     * @example
     * // Get one Cluster
     * const cluster = await prisma.cluster.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends ClusterFindFirstArgs>(args?: SelectSubset<T, ClusterFindFirstArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Cluster that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterFindFirstOrThrowArgs} args - Arguments to find a Cluster
     * @example
     * // Get one Cluster
     * const cluster = await prisma.cluster.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends ClusterFindFirstOrThrowArgs>(args?: SelectSubset<T, ClusterFindFirstOrThrowArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more Clusters that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all Clusters
     * const clusters = await prisma.cluster.findMany()
     * 
     * // Get first 10 Clusters
     * const clusters = await prisma.cluster.findMany({ take: 10 })
     * 
     * // Only select the `cluster_id`
     * const clusterWithCluster_idOnly = await prisma.cluster.findMany({ select: { cluster_id: true } })
     * 
     */
    findMany<T extends ClusterFindManyArgs>(args?: SelectSubset<T, ClusterFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a Cluster.
     * @param {ClusterCreateArgs} args - Arguments to create a Cluster.
     * @example
     * // Create one Cluster
     * const Cluster = await prisma.cluster.create({
     *   data: {
     *     // ... data to create a Cluster
     *   }
     * })
     * 
     */
    create<T extends ClusterCreateArgs>(args: SelectSubset<T, ClusterCreateArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many Clusters.
     * @param {ClusterCreateManyArgs} args - Arguments to create many Clusters.
     * @example
     * // Create many Clusters
     * const cluster = await prisma.cluster.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends ClusterCreateManyArgs>(args?: SelectSubset<T, ClusterCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many Clusters and returns the data saved in the database.
     * @param {ClusterCreateManyAndReturnArgs} args - Arguments to create many Clusters.
     * @example
     * // Create many Clusters
     * const cluster = await prisma.cluster.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many Clusters and only return the `cluster_id`
     * const clusterWithCluster_idOnly = await prisma.cluster.createManyAndReturn({
     *   select: { cluster_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends ClusterCreateManyAndReturnArgs>(args?: SelectSubset<T, ClusterCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a Cluster.
     * @param {ClusterDeleteArgs} args - Arguments to delete one Cluster.
     * @example
     * // Delete one Cluster
     * const Cluster = await prisma.cluster.delete({
     *   where: {
     *     // ... filter to delete one Cluster
     *   }
     * })
     * 
     */
    delete<T extends ClusterDeleteArgs>(args: SelectSubset<T, ClusterDeleteArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one Cluster.
     * @param {ClusterUpdateArgs} args - Arguments to update one Cluster.
     * @example
     * // Update one Cluster
     * const cluster = await prisma.cluster.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends ClusterUpdateArgs>(args: SelectSubset<T, ClusterUpdateArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more Clusters.
     * @param {ClusterDeleteManyArgs} args - Arguments to filter Clusters to delete.
     * @example
     * // Delete a few Clusters
     * const { count } = await prisma.cluster.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends ClusterDeleteManyArgs>(args?: SelectSubset<T, ClusterDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Clusters.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many Clusters
     * const cluster = await prisma.cluster.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends ClusterUpdateManyArgs>(args: SelectSubset<T, ClusterUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Clusters and returns the data updated in the database.
     * @param {ClusterUpdateManyAndReturnArgs} args - Arguments to update many Clusters.
     * @example
     * // Update many Clusters
     * const cluster = await prisma.cluster.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more Clusters and only return the `cluster_id`
     * const clusterWithCluster_idOnly = await prisma.cluster.updateManyAndReturn({
     *   select: { cluster_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends ClusterUpdateManyAndReturnArgs>(args: SelectSubset<T, ClusterUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one Cluster.
     * @param {ClusterUpsertArgs} args - Arguments to update or create a Cluster.
     * @example
     * // Update or create a Cluster
     * const cluster = await prisma.cluster.upsert({
     *   create: {
     *     // ... data to create a Cluster
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the Cluster we want to update
     *   }
     * })
     */
    upsert<T extends ClusterUpsertArgs>(args: SelectSubset<T, ClusterUpsertArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of Clusters.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterCountArgs} args - Arguments to filter Clusters to count.
     * @example
     * // Count the number of Clusters
     * const count = await prisma.cluster.count({
     *   where: {
     *     // ... the filter for the Clusters we want to count
     *   }
     * })
    **/
    count<T extends ClusterCountArgs>(
      args?: Subset<T, ClusterCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], ClusterCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a Cluster.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends ClusterAggregateArgs>(args: Subset<T, ClusterAggregateArgs>): Prisma.PrismaPromise<GetClusterAggregateType<T>>

    /**
     * Group by Cluster.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ClusterGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends ClusterGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: ClusterGroupByArgs['orderBy'] }
        : { orderBy?: ClusterGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, ClusterGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetClusterGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the Cluster model
   */
  readonly fields: ClusterFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for Cluster.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__ClusterClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    clusterLocation<T extends ClusterLocationDefaultArgs<ExtArgs> = {}>(args?: Subset<T, ClusterLocationDefaultArgs<ExtArgs>>): Prisma__ClusterLocationClient<$Result.GetResult<Prisma.$ClusterLocationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>
    servers<T extends Cluster$serversArgs<ExtArgs> = {}>(args?: Subset<T, Cluster$serversArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the Cluster model
   */
  interface ClusterFieldRefs {
    readonly cluster_id: FieldRef<"Cluster", 'Int'>
    readonly name: FieldRef<"Cluster", 'String'>
    readonly created_at: FieldRef<"Cluster", 'DateTime'>
    readonly cluster_location_id: FieldRef<"Cluster", 'Int'>
  }
    

  // Custom InputTypes
  /**
   * Cluster findUnique
   */
  export type ClusterFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * Filter, which Cluster to fetch.
     */
    where: ClusterWhereUniqueInput
  }

  /**
   * Cluster findUniqueOrThrow
   */
  export type ClusterFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * Filter, which Cluster to fetch.
     */
    where: ClusterWhereUniqueInput
  }

  /**
   * Cluster findFirst
   */
  export type ClusterFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * Filter, which Cluster to fetch.
     */
    where?: ClusterWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Clusters to fetch.
     */
    orderBy?: ClusterOrderByWithRelationInput | ClusterOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Clusters.
     */
    cursor?: ClusterWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Clusters from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Clusters.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Clusters.
     */
    distinct?: ClusterScalarFieldEnum | ClusterScalarFieldEnum[]
  }

  /**
   * Cluster findFirstOrThrow
   */
  export type ClusterFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * Filter, which Cluster to fetch.
     */
    where?: ClusterWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Clusters to fetch.
     */
    orderBy?: ClusterOrderByWithRelationInput | ClusterOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Clusters.
     */
    cursor?: ClusterWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Clusters from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Clusters.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Clusters.
     */
    distinct?: ClusterScalarFieldEnum | ClusterScalarFieldEnum[]
  }

  /**
   * Cluster findMany
   */
  export type ClusterFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * Filter, which Clusters to fetch.
     */
    where?: ClusterWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Clusters to fetch.
     */
    orderBy?: ClusterOrderByWithRelationInput | ClusterOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing Clusters.
     */
    cursor?: ClusterWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Clusters from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Clusters.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Clusters.
     */
    distinct?: ClusterScalarFieldEnum | ClusterScalarFieldEnum[]
  }

  /**
   * Cluster create
   */
  export type ClusterCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * The data needed to create a Cluster.
     */
    data: XOR<ClusterCreateInput, ClusterUncheckedCreateInput>
  }

  /**
   * Cluster createMany
   */
  export type ClusterCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many Clusters.
     */
    data: ClusterCreateManyInput | ClusterCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * Cluster createManyAndReturn
   */
  export type ClusterCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * The data used to create many Clusters.
     */
    data: ClusterCreateManyInput | ClusterCreateManyInput[]
    skipDuplicates?: boolean
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterIncludeCreateManyAndReturn<ExtArgs> | null
  }

  /**
   * Cluster update
   */
  export type ClusterUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * The data needed to update a Cluster.
     */
    data: XOR<ClusterUpdateInput, ClusterUncheckedUpdateInput>
    /**
     * Choose, which Cluster to update.
     */
    where: ClusterWhereUniqueInput
  }

  /**
   * Cluster updateMany
   */
  export type ClusterUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update Clusters.
     */
    data: XOR<ClusterUpdateManyMutationInput, ClusterUncheckedUpdateManyInput>
    /**
     * Filter which Clusters to update
     */
    where?: ClusterWhereInput
    /**
     * Limit how many Clusters to update.
     */
    limit?: number
  }

  /**
   * Cluster updateManyAndReturn
   */
  export type ClusterUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * The data used to update Clusters.
     */
    data: XOR<ClusterUpdateManyMutationInput, ClusterUncheckedUpdateManyInput>
    /**
     * Filter which Clusters to update
     */
    where?: ClusterWhereInput
    /**
     * Limit how many Clusters to update.
     */
    limit?: number
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterIncludeUpdateManyAndReturn<ExtArgs> | null
  }

  /**
   * Cluster upsert
   */
  export type ClusterUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * The filter to search for the Cluster to update in case it exists.
     */
    where: ClusterWhereUniqueInput
    /**
     * In case the Cluster found by the `where` argument doesn't exist, create a new Cluster with this data.
     */
    create: XOR<ClusterCreateInput, ClusterUncheckedCreateInput>
    /**
     * In case the Cluster was found with the provided `where` argument, update it with this data.
     */
    update: XOR<ClusterUpdateInput, ClusterUncheckedUpdateInput>
  }

  /**
   * Cluster delete
   */
  export type ClusterDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
    /**
     * Filter which Cluster to delete.
     */
    where: ClusterWhereUniqueInput
  }

  /**
   * Cluster deleteMany
   */
  export type ClusterDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Clusters to delete
     */
    where?: ClusterWhereInput
    /**
     * Limit how many Clusters to delete.
     */
    limit?: number
  }

  /**
   * Cluster.servers
   */
  export type Cluster$serversArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    where?: ServerWhereInput
    orderBy?: ServerOrderByWithRelationInput | ServerOrderByWithRelationInput[]
    cursor?: ServerWhereUniqueInput
    take?: number
    skip?: number
    distinct?: ServerScalarFieldEnum | ServerScalarFieldEnum[]
  }

  /**
   * Cluster without action
   */
  export type ClusterDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Cluster
     */
    select?: ClusterSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Cluster
     */
    omit?: ClusterOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterInclude<ExtArgs> | null
  }


  /**
   * Model Server
   */

  export type AggregateServer = {
    _count: ServerCountAggregateOutputType | null
    _avg: ServerAvgAggregateOutputType | null
    _sum: ServerSumAggregateOutputType | null
    _min: ServerMinAggregateOutputType | null
    _max: ServerMaxAggregateOutputType | null
  }

  export type ServerAvgAggregateOutputType = {
    server_id: number | null
    cluster_id: number | null
    config_id: number | null
    base_consumption_offset: number | null
  }

  export type ServerSumAggregateOutputType = {
    server_id: number | null
    cluster_id: number | null
    config_id: number | null
    base_consumption_offset: number | null
  }

  export type ServerMinAggregateOutputType = {
    server_id: number | null
    cluster_id: number | null
    config_id: number | null
    hostname: string | null
    status: string | null
    base_consumption_offset: number | null
    created_at: Date | null
  }

  export type ServerMaxAggregateOutputType = {
    server_id: number | null
    cluster_id: number | null
    config_id: number | null
    hostname: string | null
    status: string | null
    base_consumption_offset: number | null
    created_at: Date | null
  }

  export type ServerCountAggregateOutputType = {
    server_id: number
    cluster_id: number
    config_id: number
    hostname: number
    status: number
    base_consumption_offset: number
    created_at: number
    _all: number
  }


  export type ServerAvgAggregateInputType = {
    server_id?: true
    cluster_id?: true
    config_id?: true
    base_consumption_offset?: true
  }

  export type ServerSumAggregateInputType = {
    server_id?: true
    cluster_id?: true
    config_id?: true
    base_consumption_offset?: true
  }

  export type ServerMinAggregateInputType = {
    server_id?: true
    cluster_id?: true
    config_id?: true
    hostname?: true
    status?: true
    base_consumption_offset?: true
    created_at?: true
  }

  export type ServerMaxAggregateInputType = {
    server_id?: true
    cluster_id?: true
    config_id?: true
    hostname?: true
    status?: true
    base_consumption_offset?: true
    created_at?: true
  }

  export type ServerCountAggregateInputType = {
    server_id?: true
    cluster_id?: true
    config_id?: true
    hostname?: true
    status?: true
    base_consumption_offset?: true
    created_at?: true
    _all?: true
  }

  export type ServerAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Server to aggregate.
     */
    where?: ServerWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Servers to fetch.
     */
    orderBy?: ServerOrderByWithRelationInput | ServerOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: ServerWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Servers from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Servers.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned Servers
    **/
    _count?: true | ServerCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: ServerAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: ServerSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: ServerMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: ServerMaxAggregateInputType
  }

  export type GetServerAggregateType<T extends ServerAggregateArgs> = {
        [P in keyof T & keyof AggregateServer]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateServer[P]>
      : GetScalarType<T[P], AggregateServer[P]>
  }




  export type ServerGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: ServerWhereInput
    orderBy?: ServerOrderByWithAggregationInput | ServerOrderByWithAggregationInput[]
    by: ServerScalarFieldEnum[] | ServerScalarFieldEnum
    having?: ServerScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: ServerCountAggregateInputType | true
    _avg?: ServerAvgAggregateInputType
    _sum?: ServerSumAggregateInputType
    _min?: ServerMinAggregateInputType
    _max?: ServerMaxAggregateInputType
  }

  export type ServerGroupByOutputType = {
    server_id: number
    cluster_id: number
    config_id: number | null
    hostname: string
    status: string
    base_consumption_offset: number
    created_at: Date
    _count: ServerCountAggregateOutputType | null
    _avg: ServerAvgAggregateOutputType | null
    _sum: ServerSumAggregateOutputType | null
    _min: ServerMinAggregateOutputType | null
    _max: ServerMaxAggregateOutputType | null
  }

  type GetServerGroupByPayload<T extends ServerGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<ServerGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof ServerGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], ServerGroupByOutputType[P]>
            : GetScalarType<T[P], ServerGroupByOutputType[P]>
        }
      >
    >


  export type ServerSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    server_id?: boolean
    cluster_id?: boolean
    config_id?: boolean
    hostname?: boolean
    status?: boolean
    base_consumption_offset?: boolean
    created_at?: boolean
    cluster?: boolean | ClusterDefaultArgs<ExtArgs>
    configuration?: boolean | Server$configurationArgs<ExtArgs>
    sensors?: boolean | Server$sensorsArgs<ExtArgs>
    fans?: boolean | Server$fansArgs<ExtArgs>
    _count?: boolean | ServerCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["server"]>

  export type ServerSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    server_id?: boolean
    cluster_id?: boolean
    config_id?: boolean
    hostname?: boolean
    status?: boolean
    base_consumption_offset?: boolean
    created_at?: boolean
    cluster?: boolean | ClusterDefaultArgs<ExtArgs>
    configuration?: boolean | Server$configurationArgs<ExtArgs>
  }, ExtArgs["result"]["server"]>

  export type ServerSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    server_id?: boolean
    cluster_id?: boolean
    config_id?: boolean
    hostname?: boolean
    status?: boolean
    base_consumption_offset?: boolean
    created_at?: boolean
    cluster?: boolean | ClusterDefaultArgs<ExtArgs>
    configuration?: boolean | Server$configurationArgs<ExtArgs>
  }, ExtArgs["result"]["server"]>

  export type ServerSelectScalar = {
    server_id?: boolean
    cluster_id?: boolean
    config_id?: boolean
    hostname?: boolean
    status?: boolean
    base_consumption_offset?: boolean
    created_at?: boolean
  }

  export type ServerOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"server_id" | "cluster_id" | "config_id" | "hostname" | "status" | "base_consumption_offset" | "created_at", ExtArgs["result"]["server"]>
  export type ServerInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster?: boolean | ClusterDefaultArgs<ExtArgs>
    configuration?: boolean | Server$configurationArgs<ExtArgs>
    sensors?: boolean | Server$sensorsArgs<ExtArgs>
    fans?: boolean | Server$fansArgs<ExtArgs>
    _count?: boolean | ServerCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type ServerIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster?: boolean | ClusterDefaultArgs<ExtArgs>
    configuration?: boolean | Server$configurationArgs<ExtArgs>
  }
  export type ServerIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    cluster?: boolean | ClusterDefaultArgs<ExtArgs>
    configuration?: boolean | Server$configurationArgs<ExtArgs>
  }

  export type $ServerPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "Server"
    objects: {
      cluster: Prisma.$ClusterPayload<ExtArgs>
      configuration: Prisma.$ClusterConfigurationPayload<ExtArgs> | null
      sensors: Prisma.$SensorPayload<ExtArgs>[]
      fans: Prisma.$FanPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      server_id: number
      cluster_id: number
      config_id: number | null
      hostname: string
      status: string
      base_consumption_offset: number
      created_at: Date
    }, ExtArgs["result"]["server"]>
    composites: {}
  }

  type ServerGetPayload<S extends boolean | null | undefined | ServerDefaultArgs> = $Result.GetResult<Prisma.$ServerPayload, S>

  type ServerCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<ServerFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: ServerCountAggregateInputType | true
    }

  export interface ServerDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['Server'], meta: { name: 'Server' } }
    /**
     * Find zero or one Server that matches the filter.
     * @param {ServerFindUniqueArgs} args - Arguments to find a Server
     * @example
     * // Get one Server
     * const server = await prisma.server.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends ServerFindUniqueArgs>(args: SelectSubset<T, ServerFindUniqueArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one Server that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {ServerFindUniqueOrThrowArgs} args - Arguments to find a Server
     * @example
     * // Get one Server
     * const server = await prisma.server.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends ServerFindUniqueOrThrowArgs>(args: SelectSubset<T, ServerFindUniqueOrThrowArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Server that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ServerFindFirstArgs} args - Arguments to find a Server
     * @example
     * // Get one Server
     * const server = await prisma.server.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends ServerFindFirstArgs>(args?: SelectSubset<T, ServerFindFirstArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Server that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ServerFindFirstOrThrowArgs} args - Arguments to find a Server
     * @example
     * // Get one Server
     * const server = await prisma.server.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends ServerFindFirstOrThrowArgs>(args?: SelectSubset<T, ServerFindFirstOrThrowArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more Servers that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ServerFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all Servers
     * const servers = await prisma.server.findMany()
     * 
     * // Get first 10 Servers
     * const servers = await prisma.server.findMany({ take: 10 })
     * 
     * // Only select the `server_id`
     * const serverWithServer_idOnly = await prisma.server.findMany({ select: { server_id: true } })
     * 
     */
    findMany<T extends ServerFindManyArgs>(args?: SelectSubset<T, ServerFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a Server.
     * @param {ServerCreateArgs} args - Arguments to create a Server.
     * @example
     * // Create one Server
     * const Server = await prisma.server.create({
     *   data: {
     *     // ... data to create a Server
     *   }
     * })
     * 
     */
    create<T extends ServerCreateArgs>(args: SelectSubset<T, ServerCreateArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many Servers.
     * @param {ServerCreateManyArgs} args - Arguments to create many Servers.
     * @example
     * // Create many Servers
     * const server = await prisma.server.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends ServerCreateManyArgs>(args?: SelectSubset<T, ServerCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many Servers and returns the data saved in the database.
     * @param {ServerCreateManyAndReturnArgs} args - Arguments to create many Servers.
     * @example
     * // Create many Servers
     * const server = await prisma.server.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many Servers and only return the `server_id`
     * const serverWithServer_idOnly = await prisma.server.createManyAndReturn({
     *   select: { server_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends ServerCreateManyAndReturnArgs>(args?: SelectSubset<T, ServerCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a Server.
     * @param {ServerDeleteArgs} args - Arguments to delete one Server.
     * @example
     * // Delete one Server
     * const Server = await prisma.server.delete({
     *   where: {
     *     // ... filter to delete one Server
     *   }
     * })
     * 
     */
    delete<T extends ServerDeleteArgs>(args: SelectSubset<T, ServerDeleteArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one Server.
     * @param {ServerUpdateArgs} args - Arguments to update one Server.
     * @example
     * // Update one Server
     * const server = await prisma.server.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends ServerUpdateArgs>(args: SelectSubset<T, ServerUpdateArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more Servers.
     * @param {ServerDeleteManyArgs} args - Arguments to filter Servers to delete.
     * @example
     * // Delete a few Servers
     * const { count } = await prisma.server.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends ServerDeleteManyArgs>(args?: SelectSubset<T, ServerDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Servers.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ServerUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many Servers
     * const server = await prisma.server.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends ServerUpdateManyArgs>(args: SelectSubset<T, ServerUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Servers and returns the data updated in the database.
     * @param {ServerUpdateManyAndReturnArgs} args - Arguments to update many Servers.
     * @example
     * // Update many Servers
     * const server = await prisma.server.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more Servers and only return the `server_id`
     * const serverWithServer_idOnly = await prisma.server.updateManyAndReturn({
     *   select: { server_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends ServerUpdateManyAndReturnArgs>(args: SelectSubset<T, ServerUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one Server.
     * @param {ServerUpsertArgs} args - Arguments to update or create a Server.
     * @example
     * // Update or create a Server
     * const server = await prisma.server.upsert({
     *   create: {
     *     // ... data to create a Server
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the Server we want to update
     *   }
     * })
     */
    upsert<T extends ServerUpsertArgs>(args: SelectSubset<T, ServerUpsertArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of Servers.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ServerCountArgs} args - Arguments to filter Servers to count.
     * @example
     * // Count the number of Servers
     * const count = await prisma.server.count({
     *   where: {
     *     // ... the filter for the Servers we want to count
     *   }
     * })
    **/
    count<T extends ServerCountArgs>(
      args?: Subset<T, ServerCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], ServerCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a Server.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ServerAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends ServerAggregateArgs>(args: Subset<T, ServerAggregateArgs>): Prisma.PrismaPromise<GetServerAggregateType<T>>

    /**
     * Group by Server.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {ServerGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends ServerGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: ServerGroupByArgs['orderBy'] }
        : { orderBy?: ServerGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, ServerGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetServerGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the Server model
   */
  readonly fields: ServerFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for Server.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__ServerClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    cluster<T extends ClusterDefaultArgs<ExtArgs> = {}>(args?: Subset<T, ClusterDefaultArgs<ExtArgs>>): Prisma__ClusterClient<$Result.GetResult<Prisma.$ClusterPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>
    configuration<T extends Server$configurationArgs<ExtArgs> = {}>(args?: Subset<T, Server$configurationArgs<ExtArgs>>): Prisma__ClusterConfigurationClient<$Result.GetResult<Prisma.$ClusterConfigurationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>
    sensors<T extends Server$sensorsArgs<ExtArgs> = {}>(args?: Subset<T, Server$sensorsArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    fans<T extends Server$fansArgs<ExtArgs> = {}>(args?: Subset<T, Server$fansArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the Server model
   */
  interface ServerFieldRefs {
    readonly server_id: FieldRef<"Server", 'Int'>
    readonly cluster_id: FieldRef<"Server", 'Int'>
    readonly config_id: FieldRef<"Server", 'Int'>
    readonly hostname: FieldRef<"Server", 'String'>
    readonly status: FieldRef<"Server", 'String'>
    readonly base_consumption_offset: FieldRef<"Server", 'Float'>
    readonly created_at: FieldRef<"Server", 'DateTime'>
  }
    

  // Custom InputTypes
  /**
   * Server findUnique
   */
  export type ServerFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * Filter, which Server to fetch.
     */
    where: ServerWhereUniqueInput
  }

  /**
   * Server findUniqueOrThrow
   */
  export type ServerFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * Filter, which Server to fetch.
     */
    where: ServerWhereUniqueInput
  }

  /**
   * Server findFirst
   */
  export type ServerFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * Filter, which Server to fetch.
     */
    where?: ServerWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Servers to fetch.
     */
    orderBy?: ServerOrderByWithRelationInput | ServerOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Servers.
     */
    cursor?: ServerWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Servers from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Servers.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Servers.
     */
    distinct?: ServerScalarFieldEnum | ServerScalarFieldEnum[]
  }

  /**
   * Server findFirstOrThrow
   */
  export type ServerFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * Filter, which Server to fetch.
     */
    where?: ServerWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Servers to fetch.
     */
    orderBy?: ServerOrderByWithRelationInput | ServerOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Servers.
     */
    cursor?: ServerWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Servers from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Servers.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Servers.
     */
    distinct?: ServerScalarFieldEnum | ServerScalarFieldEnum[]
  }

  /**
   * Server findMany
   */
  export type ServerFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * Filter, which Servers to fetch.
     */
    where?: ServerWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Servers to fetch.
     */
    orderBy?: ServerOrderByWithRelationInput | ServerOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing Servers.
     */
    cursor?: ServerWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Servers from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Servers.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Servers.
     */
    distinct?: ServerScalarFieldEnum | ServerScalarFieldEnum[]
  }

  /**
   * Server create
   */
  export type ServerCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * The data needed to create a Server.
     */
    data: XOR<ServerCreateInput, ServerUncheckedCreateInput>
  }

  /**
   * Server createMany
   */
  export type ServerCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many Servers.
     */
    data: ServerCreateManyInput | ServerCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * Server createManyAndReturn
   */
  export type ServerCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * The data used to create many Servers.
     */
    data: ServerCreateManyInput | ServerCreateManyInput[]
    skipDuplicates?: boolean
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerIncludeCreateManyAndReturn<ExtArgs> | null
  }

  /**
   * Server update
   */
  export type ServerUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * The data needed to update a Server.
     */
    data: XOR<ServerUpdateInput, ServerUncheckedUpdateInput>
    /**
     * Choose, which Server to update.
     */
    where: ServerWhereUniqueInput
  }

  /**
   * Server updateMany
   */
  export type ServerUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update Servers.
     */
    data: XOR<ServerUpdateManyMutationInput, ServerUncheckedUpdateManyInput>
    /**
     * Filter which Servers to update
     */
    where?: ServerWhereInput
    /**
     * Limit how many Servers to update.
     */
    limit?: number
  }

  /**
   * Server updateManyAndReturn
   */
  export type ServerUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * The data used to update Servers.
     */
    data: XOR<ServerUpdateManyMutationInput, ServerUncheckedUpdateManyInput>
    /**
     * Filter which Servers to update
     */
    where?: ServerWhereInput
    /**
     * Limit how many Servers to update.
     */
    limit?: number
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerIncludeUpdateManyAndReturn<ExtArgs> | null
  }

  /**
   * Server upsert
   */
  export type ServerUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * The filter to search for the Server to update in case it exists.
     */
    where: ServerWhereUniqueInput
    /**
     * In case the Server found by the `where` argument doesn't exist, create a new Server with this data.
     */
    create: XOR<ServerCreateInput, ServerUncheckedCreateInput>
    /**
     * In case the Server was found with the provided `where` argument, update it with this data.
     */
    update: XOR<ServerUpdateInput, ServerUncheckedUpdateInput>
  }

  /**
   * Server delete
   */
  export type ServerDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
    /**
     * Filter which Server to delete.
     */
    where: ServerWhereUniqueInput
  }

  /**
   * Server deleteMany
   */
  export type ServerDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Servers to delete
     */
    where?: ServerWhereInput
    /**
     * Limit how many Servers to delete.
     */
    limit?: number
  }

  /**
   * Server.configuration
   */
  export type Server$configurationArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the ClusterConfiguration
     */
    select?: ClusterConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the ClusterConfiguration
     */
    omit?: ClusterConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ClusterConfigurationInclude<ExtArgs> | null
    where?: ClusterConfigurationWhereInput
  }

  /**
   * Server.sensors
   */
  export type Server$sensorsArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    where?: SensorWhereInput
    orderBy?: SensorOrderByWithRelationInput | SensorOrderByWithRelationInput[]
    cursor?: SensorWhereUniqueInput
    take?: number
    skip?: number
    distinct?: SensorScalarFieldEnum | SensorScalarFieldEnum[]
  }

  /**
   * Server.fans
   */
  export type Server$fansArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    where?: FanWhereInput
    orderBy?: FanOrderByWithRelationInput | FanOrderByWithRelationInput[]
    cursor?: FanWhereUniqueInput
    take?: number
    skip?: number
    distinct?: FanScalarFieldEnum | FanScalarFieldEnum[]
  }

  /**
   * Server without action
   */
  export type ServerDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Server
     */
    select?: ServerSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Server
     */
    omit?: ServerOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: ServerInclude<ExtArgs> | null
  }


  /**
   * Model Fan
   */

  export type AggregateFan = {
    _count: FanCountAggregateOutputType | null
    _avg: FanAvgAggregateOutputType | null
    _sum: FanSumAggregateOutputType | null
    _min: FanMinAggregateOutputType | null
    _max: FanMaxAggregateOutputType | null
  }

  export type FanAvgAggregateOutputType = {
    fan_id: number | null
    server_id: number | null
    fan_catalog_id: number | null
    fan_config_id: number | null
    speed_percent: number | null
  }

  export type FanSumAggregateOutputType = {
    fan_id: number | null
    server_id: number | null
    fan_catalog_id: number | null
    fan_config_id: number | null
    speed_percent: number | null
  }

  export type FanMinAggregateOutputType = {
    fan_id: number | null
    server_id: number | null
    fan_catalog_id: number | null
    fan_config_id: number | null
    control_mode: string | null
    status: string | null
    speed_percent: number | null
    created_at: Date | null
  }

  export type FanMaxAggregateOutputType = {
    fan_id: number | null
    server_id: number | null
    fan_catalog_id: number | null
    fan_config_id: number | null
    control_mode: string | null
    status: string | null
    speed_percent: number | null
    created_at: Date | null
  }

  export type FanCountAggregateOutputType = {
    fan_id: number
    server_id: number
    fan_catalog_id: number
    fan_config_id: number
    control_mode: number
    status: number
    speed_percent: number
    created_at: number
    _all: number
  }


  export type FanAvgAggregateInputType = {
    fan_id?: true
    server_id?: true
    fan_catalog_id?: true
    fan_config_id?: true
    speed_percent?: true
  }

  export type FanSumAggregateInputType = {
    fan_id?: true
    server_id?: true
    fan_catalog_id?: true
    fan_config_id?: true
    speed_percent?: true
  }

  export type FanMinAggregateInputType = {
    fan_id?: true
    server_id?: true
    fan_catalog_id?: true
    fan_config_id?: true
    control_mode?: true
    status?: true
    speed_percent?: true
    created_at?: true
  }

  export type FanMaxAggregateInputType = {
    fan_id?: true
    server_id?: true
    fan_catalog_id?: true
    fan_config_id?: true
    control_mode?: true
    status?: true
    speed_percent?: true
    created_at?: true
  }

  export type FanCountAggregateInputType = {
    fan_id?: true
    server_id?: true
    fan_catalog_id?: true
    fan_config_id?: true
    control_mode?: true
    status?: true
    speed_percent?: true
    created_at?: true
    _all?: true
  }

  export type FanAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Fan to aggregate.
     */
    where?: FanWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Fans to fetch.
     */
    orderBy?: FanOrderByWithRelationInput | FanOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: FanWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Fans from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Fans.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned Fans
    **/
    _count?: true | FanCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: FanAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: FanSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: FanMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: FanMaxAggregateInputType
  }

  export type GetFanAggregateType<T extends FanAggregateArgs> = {
        [P in keyof T & keyof AggregateFan]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateFan[P]>
      : GetScalarType<T[P], AggregateFan[P]>
  }




  export type FanGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: FanWhereInput
    orderBy?: FanOrderByWithAggregationInput | FanOrderByWithAggregationInput[]
    by: FanScalarFieldEnum[] | FanScalarFieldEnum
    having?: FanScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: FanCountAggregateInputType | true
    _avg?: FanAvgAggregateInputType
    _sum?: FanSumAggregateInputType
    _min?: FanMinAggregateInputType
    _max?: FanMaxAggregateInputType
  }

  export type FanGroupByOutputType = {
    fan_id: number
    server_id: number
    fan_catalog_id: number | null
    fan_config_id: number | null
    control_mode: string
    status: string
    speed_percent: number
    created_at: Date
    _count: FanCountAggregateOutputType | null
    _avg: FanAvgAggregateOutputType | null
    _sum: FanSumAggregateOutputType | null
    _min: FanMinAggregateOutputType | null
    _max: FanMaxAggregateOutputType | null
  }

  type GetFanGroupByPayload<T extends FanGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<FanGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof FanGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], FanGroupByOutputType[P]>
            : GetScalarType<T[P], FanGroupByOutputType[P]>
        }
      >
    >


  export type FanSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_id?: boolean
    server_id?: boolean
    fan_catalog_id?: boolean
    fan_config_id?: boolean
    control_mode?: boolean
    status?: boolean
    speed_percent?: boolean
    created_at?: boolean
    server?: boolean | ServerDefaultArgs<ExtArgs>
    catalog_info?: boolean | Fan$catalog_infoArgs<ExtArgs>
    fan_config?: boolean | Fan$fan_configArgs<ExtArgs>
  }, ExtArgs["result"]["fan"]>

  export type FanSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_id?: boolean
    server_id?: boolean
    fan_catalog_id?: boolean
    fan_config_id?: boolean
    control_mode?: boolean
    status?: boolean
    speed_percent?: boolean
    created_at?: boolean
    server?: boolean | ServerDefaultArgs<ExtArgs>
    catalog_info?: boolean | Fan$catalog_infoArgs<ExtArgs>
    fan_config?: boolean | Fan$fan_configArgs<ExtArgs>
  }, ExtArgs["result"]["fan"]>

  export type FanSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    fan_id?: boolean
    server_id?: boolean
    fan_catalog_id?: boolean
    fan_config_id?: boolean
    control_mode?: boolean
    status?: boolean
    speed_percent?: boolean
    created_at?: boolean
    server?: boolean | ServerDefaultArgs<ExtArgs>
    catalog_info?: boolean | Fan$catalog_infoArgs<ExtArgs>
    fan_config?: boolean | Fan$fan_configArgs<ExtArgs>
  }, ExtArgs["result"]["fan"]>

  export type FanSelectScalar = {
    fan_id?: boolean
    server_id?: boolean
    fan_catalog_id?: boolean
    fan_config_id?: boolean
    control_mode?: boolean
    status?: boolean
    speed_percent?: boolean
    created_at?: boolean
  }

  export type FanOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"fan_id" | "server_id" | "fan_catalog_id" | "fan_config_id" | "control_mode" | "status" | "speed_percent" | "created_at", ExtArgs["result"]["fan"]>
  export type FanInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    server?: boolean | ServerDefaultArgs<ExtArgs>
    catalog_info?: boolean | Fan$catalog_infoArgs<ExtArgs>
    fan_config?: boolean | Fan$fan_configArgs<ExtArgs>
  }
  export type FanIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    server?: boolean | ServerDefaultArgs<ExtArgs>
    catalog_info?: boolean | Fan$catalog_infoArgs<ExtArgs>
    fan_config?: boolean | Fan$fan_configArgs<ExtArgs>
  }
  export type FanIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    server?: boolean | ServerDefaultArgs<ExtArgs>
    catalog_info?: boolean | Fan$catalog_infoArgs<ExtArgs>
    fan_config?: boolean | Fan$fan_configArgs<ExtArgs>
  }

  export type $FanPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "Fan"
    objects: {
      server: Prisma.$ServerPayload<ExtArgs>
      catalog_info: Prisma.$FanCatalogPayload<ExtArgs> | null
      fan_config: Prisma.$FanConfigurationPayload<ExtArgs> | null
    }
    scalars: $Extensions.GetPayloadResult<{
      fan_id: number
      server_id: number
      fan_catalog_id: number | null
      fan_config_id: number | null
      control_mode: string
      status: string
      speed_percent: number
      created_at: Date
    }, ExtArgs["result"]["fan"]>
    composites: {}
  }

  type FanGetPayload<S extends boolean | null | undefined | FanDefaultArgs> = $Result.GetResult<Prisma.$FanPayload, S>

  type FanCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<FanFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: FanCountAggregateInputType | true
    }

  export interface FanDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['Fan'], meta: { name: 'Fan' } }
    /**
     * Find zero or one Fan that matches the filter.
     * @param {FanFindUniqueArgs} args - Arguments to find a Fan
     * @example
     * // Get one Fan
     * const fan = await prisma.fan.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends FanFindUniqueArgs>(args: SelectSubset<T, FanFindUniqueArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one Fan that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {FanFindUniqueOrThrowArgs} args - Arguments to find a Fan
     * @example
     * // Get one Fan
     * const fan = await prisma.fan.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends FanFindUniqueOrThrowArgs>(args: SelectSubset<T, FanFindUniqueOrThrowArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Fan that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanFindFirstArgs} args - Arguments to find a Fan
     * @example
     * // Get one Fan
     * const fan = await prisma.fan.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends FanFindFirstArgs>(args?: SelectSubset<T, FanFindFirstArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Fan that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanFindFirstOrThrowArgs} args - Arguments to find a Fan
     * @example
     * // Get one Fan
     * const fan = await prisma.fan.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends FanFindFirstOrThrowArgs>(args?: SelectSubset<T, FanFindFirstOrThrowArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more Fans that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all Fans
     * const fans = await prisma.fan.findMany()
     * 
     * // Get first 10 Fans
     * const fans = await prisma.fan.findMany({ take: 10 })
     * 
     * // Only select the `fan_id`
     * const fanWithFan_idOnly = await prisma.fan.findMany({ select: { fan_id: true } })
     * 
     */
    findMany<T extends FanFindManyArgs>(args?: SelectSubset<T, FanFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a Fan.
     * @param {FanCreateArgs} args - Arguments to create a Fan.
     * @example
     * // Create one Fan
     * const Fan = await prisma.fan.create({
     *   data: {
     *     // ... data to create a Fan
     *   }
     * })
     * 
     */
    create<T extends FanCreateArgs>(args: SelectSubset<T, FanCreateArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many Fans.
     * @param {FanCreateManyArgs} args - Arguments to create many Fans.
     * @example
     * // Create many Fans
     * const fan = await prisma.fan.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends FanCreateManyArgs>(args?: SelectSubset<T, FanCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many Fans and returns the data saved in the database.
     * @param {FanCreateManyAndReturnArgs} args - Arguments to create many Fans.
     * @example
     * // Create many Fans
     * const fan = await prisma.fan.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many Fans and only return the `fan_id`
     * const fanWithFan_idOnly = await prisma.fan.createManyAndReturn({
     *   select: { fan_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends FanCreateManyAndReturnArgs>(args?: SelectSubset<T, FanCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a Fan.
     * @param {FanDeleteArgs} args - Arguments to delete one Fan.
     * @example
     * // Delete one Fan
     * const Fan = await prisma.fan.delete({
     *   where: {
     *     // ... filter to delete one Fan
     *   }
     * })
     * 
     */
    delete<T extends FanDeleteArgs>(args: SelectSubset<T, FanDeleteArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one Fan.
     * @param {FanUpdateArgs} args - Arguments to update one Fan.
     * @example
     * // Update one Fan
     * const fan = await prisma.fan.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends FanUpdateArgs>(args: SelectSubset<T, FanUpdateArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more Fans.
     * @param {FanDeleteManyArgs} args - Arguments to filter Fans to delete.
     * @example
     * // Delete a few Fans
     * const { count } = await prisma.fan.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends FanDeleteManyArgs>(args?: SelectSubset<T, FanDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Fans.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many Fans
     * const fan = await prisma.fan.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends FanUpdateManyArgs>(args: SelectSubset<T, FanUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Fans and returns the data updated in the database.
     * @param {FanUpdateManyAndReturnArgs} args - Arguments to update many Fans.
     * @example
     * // Update many Fans
     * const fan = await prisma.fan.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more Fans and only return the `fan_id`
     * const fanWithFan_idOnly = await prisma.fan.updateManyAndReturn({
     *   select: { fan_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends FanUpdateManyAndReturnArgs>(args: SelectSubset<T, FanUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one Fan.
     * @param {FanUpsertArgs} args - Arguments to update or create a Fan.
     * @example
     * // Update or create a Fan
     * const fan = await prisma.fan.upsert({
     *   create: {
     *     // ... data to create a Fan
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the Fan we want to update
     *   }
     * })
     */
    upsert<T extends FanUpsertArgs>(args: SelectSubset<T, FanUpsertArgs<ExtArgs>>): Prisma__FanClient<$Result.GetResult<Prisma.$FanPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of Fans.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanCountArgs} args - Arguments to filter Fans to count.
     * @example
     * // Count the number of Fans
     * const count = await prisma.fan.count({
     *   where: {
     *     // ... the filter for the Fans we want to count
     *   }
     * })
    **/
    count<T extends FanCountArgs>(
      args?: Subset<T, FanCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], FanCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a Fan.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends FanAggregateArgs>(args: Subset<T, FanAggregateArgs>): Prisma.PrismaPromise<GetFanAggregateType<T>>

    /**
     * Group by Fan.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {FanGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends FanGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: FanGroupByArgs['orderBy'] }
        : { orderBy?: FanGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, FanGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetFanGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the Fan model
   */
  readonly fields: FanFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for Fan.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__FanClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    server<T extends ServerDefaultArgs<ExtArgs> = {}>(args?: Subset<T, ServerDefaultArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>
    catalog_info<T extends Fan$catalog_infoArgs<ExtArgs> = {}>(args?: Subset<T, Fan$catalog_infoArgs<ExtArgs>>): Prisma__FanCatalogClient<$Result.GetResult<Prisma.$FanCatalogPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>
    fan_config<T extends Fan$fan_configArgs<ExtArgs> = {}>(args?: Subset<T, Fan$fan_configArgs<ExtArgs>>): Prisma__FanConfigurationClient<$Result.GetResult<Prisma.$FanConfigurationPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the Fan model
   */
  interface FanFieldRefs {
    readonly fan_id: FieldRef<"Fan", 'Int'>
    readonly server_id: FieldRef<"Fan", 'Int'>
    readonly fan_catalog_id: FieldRef<"Fan", 'Int'>
    readonly fan_config_id: FieldRef<"Fan", 'Int'>
    readonly control_mode: FieldRef<"Fan", 'String'>
    readonly status: FieldRef<"Fan", 'String'>
    readonly speed_percent: FieldRef<"Fan", 'Int'>
    readonly created_at: FieldRef<"Fan", 'DateTime'>
  }
    

  // Custom InputTypes
  /**
   * Fan findUnique
   */
  export type FanFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * Filter, which Fan to fetch.
     */
    where: FanWhereUniqueInput
  }

  /**
   * Fan findUniqueOrThrow
   */
  export type FanFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * Filter, which Fan to fetch.
     */
    where: FanWhereUniqueInput
  }

  /**
   * Fan findFirst
   */
  export type FanFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * Filter, which Fan to fetch.
     */
    where?: FanWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Fans to fetch.
     */
    orderBy?: FanOrderByWithRelationInput | FanOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Fans.
     */
    cursor?: FanWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Fans from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Fans.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Fans.
     */
    distinct?: FanScalarFieldEnum | FanScalarFieldEnum[]
  }

  /**
   * Fan findFirstOrThrow
   */
  export type FanFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * Filter, which Fan to fetch.
     */
    where?: FanWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Fans to fetch.
     */
    orderBy?: FanOrderByWithRelationInput | FanOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Fans.
     */
    cursor?: FanWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Fans from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Fans.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Fans.
     */
    distinct?: FanScalarFieldEnum | FanScalarFieldEnum[]
  }

  /**
   * Fan findMany
   */
  export type FanFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * Filter, which Fans to fetch.
     */
    where?: FanWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Fans to fetch.
     */
    orderBy?: FanOrderByWithRelationInput | FanOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing Fans.
     */
    cursor?: FanWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Fans from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Fans.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Fans.
     */
    distinct?: FanScalarFieldEnum | FanScalarFieldEnum[]
  }

  /**
   * Fan create
   */
  export type FanCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * The data needed to create a Fan.
     */
    data: XOR<FanCreateInput, FanUncheckedCreateInput>
  }

  /**
   * Fan createMany
   */
  export type FanCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many Fans.
     */
    data: FanCreateManyInput | FanCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * Fan createManyAndReturn
   */
  export type FanCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * The data used to create many Fans.
     */
    data: FanCreateManyInput | FanCreateManyInput[]
    skipDuplicates?: boolean
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanIncludeCreateManyAndReturn<ExtArgs> | null
  }

  /**
   * Fan update
   */
  export type FanUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * The data needed to update a Fan.
     */
    data: XOR<FanUpdateInput, FanUncheckedUpdateInput>
    /**
     * Choose, which Fan to update.
     */
    where: FanWhereUniqueInput
  }

  /**
   * Fan updateMany
   */
  export type FanUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update Fans.
     */
    data: XOR<FanUpdateManyMutationInput, FanUncheckedUpdateManyInput>
    /**
     * Filter which Fans to update
     */
    where?: FanWhereInput
    /**
     * Limit how many Fans to update.
     */
    limit?: number
  }

  /**
   * Fan updateManyAndReturn
   */
  export type FanUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * The data used to update Fans.
     */
    data: XOR<FanUpdateManyMutationInput, FanUncheckedUpdateManyInput>
    /**
     * Filter which Fans to update
     */
    where?: FanWhereInput
    /**
     * Limit how many Fans to update.
     */
    limit?: number
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanIncludeUpdateManyAndReturn<ExtArgs> | null
  }

  /**
   * Fan upsert
   */
  export type FanUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * The filter to search for the Fan to update in case it exists.
     */
    where: FanWhereUniqueInput
    /**
     * In case the Fan found by the `where` argument doesn't exist, create a new Fan with this data.
     */
    create: XOR<FanCreateInput, FanUncheckedCreateInput>
    /**
     * In case the Fan was found with the provided `where` argument, update it with this data.
     */
    update: XOR<FanUpdateInput, FanUncheckedUpdateInput>
  }

  /**
   * Fan delete
   */
  export type FanDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
    /**
     * Filter which Fan to delete.
     */
    where: FanWhereUniqueInput
  }

  /**
   * Fan deleteMany
   */
  export type FanDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Fans to delete
     */
    where?: FanWhereInput
    /**
     * Limit how many Fans to delete.
     */
    limit?: number
  }

  /**
   * Fan.catalog_info
   */
  export type Fan$catalog_infoArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanCatalog
     */
    select?: FanCatalogSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanCatalog
     */
    omit?: FanCatalogOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanCatalogInclude<ExtArgs> | null
    where?: FanCatalogWhereInput
  }

  /**
   * Fan.fan_config
   */
  export type Fan$fan_configArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the FanConfiguration
     */
    select?: FanConfigurationSelect<ExtArgs> | null
    /**
     * Omit specific fields from the FanConfiguration
     */
    omit?: FanConfigurationOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanConfigurationInclude<ExtArgs> | null
    where?: FanConfigurationWhereInput
  }

  /**
   * Fan without action
   */
  export type FanDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Fan
     */
    select?: FanSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Fan
     */
    omit?: FanOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: FanInclude<ExtArgs> | null
  }


  /**
   * Model Sensor
   */

  export type AggregateSensor = {
    _count: SensorCountAggregateOutputType | null
    _avg: SensorAvgAggregateOutputType | null
    _sum: SensorSumAggregateOutputType | null
    _min: SensorMinAggregateOutputType | null
    _max: SensorMaxAggregateOutputType | null
  }

  export type SensorAvgAggregateOutputType = {
    sensor_id: number | null
    server_id: number | null
    last_value: number | null
  }

  export type SensorSumAggregateOutputType = {
    sensor_id: number | null
    server_id: number | null
    last_value: number | null
  }

  export type SensorMinAggregateOutputType = {
    sensor_id: number | null
    server_id: number | null
    sensor_type: string | null
    unit: string | null
    last_value: number | null
    created_at: Date | null
  }

  export type SensorMaxAggregateOutputType = {
    sensor_id: number | null
    server_id: number | null
    sensor_type: string | null
    unit: string | null
    last_value: number | null
    created_at: Date | null
  }

  export type SensorCountAggregateOutputType = {
    sensor_id: number
    server_id: number
    sensor_type: number
    unit: number
    last_value: number
    created_at: number
    _all: number
  }


  export type SensorAvgAggregateInputType = {
    sensor_id?: true
    server_id?: true
    last_value?: true
  }

  export type SensorSumAggregateInputType = {
    sensor_id?: true
    server_id?: true
    last_value?: true
  }

  export type SensorMinAggregateInputType = {
    sensor_id?: true
    server_id?: true
    sensor_type?: true
    unit?: true
    last_value?: true
    created_at?: true
  }

  export type SensorMaxAggregateInputType = {
    sensor_id?: true
    server_id?: true
    sensor_type?: true
    unit?: true
    last_value?: true
    created_at?: true
  }

  export type SensorCountAggregateInputType = {
    sensor_id?: true
    server_id?: true
    sensor_type?: true
    unit?: true
    last_value?: true
    created_at?: true
    _all?: true
  }

  export type SensorAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Sensor to aggregate.
     */
    where?: SensorWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Sensors to fetch.
     */
    orderBy?: SensorOrderByWithRelationInput | SensorOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: SensorWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Sensors from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Sensors.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned Sensors
    **/
    _count?: true | SensorCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: SensorAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: SensorSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: SensorMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: SensorMaxAggregateInputType
  }

  export type GetSensorAggregateType<T extends SensorAggregateArgs> = {
        [P in keyof T & keyof AggregateSensor]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateSensor[P]>
      : GetScalarType<T[P], AggregateSensor[P]>
  }




  export type SensorGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: SensorWhereInput
    orderBy?: SensorOrderByWithAggregationInput | SensorOrderByWithAggregationInput[]
    by: SensorScalarFieldEnum[] | SensorScalarFieldEnum
    having?: SensorScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: SensorCountAggregateInputType | true
    _avg?: SensorAvgAggregateInputType
    _sum?: SensorSumAggregateInputType
    _min?: SensorMinAggregateInputType
    _max?: SensorMaxAggregateInputType
  }

  export type SensorGroupByOutputType = {
    sensor_id: number
    server_id: number
    sensor_type: string
    unit: string
    last_value: number | null
    created_at: Date
    _count: SensorCountAggregateOutputType | null
    _avg: SensorAvgAggregateOutputType | null
    _sum: SensorSumAggregateOutputType | null
    _min: SensorMinAggregateOutputType | null
    _max: SensorMaxAggregateOutputType | null
  }

  type GetSensorGroupByPayload<T extends SensorGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<SensorGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof SensorGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], SensorGroupByOutputType[P]>
            : GetScalarType<T[P], SensorGroupByOutputType[P]>
        }
      >
    >


  export type SensorSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    sensor_id?: boolean
    server_id?: boolean
    sensor_type?: boolean
    unit?: boolean
    last_value?: boolean
    created_at?: boolean
    server?: boolean | ServerDefaultArgs<ExtArgs>
    data?: boolean | Sensor$dataArgs<ExtArgs>
    _count?: boolean | SensorCountOutputTypeDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["sensor"]>

  export type SensorSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    sensor_id?: boolean
    server_id?: boolean
    sensor_type?: boolean
    unit?: boolean
    last_value?: boolean
    created_at?: boolean
    server?: boolean | ServerDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["sensor"]>

  export type SensorSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    sensor_id?: boolean
    server_id?: boolean
    sensor_type?: boolean
    unit?: boolean
    last_value?: boolean
    created_at?: boolean
    server?: boolean | ServerDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["sensor"]>

  export type SensorSelectScalar = {
    sensor_id?: boolean
    server_id?: boolean
    sensor_type?: boolean
    unit?: boolean
    last_value?: boolean
    created_at?: boolean
  }

  export type SensorOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"sensor_id" | "server_id" | "sensor_type" | "unit" | "last_value" | "created_at", ExtArgs["result"]["sensor"]>
  export type SensorInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    server?: boolean | ServerDefaultArgs<ExtArgs>
    data?: boolean | Sensor$dataArgs<ExtArgs>
    _count?: boolean | SensorCountOutputTypeDefaultArgs<ExtArgs>
  }
  export type SensorIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    server?: boolean | ServerDefaultArgs<ExtArgs>
  }
  export type SensorIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    server?: boolean | ServerDefaultArgs<ExtArgs>
  }

  export type $SensorPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "Sensor"
    objects: {
      server: Prisma.$ServerPayload<ExtArgs>
      data: Prisma.$SensorDataPayload<ExtArgs>[]
    }
    scalars: $Extensions.GetPayloadResult<{
      sensor_id: number
      server_id: number
      sensor_type: string
      unit: string
      last_value: number | null
      created_at: Date
    }, ExtArgs["result"]["sensor"]>
    composites: {}
  }

  type SensorGetPayload<S extends boolean | null | undefined | SensorDefaultArgs> = $Result.GetResult<Prisma.$SensorPayload, S>

  type SensorCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<SensorFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: SensorCountAggregateInputType | true
    }

  export interface SensorDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['Sensor'], meta: { name: 'Sensor' } }
    /**
     * Find zero or one Sensor that matches the filter.
     * @param {SensorFindUniqueArgs} args - Arguments to find a Sensor
     * @example
     * // Get one Sensor
     * const sensor = await prisma.sensor.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends SensorFindUniqueArgs>(args: SelectSubset<T, SensorFindUniqueArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one Sensor that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {SensorFindUniqueOrThrowArgs} args - Arguments to find a Sensor
     * @example
     * // Get one Sensor
     * const sensor = await prisma.sensor.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends SensorFindUniqueOrThrowArgs>(args: SelectSubset<T, SensorFindUniqueOrThrowArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Sensor that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorFindFirstArgs} args - Arguments to find a Sensor
     * @example
     * // Get one Sensor
     * const sensor = await prisma.sensor.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends SensorFindFirstArgs>(args?: SelectSubset<T, SensorFindFirstArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first Sensor that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorFindFirstOrThrowArgs} args - Arguments to find a Sensor
     * @example
     * // Get one Sensor
     * const sensor = await prisma.sensor.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends SensorFindFirstOrThrowArgs>(args?: SelectSubset<T, SensorFindFirstOrThrowArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more Sensors that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all Sensors
     * const sensors = await prisma.sensor.findMany()
     * 
     * // Get first 10 Sensors
     * const sensors = await prisma.sensor.findMany({ take: 10 })
     * 
     * // Only select the `sensor_id`
     * const sensorWithSensor_idOnly = await prisma.sensor.findMany({ select: { sensor_id: true } })
     * 
     */
    findMany<T extends SensorFindManyArgs>(args?: SelectSubset<T, SensorFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a Sensor.
     * @param {SensorCreateArgs} args - Arguments to create a Sensor.
     * @example
     * // Create one Sensor
     * const Sensor = await prisma.sensor.create({
     *   data: {
     *     // ... data to create a Sensor
     *   }
     * })
     * 
     */
    create<T extends SensorCreateArgs>(args: SelectSubset<T, SensorCreateArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many Sensors.
     * @param {SensorCreateManyArgs} args - Arguments to create many Sensors.
     * @example
     * // Create many Sensors
     * const sensor = await prisma.sensor.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends SensorCreateManyArgs>(args?: SelectSubset<T, SensorCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many Sensors and returns the data saved in the database.
     * @param {SensorCreateManyAndReturnArgs} args - Arguments to create many Sensors.
     * @example
     * // Create many Sensors
     * const sensor = await prisma.sensor.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many Sensors and only return the `sensor_id`
     * const sensorWithSensor_idOnly = await prisma.sensor.createManyAndReturn({
     *   select: { sensor_id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends SensorCreateManyAndReturnArgs>(args?: SelectSubset<T, SensorCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a Sensor.
     * @param {SensorDeleteArgs} args - Arguments to delete one Sensor.
     * @example
     * // Delete one Sensor
     * const Sensor = await prisma.sensor.delete({
     *   where: {
     *     // ... filter to delete one Sensor
     *   }
     * })
     * 
     */
    delete<T extends SensorDeleteArgs>(args: SelectSubset<T, SensorDeleteArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one Sensor.
     * @param {SensorUpdateArgs} args - Arguments to update one Sensor.
     * @example
     * // Update one Sensor
     * const sensor = await prisma.sensor.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends SensorUpdateArgs>(args: SelectSubset<T, SensorUpdateArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more Sensors.
     * @param {SensorDeleteManyArgs} args - Arguments to filter Sensors to delete.
     * @example
     * // Delete a few Sensors
     * const { count } = await prisma.sensor.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends SensorDeleteManyArgs>(args?: SelectSubset<T, SensorDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Sensors.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many Sensors
     * const sensor = await prisma.sensor.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends SensorUpdateManyArgs>(args: SelectSubset<T, SensorUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more Sensors and returns the data updated in the database.
     * @param {SensorUpdateManyAndReturnArgs} args - Arguments to update many Sensors.
     * @example
     * // Update many Sensors
     * const sensor = await prisma.sensor.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more Sensors and only return the `sensor_id`
     * const sensorWithSensor_idOnly = await prisma.sensor.updateManyAndReturn({
     *   select: { sensor_id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends SensorUpdateManyAndReturnArgs>(args: SelectSubset<T, SensorUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one Sensor.
     * @param {SensorUpsertArgs} args - Arguments to update or create a Sensor.
     * @example
     * // Update or create a Sensor
     * const sensor = await prisma.sensor.upsert({
     *   create: {
     *     // ... data to create a Sensor
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the Sensor we want to update
     *   }
     * })
     */
    upsert<T extends SensorUpsertArgs>(args: SelectSubset<T, SensorUpsertArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of Sensors.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorCountArgs} args - Arguments to filter Sensors to count.
     * @example
     * // Count the number of Sensors
     * const count = await prisma.sensor.count({
     *   where: {
     *     // ... the filter for the Sensors we want to count
     *   }
     * })
    **/
    count<T extends SensorCountArgs>(
      args?: Subset<T, SensorCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], SensorCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a Sensor.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends SensorAggregateArgs>(args: Subset<T, SensorAggregateArgs>): Prisma.PrismaPromise<GetSensorAggregateType<T>>

    /**
     * Group by Sensor.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends SensorGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: SensorGroupByArgs['orderBy'] }
        : { orderBy?: SensorGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, SensorGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetSensorGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the Sensor model
   */
  readonly fields: SensorFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for Sensor.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__SensorClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    server<T extends ServerDefaultArgs<ExtArgs> = {}>(args?: Subset<T, ServerDefaultArgs<ExtArgs>>): Prisma__ServerClient<$Result.GetResult<Prisma.$ServerPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>
    data<T extends Sensor$dataArgs<ExtArgs> = {}>(args?: Subset<T, Sensor$dataArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the Sensor model
   */
  interface SensorFieldRefs {
    readonly sensor_id: FieldRef<"Sensor", 'Int'>
    readonly server_id: FieldRef<"Sensor", 'Int'>
    readonly sensor_type: FieldRef<"Sensor", 'String'>
    readonly unit: FieldRef<"Sensor", 'String'>
    readonly last_value: FieldRef<"Sensor", 'Float'>
    readonly created_at: FieldRef<"Sensor", 'DateTime'>
  }
    

  // Custom InputTypes
  /**
   * Sensor findUnique
   */
  export type SensorFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * Filter, which Sensor to fetch.
     */
    where: SensorWhereUniqueInput
  }

  /**
   * Sensor findUniqueOrThrow
   */
  export type SensorFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * Filter, which Sensor to fetch.
     */
    where: SensorWhereUniqueInput
  }

  /**
   * Sensor findFirst
   */
  export type SensorFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * Filter, which Sensor to fetch.
     */
    where?: SensorWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Sensors to fetch.
     */
    orderBy?: SensorOrderByWithRelationInput | SensorOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Sensors.
     */
    cursor?: SensorWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Sensors from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Sensors.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Sensors.
     */
    distinct?: SensorScalarFieldEnum | SensorScalarFieldEnum[]
  }

  /**
   * Sensor findFirstOrThrow
   */
  export type SensorFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * Filter, which Sensor to fetch.
     */
    where?: SensorWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Sensors to fetch.
     */
    orderBy?: SensorOrderByWithRelationInput | SensorOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for Sensors.
     */
    cursor?: SensorWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Sensors from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Sensors.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Sensors.
     */
    distinct?: SensorScalarFieldEnum | SensorScalarFieldEnum[]
  }

  /**
   * Sensor findMany
   */
  export type SensorFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * Filter, which Sensors to fetch.
     */
    where?: SensorWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of Sensors to fetch.
     */
    orderBy?: SensorOrderByWithRelationInput | SensorOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing Sensors.
     */
    cursor?: SensorWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` Sensors from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` Sensors.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of Sensors.
     */
    distinct?: SensorScalarFieldEnum | SensorScalarFieldEnum[]
  }

  /**
   * Sensor create
   */
  export type SensorCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * The data needed to create a Sensor.
     */
    data: XOR<SensorCreateInput, SensorUncheckedCreateInput>
  }

  /**
   * Sensor createMany
   */
  export type SensorCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many Sensors.
     */
    data: SensorCreateManyInput | SensorCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * Sensor createManyAndReturn
   */
  export type SensorCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * The data used to create many Sensors.
     */
    data: SensorCreateManyInput | SensorCreateManyInput[]
    skipDuplicates?: boolean
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorIncludeCreateManyAndReturn<ExtArgs> | null
  }

  /**
   * Sensor update
   */
  export type SensorUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * The data needed to update a Sensor.
     */
    data: XOR<SensorUpdateInput, SensorUncheckedUpdateInput>
    /**
     * Choose, which Sensor to update.
     */
    where: SensorWhereUniqueInput
  }

  /**
   * Sensor updateMany
   */
  export type SensorUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update Sensors.
     */
    data: XOR<SensorUpdateManyMutationInput, SensorUncheckedUpdateManyInput>
    /**
     * Filter which Sensors to update
     */
    where?: SensorWhereInput
    /**
     * Limit how many Sensors to update.
     */
    limit?: number
  }

  /**
   * Sensor updateManyAndReturn
   */
  export type SensorUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * The data used to update Sensors.
     */
    data: XOR<SensorUpdateManyMutationInput, SensorUncheckedUpdateManyInput>
    /**
     * Filter which Sensors to update
     */
    where?: SensorWhereInput
    /**
     * Limit how many Sensors to update.
     */
    limit?: number
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorIncludeUpdateManyAndReturn<ExtArgs> | null
  }

  /**
   * Sensor upsert
   */
  export type SensorUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * The filter to search for the Sensor to update in case it exists.
     */
    where: SensorWhereUniqueInput
    /**
     * In case the Sensor found by the `where` argument doesn't exist, create a new Sensor with this data.
     */
    create: XOR<SensorCreateInput, SensorUncheckedCreateInput>
    /**
     * In case the Sensor was found with the provided `where` argument, update it with this data.
     */
    update: XOR<SensorUpdateInput, SensorUncheckedUpdateInput>
  }

  /**
   * Sensor delete
   */
  export type SensorDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
    /**
     * Filter which Sensor to delete.
     */
    where: SensorWhereUniqueInput
  }

  /**
   * Sensor deleteMany
   */
  export type SensorDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which Sensors to delete
     */
    where?: SensorWhereInput
    /**
     * Limit how many Sensors to delete.
     */
    limit?: number
  }

  /**
   * Sensor.data
   */
  export type Sensor$dataArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    where?: SensorDataWhereInput
    orderBy?: SensorDataOrderByWithRelationInput | SensorDataOrderByWithRelationInput[]
    cursor?: SensorDataWhereUniqueInput
    take?: number
    skip?: number
    distinct?: SensorDataScalarFieldEnum | SensorDataScalarFieldEnum[]
  }

  /**
   * Sensor without action
   */
  export type SensorDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Sensor
     */
    select?: SensorSelect<ExtArgs> | null
    /**
     * Omit specific fields from the Sensor
     */
    omit?: SensorOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorInclude<ExtArgs> | null
  }


  /**
   * Model SensorData
   */

  export type AggregateSensorData = {
    _count: SensorDataCountAggregateOutputType | null
    _avg: SensorDataAvgAggregateOutputType | null
    _sum: SensorDataSumAggregateOutputType | null
    _min: SensorDataMinAggregateOutputType | null
    _max: SensorDataMaxAggregateOutputType | null
  }

  export type SensorDataAvgAggregateOutputType = {
    id: number | null
    sensor_id: number | null
    value: number | null
  }

  export type SensorDataSumAggregateOutputType = {
    id: number | null
    sensor_id: number | null
    value: number | null
  }

  export type SensorDataMinAggregateOutputType = {
    id: number | null
    time: Date | null
    sensor_id: number | null
    value: number | null
  }

  export type SensorDataMaxAggregateOutputType = {
    id: number | null
    time: Date | null
    sensor_id: number | null
    value: number | null
  }

  export type SensorDataCountAggregateOutputType = {
    id: number
    time: number
    sensor_id: number
    value: number
    _all: number
  }


  export type SensorDataAvgAggregateInputType = {
    id?: true
    sensor_id?: true
    value?: true
  }

  export type SensorDataSumAggregateInputType = {
    id?: true
    sensor_id?: true
    value?: true
  }

  export type SensorDataMinAggregateInputType = {
    id?: true
    time?: true
    sensor_id?: true
    value?: true
  }

  export type SensorDataMaxAggregateInputType = {
    id?: true
    time?: true
    sensor_id?: true
    value?: true
  }

  export type SensorDataCountAggregateInputType = {
    id?: true
    time?: true
    sensor_id?: true
    value?: true
    _all?: true
  }

  export type SensorDataAggregateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which SensorData to aggregate.
     */
    where?: SensorDataWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of SensorData to fetch.
     */
    orderBy?: SensorDataOrderByWithRelationInput | SensorDataOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the start position
     */
    cursor?: SensorDataWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` SensorData from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` SensorData.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Count returned SensorData
    **/
    _count?: true | SensorDataCountAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to average
    **/
    _avg?: SensorDataAvgAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to sum
    **/
    _sum?: SensorDataSumAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the minimum value
    **/
    _min?: SensorDataMinAggregateInputType
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     * 
     * Select which fields to find the maximum value
    **/
    _max?: SensorDataMaxAggregateInputType
  }

  export type GetSensorDataAggregateType<T extends SensorDataAggregateArgs> = {
        [P in keyof T & keyof AggregateSensorData]: P extends '_count' | 'count'
      ? T[P] extends true
        ? number
        : GetScalarType<T[P], AggregateSensorData[P]>
      : GetScalarType<T[P], AggregateSensorData[P]>
  }




  export type SensorDataGroupByArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    where?: SensorDataWhereInput
    orderBy?: SensorDataOrderByWithAggregationInput | SensorDataOrderByWithAggregationInput[]
    by: SensorDataScalarFieldEnum[] | SensorDataScalarFieldEnum
    having?: SensorDataScalarWhereWithAggregatesInput
    take?: number
    skip?: number
    _count?: SensorDataCountAggregateInputType | true
    _avg?: SensorDataAvgAggregateInputType
    _sum?: SensorDataSumAggregateInputType
    _min?: SensorDataMinAggregateInputType
    _max?: SensorDataMaxAggregateInputType
  }

  export type SensorDataGroupByOutputType = {
    id: number
    time: Date
    sensor_id: number
    value: number
    _count: SensorDataCountAggregateOutputType | null
    _avg: SensorDataAvgAggregateOutputType | null
    _sum: SensorDataSumAggregateOutputType | null
    _min: SensorDataMinAggregateOutputType | null
    _max: SensorDataMaxAggregateOutputType | null
  }

  type GetSensorDataGroupByPayload<T extends SensorDataGroupByArgs> = Prisma.PrismaPromise<
    Array<
      PickEnumerable<SensorDataGroupByOutputType, T['by']> &
        {
          [P in ((keyof T) & (keyof SensorDataGroupByOutputType))]: P extends '_count'
            ? T[P] extends boolean
              ? number
              : GetScalarType<T[P], SensorDataGroupByOutputType[P]>
            : GetScalarType<T[P], SensorDataGroupByOutputType[P]>
        }
      >
    >


  export type SensorDataSelect<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    id?: boolean
    time?: boolean
    sensor_id?: boolean
    value?: boolean
    sensor?: boolean | SensorDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["sensorData"]>

  export type SensorDataSelectCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    id?: boolean
    time?: boolean
    sensor_id?: boolean
    value?: boolean
    sensor?: boolean | SensorDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["sensorData"]>

  export type SensorDataSelectUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetSelect<{
    id?: boolean
    time?: boolean
    sensor_id?: boolean
    value?: boolean
    sensor?: boolean | SensorDefaultArgs<ExtArgs>
  }, ExtArgs["result"]["sensorData"]>

  export type SensorDataSelectScalar = {
    id?: boolean
    time?: boolean
    sensor_id?: boolean
    value?: boolean
  }

  export type SensorDataOmit<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = $Extensions.GetOmit<"id" | "time" | "sensor_id" | "value", ExtArgs["result"]["sensorData"]>
  export type SensorDataInclude<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    sensor?: boolean | SensorDefaultArgs<ExtArgs>
  }
  export type SensorDataIncludeCreateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    sensor?: boolean | SensorDefaultArgs<ExtArgs>
  }
  export type SensorDataIncludeUpdateManyAndReturn<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    sensor?: boolean | SensorDefaultArgs<ExtArgs>
  }

  export type $SensorDataPayload<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    name: "SensorData"
    objects: {
      sensor: Prisma.$SensorPayload<ExtArgs>
    }
    scalars: $Extensions.GetPayloadResult<{
      id: number
      time: Date
      sensor_id: number
      value: number
    }, ExtArgs["result"]["sensorData"]>
    composites: {}
  }

  type SensorDataGetPayload<S extends boolean | null | undefined | SensorDataDefaultArgs> = $Result.GetResult<Prisma.$SensorDataPayload, S>

  type SensorDataCountArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> =
    Omit<SensorDataFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
      select?: SensorDataCountAggregateInputType | true
    }

  export interface SensorDataDelegate<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: { types: Prisma.TypeMap<ExtArgs>['model']['SensorData'], meta: { name: 'SensorData' } }
    /**
     * Find zero or one SensorData that matches the filter.
     * @param {SensorDataFindUniqueArgs} args - Arguments to find a SensorData
     * @example
     * // Get one SensorData
     * const sensorData = await prisma.sensorData.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends SensorDataFindUniqueArgs>(args: SelectSubset<T, SensorDataFindUniqueArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find one SensorData that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {SensorDataFindUniqueOrThrowArgs} args - Arguments to find a SensorData
     * @example
     * // Get one SensorData
     * const sensorData = await prisma.sensorData.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends SensorDataFindUniqueOrThrowArgs>(args: SelectSubset<T, SensorDataFindUniqueOrThrowArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first SensorData that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorDataFindFirstArgs} args - Arguments to find a SensorData
     * @example
     * // Get one SensorData
     * const sensorData = await prisma.sensorData.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends SensorDataFindFirstArgs>(args?: SelectSubset<T, SensorDataFindFirstArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>

    /**
     * Find the first SensorData that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorDataFindFirstOrThrowArgs} args - Arguments to find a SensorData
     * @example
     * // Get one SensorData
     * const sensorData = await prisma.sensorData.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends SensorDataFindFirstOrThrowArgs>(args?: SelectSubset<T, SensorDataFindFirstOrThrowArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Find zero or more SensorData that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorDataFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all SensorData
     * const sensorData = await prisma.sensorData.findMany()
     * 
     * // Get first 10 SensorData
     * const sensorData = await prisma.sensorData.findMany({ take: 10 })
     * 
     * // Only select the `id`
     * const sensorDataWithIdOnly = await prisma.sensorData.findMany({ select: { id: true } })
     * 
     */
    findMany<T extends SensorDataFindManyArgs>(args?: SelectSubset<T, SensorDataFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>

    /**
     * Create a SensorData.
     * @param {SensorDataCreateArgs} args - Arguments to create a SensorData.
     * @example
     * // Create one SensorData
     * const SensorData = await prisma.sensorData.create({
     *   data: {
     *     // ... data to create a SensorData
     *   }
     * })
     * 
     */
    create<T extends SensorDataCreateArgs>(args: SelectSubset<T, SensorDataCreateArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Create many SensorData.
     * @param {SensorDataCreateManyArgs} args - Arguments to create many SensorData.
     * @example
     * // Create many SensorData
     * const sensorData = await prisma.sensorData.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *     
     */
    createMany<T extends SensorDataCreateManyArgs>(args?: SelectSubset<T, SensorDataCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Create many SensorData and returns the data saved in the database.
     * @param {SensorDataCreateManyAndReturnArgs} args - Arguments to create many SensorData.
     * @example
     * // Create many SensorData
     * const sensorData = await prisma.sensorData.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Create many SensorData and only return the `id`
     * const sensorDataWithIdOnly = await prisma.sensorData.createManyAndReturn({
     *   select: { id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    createManyAndReturn<T extends SensorDataCreateManyAndReturnArgs>(args?: SelectSubset<T, SensorDataCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>

    /**
     * Delete a SensorData.
     * @param {SensorDataDeleteArgs} args - Arguments to delete one SensorData.
     * @example
     * // Delete one SensorData
     * const SensorData = await prisma.sensorData.delete({
     *   where: {
     *     // ... filter to delete one SensorData
     *   }
     * })
     * 
     */
    delete<T extends SensorDataDeleteArgs>(args: SelectSubset<T, SensorDataDeleteArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Update one SensorData.
     * @param {SensorDataUpdateArgs} args - Arguments to update one SensorData.
     * @example
     * // Update one SensorData
     * const sensorData = await prisma.sensorData.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    update<T extends SensorDataUpdateArgs>(args: SelectSubset<T, SensorDataUpdateArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>

    /**
     * Delete zero or more SensorData.
     * @param {SensorDataDeleteManyArgs} args - Arguments to filter SensorData to delete.
     * @example
     * // Delete a few SensorData
     * const { count } = await prisma.sensorData.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     * 
     */
    deleteMany<T extends SensorDataDeleteManyArgs>(args?: SelectSubset<T, SensorDataDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more SensorData.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorDataUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many SensorData
     * const sensorData = await prisma.sensorData.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     * 
     */
    updateMany<T extends SensorDataUpdateManyArgs>(args: SelectSubset<T, SensorDataUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<BatchPayload>

    /**
     * Update zero or more SensorData and returns the data updated in the database.
     * @param {SensorDataUpdateManyAndReturnArgs} args - Arguments to update many SensorData.
     * @example
     * // Update many SensorData
     * const sensorData = await prisma.sensorData.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * 
     * // Update zero or more SensorData and only return the `id`
     * const sensorDataWithIdOnly = await prisma.sensorData.updateManyAndReturn({
     *   select: { id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * 
     */
    updateManyAndReturn<T extends SensorDataUpdateManyAndReturnArgs>(args: SelectSubset<T, SensorDataUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>

    /**
     * Create or update one SensorData.
     * @param {SensorDataUpsertArgs} args - Arguments to update or create a SensorData.
     * @example
     * // Update or create a SensorData
     * const sensorData = await prisma.sensorData.upsert({
     *   create: {
     *     // ... data to create a SensorData
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the SensorData we want to update
     *   }
     * })
     */
    upsert<T extends SensorDataUpsertArgs>(args: SelectSubset<T, SensorDataUpsertArgs<ExtArgs>>): Prisma__SensorDataClient<$Result.GetResult<Prisma.$SensorDataPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>


    /**
     * Count the number of SensorData.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorDataCountArgs} args - Arguments to filter SensorData to count.
     * @example
     * // Count the number of SensorData
     * const count = await prisma.sensorData.count({
     *   where: {
     *     // ... the filter for the SensorData we want to count
     *   }
     * })
    **/
    count<T extends SensorDataCountArgs>(
      args?: Subset<T, SensorDataCountArgs>,
    ): Prisma.PrismaPromise<
      T extends $Utils.Record<'select', any>
        ? T['select'] extends true
          ? number
          : GetScalarType<T['select'], SensorDataCountAggregateOutputType>
        : number
    >

    /**
     * Allows you to perform aggregations operations on a SensorData.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorDataAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends SensorDataAggregateArgs>(args: Subset<T, SensorDataAggregateArgs>): Prisma.PrismaPromise<GetSensorDataAggregateType<T>>

    /**
     * Group by SensorData.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {SensorDataGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     * 
    **/
    groupBy<
      T extends SensorDataGroupByArgs,
      HasSelectOrTake extends Or<
        Extends<'skip', Keys<T>>,
        Extends<'take', Keys<T>>
      >,
      OrderByArg extends True extends HasSelectOrTake
        ? { orderBy: SensorDataGroupByArgs['orderBy'] }
        : { orderBy?: SensorDataGroupByArgs['orderBy'] },
      OrderFields extends ExcludeUnderscoreKeys<Keys<MaybeTupleToUnion<T['orderBy']>>>,
      ByFields extends MaybeTupleToUnion<T['by']>,
      ByValid extends Has<ByFields, OrderFields>,
      HavingFields extends GetHavingFields<T['having']>,
      HavingValid extends Has<ByFields, HavingFields>,
      ByEmpty extends T['by'] extends never[] ? True : False,
      InputErrors extends ByEmpty extends True
      ? `Error: "by" must not be empty.`
      : HavingValid extends False
      ? {
          [P in HavingFields]: P extends ByFields
            ? never
            : P extends string
            ? `Error: Field "${P}" used in "having" needs to be provided in "by".`
            : [
                Error,
                'Field ',
                P,
                ` in "having" needs to be provided in "by"`,
              ]
        }[HavingFields]
      : 'take' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "take", you also need to provide "orderBy"'
      : 'skip' extends Keys<T>
      ? 'orderBy' extends Keys<T>
        ? ByValid extends True
          ? {}
          : {
              [P in OrderFields]: P extends ByFields
                ? never
                : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
            }[OrderFields]
        : 'Error: If you provide "skip", you also need to provide "orderBy"'
      : ByValid extends True
      ? {}
      : {
          [P in OrderFields]: P extends ByFields
            ? never
            : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`
        }[OrderFields]
    >(args: SubsetIntersection<T, SensorDataGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetSensorDataGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>
  /**
   * Fields of the SensorData model
   */
  readonly fields: SensorDataFieldRefs;
  }

  /**
   * The delegate class that acts as a "Promise-like" for SensorData.
   * Why is this prefixed with `Prisma__`?
   * Because we want to prevent naming conflicts as mentioned in
   * https://github.com/prisma/prisma-client-js/issues/707
   */
  export interface Prisma__SensorDataClient<T, Null = never, ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise"
    sensor<T extends SensorDefaultArgs<ExtArgs> = {}>(args?: Subset<T, SensorDefaultArgs<ExtArgs>>): Prisma__SensorClient<$Result.GetResult<Prisma.$SensorPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): $Utils.JsPromise<TResult1 | TResult2>
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): $Utils.JsPromise<T | TResult>
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): $Utils.JsPromise<T>
  }




  /**
   * Fields of the SensorData model
   */
  interface SensorDataFieldRefs {
    readonly id: FieldRef<"SensorData", 'Int'>
    readonly time: FieldRef<"SensorData", 'DateTime'>
    readonly sensor_id: FieldRef<"SensorData", 'Int'>
    readonly value: FieldRef<"SensorData", 'Float'>
  }
    

  // Custom InputTypes
  /**
   * SensorData findUnique
   */
  export type SensorDataFindUniqueArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * Filter, which SensorData to fetch.
     */
    where: SensorDataWhereUniqueInput
  }

  /**
   * SensorData findUniqueOrThrow
   */
  export type SensorDataFindUniqueOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * Filter, which SensorData to fetch.
     */
    where: SensorDataWhereUniqueInput
  }

  /**
   * SensorData findFirst
   */
  export type SensorDataFindFirstArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * Filter, which SensorData to fetch.
     */
    where?: SensorDataWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of SensorData to fetch.
     */
    orderBy?: SensorDataOrderByWithRelationInput | SensorDataOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for SensorData.
     */
    cursor?: SensorDataWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` SensorData from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` SensorData.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of SensorData.
     */
    distinct?: SensorDataScalarFieldEnum | SensorDataScalarFieldEnum[]
  }

  /**
   * SensorData findFirstOrThrow
   */
  export type SensorDataFindFirstOrThrowArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * Filter, which SensorData to fetch.
     */
    where?: SensorDataWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of SensorData to fetch.
     */
    orderBy?: SensorDataOrderByWithRelationInput | SensorDataOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for searching for SensorData.
     */
    cursor?: SensorDataWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` SensorData from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` SensorData.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of SensorData.
     */
    distinct?: SensorDataScalarFieldEnum | SensorDataScalarFieldEnum[]
  }

  /**
   * SensorData findMany
   */
  export type SensorDataFindManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * Filter, which SensorData to fetch.
     */
    where?: SensorDataWhereInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     * 
     * Determine the order of SensorData to fetch.
     */
    orderBy?: SensorDataOrderByWithRelationInput | SensorDataOrderByWithRelationInput[]
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     * 
     * Sets the position for listing SensorData.
     */
    cursor?: SensorDataWhereUniqueInput
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Take `±n` SensorData from the position of the cursor.
     */
    take?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     * 
     * Skip the first `n` SensorData.
     */
    skip?: number
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     * 
     * Filter by unique combinations of SensorData.
     */
    distinct?: SensorDataScalarFieldEnum | SensorDataScalarFieldEnum[]
  }

  /**
   * SensorData create
   */
  export type SensorDataCreateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * The data needed to create a SensorData.
     */
    data: XOR<SensorDataCreateInput, SensorDataUncheckedCreateInput>
  }

  /**
   * SensorData createMany
   */
  export type SensorDataCreateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to create many SensorData.
     */
    data: SensorDataCreateManyInput | SensorDataCreateManyInput[]
    skipDuplicates?: boolean
  }

  /**
   * SensorData createManyAndReturn
   */
  export type SensorDataCreateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelectCreateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * The data used to create many SensorData.
     */
    data: SensorDataCreateManyInput | SensorDataCreateManyInput[]
    skipDuplicates?: boolean
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataIncludeCreateManyAndReturn<ExtArgs> | null
  }

  /**
   * SensorData update
   */
  export type SensorDataUpdateArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * The data needed to update a SensorData.
     */
    data: XOR<SensorDataUpdateInput, SensorDataUncheckedUpdateInput>
    /**
     * Choose, which SensorData to update.
     */
    where: SensorDataWhereUniqueInput
  }

  /**
   * SensorData updateMany
   */
  export type SensorDataUpdateManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * The data used to update SensorData.
     */
    data: XOR<SensorDataUpdateManyMutationInput, SensorDataUncheckedUpdateManyInput>
    /**
     * Filter which SensorData to update
     */
    where?: SensorDataWhereInput
    /**
     * Limit how many SensorData to update.
     */
    limit?: number
  }

  /**
   * SensorData updateManyAndReturn
   */
  export type SensorDataUpdateManyAndReturnArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelectUpdateManyAndReturn<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * The data used to update SensorData.
     */
    data: XOR<SensorDataUpdateManyMutationInput, SensorDataUncheckedUpdateManyInput>
    /**
     * Filter which SensorData to update
     */
    where?: SensorDataWhereInput
    /**
     * Limit how many SensorData to update.
     */
    limit?: number
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataIncludeUpdateManyAndReturn<ExtArgs> | null
  }

  /**
   * SensorData upsert
   */
  export type SensorDataUpsertArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * The filter to search for the SensorData to update in case it exists.
     */
    where: SensorDataWhereUniqueInput
    /**
     * In case the SensorData found by the `where` argument doesn't exist, create a new SensorData with this data.
     */
    create: XOR<SensorDataCreateInput, SensorDataUncheckedCreateInput>
    /**
     * In case the SensorData was found with the provided `where` argument, update it with this data.
     */
    update: XOR<SensorDataUpdateInput, SensorDataUncheckedUpdateInput>
  }

  /**
   * SensorData delete
   */
  export type SensorDataDeleteArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
    /**
     * Filter which SensorData to delete.
     */
    where: SensorDataWhereUniqueInput
  }

  /**
   * SensorData deleteMany
   */
  export type SensorDataDeleteManyArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Filter which SensorData to delete
     */
    where?: SensorDataWhereInput
    /**
     * Limit how many SensorData to delete.
     */
    limit?: number
  }

  /**
   * SensorData without action
   */
  export type SensorDataDefaultArgs<ExtArgs extends $Extensions.InternalArgs = $Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the SensorData
     */
    select?: SensorDataSelect<ExtArgs> | null
    /**
     * Omit specific fields from the SensorData
     */
    omit?: SensorDataOmit<ExtArgs> | null
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: SensorDataInclude<ExtArgs> | null
  }


  /**
   * Enums
   */

  export const TransactionIsolationLevel: {
    ReadUncommitted: 'ReadUncommitted',
    ReadCommitted: 'ReadCommitted',
    RepeatableRead: 'RepeatableRead',
    Serializable: 'Serializable'
  };

  export type TransactionIsolationLevel = (typeof TransactionIsolationLevel)[keyof typeof TransactionIsolationLevel]


  export const ClusterLocationScalarFieldEnum: {
    location_id: 'location_id',
    name: 'name',
    location: 'location',
    env_factor: 'env_factor',
    cluster_count: 'cluster_count',
    created_at: 'created_at'
  };

  export type ClusterLocationScalarFieldEnum = (typeof ClusterLocationScalarFieldEnum)[keyof typeof ClusterLocationScalarFieldEnum]


  export const LoadProfileScalarFieldEnum: {
    id: 'id',
    name: 'name',
    hour: 'hour',
    expected_load_percent: 'expected_load_percent',
    target_temp_celsius: 'target_temp_celsius',
    standard_fan_speed: 'standard_fan_speed'
  };

  export type LoadProfileScalarFieldEnum = (typeof LoadProfileScalarFieldEnum)[keyof typeof LoadProfileScalarFieldEnum]


  export const FanConfigurationScalarFieldEnum: {
    fan_id: 'fan_id',
    name: 'name',
    consomation: 'consomation'
  };

  export type FanConfigurationScalarFieldEnum = (typeof FanConfigurationScalarFieldEnum)[keyof typeof FanConfigurationScalarFieldEnum]


  export const FanCatalogScalarFieldEnum: {
    fan_catalog_id: 'fan_catalog_id',
    model_name: 'model_name',
    consomation: 'consomation'
  };

  export type FanCatalogScalarFieldEnum = (typeof FanCatalogScalarFieldEnum)[keyof typeof FanCatalogScalarFieldEnum]


  export const CpuCoolerCatalogScalarFieldEnum: {
    cpu_cooler_catalog_id: 'cpu_cooler_catalog_id',
    model_name: 'model_name',
    type: 'type',
    thermal_capacity: 'thermal_capacity'
  };

  export type CpuCoolerCatalogScalarFieldEnum = (typeof CpuCoolerCatalogScalarFieldEnum)[keyof typeof CpuCoolerCatalogScalarFieldEnum]


  export const ClusterConfigurationScalarFieldEnum: {
    cluster_config_id: 'cluster_config_id',
    name: 'name',
    master: 'master',
    worker: 'worker',
    consomation_per_master: 'consomation_per_master',
    consomation_per_worker: 'consomation_per_worker',
    hardware_per_master: 'hardware_per_master',
    hardware_per_worker: 'hardware_per_worker',
    pue: 'pue',
    location_id: 'location_id',
    fan_id: 'fan_id',
    fan_count: 'fan_count',
    cpu_cooler_catalog_id: 'cpu_cooler_catalog_id',
    fan_catalog_id: 'fan_catalog_id',
    load_profile_id: 'load_profile_id'
  };

  export type ClusterConfigurationScalarFieldEnum = (typeof ClusterConfigurationScalarFieldEnum)[keyof typeof ClusterConfigurationScalarFieldEnum]


  export const ClusterScalarFieldEnum: {
    cluster_id: 'cluster_id',
    name: 'name',
    created_at: 'created_at',
    cluster_location_id: 'cluster_location_id'
  };

  export type ClusterScalarFieldEnum = (typeof ClusterScalarFieldEnum)[keyof typeof ClusterScalarFieldEnum]


  export const ServerScalarFieldEnum: {
    server_id: 'server_id',
    cluster_id: 'cluster_id',
    config_id: 'config_id',
    hostname: 'hostname',
    status: 'status',
    base_consumption_offset: 'base_consumption_offset',
    created_at: 'created_at'
  };

  export type ServerScalarFieldEnum = (typeof ServerScalarFieldEnum)[keyof typeof ServerScalarFieldEnum]


  export const FanScalarFieldEnum: {
    fan_id: 'fan_id',
    server_id: 'server_id',
    fan_catalog_id: 'fan_catalog_id',
    fan_config_id: 'fan_config_id',
    control_mode: 'control_mode',
    status: 'status',
    speed_percent: 'speed_percent',
    created_at: 'created_at'
  };

  export type FanScalarFieldEnum = (typeof FanScalarFieldEnum)[keyof typeof FanScalarFieldEnum]


  export const SensorScalarFieldEnum: {
    sensor_id: 'sensor_id',
    server_id: 'server_id',
    sensor_type: 'sensor_type',
    unit: 'unit',
    last_value: 'last_value',
    created_at: 'created_at'
  };

  export type SensorScalarFieldEnum = (typeof SensorScalarFieldEnum)[keyof typeof SensorScalarFieldEnum]


  export const SensorDataScalarFieldEnum: {
    id: 'id',
    time: 'time',
    sensor_id: 'sensor_id',
    value: 'value'
  };

  export type SensorDataScalarFieldEnum = (typeof SensorDataScalarFieldEnum)[keyof typeof SensorDataScalarFieldEnum]


  export const SortOrder: {
    asc: 'asc',
    desc: 'desc'
  };

  export type SortOrder = (typeof SortOrder)[keyof typeof SortOrder]


  export const QueryMode: {
    default: 'default',
    insensitive: 'insensitive'
  };

  export type QueryMode = (typeof QueryMode)[keyof typeof QueryMode]


  export const NullsOrder: {
    first: 'first',
    last: 'last'
  };

  export type NullsOrder = (typeof NullsOrder)[keyof typeof NullsOrder]


  /**
   * Field references
   */


  /**
   * Reference to a field of type 'Int'
   */
  export type IntFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Int'>
    


  /**
   * Reference to a field of type 'Int[]'
   */
  export type ListIntFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Int[]'>
    


  /**
   * Reference to a field of type 'String'
   */
  export type StringFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'String'>
    


  /**
   * Reference to a field of type 'String[]'
   */
  export type ListStringFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'String[]'>
    


  /**
   * Reference to a field of type 'Float'
   */
  export type FloatFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Float'>
    


  /**
   * Reference to a field of type 'Float[]'
   */
  export type ListFloatFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Float[]'>
    


  /**
   * Reference to a field of type 'DateTime'
   */
  export type DateTimeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'DateTime'>
    


  /**
   * Reference to a field of type 'DateTime[]'
   */
  export type ListDateTimeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'DateTime[]'>
    
  /**
   * Deep Input Types
   */


  export type ClusterLocationWhereInput = {
    AND?: ClusterLocationWhereInput | ClusterLocationWhereInput[]
    OR?: ClusterLocationWhereInput[]
    NOT?: ClusterLocationWhereInput | ClusterLocationWhereInput[]
    location_id?: IntFilter<"ClusterLocation"> | number
    name?: StringFilter<"ClusterLocation"> | string
    location?: StringNullableFilter<"ClusterLocation"> | string | null
    env_factor?: FloatFilter<"ClusterLocation"> | number
    cluster_count?: IntFilter<"ClusterLocation"> | number
    created_at?: DateTimeFilter<"ClusterLocation"> | Date | string
    cluster_configurations?: ClusterConfigurationListRelationFilter
    clusters?: ClusterListRelationFilter
  }

  export type ClusterLocationOrderByWithRelationInput = {
    location_id?: SortOrder
    name?: SortOrder
    location?: SortOrderInput | SortOrder
    env_factor?: SortOrder
    cluster_count?: SortOrder
    created_at?: SortOrder
    cluster_configurations?: ClusterConfigurationOrderByRelationAggregateInput
    clusters?: ClusterOrderByRelationAggregateInput
  }

  export type ClusterLocationWhereUniqueInput = Prisma.AtLeast<{
    location_id?: number
    name?: string
    AND?: ClusterLocationWhereInput | ClusterLocationWhereInput[]
    OR?: ClusterLocationWhereInput[]
    NOT?: ClusterLocationWhereInput | ClusterLocationWhereInput[]
    location?: StringNullableFilter<"ClusterLocation"> | string | null
    env_factor?: FloatFilter<"ClusterLocation"> | number
    cluster_count?: IntFilter<"ClusterLocation"> | number
    created_at?: DateTimeFilter<"ClusterLocation"> | Date | string
    cluster_configurations?: ClusterConfigurationListRelationFilter
    clusters?: ClusterListRelationFilter
  }, "location_id" | "name">

  export type ClusterLocationOrderByWithAggregationInput = {
    location_id?: SortOrder
    name?: SortOrder
    location?: SortOrderInput | SortOrder
    env_factor?: SortOrder
    cluster_count?: SortOrder
    created_at?: SortOrder
    _count?: ClusterLocationCountOrderByAggregateInput
    _avg?: ClusterLocationAvgOrderByAggregateInput
    _max?: ClusterLocationMaxOrderByAggregateInput
    _min?: ClusterLocationMinOrderByAggregateInput
    _sum?: ClusterLocationSumOrderByAggregateInput
  }

  export type ClusterLocationScalarWhereWithAggregatesInput = {
    AND?: ClusterLocationScalarWhereWithAggregatesInput | ClusterLocationScalarWhereWithAggregatesInput[]
    OR?: ClusterLocationScalarWhereWithAggregatesInput[]
    NOT?: ClusterLocationScalarWhereWithAggregatesInput | ClusterLocationScalarWhereWithAggregatesInput[]
    location_id?: IntWithAggregatesFilter<"ClusterLocation"> | number
    name?: StringWithAggregatesFilter<"ClusterLocation"> | string
    location?: StringNullableWithAggregatesFilter<"ClusterLocation"> | string | null
    env_factor?: FloatWithAggregatesFilter<"ClusterLocation"> | number
    cluster_count?: IntWithAggregatesFilter<"ClusterLocation"> | number
    created_at?: DateTimeWithAggregatesFilter<"ClusterLocation"> | Date | string
  }

  export type LoadProfileWhereInput = {
    AND?: LoadProfileWhereInput | LoadProfileWhereInput[]
    OR?: LoadProfileWhereInput[]
    NOT?: LoadProfileWhereInput | LoadProfileWhereInput[]
    id?: IntFilter<"LoadProfile"> | number
    name?: StringFilter<"LoadProfile"> | string
    hour?: IntFilter<"LoadProfile"> | number
    expected_load_percent?: FloatFilter<"LoadProfile"> | number
    target_temp_celsius?: FloatFilter<"LoadProfile"> | number
    standard_fan_speed?: StringFilter<"LoadProfile"> | string
    cluster_configurations?: ClusterConfigurationListRelationFilter
  }

  export type LoadProfileOrderByWithRelationInput = {
    id?: SortOrder
    name?: SortOrder
    hour?: SortOrder
    expected_load_percent?: SortOrder
    target_temp_celsius?: SortOrder
    standard_fan_speed?: SortOrder
    cluster_configurations?: ClusterConfigurationOrderByRelationAggregateInput
  }

  export type LoadProfileWhereUniqueInput = Prisma.AtLeast<{
    id?: number
    name_hour?: LoadProfileNameHourCompoundUniqueInput
    AND?: LoadProfileWhereInput | LoadProfileWhereInput[]
    OR?: LoadProfileWhereInput[]
    NOT?: LoadProfileWhereInput | LoadProfileWhereInput[]
    name?: StringFilter<"LoadProfile"> | string
    hour?: IntFilter<"LoadProfile"> | number
    expected_load_percent?: FloatFilter<"LoadProfile"> | number
    target_temp_celsius?: FloatFilter<"LoadProfile"> | number
    standard_fan_speed?: StringFilter<"LoadProfile"> | string
    cluster_configurations?: ClusterConfigurationListRelationFilter
  }, "id" | "name_hour">

  export type LoadProfileOrderByWithAggregationInput = {
    id?: SortOrder
    name?: SortOrder
    hour?: SortOrder
    expected_load_percent?: SortOrder
    target_temp_celsius?: SortOrder
    standard_fan_speed?: SortOrder
    _count?: LoadProfileCountOrderByAggregateInput
    _avg?: LoadProfileAvgOrderByAggregateInput
    _max?: LoadProfileMaxOrderByAggregateInput
    _min?: LoadProfileMinOrderByAggregateInput
    _sum?: LoadProfileSumOrderByAggregateInput
  }

  export type LoadProfileScalarWhereWithAggregatesInput = {
    AND?: LoadProfileScalarWhereWithAggregatesInput | LoadProfileScalarWhereWithAggregatesInput[]
    OR?: LoadProfileScalarWhereWithAggregatesInput[]
    NOT?: LoadProfileScalarWhereWithAggregatesInput | LoadProfileScalarWhereWithAggregatesInput[]
    id?: IntWithAggregatesFilter<"LoadProfile"> | number
    name?: StringWithAggregatesFilter<"LoadProfile"> | string
    hour?: IntWithAggregatesFilter<"LoadProfile"> | number
    expected_load_percent?: FloatWithAggregatesFilter<"LoadProfile"> | number
    target_temp_celsius?: FloatWithAggregatesFilter<"LoadProfile"> | number
    standard_fan_speed?: StringWithAggregatesFilter<"LoadProfile"> | string
  }

  export type FanConfigurationWhereInput = {
    AND?: FanConfigurationWhereInput | FanConfigurationWhereInput[]
    OR?: FanConfigurationWhereInput[]
    NOT?: FanConfigurationWhereInput | FanConfigurationWhereInput[]
    fan_id?: IntFilter<"FanConfiguration"> | number
    name?: StringFilter<"FanConfiguration"> | string
    consomation?: FloatNullableFilter<"FanConfiguration"> | number | null
    cluster_configurations?: ClusterConfigurationListRelationFilter
    fans?: FanListRelationFilter
  }

  export type FanConfigurationOrderByWithRelationInput = {
    fan_id?: SortOrder
    name?: SortOrder
    consomation?: SortOrderInput | SortOrder
    cluster_configurations?: ClusterConfigurationOrderByRelationAggregateInput
    fans?: FanOrderByRelationAggregateInput
  }

  export type FanConfigurationWhereUniqueInput = Prisma.AtLeast<{
    fan_id?: number
    name?: string
    AND?: FanConfigurationWhereInput | FanConfigurationWhereInput[]
    OR?: FanConfigurationWhereInput[]
    NOT?: FanConfigurationWhereInput | FanConfigurationWhereInput[]
    consomation?: FloatNullableFilter<"FanConfiguration"> | number | null
    cluster_configurations?: ClusterConfigurationListRelationFilter
    fans?: FanListRelationFilter
  }, "fan_id" | "name">

  export type FanConfigurationOrderByWithAggregationInput = {
    fan_id?: SortOrder
    name?: SortOrder
    consomation?: SortOrderInput | SortOrder
    _count?: FanConfigurationCountOrderByAggregateInput
    _avg?: FanConfigurationAvgOrderByAggregateInput
    _max?: FanConfigurationMaxOrderByAggregateInput
    _min?: FanConfigurationMinOrderByAggregateInput
    _sum?: FanConfigurationSumOrderByAggregateInput
  }

  export type FanConfigurationScalarWhereWithAggregatesInput = {
    AND?: FanConfigurationScalarWhereWithAggregatesInput | FanConfigurationScalarWhereWithAggregatesInput[]
    OR?: FanConfigurationScalarWhereWithAggregatesInput[]
    NOT?: FanConfigurationScalarWhereWithAggregatesInput | FanConfigurationScalarWhereWithAggregatesInput[]
    fan_id?: IntWithAggregatesFilter<"FanConfiguration"> | number
    name?: StringWithAggregatesFilter<"FanConfiguration"> | string
    consomation?: FloatNullableWithAggregatesFilter<"FanConfiguration"> | number | null
  }

  export type FanCatalogWhereInput = {
    AND?: FanCatalogWhereInput | FanCatalogWhereInput[]
    OR?: FanCatalogWhereInput[]
    NOT?: FanCatalogWhereInput | FanCatalogWhereInput[]
    fan_catalog_id?: IntFilter<"FanCatalog"> | number
    model_name?: StringFilter<"FanCatalog"> | string
    consomation?: FloatNullableFilter<"FanCatalog"> | number | null
    cluster_configurations?: ClusterConfigurationListRelationFilter
    fans?: FanListRelationFilter
  }

  export type FanCatalogOrderByWithRelationInput = {
    fan_catalog_id?: SortOrder
    model_name?: SortOrder
    consomation?: SortOrderInput | SortOrder
    cluster_configurations?: ClusterConfigurationOrderByRelationAggregateInput
    fans?: FanOrderByRelationAggregateInput
  }

  export type FanCatalogWhereUniqueInput = Prisma.AtLeast<{
    fan_catalog_id?: number
    model_name?: string
    AND?: FanCatalogWhereInput | FanCatalogWhereInput[]
    OR?: FanCatalogWhereInput[]
    NOT?: FanCatalogWhereInput | FanCatalogWhereInput[]
    consomation?: FloatNullableFilter<"FanCatalog"> | number | null
    cluster_configurations?: ClusterConfigurationListRelationFilter
    fans?: FanListRelationFilter
  }, "fan_catalog_id" | "model_name">

  export type FanCatalogOrderByWithAggregationInput = {
    fan_catalog_id?: SortOrder
    model_name?: SortOrder
    consomation?: SortOrderInput | SortOrder
    _count?: FanCatalogCountOrderByAggregateInput
    _avg?: FanCatalogAvgOrderByAggregateInput
    _max?: FanCatalogMaxOrderByAggregateInput
    _min?: FanCatalogMinOrderByAggregateInput
    _sum?: FanCatalogSumOrderByAggregateInput
  }

  export type FanCatalogScalarWhereWithAggregatesInput = {
    AND?: FanCatalogScalarWhereWithAggregatesInput | FanCatalogScalarWhereWithAggregatesInput[]
    OR?: FanCatalogScalarWhereWithAggregatesInput[]
    NOT?: FanCatalogScalarWhereWithAggregatesInput | FanCatalogScalarWhereWithAggregatesInput[]
    fan_catalog_id?: IntWithAggregatesFilter<"FanCatalog"> | number
    model_name?: StringWithAggregatesFilter<"FanCatalog"> | string
    consomation?: FloatNullableWithAggregatesFilter<"FanCatalog"> | number | null
  }

  export type CpuCoolerCatalogWhereInput = {
    AND?: CpuCoolerCatalogWhereInput | CpuCoolerCatalogWhereInput[]
    OR?: CpuCoolerCatalogWhereInput[]
    NOT?: CpuCoolerCatalogWhereInput | CpuCoolerCatalogWhereInput[]
    cpu_cooler_catalog_id?: IntFilter<"CpuCoolerCatalog"> | number
    model_name?: StringFilter<"CpuCoolerCatalog"> | string
    type?: StringFilter<"CpuCoolerCatalog"> | string
    thermal_capacity?: IntFilter<"CpuCoolerCatalog"> | number
    cluster_configs?: ClusterConfigurationListRelationFilter
  }

  export type CpuCoolerCatalogOrderByWithRelationInput = {
    cpu_cooler_catalog_id?: SortOrder
    model_name?: SortOrder
    type?: SortOrder
    thermal_capacity?: SortOrder
    cluster_configs?: ClusterConfigurationOrderByRelationAggregateInput
  }

  export type CpuCoolerCatalogWhereUniqueInput = Prisma.AtLeast<{
    cpu_cooler_catalog_id?: number
    model_name?: string
    AND?: CpuCoolerCatalogWhereInput | CpuCoolerCatalogWhereInput[]
    OR?: CpuCoolerCatalogWhereInput[]
    NOT?: CpuCoolerCatalogWhereInput | CpuCoolerCatalogWhereInput[]
    type?: StringFilter<"CpuCoolerCatalog"> | string
    thermal_capacity?: IntFilter<"CpuCoolerCatalog"> | number
    cluster_configs?: ClusterConfigurationListRelationFilter
  }, "cpu_cooler_catalog_id" | "model_name">

  export type CpuCoolerCatalogOrderByWithAggregationInput = {
    cpu_cooler_catalog_id?: SortOrder
    model_name?: SortOrder
    type?: SortOrder
    thermal_capacity?: SortOrder
    _count?: CpuCoolerCatalogCountOrderByAggregateInput
    _avg?: CpuCoolerCatalogAvgOrderByAggregateInput
    _max?: CpuCoolerCatalogMaxOrderByAggregateInput
    _min?: CpuCoolerCatalogMinOrderByAggregateInput
    _sum?: CpuCoolerCatalogSumOrderByAggregateInput
  }

  export type CpuCoolerCatalogScalarWhereWithAggregatesInput = {
    AND?: CpuCoolerCatalogScalarWhereWithAggregatesInput | CpuCoolerCatalogScalarWhereWithAggregatesInput[]
    OR?: CpuCoolerCatalogScalarWhereWithAggregatesInput[]
    NOT?: CpuCoolerCatalogScalarWhereWithAggregatesInput | CpuCoolerCatalogScalarWhereWithAggregatesInput[]
    cpu_cooler_catalog_id?: IntWithAggregatesFilter<"CpuCoolerCatalog"> | number
    model_name?: StringWithAggregatesFilter<"CpuCoolerCatalog"> | string
    type?: StringWithAggregatesFilter<"CpuCoolerCatalog"> | string
    thermal_capacity?: IntWithAggregatesFilter<"CpuCoolerCatalog"> | number
  }

  export type ClusterConfigurationWhereInput = {
    AND?: ClusterConfigurationWhereInput | ClusterConfigurationWhereInput[]
    OR?: ClusterConfigurationWhereInput[]
    NOT?: ClusterConfigurationWhereInput | ClusterConfigurationWhereInput[]
    cluster_config_id?: IntFilter<"ClusterConfiguration"> | number
    name?: StringFilter<"ClusterConfiguration"> | string
    master?: IntFilter<"ClusterConfiguration"> | number
    worker?: IntFilter<"ClusterConfiguration"> | number
    consomation_per_master?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    consomation_per_worker?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    hardware_per_master?: StringNullableFilter<"ClusterConfiguration"> | string | null
    hardware_per_worker?: StringNullableFilter<"ClusterConfiguration"> | string | null
    pue?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    location_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    fan_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    fan_count?: IntFilter<"ClusterConfiguration"> | number
    cpu_cooler_catalog_id?: IntFilter<"ClusterConfiguration"> | number
    fan_catalog_id?: IntFilter<"ClusterConfiguration"> | number
    load_profile_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    load_profile?: XOR<LoadProfileNullableScalarRelationFilter, LoadProfileWhereInput> | null
    cooler_model?: XOR<CpuCoolerCatalogScalarRelationFilter, CpuCoolerCatalogWhereInput>
    fan_model?: XOR<FanCatalogNullableScalarRelationFilter, FanCatalogWhereInput> | null
    location?: XOR<ClusterLocationNullableScalarRelationFilter, ClusterLocationWhereInput> | null
    fan_config?: XOR<FanConfigurationNullableScalarRelationFilter, FanConfigurationWhereInput> | null
    servers?: ServerListRelationFilter
  }

  export type ClusterConfigurationOrderByWithRelationInput = {
    cluster_config_id?: SortOrder
    name?: SortOrder
    master?: SortOrder
    worker?: SortOrder
    consomation_per_master?: SortOrderInput | SortOrder
    consomation_per_worker?: SortOrderInput | SortOrder
    hardware_per_master?: SortOrderInput | SortOrder
    hardware_per_worker?: SortOrderInput | SortOrder
    pue?: SortOrderInput | SortOrder
    location_id?: SortOrderInput | SortOrder
    fan_id?: SortOrderInput | SortOrder
    fan_count?: SortOrder
    cpu_cooler_catalog_id?: SortOrder
    fan_catalog_id?: SortOrder
    load_profile_id?: SortOrderInput | SortOrder
    load_profile?: LoadProfileOrderByWithRelationInput
    cooler_model?: CpuCoolerCatalogOrderByWithRelationInput
    fan_model?: FanCatalogOrderByWithRelationInput
    location?: ClusterLocationOrderByWithRelationInput
    fan_config?: FanConfigurationOrderByWithRelationInput
    servers?: ServerOrderByRelationAggregateInput
  }

  export type ClusterConfigurationWhereUniqueInput = Prisma.AtLeast<{
    cluster_config_id?: number
    name?: string
    AND?: ClusterConfigurationWhereInput | ClusterConfigurationWhereInput[]
    OR?: ClusterConfigurationWhereInput[]
    NOT?: ClusterConfigurationWhereInput | ClusterConfigurationWhereInput[]
    master?: IntFilter<"ClusterConfiguration"> | number
    worker?: IntFilter<"ClusterConfiguration"> | number
    consomation_per_master?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    consomation_per_worker?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    hardware_per_master?: StringNullableFilter<"ClusterConfiguration"> | string | null
    hardware_per_worker?: StringNullableFilter<"ClusterConfiguration"> | string | null
    pue?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    location_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    fan_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    fan_count?: IntFilter<"ClusterConfiguration"> | number
    cpu_cooler_catalog_id?: IntFilter<"ClusterConfiguration"> | number
    fan_catalog_id?: IntFilter<"ClusterConfiguration"> | number
    load_profile_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    load_profile?: XOR<LoadProfileNullableScalarRelationFilter, LoadProfileWhereInput> | null
    cooler_model?: XOR<CpuCoolerCatalogScalarRelationFilter, CpuCoolerCatalogWhereInput>
    fan_model?: XOR<FanCatalogNullableScalarRelationFilter, FanCatalogWhereInput> | null
    location?: XOR<ClusterLocationNullableScalarRelationFilter, ClusterLocationWhereInput> | null
    fan_config?: XOR<FanConfigurationNullableScalarRelationFilter, FanConfigurationWhereInput> | null
    servers?: ServerListRelationFilter
  }, "cluster_config_id" | "name">

  export type ClusterConfigurationOrderByWithAggregationInput = {
    cluster_config_id?: SortOrder
    name?: SortOrder
    master?: SortOrder
    worker?: SortOrder
    consomation_per_master?: SortOrderInput | SortOrder
    consomation_per_worker?: SortOrderInput | SortOrder
    hardware_per_master?: SortOrderInput | SortOrder
    hardware_per_worker?: SortOrderInput | SortOrder
    pue?: SortOrderInput | SortOrder
    location_id?: SortOrderInput | SortOrder
    fan_id?: SortOrderInput | SortOrder
    fan_count?: SortOrder
    cpu_cooler_catalog_id?: SortOrder
    fan_catalog_id?: SortOrder
    load_profile_id?: SortOrderInput | SortOrder
    _count?: ClusterConfigurationCountOrderByAggregateInput
    _avg?: ClusterConfigurationAvgOrderByAggregateInput
    _max?: ClusterConfigurationMaxOrderByAggregateInput
    _min?: ClusterConfigurationMinOrderByAggregateInput
    _sum?: ClusterConfigurationSumOrderByAggregateInput
  }

  export type ClusterConfigurationScalarWhereWithAggregatesInput = {
    AND?: ClusterConfigurationScalarWhereWithAggregatesInput | ClusterConfigurationScalarWhereWithAggregatesInput[]
    OR?: ClusterConfigurationScalarWhereWithAggregatesInput[]
    NOT?: ClusterConfigurationScalarWhereWithAggregatesInput | ClusterConfigurationScalarWhereWithAggregatesInput[]
    cluster_config_id?: IntWithAggregatesFilter<"ClusterConfiguration"> | number
    name?: StringWithAggregatesFilter<"ClusterConfiguration"> | string
    master?: IntWithAggregatesFilter<"ClusterConfiguration"> | number
    worker?: IntWithAggregatesFilter<"ClusterConfiguration"> | number
    consomation_per_master?: FloatNullableWithAggregatesFilter<"ClusterConfiguration"> | number | null
    consomation_per_worker?: FloatNullableWithAggregatesFilter<"ClusterConfiguration"> | number | null
    hardware_per_master?: StringNullableWithAggregatesFilter<"ClusterConfiguration"> | string | null
    hardware_per_worker?: StringNullableWithAggregatesFilter<"ClusterConfiguration"> | string | null
    pue?: FloatNullableWithAggregatesFilter<"ClusterConfiguration"> | number | null
    location_id?: IntNullableWithAggregatesFilter<"ClusterConfiguration"> | number | null
    fan_id?: IntNullableWithAggregatesFilter<"ClusterConfiguration"> | number | null
    fan_count?: IntWithAggregatesFilter<"ClusterConfiguration"> | number
    cpu_cooler_catalog_id?: IntWithAggregatesFilter<"ClusterConfiguration"> | number
    fan_catalog_id?: IntWithAggregatesFilter<"ClusterConfiguration"> | number
    load_profile_id?: IntNullableWithAggregatesFilter<"ClusterConfiguration"> | number | null
  }

  export type ClusterWhereInput = {
    AND?: ClusterWhereInput | ClusterWhereInput[]
    OR?: ClusterWhereInput[]
    NOT?: ClusterWhereInput | ClusterWhereInput[]
    cluster_id?: IntFilter<"Cluster"> | number
    name?: StringFilter<"Cluster"> | string
    created_at?: DateTimeFilter<"Cluster"> | Date | string
    cluster_location_id?: IntFilter<"Cluster"> | number
    clusterLocation?: XOR<ClusterLocationScalarRelationFilter, ClusterLocationWhereInput>
    servers?: ServerListRelationFilter
  }

  export type ClusterOrderByWithRelationInput = {
    cluster_id?: SortOrder
    name?: SortOrder
    created_at?: SortOrder
    cluster_location_id?: SortOrder
    clusterLocation?: ClusterLocationOrderByWithRelationInput
    servers?: ServerOrderByRelationAggregateInput
  }

  export type ClusterWhereUniqueInput = Prisma.AtLeast<{
    cluster_id?: number
    name?: string
    AND?: ClusterWhereInput | ClusterWhereInput[]
    OR?: ClusterWhereInput[]
    NOT?: ClusterWhereInput | ClusterWhereInput[]
    created_at?: DateTimeFilter<"Cluster"> | Date | string
    cluster_location_id?: IntFilter<"Cluster"> | number
    clusterLocation?: XOR<ClusterLocationScalarRelationFilter, ClusterLocationWhereInput>
    servers?: ServerListRelationFilter
  }, "cluster_id" | "name">

  export type ClusterOrderByWithAggregationInput = {
    cluster_id?: SortOrder
    name?: SortOrder
    created_at?: SortOrder
    cluster_location_id?: SortOrder
    _count?: ClusterCountOrderByAggregateInput
    _avg?: ClusterAvgOrderByAggregateInput
    _max?: ClusterMaxOrderByAggregateInput
    _min?: ClusterMinOrderByAggregateInput
    _sum?: ClusterSumOrderByAggregateInput
  }

  export type ClusterScalarWhereWithAggregatesInput = {
    AND?: ClusterScalarWhereWithAggregatesInput | ClusterScalarWhereWithAggregatesInput[]
    OR?: ClusterScalarWhereWithAggregatesInput[]
    NOT?: ClusterScalarWhereWithAggregatesInput | ClusterScalarWhereWithAggregatesInput[]
    cluster_id?: IntWithAggregatesFilter<"Cluster"> | number
    name?: StringWithAggregatesFilter<"Cluster"> | string
    created_at?: DateTimeWithAggregatesFilter<"Cluster"> | Date | string
    cluster_location_id?: IntWithAggregatesFilter<"Cluster"> | number
  }

  export type ServerWhereInput = {
    AND?: ServerWhereInput | ServerWhereInput[]
    OR?: ServerWhereInput[]
    NOT?: ServerWhereInput | ServerWhereInput[]
    server_id?: IntFilter<"Server"> | number
    cluster_id?: IntFilter<"Server"> | number
    config_id?: IntNullableFilter<"Server"> | number | null
    hostname?: StringFilter<"Server"> | string
    status?: StringFilter<"Server"> | string
    base_consumption_offset?: FloatFilter<"Server"> | number
    created_at?: DateTimeFilter<"Server"> | Date | string
    cluster?: XOR<ClusterScalarRelationFilter, ClusterWhereInput>
    configuration?: XOR<ClusterConfigurationNullableScalarRelationFilter, ClusterConfigurationWhereInput> | null
    sensors?: SensorListRelationFilter
    fans?: FanListRelationFilter
  }

  export type ServerOrderByWithRelationInput = {
    server_id?: SortOrder
    cluster_id?: SortOrder
    config_id?: SortOrderInput | SortOrder
    hostname?: SortOrder
    status?: SortOrder
    base_consumption_offset?: SortOrder
    created_at?: SortOrder
    cluster?: ClusterOrderByWithRelationInput
    configuration?: ClusterConfigurationOrderByWithRelationInput
    sensors?: SensorOrderByRelationAggregateInput
    fans?: FanOrderByRelationAggregateInput
  }

  export type ServerWhereUniqueInput = Prisma.AtLeast<{
    server_id?: number
    AND?: ServerWhereInput | ServerWhereInput[]
    OR?: ServerWhereInput[]
    NOT?: ServerWhereInput | ServerWhereInput[]
    cluster_id?: IntFilter<"Server"> | number
    config_id?: IntNullableFilter<"Server"> | number | null
    hostname?: StringFilter<"Server"> | string
    status?: StringFilter<"Server"> | string
    base_consumption_offset?: FloatFilter<"Server"> | number
    created_at?: DateTimeFilter<"Server"> | Date | string
    cluster?: XOR<ClusterScalarRelationFilter, ClusterWhereInput>
    configuration?: XOR<ClusterConfigurationNullableScalarRelationFilter, ClusterConfigurationWhereInput> | null
    sensors?: SensorListRelationFilter
    fans?: FanListRelationFilter
  }, "server_id">

  export type ServerOrderByWithAggregationInput = {
    server_id?: SortOrder
    cluster_id?: SortOrder
    config_id?: SortOrderInput | SortOrder
    hostname?: SortOrder
    status?: SortOrder
    base_consumption_offset?: SortOrder
    created_at?: SortOrder
    _count?: ServerCountOrderByAggregateInput
    _avg?: ServerAvgOrderByAggregateInput
    _max?: ServerMaxOrderByAggregateInput
    _min?: ServerMinOrderByAggregateInput
    _sum?: ServerSumOrderByAggregateInput
  }

  export type ServerScalarWhereWithAggregatesInput = {
    AND?: ServerScalarWhereWithAggregatesInput | ServerScalarWhereWithAggregatesInput[]
    OR?: ServerScalarWhereWithAggregatesInput[]
    NOT?: ServerScalarWhereWithAggregatesInput | ServerScalarWhereWithAggregatesInput[]
    server_id?: IntWithAggregatesFilter<"Server"> | number
    cluster_id?: IntWithAggregatesFilter<"Server"> | number
    config_id?: IntNullableWithAggregatesFilter<"Server"> | number | null
    hostname?: StringWithAggregatesFilter<"Server"> | string
    status?: StringWithAggregatesFilter<"Server"> | string
    base_consumption_offset?: FloatWithAggregatesFilter<"Server"> | number
    created_at?: DateTimeWithAggregatesFilter<"Server"> | Date | string
  }

  export type FanWhereInput = {
    AND?: FanWhereInput | FanWhereInput[]
    OR?: FanWhereInput[]
    NOT?: FanWhereInput | FanWhereInput[]
    fan_id?: IntFilter<"Fan"> | number
    server_id?: IntFilter<"Fan"> | number
    fan_catalog_id?: IntNullableFilter<"Fan"> | number | null
    fan_config_id?: IntNullableFilter<"Fan"> | number | null
    control_mode?: StringFilter<"Fan"> | string
    status?: StringFilter<"Fan"> | string
    speed_percent?: IntFilter<"Fan"> | number
    created_at?: DateTimeFilter<"Fan"> | Date | string
    server?: XOR<ServerScalarRelationFilter, ServerWhereInput>
    catalog_info?: XOR<FanCatalogNullableScalarRelationFilter, FanCatalogWhereInput> | null
    fan_config?: XOR<FanConfigurationNullableScalarRelationFilter, FanConfigurationWhereInput> | null
  }

  export type FanOrderByWithRelationInput = {
    fan_id?: SortOrder
    server_id?: SortOrder
    fan_catalog_id?: SortOrderInput | SortOrder
    fan_config_id?: SortOrderInput | SortOrder
    control_mode?: SortOrder
    status?: SortOrder
    speed_percent?: SortOrder
    created_at?: SortOrder
    server?: ServerOrderByWithRelationInput
    catalog_info?: FanCatalogOrderByWithRelationInput
    fan_config?: FanConfigurationOrderByWithRelationInput
  }

  export type FanWhereUniqueInput = Prisma.AtLeast<{
    fan_id?: number
    AND?: FanWhereInput | FanWhereInput[]
    OR?: FanWhereInput[]
    NOT?: FanWhereInput | FanWhereInput[]
    server_id?: IntFilter<"Fan"> | number
    fan_catalog_id?: IntNullableFilter<"Fan"> | number | null
    fan_config_id?: IntNullableFilter<"Fan"> | number | null
    control_mode?: StringFilter<"Fan"> | string
    status?: StringFilter<"Fan"> | string
    speed_percent?: IntFilter<"Fan"> | number
    created_at?: DateTimeFilter<"Fan"> | Date | string
    server?: XOR<ServerScalarRelationFilter, ServerWhereInput>
    catalog_info?: XOR<FanCatalogNullableScalarRelationFilter, FanCatalogWhereInput> | null
    fan_config?: XOR<FanConfigurationNullableScalarRelationFilter, FanConfigurationWhereInput> | null
  }, "fan_id">

  export type FanOrderByWithAggregationInput = {
    fan_id?: SortOrder
    server_id?: SortOrder
    fan_catalog_id?: SortOrderInput | SortOrder
    fan_config_id?: SortOrderInput | SortOrder
    control_mode?: SortOrder
    status?: SortOrder
    speed_percent?: SortOrder
    created_at?: SortOrder
    _count?: FanCountOrderByAggregateInput
    _avg?: FanAvgOrderByAggregateInput
    _max?: FanMaxOrderByAggregateInput
    _min?: FanMinOrderByAggregateInput
    _sum?: FanSumOrderByAggregateInput
  }

  export type FanScalarWhereWithAggregatesInput = {
    AND?: FanScalarWhereWithAggregatesInput | FanScalarWhereWithAggregatesInput[]
    OR?: FanScalarWhereWithAggregatesInput[]
    NOT?: FanScalarWhereWithAggregatesInput | FanScalarWhereWithAggregatesInput[]
    fan_id?: IntWithAggregatesFilter<"Fan"> | number
    server_id?: IntWithAggregatesFilter<"Fan"> | number
    fan_catalog_id?: IntNullableWithAggregatesFilter<"Fan"> | number | null
    fan_config_id?: IntNullableWithAggregatesFilter<"Fan"> | number | null
    control_mode?: StringWithAggregatesFilter<"Fan"> | string
    status?: StringWithAggregatesFilter<"Fan"> | string
    speed_percent?: IntWithAggregatesFilter<"Fan"> | number
    created_at?: DateTimeWithAggregatesFilter<"Fan"> | Date | string
  }

  export type SensorWhereInput = {
    AND?: SensorWhereInput | SensorWhereInput[]
    OR?: SensorWhereInput[]
    NOT?: SensorWhereInput | SensorWhereInput[]
    sensor_id?: IntFilter<"Sensor"> | number
    server_id?: IntFilter<"Sensor"> | number
    sensor_type?: StringFilter<"Sensor"> | string
    unit?: StringFilter<"Sensor"> | string
    last_value?: FloatNullableFilter<"Sensor"> | number | null
    created_at?: DateTimeFilter<"Sensor"> | Date | string
    server?: XOR<ServerScalarRelationFilter, ServerWhereInput>
    data?: SensorDataListRelationFilter
  }

  export type SensorOrderByWithRelationInput = {
    sensor_id?: SortOrder
    server_id?: SortOrder
    sensor_type?: SortOrder
    unit?: SortOrder
    last_value?: SortOrderInput | SortOrder
    created_at?: SortOrder
    server?: ServerOrderByWithRelationInput
    data?: SensorDataOrderByRelationAggregateInput
  }

  export type SensorWhereUniqueInput = Prisma.AtLeast<{
    sensor_id?: number
    AND?: SensorWhereInput | SensorWhereInput[]
    OR?: SensorWhereInput[]
    NOT?: SensorWhereInput | SensorWhereInput[]
    server_id?: IntFilter<"Sensor"> | number
    sensor_type?: StringFilter<"Sensor"> | string
    unit?: StringFilter<"Sensor"> | string
    last_value?: FloatNullableFilter<"Sensor"> | number | null
    created_at?: DateTimeFilter<"Sensor"> | Date | string
    server?: XOR<ServerScalarRelationFilter, ServerWhereInput>
    data?: SensorDataListRelationFilter
  }, "sensor_id">

  export type SensorOrderByWithAggregationInput = {
    sensor_id?: SortOrder
    server_id?: SortOrder
    sensor_type?: SortOrder
    unit?: SortOrder
    last_value?: SortOrderInput | SortOrder
    created_at?: SortOrder
    _count?: SensorCountOrderByAggregateInput
    _avg?: SensorAvgOrderByAggregateInput
    _max?: SensorMaxOrderByAggregateInput
    _min?: SensorMinOrderByAggregateInput
    _sum?: SensorSumOrderByAggregateInput
  }

  export type SensorScalarWhereWithAggregatesInput = {
    AND?: SensorScalarWhereWithAggregatesInput | SensorScalarWhereWithAggregatesInput[]
    OR?: SensorScalarWhereWithAggregatesInput[]
    NOT?: SensorScalarWhereWithAggregatesInput | SensorScalarWhereWithAggregatesInput[]
    sensor_id?: IntWithAggregatesFilter<"Sensor"> | number
    server_id?: IntWithAggregatesFilter<"Sensor"> | number
    sensor_type?: StringWithAggregatesFilter<"Sensor"> | string
    unit?: StringWithAggregatesFilter<"Sensor"> | string
    last_value?: FloatNullableWithAggregatesFilter<"Sensor"> | number | null
    created_at?: DateTimeWithAggregatesFilter<"Sensor"> | Date | string
  }

  export type SensorDataWhereInput = {
    AND?: SensorDataWhereInput | SensorDataWhereInput[]
    OR?: SensorDataWhereInput[]
    NOT?: SensorDataWhereInput | SensorDataWhereInput[]
    id?: IntFilter<"SensorData"> | number
    time?: DateTimeFilter<"SensorData"> | Date | string
    sensor_id?: IntFilter<"SensorData"> | number
    value?: FloatFilter<"SensorData"> | number
    sensor?: XOR<SensorScalarRelationFilter, SensorWhereInput>
  }

  export type SensorDataOrderByWithRelationInput = {
    id?: SortOrder
    time?: SortOrder
    sensor_id?: SortOrder
    value?: SortOrder
    sensor?: SensorOrderByWithRelationInput
  }

  export type SensorDataWhereUniqueInput = Prisma.AtLeast<{
    id?: number
    AND?: SensorDataWhereInput | SensorDataWhereInput[]
    OR?: SensorDataWhereInput[]
    NOT?: SensorDataWhereInput | SensorDataWhereInput[]
    time?: DateTimeFilter<"SensorData"> | Date | string
    sensor_id?: IntFilter<"SensorData"> | number
    value?: FloatFilter<"SensorData"> | number
    sensor?: XOR<SensorScalarRelationFilter, SensorWhereInput>
  }, "id">

  export type SensorDataOrderByWithAggregationInput = {
    id?: SortOrder
    time?: SortOrder
    sensor_id?: SortOrder
    value?: SortOrder
    _count?: SensorDataCountOrderByAggregateInput
    _avg?: SensorDataAvgOrderByAggregateInput
    _max?: SensorDataMaxOrderByAggregateInput
    _min?: SensorDataMinOrderByAggregateInput
    _sum?: SensorDataSumOrderByAggregateInput
  }

  export type SensorDataScalarWhereWithAggregatesInput = {
    AND?: SensorDataScalarWhereWithAggregatesInput | SensorDataScalarWhereWithAggregatesInput[]
    OR?: SensorDataScalarWhereWithAggregatesInput[]
    NOT?: SensorDataScalarWhereWithAggregatesInput | SensorDataScalarWhereWithAggregatesInput[]
    id?: IntWithAggregatesFilter<"SensorData"> | number
    time?: DateTimeWithAggregatesFilter<"SensorData"> | Date | string
    sensor_id?: IntWithAggregatesFilter<"SensorData"> | number
    value?: FloatWithAggregatesFilter<"SensorData"> | number
  }

  export type ClusterLocationCreateInput = {
    name: string
    location?: string | null
    env_factor?: number
    cluster_count: number
    created_at?: Date | string
    cluster_configurations?: ClusterConfigurationCreateNestedManyWithoutLocationInput
    clusters?: ClusterCreateNestedManyWithoutClusterLocationInput
  }

  export type ClusterLocationUncheckedCreateInput = {
    location_id?: number
    name: string
    location?: string | null
    env_factor?: number
    cluster_count: number
    created_at?: Date | string
    cluster_configurations?: ClusterConfigurationUncheckedCreateNestedManyWithoutLocationInput
    clusters?: ClusterUncheckedCreateNestedManyWithoutClusterLocationInput
  }

  export type ClusterLocationUpdateInput = {
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster_configurations?: ClusterConfigurationUpdateManyWithoutLocationNestedInput
    clusters?: ClusterUpdateManyWithoutClusterLocationNestedInput
  }

  export type ClusterLocationUncheckedUpdateInput = {
    location_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster_configurations?: ClusterConfigurationUncheckedUpdateManyWithoutLocationNestedInput
    clusters?: ClusterUncheckedUpdateManyWithoutClusterLocationNestedInput
  }

  export type ClusterLocationCreateManyInput = {
    location_id?: number
    name: string
    location?: string | null
    env_factor?: number
    cluster_count: number
    created_at?: Date | string
  }

  export type ClusterLocationUpdateManyMutationInput = {
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ClusterLocationUncheckedUpdateManyInput = {
    location_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type LoadProfileCreateInput = {
    name: string
    hour: number
    expected_load_percent: number
    target_temp_celsius: number
    standard_fan_speed?: string
    cluster_configurations?: ClusterConfigurationCreateNestedManyWithoutLoad_profileInput
  }

  export type LoadProfileUncheckedCreateInput = {
    id?: number
    name: string
    hour: number
    expected_load_percent: number
    target_temp_celsius: number
    standard_fan_speed?: string
    cluster_configurations?: ClusterConfigurationUncheckedCreateNestedManyWithoutLoad_profileInput
  }

  export type LoadProfileUpdateInput = {
    name?: StringFieldUpdateOperationsInput | string
    hour?: IntFieldUpdateOperationsInput | number
    expected_load_percent?: FloatFieldUpdateOperationsInput | number
    target_temp_celsius?: FloatFieldUpdateOperationsInput | number
    standard_fan_speed?: StringFieldUpdateOperationsInput | string
    cluster_configurations?: ClusterConfigurationUpdateManyWithoutLoad_profileNestedInput
  }

  export type LoadProfileUncheckedUpdateInput = {
    id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    hour?: IntFieldUpdateOperationsInput | number
    expected_load_percent?: FloatFieldUpdateOperationsInput | number
    target_temp_celsius?: FloatFieldUpdateOperationsInput | number
    standard_fan_speed?: StringFieldUpdateOperationsInput | string
    cluster_configurations?: ClusterConfigurationUncheckedUpdateManyWithoutLoad_profileNestedInput
  }

  export type LoadProfileCreateManyInput = {
    id?: number
    name: string
    hour: number
    expected_load_percent: number
    target_temp_celsius: number
    standard_fan_speed?: string
  }

  export type LoadProfileUpdateManyMutationInput = {
    name?: StringFieldUpdateOperationsInput | string
    hour?: IntFieldUpdateOperationsInput | number
    expected_load_percent?: FloatFieldUpdateOperationsInput | number
    target_temp_celsius?: FloatFieldUpdateOperationsInput | number
    standard_fan_speed?: StringFieldUpdateOperationsInput | string
  }

  export type LoadProfileUncheckedUpdateManyInput = {
    id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    hour?: IntFieldUpdateOperationsInput | number
    expected_load_percent?: FloatFieldUpdateOperationsInput | number
    target_temp_celsius?: FloatFieldUpdateOperationsInput | number
    standard_fan_speed?: StringFieldUpdateOperationsInput | string
  }

  export type FanConfigurationCreateInput = {
    name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationCreateNestedManyWithoutFan_configInput
    fans?: FanCreateNestedManyWithoutFan_configInput
  }

  export type FanConfigurationUncheckedCreateInput = {
    fan_id?: number
    name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationUncheckedCreateNestedManyWithoutFan_configInput
    fans?: FanUncheckedCreateNestedManyWithoutFan_configInput
  }

  export type FanConfigurationUpdateInput = {
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUpdateManyWithoutFan_configNestedInput
    fans?: FanUpdateManyWithoutFan_configNestedInput
  }

  export type FanConfigurationUncheckedUpdateInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUncheckedUpdateManyWithoutFan_configNestedInput
    fans?: FanUncheckedUpdateManyWithoutFan_configNestedInput
  }

  export type FanConfigurationCreateManyInput = {
    fan_id?: number
    name: string
    consomation?: number | null
  }

  export type FanConfigurationUpdateManyMutationInput = {
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
  }

  export type FanConfigurationUncheckedUpdateManyInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
  }

  export type FanCatalogCreateInput = {
    model_name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationCreateNestedManyWithoutFan_modelInput
    fans?: FanCreateNestedManyWithoutCatalog_infoInput
  }

  export type FanCatalogUncheckedCreateInput = {
    fan_catalog_id?: number
    model_name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationUncheckedCreateNestedManyWithoutFan_modelInput
    fans?: FanUncheckedCreateNestedManyWithoutCatalog_infoInput
  }

  export type FanCatalogUpdateInput = {
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUpdateManyWithoutFan_modelNestedInput
    fans?: FanUpdateManyWithoutCatalog_infoNestedInput
  }

  export type FanCatalogUncheckedUpdateInput = {
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUncheckedUpdateManyWithoutFan_modelNestedInput
    fans?: FanUncheckedUpdateManyWithoutCatalog_infoNestedInput
  }

  export type FanCatalogCreateManyInput = {
    fan_catalog_id?: number
    model_name: string
    consomation?: number | null
  }

  export type FanCatalogUpdateManyMutationInput = {
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
  }

  export type FanCatalogUncheckedUpdateManyInput = {
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
  }

  export type CpuCoolerCatalogCreateInput = {
    model_name: string
    type: string
    thermal_capacity: number
    cluster_configs?: ClusterConfigurationCreateNestedManyWithoutCooler_modelInput
  }

  export type CpuCoolerCatalogUncheckedCreateInput = {
    cpu_cooler_catalog_id?: number
    model_name: string
    type: string
    thermal_capacity: number
    cluster_configs?: ClusterConfigurationUncheckedCreateNestedManyWithoutCooler_modelInput
  }

  export type CpuCoolerCatalogUpdateInput = {
    model_name?: StringFieldUpdateOperationsInput | string
    type?: StringFieldUpdateOperationsInput | string
    thermal_capacity?: IntFieldUpdateOperationsInput | number
    cluster_configs?: ClusterConfigurationUpdateManyWithoutCooler_modelNestedInput
  }

  export type CpuCoolerCatalogUncheckedUpdateInput = {
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    model_name?: StringFieldUpdateOperationsInput | string
    type?: StringFieldUpdateOperationsInput | string
    thermal_capacity?: IntFieldUpdateOperationsInput | number
    cluster_configs?: ClusterConfigurationUncheckedUpdateManyWithoutCooler_modelNestedInput
  }

  export type CpuCoolerCatalogCreateManyInput = {
    cpu_cooler_catalog_id?: number
    model_name: string
    type: string
    thermal_capacity: number
  }

  export type CpuCoolerCatalogUpdateManyMutationInput = {
    model_name?: StringFieldUpdateOperationsInput | string
    type?: StringFieldUpdateOperationsInput | string
    thermal_capacity?: IntFieldUpdateOperationsInput | number
  }

  export type CpuCoolerCatalogUncheckedUpdateManyInput = {
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    model_name?: StringFieldUpdateOperationsInput | string
    type?: StringFieldUpdateOperationsInput | string
    thermal_capacity?: IntFieldUpdateOperationsInput | number
  }

  export type ClusterConfigurationCreateInput = {
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_count?: number
    load_profile?: LoadProfileCreateNestedOneWithoutCluster_configurationsInput
    cooler_model: CpuCoolerCatalogCreateNestedOneWithoutCluster_configsInput
    fan_model?: FanCatalogCreateNestedOneWithoutCluster_configurationsInput
    location?: ClusterLocationCreateNestedOneWithoutCluster_configurationsInput
    fan_config?: FanConfigurationCreateNestedOneWithoutCluster_configurationsInput
    servers?: ServerCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationUncheckedCreateInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id?: number | null
    servers?: ServerUncheckedCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationUpdateInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    load_profile?: LoadProfileUpdateOneWithoutCluster_configurationsNestedInput
    cooler_model?: CpuCoolerCatalogUpdateOneRequiredWithoutCluster_configsNestedInput
    fan_model?: FanCatalogUpdateOneWithoutCluster_configurationsNestedInput
    location?: ClusterLocationUpdateOneWithoutCluster_configurationsNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutCluster_configurationsNestedInput
    servers?: ServerUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
    servers?: ServerUncheckedUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationCreateManyInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id?: number | null
  }

  export type ClusterConfigurationUpdateManyMutationInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
  }

  export type ClusterConfigurationUncheckedUpdateManyInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
  }

  export type ClusterCreateInput = {
    name: string
    created_at?: Date | string
    clusterLocation: ClusterLocationCreateNestedOneWithoutClustersInput
    servers?: ServerCreateNestedManyWithoutClusterInput
  }

  export type ClusterUncheckedCreateInput = {
    cluster_id?: number
    name: string
    created_at?: Date | string
    cluster_location_id: number
    servers?: ServerUncheckedCreateNestedManyWithoutClusterInput
  }

  export type ClusterUpdateInput = {
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    clusterLocation?: ClusterLocationUpdateOneRequiredWithoutClustersNestedInput
    servers?: ServerUpdateManyWithoutClusterNestedInput
  }

  export type ClusterUncheckedUpdateInput = {
    cluster_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster_location_id?: IntFieldUpdateOperationsInput | number
    servers?: ServerUncheckedUpdateManyWithoutClusterNestedInput
  }

  export type ClusterCreateManyInput = {
    cluster_id?: number
    name: string
    created_at?: Date | string
    cluster_location_id: number
  }

  export type ClusterUpdateManyMutationInput = {
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ClusterUncheckedUpdateManyInput = {
    cluster_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster_location_id?: IntFieldUpdateOperationsInput | number
  }

  export type ServerCreateInput = {
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    cluster: ClusterCreateNestedOneWithoutServersInput
    configuration?: ClusterConfigurationCreateNestedOneWithoutServersInput
    sensors?: SensorCreateNestedManyWithoutServerInput
    fans?: FanCreateNestedManyWithoutServerInput
  }

  export type ServerUncheckedCreateInput = {
    server_id?: number
    cluster_id: number
    config_id?: number | null
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    sensors?: SensorUncheckedCreateNestedManyWithoutServerInput
    fans?: FanUncheckedCreateNestedManyWithoutServerInput
  }

  export type ServerUpdateInput = {
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster?: ClusterUpdateOneRequiredWithoutServersNestedInput
    configuration?: ClusterConfigurationUpdateOneWithoutServersNestedInput
    sensors?: SensorUpdateManyWithoutServerNestedInput
    fans?: FanUpdateManyWithoutServerNestedInput
  }

  export type ServerUncheckedUpdateInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    cluster_id?: IntFieldUpdateOperationsInput | number
    config_id?: NullableIntFieldUpdateOperationsInput | number | null
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    sensors?: SensorUncheckedUpdateManyWithoutServerNestedInput
    fans?: FanUncheckedUpdateManyWithoutServerNestedInput
  }

  export type ServerCreateManyInput = {
    server_id?: number
    cluster_id: number
    config_id?: number | null
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
  }

  export type ServerUpdateManyMutationInput = {
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ServerUncheckedUpdateManyInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    cluster_id?: IntFieldUpdateOperationsInput | number
    config_id?: NullableIntFieldUpdateOperationsInput | number | null
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type FanCreateInput = {
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
    server: ServerCreateNestedOneWithoutFansInput
    catalog_info?: FanCatalogCreateNestedOneWithoutFansInput
    fan_config?: FanConfigurationCreateNestedOneWithoutFansInput
  }

  export type FanUncheckedCreateInput = {
    fan_id?: number
    server_id: number
    fan_catalog_id?: number | null
    fan_config_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type FanUpdateInput = {
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    server?: ServerUpdateOneRequiredWithoutFansNestedInput
    catalog_info?: FanCatalogUpdateOneWithoutFansNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutFansNestedInput
  }

  export type FanUncheckedUpdateInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_config_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type FanCreateManyInput = {
    fan_id?: number
    server_id: number
    fan_catalog_id?: number | null
    fan_config_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type FanUpdateManyMutationInput = {
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type FanUncheckedUpdateManyInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_config_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type SensorCreateInput = {
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
    server: ServerCreateNestedOneWithoutSensorsInput
    data?: SensorDataCreateNestedManyWithoutSensorInput
  }

  export type SensorUncheckedCreateInput = {
    sensor_id?: number
    server_id: number
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
    data?: SensorDataUncheckedCreateNestedManyWithoutSensorInput
  }

  export type SensorUpdateInput = {
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    server?: ServerUpdateOneRequiredWithoutSensorsNestedInput
    data?: SensorDataUpdateManyWithoutSensorNestedInput
  }

  export type SensorUncheckedUpdateInput = {
    sensor_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    data?: SensorDataUncheckedUpdateManyWithoutSensorNestedInput
  }

  export type SensorCreateManyInput = {
    sensor_id?: number
    server_id: number
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
  }

  export type SensorUpdateManyMutationInput = {
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type SensorUncheckedUpdateManyInput = {
    sensor_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type SensorDataCreateInput = {
    time?: Date | string
    value: number
    sensor: SensorCreateNestedOneWithoutDataInput
  }

  export type SensorDataUncheckedCreateInput = {
    id?: number
    time?: Date | string
    sensor_id: number
    value: number
  }

  export type SensorDataUpdateInput = {
    time?: DateTimeFieldUpdateOperationsInput | Date | string
    value?: FloatFieldUpdateOperationsInput | number
    sensor?: SensorUpdateOneRequiredWithoutDataNestedInput
  }

  export type SensorDataUncheckedUpdateInput = {
    id?: IntFieldUpdateOperationsInput | number
    time?: DateTimeFieldUpdateOperationsInput | Date | string
    sensor_id?: IntFieldUpdateOperationsInput | number
    value?: FloatFieldUpdateOperationsInput | number
  }

  export type SensorDataCreateManyInput = {
    id?: number
    time?: Date | string
    sensor_id: number
    value: number
  }

  export type SensorDataUpdateManyMutationInput = {
    time?: DateTimeFieldUpdateOperationsInput | Date | string
    value?: FloatFieldUpdateOperationsInput | number
  }

  export type SensorDataUncheckedUpdateManyInput = {
    id?: IntFieldUpdateOperationsInput | number
    time?: DateTimeFieldUpdateOperationsInput | Date | string
    sensor_id?: IntFieldUpdateOperationsInput | number
    value?: FloatFieldUpdateOperationsInput | number
  }

  export type IntFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel>
    in?: number[] | ListIntFieldRefInput<$PrismaModel>
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel>
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntFilter<$PrismaModel> | number
  }

  export type StringFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel>
    in?: string[] | ListStringFieldRefInput<$PrismaModel>
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel>
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    mode?: QueryMode
    not?: NestedStringFilter<$PrismaModel> | string
  }

  export type StringNullableFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel> | null
    in?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    mode?: QueryMode
    not?: NestedStringNullableFilter<$PrismaModel> | string | null
  }

  export type FloatFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel>
    in?: number[] | ListFloatFieldRefInput<$PrismaModel>
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel>
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatFilter<$PrismaModel> | number
  }

  export type DateTimeFilter<$PrismaModel = never> = {
    equals?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    in?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    notIn?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    lt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    lte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    not?: NestedDateTimeFilter<$PrismaModel> | Date | string
  }

  export type ClusterConfigurationListRelationFilter = {
    every?: ClusterConfigurationWhereInput
    some?: ClusterConfigurationWhereInput
    none?: ClusterConfigurationWhereInput
  }

  export type ClusterListRelationFilter = {
    every?: ClusterWhereInput
    some?: ClusterWhereInput
    none?: ClusterWhereInput
  }

  export type SortOrderInput = {
    sort: SortOrder
    nulls?: NullsOrder
  }

  export type ClusterConfigurationOrderByRelationAggregateInput = {
    _count?: SortOrder
  }

  export type ClusterOrderByRelationAggregateInput = {
    _count?: SortOrder
  }

  export type ClusterLocationCountOrderByAggregateInput = {
    location_id?: SortOrder
    name?: SortOrder
    location?: SortOrder
    env_factor?: SortOrder
    cluster_count?: SortOrder
    created_at?: SortOrder
  }

  export type ClusterLocationAvgOrderByAggregateInput = {
    location_id?: SortOrder
    env_factor?: SortOrder
    cluster_count?: SortOrder
  }

  export type ClusterLocationMaxOrderByAggregateInput = {
    location_id?: SortOrder
    name?: SortOrder
    location?: SortOrder
    env_factor?: SortOrder
    cluster_count?: SortOrder
    created_at?: SortOrder
  }

  export type ClusterLocationMinOrderByAggregateInput = {
    location_id?: SortOrder
    name?: SortOrder
    location?: SortOrder
    env_factor?: SortOrder
    cluster_count?: SortOrder
    created_at?: SortOrder
  }

  export type ClusterLocationSumOrderByAggregateInput = {
    location_id?: SortOrder
    env_factor?: SortOrder
    cluster_count?: SortOrder
  }

  export type IntWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel>
    in?: number[] | ListIntFieldRefInput<$PrismaModel>
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel>
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntWithAggregatesFilter<$PrismaModel> | number
    _count?: NestedIntFilter<$PrismaModel>
    _avg?: NestedFloatFilter<$PrismaModel>
    _sum?: NestedIntFilter<$PrismaModel>
    _min?: NestedIntFilter<$PrismaModel>
    _max?: NestedIntFilter<$PrismaModel>
  }

  export type StringWithAggregatesFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel>
    in?: string[] | ListStringFieldRefInput<$PrismaModel>
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel>
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    mode?: QueryMode
    not?: NestedStringWithAggregatesFilter<$PrismaModel> | string
    _count?: NestedIntFilter<$PrismaModel>
    _min?: NestedStringFilter<$PrismaModel>
    _max?: NestedStringFilter<$PrismaModel>
  }

  export type StringNullableWithAggregatesFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel> | null
    in?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    mode?: QueryMode
    not?: NestedStringNullableWithAggregatesFilter<$PrismaModel> | string | null
    _count?: NestedIntNullableFilter<$PrismaModel>
    _min?: NestedStringNullableFilter<$PrismaModel>
    _max?: NestedStringNullableFilter<$PrismaModel>
  }

  export type FloatWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel>
    in?: number[] | ListFloatFieldRefInput<$PrismaModel>
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel>
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatWithAggregatesFilter<$PrismaModel> | number
    _count?: NestedIntFilter<$PrismaModel>
    _avg?: NestedFloatFilter<$PrismaModel>
    _sum?: NestedFloatFilter<$PrismaModel>
    _min?: NestedFloatFilter<$PrismaModel>
    _max?: NestedFloatFilter<$PrismaModel>
  }

  export type DateTimeWithAggregatesFilter<$PrismaModel = never> = {
    equals?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    in?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    notIn?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    lt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    lte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    not?: NestedDateTimeWithAggregatesFilter<$PrismaModel> | Date | string
    _count?: NestedIntFilter<$PrismaModel>
    _min?: NestedDateTimeFilter<$PrismaModel>
    _max?: NestedDateTimeFilter<$PrismaModel>
  }

  export type LoadProfileNameHourCompoundUniqueInput = {
    name: string
    hour: number
  }

  export type LoadProfileCountOrderByAggregateInput = {
    id?: SortOrder
    name?: SortOrder
    hour?: SortOrder
    expected_load_percent?: SortOrder
    target_temp_celsius?: SortOrder
    standard_fan_speed?: SortOrder
  }

  export type LoadProfileAvgOrderByAggregateInput = {
    id?: SortOrder
    hour?: SortOrder
    expected_load_percent?: SortOrder
    target_temp_celsius?: SortOrder
  }

  export type LoadProfileMaxOrderByAggregateInput = {
    id?: SortOrder
    name?: SortOrder
    hour?: SortOrder
    expected_load_percent?: SortOrder
    target_temp_celsius?: SortOrder
    standard_fan_speed?: SortOrder
  }

  export type LoadProfileMinOrderByAggregateInput = {
    id?: SortOrder
    name?: SortOrder
    hour?: SortOrder
    expected_load_percent?: SortOrder
    target_temp_celsius?: SortOrder
    standard_fan_speed?: SortOrder
  }

  export type LoadProfileSumOrderByAggregateInput = {
    id?: SortOrder
    hour?: SortOrder
    expected_load_percent?: SortOrder
    target_temp_celsius?: SortOrder
  }

  export type FloatNullableFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel> | null
    in?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatNullableFilter<$PrismaModel> | number | null
  }

  export type FanListRelationFilter = {
    every?: FanWhereInput
    some?: FanWhereInput
    none?: FanWhereInput
  }

  export type FanOrderByRelationAggregateInput = {
    _count?: SortOrder
  }

  export type FanConfigurationCountOrderByAggregateInput = {
    fan_id?: SortOrder
    name?: SortOrder
    consomation?: SortOrder
  }

  export type FanConfigurationAvgOrderByAggregateInput = {
    fan_id?: SortOrder
    consomation?: SortOrder
  }

  export type FanConfigurationMaxOrderByAggregateInput = {
    fan_id?: SortOrder
    name?: SortOrder
    consomation?: SortOrder
  }

  export type FanConfigurationMinOrderByAggregateInput = {
    fan_id?: SortOrder
    name?: SortOrder
    consomation?: SortOrder
  }

  export type FanConfigurationSumOrderByAggregateInput = {
    fan_id?: SortOrder
    consomation?: SortOrder
  }

  export type FloatNullableWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel> | null
    in?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatNullableWithAggregatesFilter<$PrismaModel> | number | null
    _count?: NestedIntNullableFilter<$PrismaModel>
    _avg?: NestedFloatNullableFilter<$PrismaModel>
    _sum?: NestedFloatNullableFilter<$PrismaModel>
    _min?: NestedFloatNullableFilter<$PrismaModel>
    _max?: NestedFloatNullableFilter<$PrismaModel>
  }

  export type FanCatalogCountOrderByAggregateInput = {
    fan_catalog_id?: SortOrder
    model_name?: SortOrder
    consomation?: SortOrder
  }

  export type FanCatalogAvgOrderByAggregateInput = {
    fan_catalog_id?: SortOrder
    consomation?: SortOrder
  }

  export type FanCatalogMaxOrderByAggregateInput = {
    fan_catalog_id?: SortOrder
    model_name?: SortOrder
    consomation?: SortOrder
  }

  export type FanCatalogMinOrderByAggregateInput = {
    fan_catalog_id?: SortOrder
    model_name?: SortOrder
    consomation?: SortOrder
  }

  export type FanCatalogSumOrderByAggregateInput = {
    fan_catalog_id?: SortOrder
    consomation?: SortOrder
  }

  export type CpuCoolerCatalogCountOrderByAggregateInput = {
    cpu_cooler_catalog_id?: SortOrder
    model_name?: SortOrder
    type?: SortOrder
    thermal_capacity?: SortOrder
  }

  export type CpuCoolerCatalogAvgOrderByAggregateInput = {
    cpu_cooler_catalog_id?: SortOrder
    thermal_capacity?: SortOrder
  }

  export type CpuCoolerCatalogMaxOrderByAggregateInput = {
    cpu_cooler_catalog_id?: SortOrder
    model_name?: SortOrder
    type?: SortOrder
    thermal_capacity?: SortOrder
  }

  export type CpuCoolerCatalogMinOrderByAggregateInput = {
    cpu_cooler_catalog_id?: SortOrder
    model_name?: SortOrder
    type?: SortOrder
    thermal_capacity?: SortOrder
  }

  export type CpuCoolerCatalogSumOrderByAggregateInput = {
    cpu_cooler_catalog_id?: SortOrder
    thermal_capacity?: SortOrder
  }

  export type IntNullableFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel> | null
    in?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntNullableFilter<$PrismaModel> | number | null
  }

  export type LoadProfileNullableScalarRelationFilter = {
    is?: LoadProfileWhereInput | null
    isNot?: LoadProfileWhereInput | null
  }

  export type CpuCoolerCatalogScalarRelationFilter = {
    is?: CpuCoolerCatalogWhereInput
    isNot?: CpuCoolerCatalogWhereInput
  }

  export type FanCatalogNullableScalarRelationFilter = {
    is?: FanCatalogWhereInput | null
    isNot?: FanCatalogWhereInput | null
  }

  export type ClusterLocationNullableScalarRelationFilter = {
    is?: ClusterLocationWhereInput | null
    isNot?: ClusterLocationWhereInput | null
  }

  export type FanConfigurationNullableScalarRelationFilter = {
    is?: FanConfigurationWhereInput | null
    isNot?: FanConfigurationWhereInput | null
  }

  export type ServerListRelationFilter = {
    every?: ServerWhereInput
    some?: ServerWhereInput
    none?: ServerWhereInput
  }

  export type ServerOrderByRelationAggregateInput = {
    _count?: SortOrder
  }

  export type ClusterConfigurationCountOrderByAggregateInput = {
    cluster_config_id?: SortOrder
    name?: SortOrder
    master?: SortOrder
    worker?: SortOrder
    consomation_per_master?: SortOrder
    consomation_per_worker?: SortOrder
    hardware_per_master?: SortOrder
    hardware_per_worker?: SortOrder
    pue?: SortOrder
    location_id?: SortOrder
    fan_id?: SortOrder
    fan_count?: SortOrder
    cpu_cooler_catalog_id?: SortOrder
    fan_catalog_id?: SortOrder
    load_profile_id?: SortOrder
  }

  export type ClusterConfigurationAvgOrderByAggregateInput = {
    cluster_config_id?: SortOrder
    master?: SortOrder
    worker?: SortOrder
    consomation_per_master?: SortOrder
    consomation_per_worker?: SortOrder
    pue?: SortOrder
    location_id?: SortOrder
    fan_id?: SortOrder
    fan_count?: SortOrder
    cpu_cooler_catalog_id?: SortOrder
    fan_catalog_id?: SortOrder
    load_profile_id?: SortOrder
  }

  export type ClusterConfigurationMaxOrderByAggregateInput = {
    cluster_config_id?: SortOrder
    name?: SortOrder
    master?: SortOrder
    worker?: SortOrder
    consomation_per_master?: SortOrder
    consomation_per_worker?: SortOrder
    hardware_per_master?: SortOrder
    hardware_per_worker?: SortOrder
    pue?: SortOrder
    location_id?: SortOrder
    fan_id?: SortOrder
    fan_count?: SortOrder
    cpu_cooler_catalog_id?: SortOrder
    fan_catalog_id?: SortOrder
    load_profile_id?: SortOrder
  }

  export type ClusterConfigurationMinOrderByAggregateInput = {
    cluster_config_id?: SortOrder
    name?: SortOrder
    master?: SortOrder
    worker?: SortOrder
    consomation_per_master?: SortOrder
    consomation_per_worker?: SortOrder
    hardware_per_master?: SortOrder
    hardware_per_worker?: SortOrder
    pue?: SortOrder
    location_id?: SortOrder
    fan_id?: SortOrder
    fan_count?: SortOrder
    cpu_cooler_catalog_id?: SortOrder
    fan_catalog_id?: SortOrder
    load_profile_id?: SortOrder
  }

  export type ClusterConfigurationSumOrderByAggregateInput = {
    cluster_config_id?: SortOrder
    master?: SortOrder
    worker?: SortOrder
    consomation_per_master?: SortOrder
    consomation_per_worker?: SortOrder
    pue?: SortOrder
    location_id?: SortOrder
    fan_id?: SortOrder
    fan_count?: SortOrder
    cpu_cooler_catalog_id?: SortOrder
    fan_catalog_id?: SortOrder
    load_profile_id?: SortOrder
  }

  export type IntNullableWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel> | null
    in?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntNullableWithAggregatesFilter<$PrismaModel> | number | null
    _count?: NestedIntNullableFilter<$PrismaModel>
    _avg?: NestedFloatNullableFilter<$PrismaModel>
    _sum?: NestedIntNullableFilter<$PrismaModel>
    _min?: NestedIntNullableFilter<$PrismaModel>
    _max?: NestedIntNullableFilter<$PrismaModel>
  }

  export type ClusterLocationScalarRelationFilter = {
    is?: ClusterLocationWhereInput
    isNot?: ClusterLocationWhereInput
  }

  export type ClusterCountOrderByAggregateInput = {
    cluster_id?: SortOrder
    name?: SortOrder
    created_at?: SortOrder
    cluster_location_id?: SortOrder
  }

  export type ClusterAvgOrderByAggregateInput = {
    cluster_id?: SortOrder
    cluster_location_id?: SortOrder
  }

  export type ClusterMaxOrderByAggregateInput = {
    cluster_id?: SortOrder
    name?: SortOrder
    created_at?: SortOrder
    cluster_location_id?: SortOrder
  }

  export type ClusterMinOrderByAggregateInput = {
    cluster_id?: SortOrder
    name?: SortOrder
    created_at?: SortOrder
    cluster_location_id?: SortOrder
  }

  export type ClusterSumOrderByAggregateInput = {
    cluster_id?: SortOrder
    cluster_location_id?: SortOrder
  }

  export type ClusterScalarRelationFilter = {
    is?: ClusterWhereInput
    isNot?: ClusterWhereInput
  }

  export type ClusterConfigurationNullableScalarRelationFilter = {
    is?: ClusterConfigurationWhereInput | null
    isNot?: ClusterConfigurationWhereInput | null
  }

  export type SensorListRelationFilter = {
    every?: SensorWhereInput
    some?: SensorWhereInput
    none?: SensorWhereInput
  }

  export type SensorOrderByRelationAggregateInput = {
    _count?: SortOrder
  }

  export type ServerCountOrderByAggregateInput = {
    server_id?: SortOrder
    cluster_id?: SortOrder
    config_id?: SortOrder
    hostname?: SortOrder
    status?: SortOrder
    base_consumption_offset?: SortOrder
    created_at?: SortOrder
  }

  export type ServerAvgOrderByAggregateInput = {
    server_id?: SortOrder
    cluster_id?: SortOrder
    config_id?: SortOrder
    base_consumption_offset?: SortOrder
  }

  export type ServerMaxOrderByAggregateInput = {
    server_id?: SortOrder
    cluster_id?: SortOrder
    config_id?: SortOrder
    hostname?: SortOrder
    status?: SortOrder
    base_consumption_offset?: SortOrder
    created_at?: SortOrder
  }

  export type ServerMinOrderByAggregateInput = {
    server_id?: SortOrder
    cluster_id?: SortOrder
    config_id?: SortOrder
    hostname?: SortOrder
    status?: SortOrder
    base_consumption_offset?: SortOrder
    created_at?: SortOrder
  }

  export type ServerSumOrderByAggregateInput = {
    server_id?: SortOrder
    cluster_id?: SortOrder
    config_id?: SortOrder
    base_consumption_offset?: SortOrder
  }

  export type ServerScalarRelationFilter = {
    is?: ServerWhereInput
    isNot?: ServerWhereInput
  }

  export type FanCountOrderByAggregateInput = {
    fan_id?: SortOrder
    server_id?: SortOrder
    fan_catalog_id?: SortOrder
    fan_config_id?: SortOrder
    control_mode?: SortOrder
    status?: SortOrder
    speed_percent?: SortOrder
    created_at?: SortOrder
  }

  export type FanAvgOrderByAggregateInput = {
    fan_id?: SortOrder
    server_id?: SortOrder
    fan_catalog_id?: SortOrder
    fan_config_id?: SortOrder
    speed_percent?: SortOrder
  }

  export type FanMaxOrderByAggregateInput = {
    fan_id?: SortOrder
    server_id?: SortOrder
    fan_catalog_id?: SortOrder
    fan_config_id?: SortOrder
    control_mode?: SortOrder
    status?: SortOrder
    speed_percent?: SortOrder
    created_at?: SortOrder
  }

  export type FanMinOrderByAggregateInput = {
    fan_id?: SortOrder
    server_id?: SortOrder
    fan_catalog_id?: SortOrder
    fan_config_id?: SortOrder
    control_mode?: SortOrder
    status?: SortOrder
    speed_percent?: SortOrder
    created_at?: SortOrder
  }

  export type FanSumOrderByAggregateInput = {
    fan_id?: SortOrder
    server_id?: SortOrder
    fan_catalog_id?: SortOrder
    fan_config_id?: SortOrder
    speed_percent?: SortOrder
  }

  export type SensorDataListRelationFilter = {
    every?: SensorDataWhereInput
    some?: SensorDataWhereInput
    none?: SensorDataWhereInput
  }

  export type SensorDataOrderByRelationAggregateInput = {
    _count?: SortOrder
  }

  export type SensorCountOrderByAggregateInput = {
    sensor_id?: SortOrder
    server_id?: SortOrder
    sensor_type?: SortOrder
    unit?: SortOrder
    last_value?: SortOrder
    created_at?: SortOrder
  }

  export type SensorAvgOrderByAggregateInput = {
    sensor_id?: SortOrder
    server_id?: SortOrder
    last_value?: SortOrder
  }

  export type SensorMaxOrderByAggregateInput = {
    sensor_id?: SortOrder
    server_id?: SortOrder
    sensor_type?: SortOrder
    unit?: SortOrder
    last_value?: SortOrder
    created_at?: SortOrder
  }

  export type SensorMinOrderByAggregateInput = {
    sensor_id?: SortOrder
    server_id?: SortOrder
    sensor_type?: SortOrder
    unit?: SortOrder
    last_value?: SortOrder
    created_at?: SortOrder
  }

  export type SensorSumOrderByAggregateInput = {
    sensor_id?: SortOrder
    server_id?: SortOrder
    last_value?: SortOrder
  }

  export type SensorScalarRelationFilter = {
    is?: SensorWhereInput
    isNot?: SensorWhereInput
  }

  export type SensorDataCountOrderByAggregateInput = {
    id?: SortOrder
    time?: SortOrder
    sensor_id?: SortOrder
    value?: SortOrder
  }

  export type SensorDataAvgOrderByAggregateInput = {
    id?: SortOrder
    sensor_id?: SortOrder
    value?: SortOrder
  }

  export type SensorDataMaxOrderByAggregateInput = {
    id?: SortOrder
    time?: SortOrder
    sensor_id?: SortOrder
    value?: SortOrder
  }

  export type SensorDataMinOrderByAggregateInput = {
    id?: SortOrder
    time?: SortOrder
    sensor_id?: SortOrder
    value?: SortOrder
  }

  export type SensorDataSumOrderByAggregateInput = {
    id?: SortOrder
    sensor_id?: SortOrder
    value?: SortOrder
  }

  export type ClusterConfigurationCreateNestedManyWithoutLocationInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLocationInput, ClusterConfigurationUncheckedCreateWithoutLocationInput> | ClusterConfigurationCreateWithoutLocationInput[] | ClusterConfigurationUncheckedCreateWithoutLocationInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLocationInput | ClusterConfigurationCreateOrConnectWithoutLocationInput[]
    createMany?: ClusterConfigurationCreateManyLocationInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type ClusterCreateNestedManyWithoutClusterLocationInput = {
    create?: XOR<ClusterCreateWithoutClusterLocationInput, ClusterUncheckedCreateWithoutClusterLocationInput> | ClusterCreateWithoutClusterLocationInput[] | ClusterUncheckedCreateWithoutClusterLocationInput[]
    connectOrCreate?: ClusterCreateOrConnectWithoutClusterLocationInput | ClusterCreateOrConnectWithoutClusterLocationInput[]
    createMany?: ClusterCreateManyClusterLocationInputEnvelope
    connect?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
  }

  export type ClusterConfigurationUncheckedCreateNestedManyWithoutLocationInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLocationInput, ClusterConfigurationUncheckedCreateWithoutLocationInput> | ClusterConfigurationCreateWithoutLocationInput[] | ClusterConfigurationUncheckedCreateWithoutLocationInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLocationInput | ClusterConfigurationCreateOrConnectWithoutLocationInput[]
    createMany?: ClusterConfigurationCreateManyLocationInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type ClusterUncheckedCreateNestedManyWithoutClusterLocationInput = {
    create?: XOR<ClusterCreateWithoutClusterLocationInput, ClusterUncheckedCreateWithoutClusterLocationInput> | ClusterCreateWithoutClusterLocationInput[] | ClusterUncheckedCreateWithoutClusterLocationInput[]
    connectOrCreate?: ClusterCreateOrConnectWithoutClusterLocationInput | ClusterCreateOrConnectWithoutClusterLocationInput[]
    createMany?: ClusterCreateManyClusterLocationInputEnvelope
    connect?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
  }

  export type StringFieldUpdateOperationsInput = {
    set?: string
  }

  export type NullableStringFieldUpdateOperationsInput = {
    set?: string | null
  }

  export type FloatFieldUpdateOperationsInput = {
    set?: number
    increment?: number
    decrement?: number
    multiply?: number
    divide?: number
  }

  export type IntFieldUpdateOperationsInput = {
    set?: number
    increment?: number
    decrement?: number
    multiply?: number
    divide?: number
  }

  export type DateTimeFieldUpdateOperationsInput = {
    set?: Date | string
  }

  export type ClusterConfigurationUpdateManyWithoutLocationNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLocationInput, ClusterConfigurationUncheckedCreateWithoutLocationInput> | ClusterConfigurationCreateWithoutLocationInput[] | ClusterConfigurationUncheckedCreateWithoutLocationInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLocationInput | ClusterConfigurationCreateOrConnectWithoutLocationInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutLocationInput | ClusterConfigurationUpsertWithWhereUniqueWithoutLocationInput[]
    createMany?: ClusterConfigurationCreateManyLocationInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutLocationInput | ClusterConfigurationUpdateWithWhereUniqueWithoutLocationInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutLocationInput | ClusterConfigurationUpdateManyWithWhereWithoutLocationInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type ClusterUpdateManyWithoutClusterLocationNestedInput = {
    create?: XOR<ClusterCreateWithoutClusterLocationInput, ClusterUncheckedCreateWithoutClusterLocationInput> | ClusterCreateWithoutClusterLocationInput[] | ClusterUncheckedCreateWithoutClusterLocationInput[]
    connectOrCreate?: ClusterCreateOrConnectWithoutClusterLocationInput | ClusterCreateOrConnectWithoutClusterLocationInput[]
    upsert?: ClusterUpsertWithWhereUniqueWithoutClusterLocationInput | ClusterUpsertWithWhereUniqueWithoutClusterLocationInput[]
    createMany?: ClusterCreateManyClusterLocationInputEnvelope
    set?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    disconnect?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    delete?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    connect?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    update?: ClusterUpdateWithWhereUniqueWithoutClusterLocationInput | ClusterUpdateWithWhereUniqueWithoutClusterLocationInput[]
    updateMany?: ClusterUpdateManyWithWhereWithoutClusterLocationInput | ClusterUpdateManyWithWhereWithoutClusterLocationInput[]
    deleteMany?: ClusterScalarWhereInput | ClusterScalarWhereInput[]
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutLocationNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLocationInput, ClusterConfigurationUncheckedCreateWithoutLocationInput> | ClusterConfigurationCreateWithoutLocationInput[] | ClusterConfigurationUncheckedCreateWithoutLocationInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLocationInput | ClusterConfigurationCreateOrConnectWithoutLocationInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutLocationInput | ClusterConfigurationUpsertWithWhereUniqueWithoutLocationInput[]
    createMany?: ClusterConfigurationCreateManyLocationInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutLocationInput | ClusterConfigurationUpdateWithWhereUniqueWithoutLocationInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutLocationInput | ClusterConfigurationUpdateManyWithWhereWithoutLocationInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type ClusterUncheckedUpdateManyWithoutClusterLocationNestedInput = {
    create?: XOR<ClusterCreateWithoutClusterLocationInput, ClusterUncheckedCreateWithoutClusterLocationInput> | ClusterCreateWithoutClusterLocationInput[] | ClusterUncheckedCreateWithoutClusterLocationInput[]
    connectOrCreate?: ClusterCreateOrConnectWithoutClusterLocationInput | ClusterCreateOrConnectWithoutClusterLocationInput[]
    upsert?: ClusterUpsertWithWhereUniqueWithoutClusterLocationInput | ClusterUpsertWithWhereUniqueWithoutClusterLocationInput[]
    createMany?: ClusterCreateManyClusterLocationInputEnvelope
    set?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    disconnect?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    delete?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    connect?: ClusterWhereUniqueInput | ClusterWhereUniqueInput[]
    update?: ClusterUpdateWithWhereUniqueWithoutClusterLocationInput | ClusterUpdateWithWhereUniqueWithoutClusterLocationInput[]
    updateMany?: ClusterUpdateManyWithWhereWithoutClusterLocationInput | ClusterUpdateManyWithWhereWithoutClusterLocationInput[]
    deleteMany?: ClusterScalarWhereInput | ClusterScalarWhereInput[]
  }

  export type ClusterConfigurationCreateNestedManyWithoutLoad_profileInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLoad_profileInput, ClusterConfigurationUncheckedCreateWithoutLoad_profileInput> | ClusterConfigurationCreateWithoutLoad_profileInput[] | ClusterConfigurationUncheckedCreateWithoutLoad_profileInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLoad_profileInput | ClusterConfigurationCreateOrConnectWithoutLoad_profileInput[]
    createMany?: ClusterConfigurationCreateManyLoad_profileInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type ClusterConfigurationUncheckedCreateNestedManyWithoutLoad_profileInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLoad_profileInput, ClusterConfigurationUncheckedCreateWithoutLoad_profileInput> | ClusterConfigurationCreateWithoutLoad_profileInput[] | ClusterConfigurationUncheckedCreateWithoutLoad_profileInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLoad_profileInput | ClusterConfigurationCreateOrConnectWithoutLoad_profileInput[]
    createMany?: ClusterConfigurationCreateManyLoad_profileInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type ClusterConfigurationUpdateManyWithoutLoad_profileNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLoad_profileInput, ClusterConfigurationUncheckedCreateWithoutLoad_profileInput> | ClusterConfigurationCreateWithoutLoad_profileInput[] | ClusterConfigurationUncheckedCreateWithoutLoad_profileInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLoad_profileInput | ClusterConfigurationCreateOrConnectWithoutLoad_profileInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutLoad_profileInput | ClusterConfigurationUpsertWithWhereUniqueWithoutLoad_profileInput[]
    createMany?: ClusterConfigurationCreateManyLoad_profileInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutLoad_profileInput | ClusterConfigurationUpdateWithWhereUniqueWithoutLoad_profileInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutLoad_profileInput | ClusterConfigurationUpdateManyWithWhereWithoutLoad_profileInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutLoad_profileNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutLoad_profileInput, ClusterConfigurationUncheckedCreateWithoutLoad_profileInput> | ClusterConfigurationCreateWithoutLoad_profileInput[] | ClusterConfigurationUncheckedCreateWithoutLoad_profileInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutLoad_profileInput | ClusterConfigurationCreateOrConnectWithoutLoad_profileInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutLoad_profileInput | ClusterConfigurationUpsertWithWhereUniqueWithoutLoad_profileInput[]
    createMany?: ClusterConfigurationCreateManyLoad_profileInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutLoad_profileInput | ClusterConfigurationUpdateWithWhereUniqueWithoutLoad_profileInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutLoad_profileInput | ClusterConfigurationUpdateManyWithWhereWithoutLoad_profileInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type ClusterConfigurationCreateNestedManyWithoutFan_configInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_configInput, ClusterConfigurationUncheckedCreateWithoutFan_configInput> | ClusterConfigurationCreateWithoutFan_configInput[] | ClusterConfigurationUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_configInput | ClusterConfigurationCreateOrConnectWithoutFan_configInput[]
    createMany?: ClusterConfigurationCreateManyFan_configInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type FanCreateNestedManyWithoutFan_configInput = {
    create?: XOR<FanCreateWithoutFan_configInput, FanUncheckedCreateWithoutFan_configInput> | FanCreateWithoutFan_configInput[] | FanUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: FanCreateOrConnectWithoutFan_configInput | FanCreateOrConnectWithoutFan_configInput[]
    createMany?: FanCreateManyFan_configInputEnvelope
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
  }

  export type ClusterConfigurationUncheckedCreateNestedManyWithoutFan_configInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_configInput, ClusterConfigurationUncheckedCreateWithoutFan_configInput> | ClusterConfigurationCreateWithoutFan_configInput[] | ClusterConfigurationUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_configInput | ClusterConfigurationCreateOrConnectWithoutFan_configInput[]
    createMany?: ClusterConfigurationCreateManyFan_configInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type FanUncheckedCreateNestedManyWithoutFan_configInput = {
    create?: XOR<FanCreateWithoutFan_configInput, FanUncheckedCreateWithoutFan_configInput> | FanCreateWithoutFan_configInput[] | FanUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: FanCreateOrConnectWithoutFan_configInput | FanCreateOrConnectWithoutFan_configInput[]
    createMany?: FanCreateManyFan_configInputEnvelope
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
  }

  export type NullableFloatFieldUpdateOperationsInput = {
    set?: number | null
    increment?: number
    decrement?: number
    multiply?: number
    divide?: number
  }

  export type ClusterConfigurationUpdateManyWithoutFan_configNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_configInput, ClusterConfigurationUncheckedCreateWithoutFan_configInput> | ClusterConfigurationCreateWithoutFan_configInput[] | ClusterConfigurationUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_configInput | ClusterConfigurationCreateOrConnectWithoutFan_configInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutFan_configInput | ClusterConfigurationUpsertWithWhereUniqueWithoutFan_configInput[]
    createMany?: ClusterConfigurationCreateManyFan_configInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutFan_configInput | ClusterConfigurationUpdateWithWhereUniqueWithoutFan_configInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutFan_configInput | ClusterConfigurationUpdateManyWithWhereWithoutFan_configInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type FanUpdateManyWithoutFan_configNestedInput = {
    create?: XOR<FanCreateWithoutFan_configInput, FanUncheckedCreateWithoutFan_configInput> | FanCreateWithoutFan_configInput[] | FanUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: FanCreateOrConnectWithoutFan_configInput | FanCreateOrConnectWithoutFan_configInput[]
    upsert?: FanUpsertWithWhereUniqueWithoutFan_configInput | FanUpsertWithWhereUniqueWithoutFan_configInput[]
    createMany?: FanCreateManyFan_configInputEnvelope
    set?: FanWhereUniqueInput | FanWhereUniqueInput[]
    disconnect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    delete?: FanWhereUniqueInput | FanWhereUniqueInput[]
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    update?: FanUpdateWithWhereUniqueWithoutFan_configInput | FanUpdateWithWhereUniqueWithoutFan_configInput[]
    updateMany?: FanUpdateManyWithWhereWithoutFan_configInput | FanUpdateManyWithWhereWithoutFan_configInput[]
    deleteMany?: FanScalarWhereInput | FanScalarWhereInput[]
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutFan_configNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_configInput, ClusterConfigurationUncheckedCreateWithoutFan_configInput> | ClusterConfigurationCreateWithoutFan_configInput[] | ClusterConfigurationUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_configInput | ClusterConfigurationCreateOrConnectWithoutFan_configInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutFan_configInput | ClusterConfigurationUpsertWithWhereUniqueWithoutFan_configInput[]
    createMany?: ClusterConfigurationCreateManyFan_configInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutFan_configInput | ClusterConfigurationUpdateWithWhereUniqueWithoutFan_configInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutFan_configInput | ClusterConfigurationUpdateManyWithWhereWithoutFan_configInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type FanUncheckedUpdateManyWithoutFan_configNestedInput = {
    create?: XOR<FanCreateWithoutFan_configInput, FanUncheckedCreateWithoutFan_configInput> | FanCreateWithoutFan_configInput[] | FanUncheckedCreateWithoutFan_configInput[]
    connectOrCreate?: FanCreateOrConnectWithoutFan_configInput | FanCreateOrConnectWithoutFan_configInput[]
    upsert?: FanUpsertWithWhereUniqueWithoutFan_configInput | FanUpsertWithWhereUniqueWithoutFan_configInput[]
    createMany?: FanCreateManyFan_configInputEnvelope
    set?: FanWhereUniqueInput | FanWhereUniqueInput[]
    disconnect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    delete?: FanWhereUniqueInput | FanWhereUniqueInput[]
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    update?: FanUpdateWithWhereUniqueWithoutFan_configInput | FanUpdateWithWhereUniqueWithoutFan_configInput[]
    updateMany?: FanUpdateManyWithWhereWithoutFan_configInput | FanUpdateManyWithWhereWithoutFan_configInput[]
    deleteMany?: FanScalarWhereInput | FanScalarWhereInput[]
  }

  export type ClusterConfigurationCreateNestedManyWithoutFan_modelInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_modelInput, ClusterConfigurationUncheckedCreateWithoutFan_modelInput> | ClusterConfigurationCreateWithoutFan_modelInput[] | ClusterConfigurationUncheckedCreateWithoutFan_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_modelInput | ClusterConfigurationCreateOrConnectWithoutFan_modelInput[]
    createMany?: ClusterConfigurationCreateManyFan_modelInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type FanCreateNestedManyWithoutCatalog_infoInput = {
    create?: XOR<FanCreateWithoutCatalog_infoInput, FanUncheckedCreateWithoutCatalog_infoInput> | FanCreateWithoutCatalog_infoInput[] | FanUncheckedCreateWithoutCatalog_infoInput[]
    connectOrCreate?: FanCreateOrConnectWithoutCatalog_infoInput | FanCreateOrConnectWithoutCatalog_infoInput[]
    createMany?: FanCreateManyCatalog_infoInputEnvelope
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
  }

  export type ClusterConfigurationUncheckedCreateNestedManyWithoutFan_modelInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_modelInput, ClusterConfigurationUncheckedCreateWithoutFan_modelInput> | ClusterConfigurationCreateWithoutFan_modelInput[] | ClusterConfigurationUncheckedCreateWithoutFan_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_modelInput | ClusterConfigurationCreateOrConnectWithoutFan_modelInput[]
    createMany?: ClusterConfigurationCreateManyFan_modelInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type FanUncheckedCreateNestedManyWithoutCatalog_infoInput = {
    create?: XOR<FanCreateWithoutCatalog_infoInput, FanUncheckedCreateWithoutCatalog_infoInput> | FanCreateWithoutCatalog_infoInput[] | FanUncheckedCreateWithoutCatalog_infoInput[]
    connectOrCreate?: FanCreateOrConnectWithoutCatalog_infoInput | FanCreateOrConnectWithoutCatalog_infoInput[]
    createMany?: FanCreateManyCatalog_infoInputEnvelope
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
  }

  export type ClusterConfigurationUpdateManyWithoutFan_modelNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_modelInput, ClusterConfigurationUncheckedCreateWithoutFan_modelInput> | ClusterConfigurationCreateWithoutFan_modelInput[] | ClusterConfigurationUncheckedCreateWithoutFan_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_modelInput | ClusterConfigurationCreateOrConnectWithoutFan_modelInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutFan_modelInput | ClusterConfigurationUpsertWithWhereUniqueWithoutFan_modelInput[]
    createMany?: ClusterConfigurationCreateManyFan_modelInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutFan_modelInput | ClusterConfigurationUpdateWithWhereUniqueWithoutFan_modelInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutFan_modelInput | ClusterConfigurationUpdateManyWithWhereWithoutFan_modelInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type FanUpdateManyWithoutCatalog_infoNestedInput = {
    create?: XOR<FanCreateWithoutCatalog_infoInput, FanUncheckedCreateWithoutCatalog_infoInput> | FanCreateWithoutCatalog_infoInput[] | FanUncheckedCreateWithoutCatalog_infoInput[]
    connectOrCreate?: FanCreateOrConnectWithoutCatalog_infoInput | FanCreateOrConnectWithoutCatalog_infoInput[]
    upsert?: FanUpsertWithWhereUniqueWithoutCatalog_infoInput | FanUpsertWithWhereUniqueWithoutCatalog_infoInput[]
    createMany?: FanCreateManyCatalog_infoInputEnvelope
    set?: FanWhereUniqueInput | FanWhereUniqueInput[]
    disconnect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    delete?: FanWhereUniqueInput | FanWhereUniqueInput[]
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    update?: FanUpdateWithWhereUniqueWithoutCatalog_infoInput | FanUpdateWithWhereUniqueWithoutCatalog_infoInput[]
    updateMany?: FanUpdateManyWithWhereWithoutCatalog_infoInput | FanUpdateManyWithWhereWithoutCatalog_infoInput[]
    deleteMany?: FanScalarWhereInput | FanScalarWhereInput[]
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutFan_modelNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutFan_modelInput, ClusterConfigurationUncheckedCreateWithoutFan_modelInput> | ClusterConfigurationCreateWithoutFan_modelInput[] | ClusterConfigurationUncheckedCreateWithoutFan_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutFan_modelInput | ClusterConfigurationCreateOrConnectWithoutFan_modelInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutFan_modelInput | ClusterConfigurationUpsertWithWhereUniqueWithoutFan_modelInput[]
    createMany?: ClusterConfigurationCreateManyFan_modelInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutFan_modelInput | ClusterConfigurationUpdateWithWhereUniqueWithoutFan_modelInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutFan_modelInput | ClusterConfigurationUpdateManyWithWhereWithoutFan_modelInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type FanUncheckedUpdateManyWithoutCatalog_infoNestedInput = {
    create?: XOR<FanCreateWithoutCatalog_infoInput, FanUncheckedCreateWithoutCatalog_infoInput> | FanCreateWithoutCatalog_infoInput[] | FanUncheckedCreateWithoutCatalog_infoInput[]
    connectOrCreate?: FanCreateOrConnectWithoutCatalog_infoInput | FanCreateOrConnectWithoutCatalog_infoInput[]
    upsert?: FanUpsertWithWhereUniqueWithoutCatalog_infoInput | FanUpsertWithWhereUniqueWithoutCatalog_infoInput[]
    createMany?: FanCreateManyCatalog_infoInputEnvelope
    set?: FanWhereUniqueInput | FanWhereUniqueInput[]
    disconnect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    delete?: FanWhereUniqueInput | FanWhereUniqueInput[]
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    update?: FanUpdateWithWhereUniqueWithoutCatalog_infoInput | FanUpdateWithWhereUniqueWithoutCatalog_infoInput[]
    updateMany?: FanUpdateManyWithWhereWithoutCatalog_infoInput | FanUpdateManyWithWhereWithoutCatalog_infoInput[]
    deleteMany?: FanScalarWhereInput | FanScalarWhereInput[]
  }

  export type ClusterConfigurationCreateNestedManyWithoutCooler_modelInput = {
    create?: XOR<ClusterConfigurationCreateWithoutCooler_modelInput, ClusterConfigurationUncheckedCreateWithoutCooler_modelInput> | ClusterConfigurationCreateWithoutCooler_modelInput[] | ClusterConfigurationUncheckedCreateWithoutCooler_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutCooler_modelInput | ClusterConfigurationCreateOrConnectWithoutCooler_modelInput[]
    createMany?: ClusterConfigurationCreateManyCooler_modelInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type ClusterConfigurationUncheckedCreateNestedManyWithoutCooler_modelInput = {
    create?: XOR<ClusterConfigurationCreateWithoutCooler_modelInput, ClusterConfigurationUncheckedCreateWithoutCooler_modelInput> | ClusterConfigurationCreateWithoutCooler_modelInput[] | ClusterConfigurationUncheckedCreateWithoutCooler_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutCooler_modelInput | ClusterConfigurationCreateOrConnectWithoutCooler_modelInput[]
    createMany?: ClusterConfigurationCreateManyCooler_modelInputEnvelope
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
  }

  export type ClusterConfigurationUpdateManyWithoutCooler_modelNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutCooler_modelInput, ClusterConfigurationUncheckedCreateWithoutCooler_modelInput> | ClusterConfigurationCreateWithoutCooler_modelInput[] | ClusterConfigurationUncheckedCreateWithoutCooler_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutCooler_modelInput | ClusterConfigurationCreateOrConnectWithoutCooler_modelInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutCooler_modelInput | ClusterConfigurationUpsertWithWhereUniqueWithoutCooler_modelInput[]
    createMany?: ClusterConfigurationCreateManyCooler_modelInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutCooler_modelInput | ClusterConfigurationUpdateWithWhereUniqueWithoutCooler_modelInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutCooler_modelInput | ClusterConfigurationUpdateManyWithWhereWithoutCooler_modelInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutCooler_modelNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutCooler_modelInput, ClusterConfigurationUncheckedCreateWithoutCooler_modelInput> | ClusterConfigurationCreateWithoutCooler_modelInput[] | ClusterConfigurationUncheckedCreateWithoutCooler_modelInput[]
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutCooler_modelInput | ClusterConfigurationCreateOrConnectWithoutCooler_modelInput[]
    upsert?: ClusterConfigurationUpsertWithWhereUniqueWithoutCooler_modelInput | ClusterConfigurationUpsertWithWhereUniqueWithoutCooler_modelInput[]
    createMany?: ClusterConfigurationCreateManyCooler_modelInputEnvelope
    set?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    disconnect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    delete?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    connect?: ClusterConfigurationWhereUniqueInput | ClusterConfigurationWhereUniqueInput[]
    update?: ClusterConfigurationUpdateWithWhereUniqueWithoutCooler_modelInput | ClusterConfigurationUpdateWithWhereUniqueWithoutCooler_modelInput[]
    updateMany?: ClusterConfigurationUpdateManyWithWhereWithoutCooler_modelInput | ClusterConfigurationUpdateManyWithWhereWithoutCooler_modelInput[]
    deleteMany?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
  }

  export type LoadProfileCreateNestedOneWithoutCluster_configurationsInput = {
    create?: XOR<LoadProfileCreateWithoutCluster_configurationsInput, LoadProfileUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: LoadProfileCreateOrConnectWithoutCluster_configurationsInput
    connect?: LoadProfileWhereUniqueInput
  }

  export type CpuCoolerCatalogCreateNestedOneWithoutCluster_configsInput = {
    create?: XOR<CpuCoolerCatalogCreateWithoutCluster_configsInput, CpuCoolerCatalogUncheckedCreateWithoutCluster_configsInput>
    connectOrCreate?: CpuCoolerCatalogCreateOrConnectWithoutCluster_configsInput
    connect?: CpuCoolerCatalogWhereUniqueInput
  }

  export type FanCatalogCreateNestedOneWithoutCluster_configurationsInput = {
    create?: XOR<FanCatalogCreateWithoutCluster_configurationsInput, FanCatalogUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: FanCatalogCreateOrConnectWithoutCluster_configurationsInput
    connect?: FanCatalogWhereUniqueInput
  }

  export type ClusterLocationCreateNestedOneWithoutCluster_configurationsInput = {
    create?: XOR<ClusterLocationCreateWithoutCluster_configurationsInput, ClusterLocationUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: ClusterLocationCreateOrConnectWithoutCluster_configurationsInput
    connect?: ClusterLocationWhereUniqueInput
  }

  export type FanConfigurationCreateNestedOneWithoutCluster_configurationsInput = {
    create?: XOR<FanConfigurationCreateWithoutCluster_configurationsInput, FanConfigurationUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: FanConfigurationCreateOrConnectWithoutCluster_configurationsInput
    connect?: FanConfigurationWhereUniqueInput
  }

  export type ServerCreateNestedManyWithoutConfigurationInput = {
    create?: XOR<ServerCreateWithoutConfigurationInput, ServerUncheckedCreateWithoutConfigurationInput> | ServerCreateWithoutConfigurationInput[] | ServerUncheckedCreateWithoutConfigurationInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutConfigurationInput | ServerCreateOrConnectWithoutConfigurationInput[]
    createMany?: ServerCreateManyConfigurationInputEnvelope
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
  }

  export type ServerUncheckedCreateNestedManyWithoutConfigurationInput = {
    create?: XOR<ServerCreateWithoutConfigurationInput, ServerUncheckedCreateWithoutConfigurationInput> | ServerCreateWithoutConfigurationInput[] | ServerUncheckedCreateWithoutConfigurationInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutConfigurationInput | ServerCreateOrConnectWithoutConfigurationInput[]
    createMany?: ServerCreateManyConfigurationInputEnvelope
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
  }

  export type LoadProfileUpdateOneWithoutCluster_configurationsNestedInput = {
    create?: XOR<LoadProfileCreateWithoutCluster_configurationsInput, LoadProfileUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: LoadProfileCreateOrConnectWithoutCluster_configurationsInput
    upsert?: LoadProfileUpsertWithoutCluster_configurationsInput
    disconnect?: LoadProfileWhereInput | boolean
    delete?: LoadProfileWhereInput | boolean
    connect?: LoadProfileWhereUniqueInput
    update?: XOR<XOR<LoadProfileUpdateToOneWithWhereWithoutCluster_configurationsInput, LoadProfileUpdateWithoutCluster_configurationsInput>, LoadProfileUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type CpuCoolerCatalogUpdateOneRequiredWithoutCluster_configsNestedInput = {
    create?: XOR<CpuCoolerCatalogCreateWithoutCluster_configsInput, CpuCoolerCatalogUncheckedCreateWithoutCluster_configsInput>
    connectOrCreate?: CpuCoolerCatalogCreateOrConnectWithoutCluster_configsInput
    upsert?: CpuCoolerCatalogUpsertWithoutCluster_configsInput
    connect?: CpuCoolerCatalogWhereUniqueInput
    update?: XOR<XOR<CpuCoolerCatalogUpdateToOneWithWhereWithoutCluster_configsInput, CpuCoolerCatalogUpdateWithoutCluster_configsInput>, CpuCoolerCatalogUncheckedUpdateWithoutCluster_configsInput>
  }

  export type FanCatalogUpdateOneWithoutCluster_configurationsNestedInput = {
    create?: XOR<FanCatalogCreateWithoutCluster_configurationsInput, FanCatalogUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: FanCatalogCreateOrConnectWithoutCluster_configurationsInput
    upsert?: FanCatalogUpsertWithoutCluster_configurationsInput
    disconnect?: FanCatalogWhereInput | boolean
    delete?: FanCatalogWhereInput | boolean
    connect?: FanCatalogWhereUniqueInput
    update?: XOR<XOR<FanCatalogUpdateToOneWithWhereWithoutCluster_configurationsInput, FanCatalogUpdateWithoutCluster_configurationsInput>, FanCatalogUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type ClusterLocationUpdateOneWithoutCluster_configurationsNestedInput = {
    create?: XOR<ClusterLocationCreateWithoutCluster_configurationsInput, ClusterLocationUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: ClusterLocationCreateOrConnectWithoutCluster_configurationsInput
    upsert?: ClusterLocationUpsertWithoutCluster_configurationsInput
    disconnect?: ClusterLocationWhereInput | boolean
    delete?: ClusterLocationWhereInput | boolean
    connect?: ClusterLocationWhereUniqueInput
    update?: XOR<XOR<ClusterLocationUpdateToOneWithWhereWithoutCluster_configurationsInput, ClusterLocationUpdateWithoutCluster_configurationsInput>, ClusterLocationUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type FanConfigurationUpdateOneWithoutCluster_configurationsNestedInput = {
    create?: XOR<FanConfigurationCreateWithoutCluster_configurationsInput, FanConfigurationUncheckedCreateWithoutCluster_configurationsInput>
    connectOrCreate?: FanConfigurationCreateOrConnectWithoutCluster_configurationsInput
    upsert?: FanConfigurationUpsertWithoutCluster_configurationsInput
    disconnect?: FanConfigurationWhereInput | boolean
    delete?: FanConfigurationWhereInput | boolean
    connect?: FanConfigurationWhereUniqueInput
    update?: XOR<XOR<FanConfigurationUpdateToOneWithWhereWithoutCluster_configurationsInput, FanConfigurationUpdateWithoutCluster_configurationsInput>, FanConfigurationUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type ServerUpdateManyWithoutConfigurationNestedInput = {
    create?: XOR<ServerCreateWithoutConfigurationInput, ServerUncheckedCreateWithoutConfigurationInput> | ServerCreateWithoutConfigurationInput[] | ServerUncheckedCreateWithoutConfigurationInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutConfigurationInput | ServerCreateOrConnectWithoutConfigurationInput[]
    upsert?: ServerUpsertWithWhereUniqueWithoutConfigurationInput | ServerUpsertWithWhereUniqueWithoutConfigurationInput[]
    createMany?: ServerCreateManyConfigurationInputEnvelope
    set?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    disconnect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    delete?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    update?: ServerUpdateWithWhereUniqueWithoutConfigurationInput | ServerUpdateWithWhereUniqueWithoutConfigurationInput[]
    updateMany?: ServerUpdateManyWithWhereWithoutConfigurationInput | ServerUpdateManyWithWhereWithoutConfigurationInput[]
    deleteMany?: ServerScalarWhereInput | ServerScalarWhereInput[]
  }

  export type NullableIntFieldUpdateOperationsInput = {
    set?: number | null
    increment?: number
    decrement?: number
    multiply?: number
    divide?: number
  }

  export type ServerUncheckedUpdateManyWithoutConfigurationNestedInput = {
    create?: XOR<ServerCreateWithoutConfigurationInput, ServerUncheckedCreateWithoutConfigurationInput> | ServerCreateWithoutConfigurationInput[] | ServerUncheckedCreateWithoutConfigurationInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutConfigurationInput | ServerCreateOrConnectWithoutConfigurationInput[]
    upsert?: ServerUpsertWithWhereUniqueWithoutConfigurationInput | ServerUpsertWithWhereUniqueWithoutConfigurationInput[]
    createMany?: ServerCreateManyConfigurationInputEnvelope
    set?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    disconnect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    delete?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    update?: ServerUpdateWithWhereUniqueWithoutConfigurationInput | ServerUpdateWithWhereUniqueWithoutConfigurationInput[]
    updateMany?: ServerUpdateManyWithWhereWithoutConfigurationInput | ServerUpdateManyWithWhereWithoutConfigurationInput[]
    deleteMany?: ServerScalarWhereInput | ServerScalarWhereInput[]
  }

  export type ClusterLocationCreateNestedOneWithoutClustersInput = {
    create?: XOR<ClusterLocationCreateWithoutClustersInput, ClusterLocationUncheckedCreateWithoutClustersInput>
    connectOrCreate?: ClusterLocationCreateOrConnectWithoutClustersInput
    connect?: ClusterLocationWhereUniqueInput
  }

  export type ServerCreateNestedManyWithoutClusterInput = {
    create?: XOR<ServerCreateWithoutClusterInput, ServerUncheckedCreateWithoutClusterInput> | ServerCreateWithoutClusterInput[] | ServerUncheckedCreateWithoutClusterInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutClusterInput | ServerCreateOrConnectWithoutClusterInput[]
    createMany?: ServerCreateManyClusterInputEnvelope
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
  }

  export type ServerUncheckedCreateNestedManyWithoutClusterInput = {
    create?: XOR<ServerCreateWithoutClusterInput, ServerUncheckedCreateWithoutClusterInput> | ServerCreateWithoutClusterInput[] | ServerUncheckedCreateWithoutClusterInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutClusterInput | ServerCreateOrConnectWithoutClusterInput[]
    createMany?: ServerCreateManyClusterInputEnvelope
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
  }

  export type ClusterLocationUpdateOneRequiredWithoutClustersNestedInput = {
    create?: XOR<ClusterLocationCreateWithoutClustersInput, ClusterLocationUncheckedCreateWithoutClustersInput>
    connectOrCreate?: ClusterLocationCreateOrConnectWithoutClustersInput
    upsert?: ClusterLocationUpsertWithoutClustersInput
    connect?: ClusterLocationWhereUniqueInput
    update?: XOR<XOR<ClusterLocationUpdateToOneWithWhereWithoutClustersInput, ClusterLocationUpdateWithoutClustersInput>, ClusterLocationUncheckedUpdateWithoutClustersInput>
  }

  export type ServerUpdateManyWithoutClusterNestedInput = {
    create?: XOR<ServerCreateWithoutClusterInput, ServerUncheckedCreateWithoutClusterInput> | ServerCreateWithoutClusterInput[] | ServerUncheckedCreateWithoutClusterInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutClusterInput | ServerCreateOrConnectWithoutClusterInput[]
    upsert?: ServerUpsertWithWhereUniqueWithoutClusterInput | ServerUpsertWithWhereUniqueWithoutClusterInput[]
    createMany?: ServerCreateManyClusterInputEnvelope
    set?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    disconnect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    delete?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    update?: ServerUpdateWithWhereUniqueWithoutClusterInput | ServerUpdateWithWhereUniqueWithoutClusterInput[]
    updateMany?: ServerUpdateManyWithWhereWithoutClusterInput | ServerUpdateManyWithWhereWithoutClusterInput[]
    deleteMany?: ServerScalarWhereInput | ServerScalarWhereInput[]
  }

  export type ServerUncheckedUpdateManyWithoutClusterNestedInput = {
    create?: XOR<ServerCreateWithoutClusterInput, ServerUncheckedCreateWithoutClusterInput> | ServerCreateWithoutClusterInput[] | ServerUncheckedCreateWithoutClusterInput[]
    connectOrCreate?: ServerCreateOrConnectWithoutClusterInput | ServerCreateOrConnectWithoutClusterInput[]
    upsert?: ServerUpsertWithWhereUniqueWithoutClusterInput | ServerUpsertWithWhereUniqueWithoutClusterInput[]
    createMany?: ServerCreateManyClusterInputEnvelope
    set?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    disconnect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    delete?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    connect?: ServerWhereUniqueInput | ServerWhereUniqueInput[]
    update?: ServerUpdateWithWhereUniqueWithoutClusterInput | ServerUpdateWithWhereUniqueWithoutClusterInput[]
    updateMany?: ServerUpdateManyWithWhereWithoutClusterInput | ServerUpdateManyWithWhereWithoutClusterInput[]
    deleteMany?: ServerScalarWhereInput | ServerScalarWhereInput[]
  }

  export type ClusterCreateNestedOneWithoutServersInput = {
    create?: XOR<ClusterCreateWithoutServersInput, ClusterUncheckedCreateWithoutServersInput>
    connectOrCreate?: ClusterCreateOrConnectWithoutServersInput
    connect?: ClusterWhereUniqueInput
  }

  export type ClusterConfigurationCreateNestedOneWithoutServersInput = {
    create?: XOR<ClusterConfigurationCreateWithoutServersInput, ClusterConfigurationUncheckedCreateWithoutServersInput>
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutServersInput
    connect?: ClusterConfigurationWhereUniqueInput
  }

  export type SensorCreateNestedManyWithoutServerInput = {
    create?: XOR<SensorCreateWithoutServerInput, SensorUncheckedCreateWithoutServerInput> | SensorCreateWithoutServerInput[] | SensorUncheckedCreateWithoutServerInput[]
    connectOrCreate?: SensorCreateOrConnectWithoutServerInput | SensorCreateOrConnectWithoutServerInput[]
    createMany?: SensorCreateManyServerInputEnvelope
    connect?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
  }

  export type FanCreateNestedManyWithoutServerInput = {
    create?: XOR<FanCreateWithoutServerInput, FanUncheckedCreateWithoutServerInput> | FanCreateWithoutServerInput[] | FanUncheckedCreateWithoutServerInput[]
    connectOrCreate?: FanCreateOrConnectWithoutServerInput | FanCreateOrConnectWithoutServerInput[]
    createMany?: FanCreateManyServerInputEnvelope
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
  }

  export type SensorUncheckedCreateNestedManyWithoutServerInput = {
    create?: XOR<SensorCreateWithoutServerInput, SensorUncheckedCreateWithoutServerInput> | SensorCreateWithoutServerInput[] | SensorUncheckedCreateWithoutServerInput[]
    connectOrCreate?: SensorCreateOrConnectWithoutServerInput | SensorCreateOrConnectWithoutServerInput[]
    createMany?: SensorCreateManyServerInputEnvelope
    connect?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
  }

  export type FanUncheckedCreateNestedManyWithoutServerInput = {
    create?: XOR<FanCreateWithoutServerInput, FanUncheckedCreateWithoutServerInput> | FanCreateWithoutServerInput[] | FanUncheckedCreateWithoutServerInput[]
    connectOrCreate?: FanCreateOrConnectWithoutServerInput | FanCreateOrConnectWithoutServerInput[]
    createMany?: FanCreateManyServerInputEnvelope
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
  }

  export type ClusterUpdateOneRequiredWithoutServersNestedInput = {
    create?: XOR<ClusterCreateWithoutServersInput, ClusterUncheckedCreateWithoutServersInput>
    connectOrCreate?: ClusterCreateOrConnectWithoutServersInput
    upsert?: ClusterUpsertWithoutServersInput
    connect?: ClusterWhereUniqueInput
    update?: XOR<XOR<ClusterUpdateToOneWithWhereWithoutServersInput, ClusterUpdateWithoutServersInput>, ClusterUncheckedUpdateWithoutServersInput>
  }

  export type ClusterConfigurationUpdateOneWithoutServersNestedInput = {
    create?: XOR<ClusterConfigurationCreateWithoutServersInput, ClusterConfigurationUncheckedCreateWithoutServersInput>
    connectOrCreate?: ClusterConfigurationCreateOrConnectWithoutServersInput
    upsert?: ClusterConfigurationUpsertWithoutServersInput
    disconnect?: ClusterConfigurationWhereInput | boolean
    delete?: ClusterConfigurationWhereInput | boolean
    connect?: ClusterConfigurationWhereUniqueInput
    update?: XOR<XOR<ClusterConfigurationUpdateToOneWithWhereWithoutServersInput, ClusterConfigurationUpdateWithoutServersInput>, ClusterConfigurationUncheckedUpdateWithoutServersInput>
  }

  export type SensorUpdateManyWithoutServerNestedInput = {
    create?: XOR<SensorCreateWithoutServerInput, SensorUncheckedCreateWithoutServerInput> | SensorCreateWithoutServerInput[] | SensorUncheckedCreateWithoutServerInput[]
    connectOrCreate?: SensorCreateOrConnectWithoutServerInput | SensorCreateOrConnectWithoutServerInput[]
    upsert?: SensorUpsertWithWhereUniqueWithoutServerInput | SensorUpsertWithWhereUniqueWithoutServerInput[]
    createMany?: SensorCreateManyServerInputEnvelope
    set?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    disconnect?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    delete?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    connect?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    update?: SensorUpdateWithWhereUniqueWithoutServerInput | SensorUpdateWithWhereUniqueWithoutServerInput[]
    updateMany?: SensorUpdateManyWithWhereWithoutServerInput | SensorUpdateManyWithWhereWithoutServerInput[]
    deleteMany?: SensorScalarWhereInput | SensorScalarWhereInput[]
  }

  export type FanUpdateManyWithoutServerNestedInput = {
    create?: XOR<FanCreateWithoutServerInput, FanUncheckedCreateWithoutServerInput> | FanCreateWithoutServerInput[] | FanUncheckedCreateWithoutServerInput[]
    connectOrCreate?: FanCreateOrConnectWithoutServerInput | FanCreateOrConnectWithoutServerInput[]
    upsert?: FanUpsertWithWhereUniqueWithoutServerInput | FanUpsertWithWhereUniqueWithoutServerInput[]
    createMany?: FanCreateManyServerInputEnvelope
    set?: FanWhereUniqueInput | FanWhereUniqueInput[]
    disconnect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    delete?: FanWhereUniqueInput | FanWhereUniqueInput[]
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    update?: FanUpdateWithWhereUniqueWithoutServerInput | FanUpdateWithWhereUniqueWithoutServerInput[]
    updateMany?: FanUpdateManyWithWhereWithoutServerInput | FanUpdateManyWithWhereWithoutServerInput[]
    deleteMany?: FanScalarWhereInput | FanScalarWhereInput[]
  }

  export type SensorUncheckedUpdateManyWithoutServerNestedInput = {
    create?: XOR<SensorCreateWithoutServerInput, SensorUncheckedCreateWithoutServerInput> | SensorCreateWithoutServerInput[] | SensorUncheckedCreateWithoutServerInput[]
    connectOrCreate?: SensorCreateOrConnectWithoutServerInput | SensorCreateOrConnectWithoutServerInput[]
    upsert?: SensorUpsertWithWhereUniqueWithoutServerInput | SensorUpsertWithWhereUniqueWithoutServerInput[]
    createMany?: SensorCreateManyServerInputEnvelope
    set?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    disconnect?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    delete?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    connect?: SensorWhereUniqueInput | SensorWhereUniqueInput[]
    update?: SensorUpdateWithWhereUniqueWithoutServerInput | SensorUpdateWithWhereUniqueWithoutServerInput[]
    updateMany?: SensorUpdateManyWithWhereWithoutServerInput | SensorUpdateManyWithWhereWithoutServerInput[]
    deleteMany?: SensorScalarWhereInput | SensorScalarWhereInput[]
  }

  export type FanUncheckedUpdateManyWithoutServerNestedInput = {
    create?: XOR<FanCreateWithoutServerInput, FanUncheckedCreateWithoutServerInput> | FanCreateWithoutServerInput[] | FanUncheckedCreateWithoutServerInput[]
    connectOrCreate?: FanCreateOrConnectWithoutServerInput | FanCreateOrConnectWithoutServerInput[]
    upsert?: FanUpsertWithWhereUniqueWithoutServerInput | FanUpsertWithWhereUniqueWithoutServerInput[]
    createMany?: FanCreateManyServerInputEnvelope
    set?: FanWhereUniqueInput | FanWhereUniqueInput[]
    disconnect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    delete?: FanWhereUniqueInput | FanWhereUniqueInput[]
    connect?: FanWhereUniqueInput | FanWhereUniqueInput[]
    update?: FanUpdateWithWhereUniqueWithoutServerInput | FanUpdateWithWhereUniqueWithoutServerInput[]
    updateMany?: FanUpdateManyWithWhereWithoutServerInput | FanUpdateManyWithWhereWithoutServerInput[]
    deleteMany?: FanScalarWhereInput | FanScalarWhereInput[]
  }

  export type ServerCreateNestedOneWithoutFansInput = {
    create?: XOR<ServerCreateWithoutFansInput, ServerUncheckedCreateWithoutFansInput>
    connectOrCreate?: ServerCreateOrConnectWithoutFansInput
    connect?: ServerWhereUniqueInput
  }

  export type FanCatalogCreateNestedOneWithoutFansInput = {
    create?: XOR<FanCatalogCreateWithoutFansInput, FanCatalogUncheckedCreateWithoutFansInput>
    connectOrCreate?: FanCatalogCreateOrConnectWithoutFansInput
    connect?: FanCatalogWhereUniqueInput
  }

  export type FanConfigurationCreateNestedOneWithoutFansInput = {
    create?: XOR<FanConfigurationCreateWithoutFansInput, FanConfigurationUncheckedCreateWithoutFansInput>
    connectOrCreate?: FanConfigurationCreateOrConnectWithoutFansInput
    connect?: FanConfigurationWhereUniqueInput
  }

  export type ServerUpdateOneRequiredWithoutFansNestedInput = {
    create?: XOR<ServerCreateWithoutFansInput, ServerUncheckedCreateWithoutFansInput>
    connectOrCreate?: ServerCreateOrConnectWithoutFansInput
    upsert?: ServerUpsertWithoutFansInput
    connect?: ServerWhereUniqueInput
    update?: XOR<XOR<ServerUpdateToOneWithWhereWithoutFansInput, ServerUpdateWithoutFansInput>, ServerUncheckedUpdateWithoutFansInput>
  }

  export type FanCatalogUpdateOneWithoutFansNestedInput = {
    create?: XOR<FanCatalogCreateWithoutFansInput, FanCatalogUncheckedCreateWithoutFansInput>
    connectOrCreate?: FanCatalogCreateOrConnectWithoutFansInput
    upsert?: FanCatalogUpsertWithoutFansInput
    disconnect?: FanCatalogWhereInput | boolean
    delete?: FanCatalogWhereInput | boolean
    connect?: FanCatalogWhereUniqueInput
    update?: XOR<XOR<FanCatalogUpdateToOneWithWhereWithoutFansInput, FanCatalogUpdateWithoutFansInput>, FanCatalogUncheckedUpdateWithoutFansInput>
  }

  export type FanConfigurationUpdateOneWithoutFansNestedInput = {
    create?: XOR<FanConfigurationCreateWithoutFansInput, FanConfigurationUncheckedCreateWithoutFansInput>
    connectOrCreate?: FanConfigurationCreateOrConnectWithoutFansInput
    upsert?: FanConfigurationUpsertWithoutFansInput
    disconnect?: FanConfigurationWhereInput | boolean
    delete?: FanConfigurationWhereInput | boolean
    connect?: FanConfigurationWhereUniqueInput
    update?: XOR<XOR<FanConfigurationUpdateToOneWithWhereWithoutFansInput, FanConfigurationUpdateWithoutFansInput>, FanConfigurationUncheckedUpdateWithoutFansInput>
  }

  export type ServerCreateNestedOneWithoutSensorsInput = {
    create?: XOR<ServerCreateWithoutSensorsInput, ServerUncheckedCreateWithoutSensorsInput>
    connectOrCreate?: ServerCreateOrConnectWithoutSensorsInput
    connect?: ServerWhereUniqueInput
  }

  export type SensorDataCreateNestedManyWithoutSensorInput = {
    create?: XOR<SensorDataCreateWithoutSensorInput, SensorDataUncheckedCreateWithoutSensorInput> | SensorDataCreateWithoutSensorInput[] | SensorDataUncheckedCreateWithoutSensorInput[]
    connectOrCreate?: SensorDataCreateOrConnectWithoutSensorInput | SensorDataCreateOrConnectWithoutSensorInput[]
    createMany?: SensorDataCreateManySensorInputEnvelope
    connect?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
  }

  export type SensorDataUncheckedCreateNestedManyWithoutSensorInput = {
    create?: XOR<SensorDataCreateWithoutSensorInput, SensorDataUncheckedCreateWithoutSensorInput> | SensorDataCreateWithoutSensorInput[] | SensorDataUncheckedCreateWithoutSensorInput[]
    connectOrCreate?: SensorDataCreateOrConnectWithoutSensorInput | SensorDataCreateOrConnectWithoutSensorInput[]
    createMany?: SensorDataCreateManySensorInputEnvelope
    connect?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
  }

  export type ServerUpdateOneRequiredWithoutSensorsNestedInput = {
    create?: XOR<ServerCreateWithoutSensorsInput, ServerUncheckedCreateWithoutSensorsInput>
    connectOrCreate?: ServerCreateOrConnectWithoutSensorsInput
    upsert?: ServerUpsertWithoutSensorsInput
    connect?: ServerWhereUniqueInput
    update?: XOR<XOR<ServerUpdateToOneWithWhereWithoutSensorsInput, ServerUpdateWithoutSensorsInput>, ServerUncheckedUpdateWithoutSensorsInput>
  }

  export type SensorDataUpdateManyWithoutSensorNestedInput = {
    create?: XOR<SensorDataCreateWithoutSensorInput, SensorDataUncheckedCreateWithoutSensorInput> | SensorDataCreateWithoutSensorInput[] | SensorDataUncheckedCreateWithoutSensorInput[]
    connectOrCreate?: SensorDataCreateOrConnectWithoutSensorInput | SensorDataCreateOrConnectWithoutSensorInput[]
    upsert?: SensorDataUpsertWithWhereUniqueWithoutSensorInput | SensorDataUpsertWithWhereUniqueWithoutSensorInput[]
    createMany?: SensorDataCreateManySensorInputEnvelope
    set?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    disconnect?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    delete?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    connect?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    update?: SensorDataUpdateWithWhereUniqueWithoutSensorInput | SensorDataUpdateWithWhereUniqueWithoutSensorInput[]
    updateMany?: SensorDataUpdateManyWithWhereWithoutSensorInput | SensorDataUpdateManyWithWhereWithoutSensorInput[]
    deleteMany?: SensorDataScalarWhereInput | SensorDataScalarWhereInput[]
  }

  export type SensorDataUncheckedUpdateManyWithoutSensorNestedInput = {
    create?: XOR<SensorDataCreateWithoutSensorInput, SensorDataUncheckedCreateWithoutSensorInput> | SensorDataCreateWithoutSensorInput[] | SensorDataUncheckedCreateWithoutSensorInput[]
    connectOrCreate?: SensorDataCreateOrConnectWithoutSensorInput | SensorDataCreateOrConnectWithoutSensorInput[]
    upsert?: SensorDataUpsertWithWhereUniqueWithoutSensorInput | SensorDataUpsertWithWhereUniqueWithoutSensorInput[]
    createMany?: SensorDataCreateManySensorInputEnvelope
    set?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    disconnect?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    delete?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    connect?: SensorDataWhereUniqueInput | SensorDataWhereUniqueInput[]
    update?: SensorDataUpdateWithWhereUniqueWithoutSensorInput | SensorDataUpdateWithWhereUniqueWithoutSensorInput[]
    updateMany?: SensorDataUpdateManyWithWhereWithoutSensorInput | SensorDataUpdateManyWithWhereWithoutSensorInput[]
    deleteMany?: SensorDataScalarWhereInput | SensorDataScalarWhereInput[]
  }

  export type SensorCreateNestedOneWithoutDataInput = {
    create?: XOR<SensorCreateWithoutDataInput, SensorUncheckedCreateWithoutDataInput>
    connectOrCreate?: SensorCreateOrConnectWithoutDataInput
    connect?: SensorWhereUniqueInput
  }

  export type SensorUpdateOneRequiredWithoutDataNestedInput = {
    create?: XOR<SensorCreateWithoutDataInput, SensorUncheckedCreateWithoutDataInput>
    connectOrCreate?: SensorCreateOrConnectWithoutDataInput
    upsert?: SensorUpsertWithoutDataInput
    connect?: SensorWhereUniqueInput
    update?: XOR<XOR<SensorUpdateToOneWithWhereWithoutDataInput, SensorUpdateWithoutDataInput>, SensorUncheckedUpdateWithoutDataInput>
  }

  export type NestedIntFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel>
    in?: number[] | ListIntFieldRefInput<$PrismaModel>
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel>
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntFilter<$PrismaModel> | number
  }

  export type NestedStringFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel>
    in?: string[] | ListStringFieldRefInput<$PrismaModel>
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel>
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    not?: NestedStringFilter<$PrismaModel> | string
  }

  export type NestedStringNullableFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel> | null
    in?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    not?: NestedStringNullableFilter<$PrismaModel> | string | null
  }

  export type NestedFloatFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel>
    in?: number[] | ListFloatFieldRefInput<$PrismaModel>
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel>
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatFilter<$PrismaModel> | number
  }

  export type NestedDateTimeFilter<$PrismaModel = never> = {
    equals?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    in?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    notIn?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    lt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    lte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    not?: NestedDateTimeFilter<$PrismaModel> | Date | string
  }

  export type NestedIntWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel>
    in?: number[] | ListIntFieldRefInput<$PrismaModel>
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel>
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntWithAggregatesFilter<$PrismaModel> | number
    _count?: NestedIntFilter<$PrismaModel>
    _avg?: NestedFloatFilter<$PrismaModel>
    _sum?: NestedIntFilter<$PrismaModel>
    _min?: NestedIntFilter<$PrismaModel>
    _max?: NestedIntFilter<$PrismaModel>
  }

  export type NestedStringWithAggregatesFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel>
    in?: string[] | ListStringFieldRefInput<$PrismaModel>
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel>
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    not?: NestedStringWithAggregatesFilter<$PrismaModel> | string
    _count?: NestedIntFilter<$PrismaModel>
    _min?: NestedStringFilter<$PrismaModel>
    _max?: NestedStringFilter<$PrismaModel>
  }

  export type NestedStringNullableWithAggregatesFilter<$PrismaModel = never> = {
    equals?: string | StringFieldRefInput<$PrismaModel> | null
    in?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    notIn?: string[] | ListStringFieldRefInput<$PrismaModel> | null
    lt?: string | StringFieldRefInput<$PrismaModel>
    lte?: string | StringFieldRefInput<$PrismaModel>
    gt?: string | StringFieldRefInput<$PrismaModel>
    gte?: string | StringFieldRefInput<$PrismaModel>
    contains?: string | StringFieldRefInput<$PrismaModel>
    startsWith?: string | StringFieldRefInput<$PrismaModel>
    endsWith?: string | StringFieldRefInput<$PrismaModel>
    not?: NestedStringNullableWithAggregatesFilter<$PrismaModel> | string | null
    _count?: NestedIntNullableFilter<$PrismaModel>
    _min?: NestedStringNullableFilter<$PrismaModel>
    _max?: NestedStringNullableFilter<$PrismaModel>
  }

  export type NestedIntNullableFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel> | null
    in?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntNullableFilter<$PrismaModel> | number | null
  }

  export type NestedFloatWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel>
    in?: number[] | ListFloatFieldRefInput<$PrismaModel>
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel>
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatWithAggregatesFilter<$PrismaModel> | number
    _count?: NestedIntFilter<$PrismaModel>
    _avg?: NestedFloatFilter<$PrismaModel>
    _sum?: NestedFloatFilter<$PrismaModel>
    _min?: NestedFloatFilter<$PrismaModel>
    _max?: NestedFloatFilter<$PrismaModel>
  }

  export type NestedDateTimeWithAggregatesFilter<$PrismaModel = never> = {
    equals?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    in?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    notIn?: Date[] | string[] | ListDateTimeFieldRefInput<$PrismaModel>
    lt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    lte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gt?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    gte?: Date | string | DateTimeFieldRefInput<$PrismaModel>
    not?: NestedDateTimeWithAggregatesFilter<$PrismaModel> | Date | string
    _count?: NestedIntFilter<$PrismaModel>
    _min?: NestedDateTimeFilter<$PrismaModel>
    _max?: NestedDateTimeFilter<$PrismaModel>
  }

  export type NestedFloatNullableFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel> | null
    in?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatNullableFilter<$PrismaModel> | number | null
  }

  export type NestedFloatNullableWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | FloatFieldRefInput<$PrismaModel> | null
    in?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListFloatFieldRefInput<$PrismaModel> | null
    lt?: number | FloatFieldRefInput<$PrismaModel>
    lte?: number | FloatFieldRefInput<$PrismaModel>
    gt?: number | FloatFieldRefInput<$PrismaModel>
    gte?: number | FloatFieldRefInput<$PrismaModel>
    not?: NestedFloatNullableWithAggregatesFilter<$PrismaModel> | number | null
    _count?: NestedIntNullableFilter<$PrismaModel>
    _avg?: NestedFloatNullableFilter<$PrismaModel>
    _sum?: NestedFloatNullableFilter<$PrismaModel>
    _min?: NestedFloatNullableFilter<$PrismaModel>
    _max?: NestedFloatNullableFilter<$PrismaModel>
  }

  export type NestedIntNullableWithAggregatesFilter<$PrismaModel = never> = {
    equals?: number | IntFieldRefInput<$PrismaModel> | null
    in?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    notIn?: number[] | ListIntFieldRefInput<$PrismaModel> | null
    lt?: number | IntFieldRefInput<$PrismaModel>
    lte?: number | IntFieldRefInput<$PrismaModel>
    gt?: number | IntFieldRefInput<$PrismaModel>
    gte?: number | IntFieldRefInput<$PrismaModel>
    not?: NestedIntNullableWithAggregatesFilter<$PrismaModel> | number | null
    _count?: NestedIntNullableFilter<$PrismaModel>
    _avg?: NestedFloatNullableFilter<$PrismaModel>
    _sum?: NestedIntNullableFilter<$PrismaModel>
    _min?: NestedIntNullableFilter<$PrismaModel>
    _max?: NestedIntNullableFilter<$PrismaModel>
  }

  export type ClusterConfigurationCreateWithoutLocationInput = {
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_count?: number
    load_profile?: LoadProfileCreateNestedOneWithoutCluster_configurationsInput
    cooler_model: CpuCoolerCatalogCreateNestedOneWithoutCluster_configsInput
    fan_model?: FanCatalogCreateNestedOneWithoutCluster_configurationsInput
    fan_config?: FanConfigurationCreateNestedOneWithoutCluster_configurationsInput
    servers?: ServerCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationUncheckedCreateWithoutLocationInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id?: number | null
    servers?: ServerUncheckedCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationCreateOrConnectWithoutLocationInput = {
    where: ClusterConfigurationWhereUniqueInput
    create: XOR<ClusterConfigurationCreateWithoutLocationInput, ClusterConfigurationUncheckedCreateWithoutLocationInput>
  }

  export type ClusterConfigurationCreateManyLocationInputEnvelope = {
    data: ClusterConfigurationCreateManyLocationInput | ClusterConfigurationCreateManyLocationInput[]
    skipDuplicates?: boolean
  }

  export type ClusterCreateWithoutClusterLocationInput = {
    name: string
    created_at?: Date | string
    servers?: ServerCreateNestedManyWithoutClusterInput
  }

  export type ClusterUncheckedCreateWithoutClusterLocationInput = {
    cluster_id?: number
    name: string
    created_at?: Date | string
    servers?: ServerUncheckedCreateNestedManyWithoutClusterInput
  }

  export type ClusterCreateOrConnectWithoutClusterLocationInput = {
    where: ClusterWhereUniqueInput
    create: XOR<ClusterCreateWithoutClusterLocationInput, ClusterUncheckedCreateWithoutClusterLocationInput>
  }

  export type ClusterCreateManyClusterLocationInputEnvelope = {
    data: ClusterCreateManyClusterLocationInput | ClusterCreateManyClusterLocationInput[]
    skipDuplicates?: boolean
  }

  export type ClusterConfigurationUpsertWithWhereUniqueWithoutLocationInput = {
    where: ClusterConfigurationWhereUniqueInput
    update: XOR<ClusterConfigurationUpdateWithoutLocationInput, ClusterConfigurationUncheckedUpdateWithoutLocationInput>
    create: XOR<ClusterConfigurationCreateWithoutLocationInput, ClusterConfigurationUncheckedCreateWithoutLocationInput>
  }

  export type ClusterConfigurationUpdateWithWhereUniqueWithoutLocationInput = {
    where: ClusterConfigurationWhereUniqueInput
    data: XOR<ClusterConfigurationUpdateWithoutLocationInput, ClusterConfigurationUncheckedUpdateWithoutLocationInput>
  }

  export type ClusterConfigurationUpdateManyWithWhereWithoutLocationInput = {
    where: ClusterConfigurationScalarWhereInput
    data: XOR<ClusterConfigurationUpdateManyMutationInput, ClusterConfigurationUncheckedUpdateManyWithoutLocationInput>
  }

  export type ClusterConfigurationScalarWhereInput = {
    AND?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
    OR?: ClusterConfigurationScalarWhereInput[]
    NOT?: ClusterConfigurationScalarWhereInput | ClusterConfigurationScalarWhereInput[]
    cluster_config_id?: IntFilter<"ClusterConfiguration"> | number
    name?: StringFilter<"ClusterConfiguration"> | string
    master?: IntFilter<"ClusterConfiguration"> | number
    worker?: IntFilter<"ClusterConfiguration"> | number
    consomation_per_master?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    consomation_per_worker?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    hardware_per_master?: StringNullableFilter<"ClusterConfiguration"> | string | null
    hardware_per_worker?: StringNullableFilter<"ClusterConfiguration"> | string | null
    pue?: FloatNullableFilter<"ClusterConfiguration"> | number | null
    location_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    fan_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
    fan_count?: IntFilter<"ClusterConfiguration"> | number
    cpu_cooler_catalog_id?: IntFilter<"ClusterConfiguration"> | number
    fan_catalog_id?: IntFilter<"ClusterConfiguration"> | number
    load_profile_id?: IntNullableFilter<"ClusterConfiguration"> | number | null
  }

  export type ClusterUpsertWithWhereUniqueWithoutClusterLocationInput = {
    where: ClusterWhereUniqueInput
    update: XOR<ClusterUpdateWithoutClusterLocationInput, ClusterUncheckedUpdateWithoutClusterLocationInput>
    create: XOR<ClusterCreateWithoutClusterLocationInput, ClusterUncheckedCreateWithoutClusterLocationInput>
  }

  export type ClusterUpdateWithWhereUniqueWithoutClusterLocationInput = {
    where: ClusterWhereUniqueInput
    data: XOR<ClusterUpdateWithoutClusterLocationInput, ClusterUncheckedUpdateWithoutClusterLocationInput>
  }

  export type ClusterUpdateManyWithWhereWithoutClusterLocationInput = {
    where: ClusterScalarWhereInput
    data: XOR<ClusterUpdateManyMutationInput, ClusterUncheckedUpdateManyWithoutClusterLocationInput>
  }

  export type ClusterScalarWhereInput = {
    AND?: ClusterScalarWhereInput | ClusterScalarWhereInput[]
    OR?: ClusterScalarWhereInput[]
    NOT?: ClusterScalarWhereInput | ClusterScalarWhereInput[]
    cluster_id?: IntFilter<"Cluster"> | number
    name?: StringFilter<"Cluster"> | string
    created_at?: DateTimeFilter<"Cluster"> | Date | string
    cluster_location_id?: IntFilter<"Cluster"> | number
  }

  export type ClusterConfigurationCreateWithoutLoad_profileInput = {
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_count?: number
    cooler_model: CpuCoolerCatalogCreateNestedOneWithoutCluster_configsInput
    fan_model?: FanCatalogCreateNestedOneWithoutCluster_configurationsInput
    location?: ClusterLocationCreateNestedOneWithoutCluster_configurationsInput
    fan_config?: FanConfigurationCreateNestedOneWithoutCluster_configurationsInput
    servers?: ServerCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationUncheckedCreateWithoutLoad_profileInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    servers?: ServerUncheckedCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationCreateOrConnectWithoutLoad_profileInput = {
    where: ClusterConfigurationWhereUniqueInput
    create: XOR<ClusterConfigurationCreateWithoutLoad_profileInput, ClusterConfigurationUncheckedCreateWithoutLoad_profileInput>
  }

  export type ClusterConfigurationCreateManyLoad_profileInputEnvelope = {
    data: ClusterConfigurationCreateManyLoad_profileInput | ClusterConfigurationCreateManyLoad_profileInput[]
    skipDuplicates?: boolean
  }

  export type ClusterConfigurationUpsertWithWhereUniqueWithoutLoad_profileInput = {
    where: ClusterConfigurationWhereUniqueInput
    update: XOR<ClusterConfigurationUpdateWithoutLoad_profileInput, ClusterConfigurationUncheckedUpdateWithoutLoad_profileInput>
    create: XOR<ClusterConfigurationCreateWithoutLoad_profileInput, ClusterConfigurationUncheckedCreateWithoutLoad_profileInput>
  }

  export type ClusterConfigurationUpdateWithWhereUniqueWithoutLoad_profileInput = {
    where: ClusterConfigurationWhereUniqueInput
    data: XOR<ClusterConfigurationUpdateWithoutLoad_profileInput, ClusterConfigurationUncheckedUpdateWithoutLoad_profileInput>
  }

  export type ClusterConfigurationUpdateManyWithWhereWithoutLoad_profileInput = {
    where: ClusterConfigurationScalarWhereInput
    data: XOR<ClusterConfigurationUpdateManyMutationInput, ClusterConfigurationUncheckedUpdateManyWithoutLoad_profileInput>
  }

  export type ClusterConfigurationCreateWithoutFan_configInput = {
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_count?: number
    load_profile?: LoadProfileCreateNestedOneWithoutCluster_configurationsInput
    cooler_model: CpuCoolerCatalogCreateNestedOneWithoutCluster_configsInput
    fan_model?: FanCatalogCreateNestedOneWithoutCluster_configurationsInput
    location?: ClusterLocationCreateNestedOneWithoutCluster_configurationsInput
    servers?: ServerCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationUncheckedCreateWithoutFan_configInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id?: number | null
    servers?: ServerUncheckedCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationCreateOrConnectWithoutFan_configInput = {
    where: ClusterConfigurationWhereUniqueInput
    create: XOR<ClusterConfigurationCreateWithoutFan_configInput, ClusterConfigurationUncheckedCreateWithoutFan_configInput>
  }

  export type ClusterConfigurationCreateManyFan_configInputEnvelope = {
    data: ClusterConfigurationCreateManyFan_configInput | ClusterConfigurationCreateManyFan_configInput[]
    skipDuplicates?: boolean
  }

  export type FanCreateWithoutFan_configInput = {
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
    server: ServerCreateNestedOneWithoutFansInput
    catalog_info?: FanCatalogCreateNestedOneWithoutFansInput
  }

  export type FanUncheckedCreateWithoutFan_configInput = {
    fan_id?: number
    server_id: number
    fan_catalog_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type FanCreateOrConnectWithoutFan_configInput = {
    where: FanWhereUniqueInput
    create: XOR<FanCreateWithoutFan_configInput, FanUncheckedCreateWithoutFan_configInput>
  }

  export type FanCreateManyFan_configInputEnvelope = {
    data: FanCreateManyFan_configInput | FanCreateManyFan_configInput[]
    skipDuplicates?: boolean
  }

  export type ClusterConfigurationUpsertWithWhereUniqueWithoutFan_configInput = {
    where: ClusterConfigurationWhereUniqueInput
    update: XOR<ClusterConfigurationUpdateWithoutFan_configInput, ClusterConfigurationUncheckedUpdateWithoutFan_configInput>
    create: XOR<ClusterConfigurationCreateWithoutFan_configInput, ClusterConfigurationUncheckedCreateWithoutFan_configInput>
  }

  export type ClusterConfigurationUpdateWithWhereUniqueWithoutFan_configInput = {
    where: ClusterConfigurationWhereUniqueInput
    data: XOR<ClusterConfigurationUpdateWithoutFan_configInput, ClusterConfigurationUncheckedUpdateWithoutFan_configInput>
  }

  export type ClusterConfigurationUpdateManyWithWhereWithoutFan_configInput = {
    where: ClusterConfigurationScalarWhereInput
    data: XOR<ClusterConfigurationUpdateManyMutationInput, ClusterConfigurationUncheckedUpdateManyWithoutFan_configInput>
  }

  export type FanUpsertWithWhereUniqueWithoutFan_configInput = {
    where: FanWhereUniqueInput
    update: XOR<FanUpdateWithoutFan_configInput, FanUncheckedUpdateWithoutFan_configInput>
    create: XOR<FanCreateWithoutFan_configInput, FanUncheckedCreateWithoutFan_configInput>
  }

  export type FanUpdateWithWhereUniqueWithoutFan_configInput = {
    where: FanWhereUniqueInput
    data: XOR<FanUpdateWithoutFan_configInput, FanUncheckedUpdateWithoutFan_configInput>
  }

  export type FanUpdateManyWithWhereWithoutFan_configInput = {
    where: FanScalarWhereInput
    data: XOR<FanUpdateManyMutationInput, FanUncheckedUpdateManyWithoutFan_configInput>
  }

  export type FanScalarWhereInput = {
    AND?: FanScalarWhereInput | FanScalarWhereInput[]
    OR?: FanScalarWhereInput[]
    NOT?: FanScalarWhereInput | FanScalarWhereInput[]
    fan_id?: IntFilter<"Fan"> | number
    server_id?: IntFilter<"Fan"> | number
    fan_catalog_id?: IntNullableFilter<"Fan"> | number | null
    fan_config_id?: IntNullableFilter<"Fan"> | number | null
    control_mode?: StringFilter<"Fan"> | string
    status?: StringFilter<"Fan"> | string
    speed_percent?: IntFilter<"Fan"> | number
    created_at?: DateTimeFilter<"Fan"> | Date | string
  }

  export type ClusterConfigurationCreateWithoutFan_modelInput = {
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_count?: number
    load_profile?: LoadProfileCreateNestedOneWithoutCluster_configurationsInput
    cooler_model: CpuCoolerCatalogCreateNestedOneWithoutCluster_configsInput
    location?: ClusterLocationCreateNestedOneWithoutCluster_configurationsInput
    fan_config?: FanConfigurationCreateNestedOneWithoutCluster_configurationsInput
    servers?: ServerCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationUncheckedCreateWithoutFan_modelInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    load_profile_id?: number | null
    servers?: ServerUncheckedCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationCreateOrConnectWithoutFan_modelInput = {
    where: ClusterConfigurationWhereUniqueInput
    create: XOR<ClusterConfigurationCreateWithoutFan_modelInput, ClusterConfigurationUncheckedCreateWithoutFan_modelInput>
  }

  export type ClusterConfigurationCreateManyFan_modelInputEnvelope = {
    data: ClusterConfigurationCreateManyFan_modelInput | ClusterConfigurationCreateManyFan_modelInput[]
    skipDuplicates?: boolean
  }

  export type FanCreateWithoutCatalog_infoInput = {
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
    server: ServerCreateNestedOneWithoutFansInput
    fan_config?: FanConfigurationCreateNestedOneWithoutFansInput
  }

  export type FanUncheckedCreateWithoutCatalog_infoInput = {
    fan_id?: number
    server_id: number
    fan_config_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type FanCreateOrConnectWithoutCatalog_infoInput = {
    where: FanWhereUniqueInput
    create: XOR<FanCreateWithoutCatalog_infoInput, FanUncheckedCreateWithoutCatalog_infoInput>
  }

  export type FanCreateManyCatalog_infoInputEnvelope = {
    data: FanCreateManyCatalog_infoInput | FanCreateManyCatalog_infoInput[]
    skipDuplicates?: boolean
  }

  export type ClusterConfigurationUpsertWithWhereUniqueWithoutFan_modelInput = {
    where: ClusterConfigurationWhereUniqueInput
    update: XOR<ClusterConfigurationUpdateWithoutFan_modelInput, ClusterConfigurationUncheckedUpdateWithoutFan_modelInput>
    create: XOR<ClusterConfigurationCreateWithoutFan_modelInput, ClusterConfigurationUncheckedCreateWithoutFan_modelInput>
  }

  export type ClusterConfigurationUpdateWithWhereUniqueWithoutFan_modelInput = {
    where: ClusterConfigurationWhereUniqueInput
    data: XOR<ClusterConfigurationUpdateWithoutFan_modelInput, ClusterConfigurationUncheckedUpdateWithoutFan_modelInput>
  }

  export type ClusterConfigurationUpdateManyWithWhereWithoutFan_modelInput = {
    where: ClusterConfigurationScalarWhereInput
    data: XOR<ClusterConfigurationUpdateManyMutationInput, ClusterConfigurationUncheckedUpdateManyWithoutFan_modelInput>
  }

  export type FanUpsertWithWhereUniqueWithoutCatalog_infoInput = {
    where: FanWhereUniqueInput
    update: XOR<FanUpdateWithoutCatalog_infoInput, FanUncheckedUpdateWithoutCatalog_infoInput>
    create: XOR<FanCreateWithoutCatalog_infoInput, FanUncheckedCreateWithoutCatalog_infoInput>
  }

  export type FanUpdateWithWhereUniqueWithoutCatalog_infoInput = {
    where: FanWhereUniqueInput
    data: XOR<FanUpdateWithoutCatalog_infoInput, FanUncheckedUpdateWithoutCatalog_infoInput>
  }

  export type FanUpdateManyWithWhereWithoutCatalog_infoInput = {
    where: FanScalarWhereInput
    data: XOR<FanUpdateManyMutationInput, FanUncheckedUpdateManyWithoutCatalog_infoInput>
  }

  export type ClusterConfigurationCreateWithoutCooler_modelInput = {
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_count?: number
    load_profile?: LoadProfileCreateNestedOneWithoutCluster_configurationsInput
    fan_model?: FanCatalogCreateNestedOneWithoutCluster_configurationsInput
    location?: ClusterLocationCreateNestedOneWithoutCluster_configurationsInput
    fan_config?: FanConfigurationCreateNestedOneWithoutCluster_configurationsInput
    servers?: ServerCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationUncheckedCreateWithoutCooler_modelInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    fan_catalog_id: number
    load_profile_id?: number | null
    servers?: ServerUncheckedCreateNestedManyWithoutConfigurationInput
  }

  export type ClusterConfigurationCreateOrConnectWithoutCooler_modelInput = {
    where: ClusterConfigurationWhereUniqueInput
    create: XOR<ClusterConfigurationCreateWithoutCooler_modelInput, ClusterConfigurationUncheckedCreateWithoutCooler_modelInput>
  }

  export type ClusterConfigurationCreateManyCooler_modelInputEnvelope = {
    data: ClusterConfigurationCreateManyCooler_modelInput | ClusterConfigurationCreateManyCooler_modelInput[]
    skipDuplicates?: boolean
  }

  export type ClusterConfigurationUpsertWithWhereUniqueWithoutCooler_modelInput = {
    where: ClusterConfigurationWhereUniqueInput
    update: XOR<ClusterConfigurationUpdateWithoutCooler_modelInput, ClusterConfigurationUncheckedUpdateWithoutCooler_modelInput>
    create: XOR<ClusterConfigurationCreateWithoutCooler_modelInput, ClusterConfigurationUncheckedCreateWithoutCooler_modelInput>
  }

  export type ClusterConfigurationUpdateWithWhereUniqueWithoutCooler_modelInput = {
    where: ClusterConfigurationWhereUniqueInput
    data: XOR<ClusterConfigurationUpdateWithoutCooler_modelInput, ClusterConfigurationUncheckedUpdateWithoutCooler_modelInput>
  }

  export type ClusterConfigurationUpdateManyWithWhereWithoutCooler_modelInput = {
    where: ClusterConfigurationScalarWhereInput
    data: XOR<ClusterConfigurationUpdateManyMutationInput, ClusterConfigurationUncheckedUpdateManyWithoutCooler_modelInput>
  }

  export type LoadProfileCreateWithoutCluster_configurationsInput = {
    name: string
    hour: number
    expected_load_percent: number
    target_temp_celsius: number
    standard_fan_speed?: string
  }

  export type LoadProfileUncheckedCreateWithoutCluster_configurationsInput = {
    id?: number
    name: string
    hour: number
    expected_load_percent: number
    target_temp_celsius: number
    standard_fan_speed?: string
  }

  export type LoadProfileCreateOrConnectWithoutCluster_configurationsInput = {
    where: LoadProfileWhereUniqueInput
    create: XOR<LoadProfileCreateWithoutCluster_configurationsInput, LoadProfileUncheckedCreateWithoutCluster_configurationsInput>
  }

  export type CpuCoolerCatalogCreateWithoutCluster_configsInput = {
    model_name: string
    type: string
    thermal_capacity: number
  }

  export type CpuCoolerCatalogUncheckedCreateWithoutCluster_configsInput = {
    cpu_cooler_catalog_id?: number
    model_name: string
    type: string
    thermal_capacity: number
  }

  export type CpuCoolerCatalogCreateOrConnectWithoutCluster_configsInput = {
    where: CpuCoolerCatalogWhereUniqueInput
    create: XOR<CpuCoolerCatalogCreateWithoutCluster_configsInput, CpuCoolerCatalogUncheckedCreateWithoutCluster_configsInput>
  }

  export type FanCatalogCreateWithoutCluster_configurationsInput = {
    model_name: string
    consomation?: number | null
    fans?: FanCreateNestedManyWithoutCatalog_infoInput
  }

  export type FanCatalogUncheckedCreateWithoutCluster_configurationsInput = {
    fan_catalog_id?: number
    model_name: string
    consomation?: number | null
    fans?: FanUncheckedCreateNestedManyWithoutCatalog_infoInput
  }

  export type FanCatalogCreateOrConnectWithoutCluster_configurationsInput = {
    where: FanCatalogWhereUniqueInput
    create: XOR<FanCatalogCreateWithoutCluster_configurationsInput, FanCatalogUncheckedCreateWithoutCluster_configurationsInput>
  }

  export type ClusterLocationCreateWithoutCluster_configurationsInput = {
    name: string
    location?: string | null
    env_factor?: number
    cluster_count: number
    created_at?: Date | string
    clusters?: ClusterCreateNestedManyWithoutClusterLocationInput
  }

  export type ClusterLocationUncheckedCreateWithoutCluster_configurationsInput = {
    location_id?: number
    name: string
    location?: string | null
    env_factor?: number
    cluster_count: number
    created_at?: Date | string
    clusters?: ClusterUncheckedCreateNestedManyWithoutClusterLocationInput
  }

  export type ClusterLocationCreateOrConnectWithoutCluster_configurationsInput = {
    where: ClusterLocationWhereUniqueInput
    create: XOR<ClusterLocationCreateWithoutCluster_configurationsInput, ClusterLocationUncheckedCreateWithoutCluster_configurationsInput>
  }

  export type FanConfigurationCreateWithoutCluster_configurationsInput = {
    name: string
    consomation?: number | null
    fans?: FanCreateNestedManyWithoutFan_configInput
  }

  export type FanConfigurationUncheckedCreateWithoutCluster_configurationsInput = {
    fan_id?: number
    name: string
    consomation?: number | null
    fans?: FanUncheckedCreateNestedManyWithoutFan_configInput
  }

  export type FanConfigurationCreateOrConnectWithoutCluster_configurationsInput = {
    where: FanConfigurationWhereUniqueInput
    create: XOR<FanConfigurationCreateWithoutCluster_configurationsInput, FanConfigurationUncheckedCreateWithoutCluster_configurationsInput>
  }

  export type ServerCreateWithoutConfigurationInput = {
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    cluster: ClusterCreateNestedOneWithoutServersInput
    sensors?: SensorCreateNestedManyWithoutServerInput
    fans?: FanCreateNestedManyWithoutServerInput
  }

  export type ServerUncheckedCreateWithoutConfigurationInput = {
    server_id?: number
    cluster_id: number
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    sensors?: SensorUncheckedCreateNestedManyWithoutServerInput
    fans?: FanUncheckedCreateNestedManyWithoutServerInput
  }

  export type ServerCreateOrConnectWithoutConfigurationInput = {
    where: ServerWhereUniqueInput
    create: XOR<ServerCreateWithoutConfigurationInput, ServerUncheckedCreateWithoutConfigurationInput>
  }

  export type ServerCreateManyConfigurationInputEnvelope = {
    data: ServerCreateManyConfigurationInput | ServerCreateManyConfigurationInput[]
    skipDuplicates?: boolean
  }

  export type LoadProfileUpsertWithoutCluster_configurationsInput = {
    update: XOR<LoadProfileUpdateWithoutCluster_configurationsInput, LoadProfileUncheckedUpdateWithoutCluster_configurationsInput>
    create: XOR<LoadProfileCreateWithoutCluster_configurationsInput, LoadProfileUncheckedCreateWithoutCluster_configurationsInput>
    where?: LoadProfileWhereInput
  }

  export type LoadProfileUpdateToOneWithWhereWithoutCluster_configurationsInput = {
    where?: LoadProfileWhereInput
    data: XOR<LoadProfileUpdateWithoutCluster_configurationsInput, LoadProfileUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type LoadProfileUpdateWithoutCluster_configurationsInput = {
    name?: StringFieldUpdateOperationsInput | string
    hour?: IntFieldUpdateOperationsInput | number
    expected_load_percent?: FloatFieldUpdateOperationsInput | number
    target_temp_celsius?: FloatFieldUpdateOperationsInput | number
    standard_fan_speed?: StringFieldUpdateOperationsInput | string
  }

  export type LoadProfileUncheckedUpdateWithoutCluster_configurationsInput = {
    id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    hour?: IntFieldUpdateOperationsInput | number
    expected_load_percent?: FloatFieldUpdateOperationsInput | number
    target_temp_celsius?: FloatFieldUpdateOperationsInput | number
    standard_fan_speed?: StringFieldUpdateOperationsInput | string
  }

  export type CpuCoolerCatalogUpsertWithoutCluster_configsInput = {
    update: XOR<CpuCoolerCatalogUpdateWithoutCluster_configsInput, CpuCoolerCatalogUncheckedUpdateWithoutCluster_configsInput>
    create: XOR<CpuCoolerCatalogCreateWithoutCluster_configsInput, CpuCoolerCatalogUncheckedCreateWithoutCluster_configsInput>
    where?: CpuCoolerCatalogWhereInput
  }

  export type CpuCoolerCatalogUpdateToOneWithWhereWithoutCluster_configsInput = {
    where?: CpuCoolerCatalogWhereInput
    data: XOR<CpuCoolerCatalogUpdateWithoutCluster_configsInput, CpuCoolerCatalogUncheckedUpdateWithoutCluster_configsInput>
  }

  export type CpuCoolerCatalogUpdateWithoutCluster_configsInput = {
    model_name?: StringFieldUpdateOperationsInput | string
    type?: StringFieldUpdateOperationsInput | string
    thermal_capacity?: IntFieldUpdateOperationsInput | number
  }

  export type CpuCoolerCatalogUncheckedUpdateWithoutCluster_configsInput = {
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    model_name?: StringFieldUpdateOperationsInput | string
    type?: StringFieldUpdateOperationsInput | string
    thermal_capacity?: IntFieldUpdateOperationsInput | number
  }

  export type FanCatalogUpsertWithoutCluster_configurationsInput = {
    update: XOR<FanCatalogUpdateWithoutCluster_configurationsInput, FanCatalogUncheckedUpdateWithoutCluster_configurationsInput>
    create: XOR<FanCatalogCreateWithoutCluster_configurationsInput, FanCatalogUncheckedCreateWithoutCluster_configurationsInput>
    where?: FanCatalogWhereInput
  }

  export type FanCatalogUpdateToOneWithWhereWithoutCluster_configurationsInput = {
    where?: FanCatalogWhereInput
    data: XOR<FanCatalogUpdateWithoutCluster_configurationsInput, FanCatalogUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type FanCatalogUpdateWithoutCluster_configurationsInput = {
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    fans?: FanUpdateManyWithoutCatalog_infoNestedInput
  }

  export type FanCatalogUncheckedUpdateWithoutCluster_configurationsInput = {
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    fans?: FanUncheckedUpdateManyWithoutCatalog_infoNestedInput
  }

  export type ClusterLocationUpsertWithoutCluster_configurationsInput = {
    update: XOR<ClusterLocationUpdateWithoutCluster_configurationsInput, ClusterLocationUncheckedUpdateWithoutCluster_configurationsInput>
    create: XOR<ClusterLocationCreateWithoutCluster_configurationsInput, ClusterLocationUncheckedCreateWithoutCluster_configurationsInput>
    where?: ClusterLocationWhereInput
  }

  export type ClusterLocationUpdateToOneWithWhereWithoutCluster_configurationsInput = {
    where?: ClusterLocationWhereInput
    data: XOR<ClusterLocationUpdateWithoutCluster_configurationsInput, ClusterLocationUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type ClusterLocationUpdateWithoutCluster_configurationsInput = {
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    clusters?: ClusterUpdateManyWithoutClusterLocationNestedInput
  }

  export type ClusterLocationUncheckedUpdateWithoutCluster_configurationsInput = {
    location_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    clusters?: ClusterUncheckedUpdateManyWithoutClusterLocationNestedInput
  }

  export type FanConfigurationUpsertWithoutCluster_configurationsInput = {
    update: XOR<FanConfigurationUpdateWithoutCluster_configurationsInput, FanConfigurationUncheckedUpdateWithoutCluster_configurationsInput>
    create: XOR<FanConfigurationCreateWithoutCluster_configurationsInput, FanConfigurationUncheckedCreateWithoutCluster_configurationsInput>
    where?: FanConfigurationWhereInput
  }

  export type FanConfigurationUpdateToOneWithWhereWithoutCluster_configurationsInput = {
    where?: FanConfigurationWhereInput
    data: XOR<FanConfigurationUpdateWithoutCluster_configurationsInput, FanConfigurationUncheckedUpdateWithoutCluster_configurationsInput>
  }

  export type FanConfigurationUpdateWithoutCluster_configurationsInput = {
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    fans?: FanUpdateManyWithoutFan_configNestedInput
  }

  export type FanConfigurationUncheckedUpdateWithoutCluster_configurationsInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    fans?: FanUncheckedUpdateManyWithoutFan_configNestedInput
  }

  export type ServerUpsertWithWhereUniqueWithoutConfigurationInput = {
    where: ServerWhereUniqueInput
    update: XOR<ServerUpdateWithoutConfigurationInput, ServerUncheckedUpdateWithoutConfigurationInput>
    create: XOR<ServerCreateWithoutConfigurationInput, ServerUncheckedCreateWithoutConfigurationInput>
  }

  export type ServerUpdateWithWhereUniqueWithoutConfigurationInput = {
    where: ServerWhereUniqueInput
    data: XOR<ServerUpdateWithoutConfigurationInput, ServerUncheckedUpdateWithoutConfigurationInput>
  }

  export type ServerUpdateManyWithWhereWithoutConfigurationInput = {
    where: ServerScalarWhereInput
    data: XOR<ServerUpdateManyMutationInput, ServerUncheckedUpdateManyWithoutConfigurationInput>
  }

  export type ServerScalarWhereInput = {
    AND?: ServerScalarWhereInput | ServerScalarWhereInput[]
    OR?: ServerScalarWhereInput[]
    NOT?: ServerScalarWhereInput | ServerScalarWhereInput[]
    server_id?: IntFilter<"Server"> | number
    cluster_id?: IntFilter<"Server"> | number
    config_id?: IntNullableFilter<"Server"> | number | null
    hostname?: StringFilter<"Server"> | string
    status?: StringFilter<"Server"> | string
    base_consumption_offset?: FloatFilter<"Server"> | number
    created_at?: DateTimeFilter<"Server"> | Date | string
  }

  export type ClusterLocationCreateWithoutClustersInput = {
    name: string
    location?: string | null
    env_factor?: number
    cluster_count: number
    created_at?: Date | string
    cluster_configurations?: ClusterConfigurationCreateNestedManyWithoutLocationInput
  }

  export type ClusterLocationUncheckedCreateWithoutClustersInput = {
    location_id?: number
    name: string
    location?: string | null
    env_factor?: number
    cluster_count: number
    created_at?: Date | string
    cluster_configurations?: ClusterConfigurationUncheckedCreateNestedManyWithoutLocationInput
  }

  export type ClusterLocationCreateOrConnectWithoutClustersInput = {
    where: ClusterLocationWhereUniqueInput
    create: XOR<ClusterLocationCreateWithoutClustersInput, ClusterLocationUncheckedCreateWithoutClustersInput>
  }

  export type ServerCreateWithoutClusterInput = {
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    configuration?: ClusterConfigurationCreateNestedOneWithoutServersInput
    sensors?: SensorCreateNestedManyWithoutServerInput
    fans?: FanCreateNestedManyWithoutServerInput
  }

  export type ServerUncheckedCreateWithoutClusterInput = {
    server_id?: number
    config_id?: number | null
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    sensors?: SensorUncheckedCreateNestedManyWithoutServerInput
    fans?: FanUncheckedCreateNestedManyWithoutServerInput
  }

  export type ServerCreateOrConnectWithoutClusterInput = {
    where: ServerWhereUniqueInput
    create: XOR<ServerCreateWithoutClusterInput, ServerUncheckedCreateWithoutClusterInput>
  }

  export type ServerCreateManyClusterInputEnvelope = {
    data: ServerCreateManyClusterInput | ServerCreateManyClusterInput[]
    skipDuplicates?: boolean
  }

  export type ClusterLocationUpsertWithoutClustersInput = {
    update: XOR<ClusterLocationUpdateWithoutClustersInput, ClusterLocationUncheckedUpdateWithoutClustersInput>
    create: XOR<ClusterLocationCreateWithoutClustersInput, ClusterLocationUncheckedCreateWithoutClustersInput>
    where?: ClusterLocationWhereInput
  }

  export type ClusterLocationUpdateToOneWithWhereWithoutClustersInput = {
    where?: ClusterLocationWhereInput
    data: XOR<ClusterLocationUpdateWithoutClustersInput, ClusterLocationUncheckedUpdateWithoutClustersInput>
  }

  export type ClusterLocationUpdateWithoutClustersInput = {
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster_configurations?: ClusterConfigurationUpdateManyWithoutLocationNestedInput
  }

  export type ClusterLocationUncheckedUpdateWithoutClustersInput = {
    location_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    location?: NullableStringFieldUpdateOperationsInput | string | null
    env_factor?: FloatFieldUpdateOperationsInput | number
    cluster_count?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster_configurations?: ClusterConfigurationUncheckedUpdateManyWithoutLocationNestedInput
  }

  export type ServerUpsertWithWhereUniqueWithoutClusterInput = {
    where: ServerWhereUniqueInput
    update: XOR<ServerUpdateWithoutClusterInput, ServerUncheckedUpdateWithoutClusterInput>
    create: XOR<ServerCreateWithoutClusterInput, ServerUncheckedCreateWithoutClusterInput>
  }

  export type ServerUpdateWithWhereUniqueWithoutClusterInput = {
    where: ServerWhereUniqueInput
    data: XOR<ServerUpdateWithoutClusterInput, ServerUncheckedUpdateWithoutClusterInput>
  }

  export type ServerUpdateManyWithWhereWithoutClusterInput = {
    where: ServerScalarWhereInput
    data: XOR<ServerUpdateManyMutationInput, ServerUncheckedUpdateManyWithoutClusterInput>
  }

  export type ClusterCreateWithoutServersInput = {
    name: string
    created_at?: Date | string
    clusterLocation: ClusterLocationCreateNestedOneWithoutClustersInput
  }

  export type ClusterUncheckedCreateWithoutServersInput = {
    cluster_id?: number
    name: string
    created_at?: Date | string
    cluster_location_id: number
  }

  export type ClusterCreateOrConnectWithoutServersInput = {
    where: ClusterWhereUniqueInput
    create: XOR<ClusterCreateWithoutServersInput, ClusterUncheckedCreateWithoutServersInput>
  }

  export type ClusterConfigurationCreateWithoutServersInput = {
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_count?: number
    load_profile?: LoadProfileCreateNestedOneWithoutCluster_configurationsInput
    cooler_model: CpuCoolerCatalogCreateNestedOneWithoutCluster_configsInput
    fan_model?: FanCatalogCreateNestedOneWithoutCluster_configurationsInput
    location?: ClusterLocationCreateNestedOneWithoutCluster_configurationsInput
    fan_config?: FanConfigurationCreateNestedOneWithoutCluster_configurationsInput
  }

  export type ClusterConfigurationUncheckedCreateWithoutServersInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id?: number | null
  }

  export type ClusterConfigurationCreateOrConnectWithoutServersInput = {
    where: ClusterConfigurationWhereUniqueInput
    create: XOR<ClusterConfigurationCreateWithoutServersInput, ClusterConfigurationUncheckedCreateWithoutServersInput>
  }

  export type SensorCreateWithoutServerInput = {
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
    data?: SensorDataCreateNestedManyWithoutSensorInput
  }

  export type SensorUncheckedCreateWithoutServerInput = {
    sensor_id?: number
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
    data?: SensorDataUncheckedCreateNestedManyWithoutSensorInput
  }

  export type SensorCreateOrConnectWithoutServerInput = {
    where: SensorWhereUniqueInput
    create: XOR<SensorCreateWithoutServerInput, SensorUncheckedCreateWithoutServerInput>
  }

  export type SensorCreateManyServerInputEnvelope = {
    data: SensorCreateManyServerInput | SensorCreateManyServerInput[]
    skipDuplicates?: boolean
  }

  export type FanCreateWithoutServerInput = {
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
    catalog_info?: FanCatalogCreateNestedOneWithoutFansInput
    fan_config?: FanConfigurationCreateNestedOneWithoutFansInput
  }

  export type FanUncheckedCreateWithoutServerInput = {
    fan_id?: number
    fan_catalog_id?: number | null
    fan_config_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type FanCreateOrConnectWithoutServerInput = {
    where: FanWhereUniqueInput
    create: XOR<FanCreateWithoutServerInput, FanUncheckedCreateWithoutServerInput>
  }

  export type FanCreateManyServerInputEnvelope = {
    data: FanCreateManyServerInput | FanCreateManyServerInput[]
    skipDuplicates?: boolean
  }

  export type ClusterUpsertWithoutServersInput = {
    update: XOR<ClusterUpdateWithoutServersInput, ClusterUncheckedUpdateWithoutServersInput>
    create: XOR<ClusterCreateWithoutServersInput, ClusterUncheckedCreateWithoutServersInput>
    where?: ClusterWhereInput
  }

  export type ClusterUpdateToOneWithWhereWithoutServersInput = {
    where?: ClusterWhereInput
    data: XOR<ClusterUpdateWithoutServersInput, ClusterUncheckedUpdateWithoutServersInput>
  }

  export type ClusterUpdateWithoutServersInput = {
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    clusterLocation?: ClusterLocationUpdateOneRequiredWithoutClustersNestedInput
  }

  export type ClusterUncheckedUpdateWithoutServersInput = {
    cluster_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster_location_id?: IntFieldUpdateOperationsInput | number
  }

  export type ClusterConfigurationUpsertWithoutServersInput = {
    update: XOR<ClusterConfigurationUpdateWithoutServersInput, ClusterConfigurationUncheckedUpdateWithoutServersInput>
    create: XOR<ClusterConfigurationCreateWithoutServersInput, ClusterConfigurationUncheckedCreateWithoutServersInput>
    where?: ClusterConfigurationWhereInput
  }

  export type ClusterConfigurationUpdateToOneWithWhereWithoutServersInput = {
    where?: ClusterConfigurationWhereInput
    data: XOR<ClusterConfigurationUpdateWithoutServersInput, ClusterConfigurationUncheckedUpdateWithoutServersInput>
  }

  export type ClusterConfigurationUpdateWithoutServersInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    load_profile?: LoadProfileUpdateOneWithoutCluster_configurationsNestedInput
    cooler_model?: CpuCoolerCatalogUpdateOneRequiredWithoutCluster_configsNestedInput
    fan_model?: FanCatalogUpdateOneWithoutCluster_configurationsNestedInput
    location?: ClusterLocationUpdateOneWithoutCluster_configurationsNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutCluster_configurationsNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateWithoutServersInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
  }

  export type SensorUpsertWithWhereUniqueWithoutServerInput = {
    where: SensorWhereUniqueInput
    update: XOR<SensorUpdateWithoutServerInput, SensorUncheckedUpdateWithoutServerInput>
    create: XOR<SensorCreateWithoutServerInput, SensorUncheckedCreateWithoutServerInput>
  }

  export type SensorUpdateWithWhereUniqueWithoutServerInput = {
    where: SensorWhereUniqueInput
    data: XOR<SensorUpdateWithoutServerInput, SensorUncheckedUpdateWithoutServerInput>
  }

  export type SensorUpdateManyWithWhereWithoutServerInput = {
    where: SensorScalarWhereInput
    data: XOR<SensorUpdateManyMutationInput, SensorUncheckedUpdateManyWithoutServerInput>
  }

  export type SensorScalarWhereInput = {
    AND?: SensorScalarWhereInput | SensorScalarWhereInput[]
    OR?: SensorScalarWhereInput[]
    NOT?: SensorScalarWhereInput | SensorScalarWhereInput[]
    sensor_id?: IntFilter<"Sensor"> | number
    server_id?: IntFilter<"Sensor"> | number
    sensor_type?: StringFilter<"Sensor"> | string
    unit?: StringFilter<"Sensor"> | string
    last_value?: FloatNullableFilter<"Sensor"> | number | null
    created_at?: DateTimeFilter<"Sensor"> | Date | string
  }

  export type FanUpsertWithWhereUniqueWithoutServerInput = {
    where: FanWhereUniqueInput
    update: XOR<FanUpdateWithoutServerInput, FanUncheckedUpdateWithoutServerInput>
    create: XOR<FanCreateWithoutServerInput, FanUncheckedCreateWithoutServerInput>
  }

  export type FanUpdateWithWhereUniqueWithoutServerInput = {
    where: FanWhereUniqueInput
    data: XOR<FanUpdateWithoutServerInput, FanUncheckedUpdateWithoutServerInput>
  }

  export type FanUpdateManyWithWhereWithoutServerInput = {
    where: FanScalarWhereInput
    data: XOR<FanUpdateManyMutationInput, FanUncheckedUpdateManyWithoutServerInput>
  }

  export type ServerCreateWithoutFansInput = {
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    cluster: ClusterCreateNestedOneWithoutServersInput
    configuration?: ClusterConfigurationCreateNestedOneWithoutServersInput
    sensors?: SensorCreateNestedManyWithoutServerInput
  }

  export type ServerUncheckedCreateWithoutFansInput = {
    server_id?: number
    cluster_id: number
    config_id?: number | null
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    sensors?: SensorUncheckedCreateNestedManyWithoutServerInput
  }

  export type ServerCreateOrConnectWithoutFansInput = {
    where: ServerWhereUniqueInput
    create: XOR<ServerCreateWithoutFansInput, ServerUncheckedCreateWithoutFansInput>
  }

  export type FanCatalogCreateWithoutFansInput = {
    model_name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationCreateNestedManyWithoutFan_modelInput
  }

  export type FanCatalogUncheckedCreateWithoutFansInput = {
    fan_catalog_id?: number
    model_name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationUncheckedCreateNestedManyWithoutFan_modelInput
  }

  export type FanCatalogCreateOrConnectWithoutFansInput = {
    where: FanCatalogWhereUniqueInput
    create: XOR<FanCatalogCreateWithoutFansInput, FanCatalogUncheckedCreateWithoutFansInput>
  }

  export type FanConfigurationCreateWithoutFansInput = {
    name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationCreateNestedManyWithoutFan_configInput
  }

  export type FanConfigurationUncheckedCreateWithoutFansInput = {
    fan_id?: number
    name: string
    consomation?: number | null
    cluster_configurations?: ClusterConfigurationUncheckedCreateNestedManyWithoutFan_configInput
  }

  export type FanConfigurationCreateOrConnectWithoutFansInput = {
    where: FanConfigurationWhereUniqueInput
    create: XOR<FanConfigurationCreateWithoutFansInput, FanConfigurationUncheckedCreateWithoutFansInput>
  }

  export type ServerUpsertWithoutFansInput = {
    update: XOR<ServerUpdateWithoutFansInput, ServerUncheckedUpdateWithoutFansInput>
    create: XOR<ServerCreateWithoutFansInput, ServerUncheckedCreateWithoutFansInput>
    where?: ServerWhereInput
  }

  export type ServerUpdateToOneWithWhereWithoutFansInput = {
    where?: ServerWhereInput
    data: XOR<ServerUpdateWithoutFansInput, ServerUncheckedUpdateWithoutFansInput>
  }

  export type ServerUpdateWithoutFansInput = {
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster?: ClusterUpdateOneRequiredWithoutServersNestedInput
    configuration?: ClusterConfigurationUpdateOneWithoutServersNestedInput
    sensors?: SensorUpdateManyWithoutServerNestedInput
  }

  export type ServerUncheckedUpdateWithoutFansInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    cluster_id?: IntFieldUpdateOperationsInput | number
    config_id?: NullableIntFieldUpdateOperationsInput | number | null
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    sensors?: SensorUncheckedUpdateManyWithoutServerNestedInput
  }

  export type FanCatalogUpsertWithoutFansInput = {
    update: XOR<FanCatalogUpdateWithoutFansInput, FanCatalogUncheckedUpdateWithoutFansInput>
    create: XOR<FanCatalogCreateWithoutFansInput, FanCatalogUncheckedCreateWithoutFansInput>
    where?: FanCatalogWhereInput
  }

  export type FanCatalogUpdateToOneWithWhereWithoutFansInput = {
    where?: FanCatalogWhereInput
    data: XOR<FanCatalogUpdateWithoutFansInput, FanCatalogUncheckedUpdateWithoutFansInput>
  }

  export type FanCatalogUpdateWithoutFansInput = {
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUpdateManyWithoutFan_modelNestedInput
  }

  export type FanCatalogUncheckedUpdateWithoutFansInput = {
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    model_name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUncheckedUpdateManyWithoutFan_modelNestedInput
  }

  export type FanConfigurationUpsertWithoutFansInput = {
    update: XOR<FanConfigurationUpdateWithoutFansInput, FanConfigurationUncheckedUpdateWithoutFansInput>
    create: XOR<FanConfigurationCreateWithoutFansInput, FanConfigurationUncheckedCreateWithoutFansInput>
    where?: FanConfigurationWhereInput
  }

  export type FanConfigurationUpdateToOneWithWhereWithoutFansInput = {
    where?: FanConfigurationWhereInput
    data: XOR<FanConfigurationUpdateWithoutFansInput, FanConfigurationUncheckedUpdateWithoutFansInput>
  }

  export type FanConfigurationUpdateWithoutFansInput = {
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUpdateManyWithoutFan_configNestedInput
  }

  export type FanConfigurationUncheckedUpdateWithoutFansInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    consomation?: NullableFloatFieldUpdateOperationsInput | number | null
    cluster_configurations?: ClusterConfigurationUncheckedUpdateManyWithoutFan_configNestedInput
  }

  export type ServerCreateWithoutSensorsInput = {
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    cluster: ClusterCreateNestedOneWithoutServersInput
    configuration?: ClusterConfigurationCreateNestedOneWithoutServersInput
    fans?: FanCreateNestedManyWithoutServerInput
  }

  export type ServerUncheckedCreateWithoutSensorsInput = {
    server_id?: number
    cluster_id: number
    config_id?: number | null
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
    fans?: FanUncheckedCreateNestedManyWithoutServerInput
  }

  export type ServerCreateOrConnectWithoutSensorsInput = {
    where: ServerWhereUniqueInput
    create: XOR<ServerCreateWithoutSensorsInput, ServerUncheckedCreateWithoutSensorsInput>
  }

  export type SensorDataCreateWithoutSensorInput = {
    time?: Date | string
    value: number
  }

  export type SensorDataUncheckedCreateWithoutSensorInput = {
    id?: number
    time?: Date | string
    value: number
  }

  export type SensorDataCreateOrConnectWithoutSensorInput = {
    where: SensorDataWhereUniqueInput
    create: XOR<SensorDataCreateWithoutSensorInput, SensorDataUncheckedCreateWithoutSensorInput>
  }

  export type SensorDataCreateManySensorInputEnvelope = {
    data: SensorDataCreateManySensorInput | SensorDataCreateManySensorInput[]
    skipDuplicates?: boolean
  }

  export type ServerUpsertWithoutSensorsInput = {
    update: XOR<ServerUpdateWithoutSensorsInput, ServerUncheckedUpdateWithoutSensorsInput>
    create: XOR<ServerCreateWithoutSensorsInput, ServerUncheckedCreateWithoutSensorsInput>
    where?: ServerWhereInput
  }

  export type ServerUpdateToOneWithWhereWithoutSensorsInput = {
    where?: ServerWhereInput
    data: XOR<ServerUpdateWithoutSensorsInput, ServerUncheckedUpdateWithoutSensorsInput>
  }

  export type ServerUpdateWithoutSensorsInput = {
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster?: ClusterUpdateOneRequiredWithoutServersNestedInput
    configuration?: ClusterConfigurationUpdateOneWithoutServersNestedInput
    fans?: FanUpdateManyWithoutServerNestedInput
  }

  export type ServerUncheckedUpdateWithoutSensorsInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    cluster_id?: IntFieldUpdateOperationsInput | number
    config_id?: NullableIntFieldUpdateOperationsInput | number | null
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    fans?: FanUncheckedUpdateManyWithoutServerNestedInput
  }

  export type SensorDataUpsertWithWhereUniqueWithoutSensorInput = {
    where: SensorDataWhereUniqueInput
    update: XOR<SensorDataUpdateWithoutSensorInput, SensorDataUncheckedUpdateWithoutSensorInput>
    create: XOR<SensorDataCreateWithoutSensorInput, SensorDataUncheckedCreateWithoutSensorInput>
  }

  export type SensorDataUpdateWithWhereUniqueWithoutSensorInput = {
    where: SensorDataWhereUniqueInput
    data: XOR<SensorDataUpdateWithoutSensorInput, SensorDataUncheckedUpdateWithoutSensorInput>
  }

  export type SensorDataUpdateManyWithWhereWithoutSensorInput = {
    where: SensorDataScalarWhereInput
    data: XOR<SensorDataUpdateManyMutationInput, SensorDataUncheckedUpdateManyWithoutSensorInput>
  }

  export type SensorDataScalarWhereInput = {
    AND?: SensorDataScalarWhereInput | SensorDataScalarWhereInput[]
    OR?: SensorDataScalarWhereInput[]
    NOT?: SensorDataScalarWhereInput | SensorDataScalarWhereInput[]
    id?: IntFilter<"SensorData"> | number
    time?: DateTimeFilter<"SensorData"> | Date | string
    sensor_id?: IntFilter<"SensorData"> | number
    value?: FloatFilter<"SensorData"> | number
  }

  export type SensorCreateWithoutDataInput = {
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
    server: ServerCreateNestedOneWithoutSensorsInput
  }

  export type SensorUncheckedCreateWithoutDataInput = {
    sensor_id?: number
    server_id: number
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
  }

  export type SensorCreateOrConnectWithoutDataInput = {
    where: SensorWhereUniqueInput
    create: XOR<SensorCreateWithoutDataInput, SensorUncheckedCreateWithoutDataInput>
  }

  export type SensorUpsertWithoutDataInput = {
    update: XOR<SensorUpdateWithoutDataInput, SensorUncheckedUpdateWithoutDataInput>
    create: XOR<SensorCreateWithoutDataInput, SensorUncheckedCreateWithoutDataInput>
    where?: SensorWhereInput
  }

  export type SensorUpdateToOneWithWhereWithoutDataInput = {
    where?: SensorWhereInput
    data: XOR<SensorUpdateWithoutDataInput, SensorUncheckedUpdateWithoutDataInput>
  }

  export type SensorUpdateWithoutDataInput = {
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    server?: ServerUpdateOneRequiredWithoutSensorsNestedInput
  }

  export type SensorUncheckedUpdateWithoutDataInput = {
    sensor_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ClusterConfigurationCreateManyLocationInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id?: number | null
  }

  export type ClusterCreateManyClusterLocationInput = {
    cluster_id?: number
    name: string
    created_at?: Date | string
  }

  export type ClusterConfigurationUpdateWithoutLocationInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    load_profile?: LoadProfileUpdateOneWithoutCluster_configurationsNestedInput
    cooler_model?: CpuCoolerCatalogUpdateOneRequiredWithoutCluster_configsNestedInput
    fan_model?: FanCatalogUpdateOneWithoutCluster_configurationsNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutCluster_configurationsNestedInput
    servers?: ServerUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateWithoutLocationInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
    servers?: ServerUncheckedUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutLocationInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
  }

  export type ClusterUpdateWithoutClusterLocationInput = {
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    servers?: ServerUpdateManyWithoutClusterNestedInput
  }

  export type ClusterUncheckedUpdateWithoutClusterLocationInput = {
    cluster_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    servers?: ServerUncheckedUpdateManyWithoutClusterNestedInput
  }

  export type ClusterUncheckedUpdateManyWithoutClusterLocationInput = {
    cluster_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ClusterConfigurationCreateManyLoad_profileInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
  }

  export type ClusterConfigurationUpdateWithoutLoad_profileInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cooler_model?: CpuCoolerCatalogUpdateOneRequiredWithoutCluster_configsNestedInput
    fan_model?: FanCatalogUpdateOneWithoutCluster_configurationsNestedInput
    location?: ClusterLocationUpdateOneWithoutCluster_configurationsNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutCluster_configurationsNestedInput
    servers?: ServerUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateWithoutLoad_profileInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    servers?: ServerUncheckedUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutLoad_profileInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
  }

  export type ClusterConfigurationCreateManyFan_configInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    fan_catalog_id: number
    load_profile_id?: number | null
  }

  export type FanCreateManyFan_configInput = {
    fan_id?: number
    server_id: number
    fan_catalog_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type ClusterConfigurationUpdateWithoutFan_configInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    load_profile?: LoadProfileUpdateOneWithoutCluster_configurationsNestedInput
    cooler_model?: CpuCoolerCatalogUpdateOneRequiredWithoutCluster_configsNestedInput
    fan_model?: FanCatalogUpdateOneWithoutCluster_configurationsNestedInput
    location?: ClusterLocationUpdateOneWithoutCluster_configurationsNestedInput
    servers?: ServerUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateWithoutFan_configInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
    servers?: ServerUncheckedUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutFan_configInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
  }

  export type FanUpdateWithoutFan_configInput = {
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    server?: ServerUpdateOneRequiredWithoutFansNestedInput
    catalog_info?: FanCatalogUpdateOneWithoutFansNestedInput
  }

  export type FanUncheckedUpdateWithoutFan_configInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type FanUncheckedUpdateManyWithoutFan_configInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ClusterConfigurationCreateManyFan_modelInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    cpu_cooler_catalog_id: number
    load_profile_id?: number | null
  }

  export type FanCreateManyCatalog_infoInput = {
    fan_id?: number
    server_id: number
    fan_config_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type ClusterConfigurationUpdateWithoutFan_modelInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    load_profile?: LoadProfileUpdateOneWithoutCluster_configurationsNestedInput
    cooler_model?: CpuCoolerCatalogUpdateOneRequiredWithoutCluster_configsNestedInput
    location?: ClusterLocationUpdateOneWithoutCluster_configurationsNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutCluster_configurationsNestedInput
    servers?: ServerUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateWithoutFan_modelInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
    servers?: ServerUncheckedUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutFan_modelInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    cpu_cooler_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
  }

  export type FanUpdateWithoutCatalog_infoInput = {
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    server?: ServerUpdateOneRequiredWithoutFansNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutFansNestedInput
  }

  export type FanUncheckedUpdateWithoutCatalog_infoInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    fan_config_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type FanUncheckedUpdateManyWithoutCatalog_infoInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    server_id?: IntFieldUpdateOperationsInput | number
    fan_config_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ClusterConfigurationCreateManyCooler_modelInput = {
    cluster_config_id?: number
    name: string
    master: number
    worker: number
    consomation_per_master?: number | null
    consomation_per_worker?: number | null
    hardware_per_master?: string | null
    hardware_per_worker?: string | null
    pue?: number | null
    location_id?: number | null
    fan_id?: number | null
    fan_count?: number
    fan_catalog_id: number
    load_profile_id?: number | null
  }

  export type ClusterConfigurationUpdateWithoutCooler_modelInput = {
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    load_profile?: LoadProfileUpdateOneWithoutCluster_configurationsNestedInput
    fan_model?: FanCatalogUpdateOneWithoutCluster_configurationsNestedInput
    location?: ClusterLocationUpdateOneWithoutCluster_configurationsNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutCluster_configurationsNestedInput
    servers?: ServerUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateWithoutCooler_modelInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
    servers?: ServerUncheckedUpdateManyWithoutConfigurationNestedInput
  }

  export type ClusterConfigurationUncheckedUpdateManyWithoutCooler_modelInput = {
    cluster_config_id?: IntFieldUpdateOperationsInput | number
    name?: StringFieldUpdateOperationsInput | string
    master?: IntFieldUpdateOperationsInput | number
    worker?: IntFieldUpdateOperationsInput | number
    consomation_per_master?: NullableFloatFieldUpdateOperationsInput | number | null
    consomation_per_worker?: NullableFloatFieldUpdateOperationsInput | number | null
    hardware_per_master?: NullableStringFieldUpdateOperationsInput | string | null
    hardware_per_worker?: NullableStringFieldUpdateOperationsInput | string | null
    pue?: NullableFloatFieldUpdateOperationsInput | number | null
    location_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_count?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: IntFieldUpdateOperationsInput | number
    load_profile_id?: NullableIntFieldUpdateOperationsInput | number | null
  }

  export type ServerCreateManyConfigurationInput = {
    server_id?: number
    cluster_id: number
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
  }

  export type ServerUpdateWithoutConfigurationInput = {
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    cluster?: ClusterUpdateOneRequiredWithoutServersNestedInput
    sensors?: SensorUpdateManyWithoutServerNestedInput
    fans?: FanUpdateManyWithoutServerNestedInput
  }

  export type ServerUncheckedUpdateWithoutConfigurationInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    cluster_id?: IntFieldUpdateOperationsInput | number
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    sensors?: SensorUncheckedUpdateManyWithoutServerNestedInput
    fans?: FanUncheckedUpdateManyWithoutServerNestedInput
  }

  export type ServerUncheckedUpdateManyWithoutConfigurationInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    cluster_id?: IntFieldUpdateOperationsInput | number
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type ServerCreateManyClusterInput = {
    server_id?: number
    config_id?: number | null
    hostname: string
    status?: string
    base_consumption_offset?: number
    created_at?: Date | string
  }

  export type ServerUpdateWithoutClusterInput = {
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    configuration?: ClusterConfigurationUpdateOneWithoutServersNestedInput
    sensors?: SensorUpdateManyWithoutServerNestedInput
    fans?: FanUpdateManyWithoutServerNestedInput
  }

  export type ServerUncheckedUpdateWithoutClusterInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    config_id?: NullableIntFieldUpdateOperationsInput | number | null
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    sensors?: SensorUncheckedUpdateManyWithoutServerNestedInput
    fans?: FanUncheckedUpdateManyWithoutServerNestedInput
  }

  export type ServerUncheckedUpdateManyWithoutClusterInput = {
    server_id?: IntFieldUpdateOperationsInput | number
    config_id?: NullableIntFieldUpdateOperationsInput | number | null
    hostname?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    base_consumption_offset?: FloatFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type SensorCreateManyServerInput = {
    sensor_id?: number
    sensor_type: string
    unit: string
    last_value?: number | null
    created_at?: Date | string
  }

  export type FanCreateManyServerInput = {
    fan_id?: number
    fan_catalog_id?: number | null
    fan_config_id?: number | null
    control_mode?: string
    status?: string
    speed_percent?: number
    created_at?: Date | string
  }

  export type SensorUpdateWithoutServerInput = {
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    data?: SensorDataUpdateManyWithoutSensorNestedInput
  }

  export type SensorUncheckedUpdateWithoutServerInput = {
    sensor_id?: IntFieldUpdateOperationsInput | number
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    data?: SensorDataUncheckedUpdateManyWithoutSensorNestedInput
  }

  export type SensorUncheckedUpdateManyWithoutServerInput = {
    sensor_id?: IntFieldUpdateOperationsInput | number
    sensor_type?: StringFieldUpdateOperationsInput | string
    unit?: StringFieldUpdateOperationsInput | string
    last_value?: NullableFloatFieldUpdateOperationsInput | number | null
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type FanUpdateWithoutServerInput = {
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
    catalog_info?: FanCatalogUpdateOneWithoutFansNestedInput
    fan_config?: FanConfigurationUpdateOneWithoutFansNestedInput
  }

  export type FanUncheckedUpdateWithoutServerInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_config_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type FanUncheckedUpdateManyWithoutServerInput = {
    fan_id?: IntFieldUpdateOperationsInput | number
    fan_catalog_id?: NullableIntFieldUpdateOperationsInput | number | null
    fan_config_id?: NullableIntFieldUpdateOperationsInput | number | null
    control_mode?: StringFieldUpdateOperationsInput | string
    status?: StringFieldUpdateOperationsInput | string
    speed_percent?: IntFieldUpdateOperationsInput | number
    created_at?: DateTimeFieldUpdateOperationsInput | Date | string
  }

  export type SensorDataCreateManySensorInput = {
    id?: number
    time?: Date | string
    value: number
  }

  export type SensorDataUpdateWithoutSensorInput = {
    time?: DateTimeFieldUpdateOperationsInput | Date | string
    value?: FloatFieldUpdateOperationsInput | number
  }

  export type SensorDataUncheckedUpdateWithoutSensorInput = {
    id?: IntFieldUpdateOperationsInput | number
    time?: DateTimeFieldUpdateOperationsInput | Date | string
    value?: FloatFieldUpdateOperationsInput | number
  }

  export type SensorDataUncheckedUpdateManyWithoutSensorInput = {
    id?: IntFieldUpdateOperationsInput | number
    time?: DateTimeFieldUpdateOperationsInput | Date | string
    value?: FloatFieldUpdateOperationsInput | number
  }



  /**
   * Batch Payload for updateMany & deleteMany & createMany
   */

  export type BatchPayload = {
    count: number
  }

  /**
   * DMMF
   */
  export const dmmf: runtime.BaseDMMF
}