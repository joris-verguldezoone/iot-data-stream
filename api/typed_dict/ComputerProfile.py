from typing import TypedDict

class ComputerProfile:
    id: int
    name: str # généré en fonction du profil  
    hardware:str # simple description 
    hardware_consommation:str # consommation annoncé en fonction du hardware
    fan_type_id:int
    Cluster_id:int
    role:int

class FanType:
    id:int
    name:str # a générer en fonction du model
    description: str # inutile ?
    consomation: float # kw/h

class ClusterProfile: 
    infra_support_kw: float # peut etre caduque du au env factor 
    env_factor:float # 1.2 indice de suprlux de consommation du a l'environnement
    PUE:float # indice d'efficience a atteindre
    roles_repartition:dict # 2 master, 18 slaves 

class Cluster:
    id:int
    clust_profile_id:int

    #consommation des éclairage et tout ce qui ne peut pas être 
    #quantifié a travers les autres entitiés 
class Profile:
    id:int
    name:str # issu des tableau en .md
    # aura une table intermédiaire pour créer les différents profils avec le details des fk 

class ComputerRole:
    id:int
    profile:str # permet d'obtenir les spec du master ou worker issu du profile 
    role:str # master ou worker

class Sensor: 
    id:int
    name:str
    sensor_type_fk:int # enum ? 
    datum:str # ° humidité air flow

class SensorType:
    id:int
    name:str # capteur de chaleur, capteur d'humidité, capteur de densité d'air
