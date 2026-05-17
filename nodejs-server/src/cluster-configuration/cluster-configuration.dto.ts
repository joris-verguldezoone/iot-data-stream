import { Type, Static } from '@sinclair/typebox';
import { Nullable } from '../common/utils.dto';
import { LoadProfileSchema } from '../cluster/load-profile.dto';
import { FanCatalogSchema, CpuCoolerCatalogSchema } from '../hardware/hardware.dto';

/**
 * Schéma Principal : ClusterConfiguration
 * Utilise Type.Ref pour les relations afin d'éviter l'erreur "schema already exists"
 */
export const ClusterConfigurationSchema = Type.Object({
  cluster_config_id: Type.Integer(),
  name: Type.String(),
  master: Type.Integer(),
  worker: Type.Integer(),
  consomation_per_master: Nullable(Type.Number()),
  consomation_per_worker: Nullable(Type.Number()),
  pue: Nullable(Type.Number()),
  fan_count: Type.Integer(),
  cpu_cooler_catalog_id: Type.Integer(),
  fan_catalog_id: Type.Integer(),
  load_profile_id: Type.Optional(Type.Integer()),
  
  // ✅ On utilise Type.Ref(Schema) pour faire un lien logique sans copier l'objet
  load_profile: Type.Optional(Type.Ref(LoadProfileSchema)), 
  fan_model: Type.Optional(Type.Ref(FanCatalogSchema)),
  cooler_model: Type.Optional(Type.Ref(CpuCoolerCatalogSchema)),
}, { $id: 'ClusterConfiguration' });

/**
 * DTO pour la création (POST)
 * On retire l'ID auto-incrémenté et les objets de relation complexes
 */
export const CreateClusterConfigSchema = Type.Omit(ClusterConfigurationSchema, [
  'cluster_config_id', 
  'load_profile', 
  'fan_model', 
  'cooler_model'
]);

// Types statiques pour l'usage dans les services
export type ClusterConfiguration = Static<typeof ClusterConfigurationSchema>;
export type CreateClusterConfigDTO = Static<typeof CreateClusterConfigSchema>;