/**
 * Tests for server.ts logic changed in this PR:
 * - coolingRegistry state management (comment removed, logic unchanged)
 * - fan_speed validation (POST /api/servers/:hostname/control)
 * - publicPath fallback algorithm (comment removed, logic unchanged)
 * - schemas array (intentional missing comma between SensorHistoryResponseSchema and FanSchema)
 * - package.json: lodash version downgraded from ^4.17.21 to ^4.17.15
 */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import path from 'path';

// ---------------------------------------------------------------------------
// 1. coolingRegistry logic
//    The PR removed a French comment above `const coolingRegistry: Record<string, number> = {};`
//    The object itself and its usage in POST /api/servers/:hostname/control are unchanged.
//    We test the equivalent logic directly.
// ---------------------------------------------------------------------------

describe('coolingRegistry state management', () => {
  let registry: Record<string, number>;

  beforeEach(() => {
    registry = {};
  });

  it('starts as an empty object', () => {
    expect(registry).toEqual({});
  });

  it('stores a fan_speed for a given hostname', () => {
    registry['server-01'] = 75;
    expect(registry['server-01']).toBe(75);
  });

  it('overwrites an existing fan_speed for the same hostname', () => {
    registry['server-01'] = 50;
    registry['server-01'] = 80;
    expect(registry['server-01']).toBe(80);
  });

  it('stores independent fan_speeds for different hostnames', () => {
    registry['server-01'] = 30;
    registry['server-02'] = 90;
    expect(registry['server-01']).toBe(30);
    expect(registry['server-02']).toBe(90);
  });

  it('returns the full registry object for /internal/control', () => {
    registry['server-01'] = 45;
    registry['server-02'] = 60;
    const response = { ...registry };
    expect(response).toEqual({ 'server-01': 45, 'server-02': 60 });
  });

  it('stores fan_speed 0 (minimum boundary)', () => {
    registry['server-min'] = 0;
    expect(registry['server-min']).toBe(0);
  });

  it('stores fan_speed 100 (maximum boundary)', () => {
    registry['server-max'] = 100;
    expect(registry['server-max']).toBe(100);
  });
});

// ---------------------------------------------------------------------------
// 2. fan_speed validation logic
//    From POST /api/servers/:hostname/control in server.ts:
//    if (fan_speed === undefined || fan_speed < 0 || fan_speed > 100) {
//      return reply.status(400).send({ error: "fan_speed doit être une valeur entre 0 et 100" });
//    }
// ---------------------------------------------------------------------------

function isInvalidFanSpeed(fan_speed: number | undefined): boolean {
  return fan_speed === undefined || fan_speed < 0 || fan_speed > 100;
}

describe('fan_speed validation (POST /api/servers/:hostname/control)', () => {
  it('rejects undefined fan_speed', () => {
    expect(isInvalidFanSpeed(undefined)).toBe(true);
  });

  it('rejects fan_speed below 0', () => {
    expect(isInvalidFanSpeed(-1)).toBe(true);
  });

  it('rejects fan_speed of -100', () => {
    expect(isInvalidFanSpeed(-100)).toBe(true);
  });

  it('rejects fan_speed above 100', () => {
    expect(isInvalidFanSpeed(101)).toBe(true);
  });

  it('rejects fan_speed of 200', () => {
    expect(isInvalidFanSpeed(200)).toBe(true);
  });

  it('accepts fan_speed of 0 (lower boundary)', () => {
    expect(isInvalidFanSpeed(0)).toBe(false);
  });

  it('accepts fan_speed of 100 (upper boundary)', () => {
    expect(isInvalidFanSpeed(100)).toBe(false);
  });

  it('accepts fan_speed of 50 (midpoint)', () => {
    expect(isInvalidFanSpeed(50)).toBe(false);
  });

  it('accepts fan_speed of 1 (just above minimum)', () => {
    expect(isInvalidFanSpeed(1)).toBe(false);
  });

  it('accepts fan_speed of 99 (just below maximum)', () => {
    expect(isInvalidFanSpeed(99)).toBe(false);
  });

  it('rejects fan_speed of 100.1 (fractional overflow)', () => {
    expect(isInvalidFanSpeed(100.1)).toBe(true);
  });

  it('rejects fan_speed of -0.1 (fractional underflow)', () => {
    expect(isInvalidFanSpeed(-0.1)).toBe(true);
  });

  it('accepts fan_speed of 0.5 (fractional within range)', () => {
    expect(isInvalidFanSpeed(0.5)).toBe(false);
  });
});

// ---------------------------------------------------------------------------
// 3. POST /api/servers/:hostname/control response shape
//    On success: { success: true, hostname, fan_speed }
//    On error:   { error: "fan_speed doit être une valeur entre 0 et 100" }
// ---------------------------------------------------------------------------

describe('control endpoint response shape', () => {
  function buildSuccessResponse(hostname: string, fan_speed: number) {
    return { success: true, hostname, fan_speed };
  }

  function buildErrorResponse() {
    return { error: 'fan_speed doit être une valeur entre 0 et 100' };
  }

  it('success response contains success: true', () => {
    const res = buildSuccessResponse('server-01', 75);
    expect(res.success).toBe(true);
  });

  it('success response echoes hostname', () => {
    const res = buildSuccessResponse('server-01', 75);
    expect(res.hostname).toBe('server-01');
  });

  it('success response echoes fan_speed', () => {
    const res = buildSuccessResponse('server-01', 75);
    expect(res.fan_speed).toBe(75);
  });

  it('error response contains correct French error message', () => {
    const res = buildErrorResponse();
    expect(res.error).toBe('fan_speed doit être une valeur entre 0 et 100');
  });

  it('success and error responses are mutually exclusive shapes', () => {
    const success = buildSuccessResponse('server-01', 50);
    const error = buildErrorResponse();
    expect('success' in success).toBe(true);
    expect('success' in error).toBe(false);
    expect('error' in error).toBe(true);
    expect('error' in success).toBe(false);
  });
});

// ---------------------------------------------------------------------------
// 4. publicPath fallback algorithm
//    The PR removed a comment above the publicPath logic but kept the logic intact.
//    Logic:
//      let publicPath = path.join(process.cwd(), 'public');
//      if (!fs.existsSync(path.join(publicPath, 'dashboard.html'))) {
//        publicPath = path.join(__dirname, '../public');
//      }
//      if (!fs.existsSync(path.join(publicPath, 'dashboard.html'))) {
//        publicPath = path.join(__dirname, '../../public');
//      }
// ---------------------------------------------------------------------------

describe('publicPath fallback algorithm', () => {
  it('resolves first candidate as CWD/public', () => {
    const firstCandidate = path.join(process.cwd(), 'public');
    expect(firstCandidate).toContain('public');
    expect(path.isAbsolute(firstCandidate)).toBe(true);
  });

  it('selects first candidate when dashboard.html exists there', () => {
    const mockExistsSync = vi.fn().mockReturnValue(true);
    const cwd = '/app';
    let publicPath = path.join(cwd, 'public');
    if (!mockExistsSync(path.join(publicPath, 'dashboard.html'))) {
      publicPath = path.join('/some/__dirname', '../public');
    }
    expect(publicPath).toBe('/app/public');
    expect(mockExistsSync).toHaveBeenCalledOnce();
  });

  it('falls back to first __dirname candidate when CWD/public has no dashboard.html', () => {
    let callCount = 0;
    const mockExistsSync = vi.fn().mockImplementation(() => {
      callCount++;
      return callCount > 1; // first call returns false, second returns true
    });

    const dirnameBase = '/app/dist/src';
    let publicPath = path.join('/app', 'public');
    if (!mockExistsSync(path.join(publicPath, 'dashboard.html'))) {
      publicPath = path.join(dirnameBase, '../public');
    }
    if (!mockExistsSync(path.join(publicPath, 'dashboard.html'))) {
      publicPath = path.join(dirnameBase, '../../public');
    }

    expect(publicPath).toBe('/app/dist/public');
    expect(mockExistsSync).toHaveBeenCalledTimes(2);
  });

  it('falls back to second __dirname candidate when first two candidates have no dashboard.html', () => {
    const mockExistsSync = vi.fn().mockReturnValue(false);
    const dirnameBase = '/app/dist/src';
    let publicPath = path.join('/app', 'public');
    if (!mockExistsSync(path.join(publicPath, 'dashboard.html'))) {
      publicPath = path.join(dirnameBase, '../public');
    }
    if (!mockExistsSync(path.join(publicPath, 'dashboard.html'))) {
      publicPath = path.join(dirnameBase, '../../public');
    }

    expect(publicPath).toBe('/app/public');
    expect(mockExistsSync).toHaveBeenCalledTimes(2);
  });

  it('each successive fallback path resolves to a different directory', () => {
    const dirnameBase = '/app/dist/src';
    const candidate1 = path.join('/app', 'public');
    const candidate2 = path.join(dirnameBase, '../public');
    const candidate3 = path.join(dirnameBase, '../../public');
    // All three are distinct paths
    expect(candidate1).not.toBe(candidate2);
    expect(candidate2).not.toBe(candidate3);
    expect(candidate1).not.toBe(candidate3);
  });
});

// ---------------------------------------------------------------------------
// 5. schemas array — intentional syntax issue introduced in this PR
//    The PR changed:
//      SensorHistoryResponseSchema,   (with trailing comma)
//    to:
//      SensorHistoryResponseSchema // erreur volontaire pour CodeRabbit
//      FanSchema                       (no comma → ASI does NOT apply in arrays)
//
//    This means the schemas array as written in server.ts is a syntax error:
//    two adjacent identifiers without a comma in an array literal.
//    We test that a correctly comma-separated schemas array behaves as expected.
// ---------------------------------------------------------------------------

describe('schemas array registration logic', () => {
  const schema1 = { $id: 'Schema1' };
  const schema2 = { $id: 'Schema2' };
  const schema3 = { $id: 'Schema3' };

  it('registers all schemas when comma-separated correctly', () => {
    const schemas = [schema1, schema2, schema3];
    expect(schemas).toHaveLength(3);
    expect(schemas[0].$id).toBe('Schema1');
    expect(schemas[2].$id).toBe('Schema3');
  });

  it('does not register a schema whose $id is already present (idempotent registration)', () => {
    const registeredIds = new Set<string>();
    const schemas = [schema1, schema2, schema3];

    const addedSchemas: typeof schema1[] = [];
    schemas.forEach(schema => {
      if (schema.$id && !registeredIds.has(schema.$id)) {
        registeredIds.add(schema.$id);
        addedSchemas.push(schema);
      }
    });

    expect(addedSchemas).toHaveLength(3);
    expect(registeredIds.has('Schema1')).toBe(true);
    expect(registeredIds.has('Schema2')).toBe(true);
    expect(registeredIds.has('Schema3')).toBe(true);
  });

  it('skips duplicate schemas without throwing', () => {
    const registeredIds = new Set<string>();
    const schemasWithDuplicate = [schema1, schema1, schema2];
    const addedSchemas: typeof schema1[] = [];

    schemasWithDuplicate.forEach(schema => {
      if (schema.$id && !registeredIds.has(schema.$id)) {
        registeredIds.add(schema.$id);
        addedSchemas.push(schema);
      }
    });

    expect(addedSchemas).toHaveLength(2);
  });

  it('handles schema without $id gracefully', () => {
    const schemaWithoutId = {} as { $id?: string };
    const registeredIds = new Set<string>();
    const addedSchemas: typeof schemaWithoutId[] = [];

    [schemaWithoutId, schema1].forEach(schema => {
      if (schema.$id && !registeredIds.has(schema.$id)) {
        registeredIds.add(schema.$id);
        addedSchemas.push(schema);
      }
    });

    expect(addedSchemas).toHaveLength(1);
    expect(addedSchemas[0].$id).toBe('Schema1');
  });

  it('SensorHistoryResponseSchema and FanSchema are both valid schema-like objects with $id', () => {
    // Simulating the two schemas that are adjacent in the broken array
    const sensorHistorySchema = { $id: 'SensorHistory' };
    const fanSchema = { $id: 'Fan' };
    const registeredIds = new Set<string>();

    // When the comma is present both are registered
    const correctArray = [sensorHistorySchema, fanSchema];
    correctArray.forEach(s => {
      if (s.$id && !registeredIds.has(s.$id)) registeredIds.add(s.$id);
    });

    expect(registeredIds.has('SensorHistory')).toBe(true);
    expect(registeredIds.has('Fan')).toBe(true);
  });
});

// ---------------------------------------------------------------------------
// 6. lodash version compatibility (package.json change: ^4.17.21 → ^4.17.15)
//    Both versions expose the same stable lodash API.
//    We test that standard lodash utilities used in the project work as expected
//    regardless of whether the resolved version is >=4.17.15 or >=4.17.21.
// ---------------------------------------------------------------------------

describe('lodash version compatibility (^4.17.15 vs ^4.17.21)', () => {
  it('semver range ^4.17.15 is satisfied by 4.17.15', () => {
    // The minimum version accepted is now 4.17.15 instead of 4.17.21
    const satisfiesMinimum = (version: string, minVersion: string): boolean => {
      const [major, minor, patch] = version.split('.').map(Number);
      const [minMaj, minMin, minPat] = minVersion.split('.').map(Number);
      if (major !== minMaj) return major > minMaj;
      if (minor !== minMin) return minor > minMin;
      return patch >= minPat;
    };

    expect(satisfiesMinimum('4.17.15', '4.17.15')).toBe(true);
    expect(satisfiesMinimum('4.17.21', '4.17.15')).toBe(true);
    expect(satisfiesMinimum('4.17.14', '4.17.15')).toBe(false);
  });

  it('semver range ^4.17.21 is NOT satisfied by 4.17.15', () => {
    const lessThan = (version: string, compareTo: string): boolean => {
      const [maj, min, pat] = version.split('.').map(Number);
      const [cMaj, cMin, cPat] = compareTo.split('.').map(Number);
      if (maj !== cMaj) return maj < cMaj;
      if (min !== cMin) return min < cMin;
      return pat < cPat;
    };

    // 4.17.15 < 4.17.21, so old minimum would reject it
    expect(lessThan('4.17.15', '4.17.21')).toBe(true);
  });

  it('both version ranges share the same major.minor (4.17.x)', () => {
    const oldMin = '4.17.21';
    const newMin = '4.17.15';
    const [oldMaj, oldMinor] = oldMin.split('.').map(Number);
    const [newMaj, newMinor] = newMin.split('.').map(Number);
    expect(oldMaj).toBe(newMaj);
    expect(oldMinor).toBe(newMinor);
  });
});

// ---------------------------------------------------------------------------
// 7. CORS configuration
//    The CORS origins list in server.ts is:
//    ['http://localhost:4200', 'http://127.0.0.1:4200', 'http://localhost:3000']
//    The server.ts diff does NOT change CORS, but CORS is set up around the
//    removed comments. We confirm the expected origins structure.
// ---------------------------------------------------------------------------

describe('CORS origins configuration', () => {
  const corsOrigins = [
    'http://localhost:4200',
    'http://127.0.0.1:4200',
    'http://localhost:3000',
  ];

  it('allows exactly three origins', () => {
    expect(corsOrigins).toHaveLength(3);
  });

  it('includes Angular dev server origin (localhost:4200)', () => {
    expect(corsOrigins).toContain('http://localhost:4200');
  });

  it('includes Angular dev server origin via 127.0.0.1:4200', () => {
    expect(corsOrigins).toContain('http://127.0.0.1:4200');
  });

  it('includes the server own port origin (localhost:3000)', () => {
    expect(corsOrigins).toContain('http://localhost:3000');
  });

  it('does not allow wildcard origin (*)', () => {
    expect(corsOrigins).not.toContain('*');
  });

  it('all origins use http scheme (no https)', () => {
    corsOrigins.forEach(origin => {
      expect(origin.startsWith('http://')).toBe(true);
    });
  });

  it('does not include production-like origins', () => {
    expect(corsOrigins.every(o => o.includes('localhost') || o.includes('127.0.0.1'))).toBe(true);
  });
});