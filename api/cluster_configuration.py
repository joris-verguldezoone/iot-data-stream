import json
#-------------------------------------big-----------------------

BIG_CLUSTERS = {

    "BIG_CLUSTER_HIGH_POWER" : {
        "name": "BIG_CLUSTER_HIGH_POWER",
        "masters":4,
        "workers": 16,
        "consomation_per_master": [1600,1800], # plage de consommation
        "consomation_per_worker": [1350,1550], # plage de consommation
        "hardware_per_master": "2×Xeon + 1×A100, 512GB",
        "hardware_per_worker": "2×Xeon, 1×A100, 512GB",
        "env_factor": 1.05,
        "PUE": 1.40, # Table intermédiaire privée pour masquer la solution
        "fan_id": int, # [fans]
        "location_id":int,        
    },

    "BIG_CLUSTER_HYBRID" : {
        "name": "BIG_CLUSTER_HYBRID",
        "masters":3,
        "workers": 17,
        "consomation_per_master": [1000,1200], # plage de consommation
        "consomation_per_worker": [800,1000], # plage de consommation
        "hardware_per_master": "2×EPYC, 1×V100, 384GB",
        "hardware_per_worker": "2×EPYC, 1×V100, 384GB",
        "env_factor": 1.05,
        "PUE": 1.40, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans]

    },

    "BIG_CLUSTER_LOW_POWER" : {
        "BIG_CLUSTER_LOW_POWER": "BIG_CLUSTER_LOW_POWER",
        "masters":2,
        "workers": 18,
        "consomation_per_master": [700, 900],   # plage de consommation
        "consomation_per_worker": [450,500], # plage de consommation
        "hardware_per_master": "2×CPU dense, no GPU, 256GB",
        "hardware_per_worker": "2×CPU dense, no GPU, 256GB",
        "env_factor": 1.15,
        "PUE": 1.70, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans]

    },
}


    #---------------------------------medium--------------------------------------------

MEDIUM_CLUSTERS = {
        

    "MEDIUM_GPU" : {
        "name":"MEDIUM_GPU",
        "masters":2,
        "workers": 8,
        "consomation_per_master": [750,950], # plage de consommation
        "consomation_per_worker": [650,750], # plage de consommation
        "hardware_per_master": "2×EPYC + 1×RTX, 256GB",
        "hardware_per_worker": "2×EPYC + 1×RTX, 256GB",
        "env_factor": 1.1,
        "PUE": 1.56, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans]

    },

    "MEDIUM_HEAVY_CPU" : {
        "name": "MEDIUM_HEAVY_CPU",
        "masters":2,
        "workers": 8,
        "consomation_per_master": [350,500], # plage de consommation
        "consomation_per_worker": [300,350], # plage de consommation
        "hardware_per_master": "2×Xeon, 128GB",
        "hardware_per_worker": "2×Xeon, 128GB",
        "env_factor": 1.2,
        "PUE": 1.75, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans]

    },

    "MEDIUM_EDGE_TYPE" : {
        "name": "MEDIUM_EDGE_TYPE",
        "masters":1,
        "workers": 9,
        "consomation_per_master": [200,250], # plage de consommation
        "consomation_per_worker": [150,180], # plage de consommation
        "hardware_per_master": "i9 + small accel, 64GB",
        "hardware_per_worker": "i9 + small accel, 64GB",
        "env_factor": 1.25,
        "PUE": 2, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans]

    },
}
    #-----------------------------small-------------------------------------
SMALL_CLUSTERS = {
    "SMALL_MINI_GPU" : {
        "name": "SMALL_MINI_GPU",
        "masters":1,
        "workers": 4,
        "consomation_per_master": [400,450], # plage de consommation
        "consomation_per_worker": [300,350], # plage de consommation
        "hardware_per_master": "i9 + 1×RTX, 128GB",
        "hardware_per_worker": "i9 + 1×RTX, 128GB",
        "env_factor": 1.2,
        "PUE": 1.75, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans] a insérer apres seeding

    },

    "SMALL_CPU" : {
        "name":"SMALL_CPU",
        "masters":1,
        "workers": 4,
        "consomation_per_master": [150,180], # plage de consommation
        "consomation_per_worker": [100,120], # plage de consommation
        "hardware_per_master": "i7 / Xeon small, 64GB",
        "hardware_per_worker": "i7 / Xeon small, 64GB",
        "env_factor": 1.3,
        "PUE": 2.25, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans] a insérer apres seeding

    },

    "SMALL_EDGE_CLOSET" : {
        "name": "SMALL_EDGE_CLOSET",
        "masters":1,
        "workers": 4,
        "consomation_per_master": [50,70], # plage de consommation
        "consomation_per_worker": [30,45], # plage de consommation
        "hardware_per_master": "NUC / low-power, 32GB",
        "hardware_per_worker": "NUC / low-power, 32GB",
        "env_factor": 1.35,
        "PUE": 2.25, # Table intermédiaire privée pour masquer la solution
        "location_id":int,
        "fan_id": int # [fans] a insérer apres seedin
        
    }
}
