Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableMoneyWash            = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'


Config.AuthorizedVehicles = {
    { name = 'Dloader',  label = 'Véhicule' },
}

Config.Blips = {
    
    Blip = {
        Pos     = { x = 1966.643, y = 4634.773, z = 41.141 },
        Sprite  = 318,
        Display = 4,
        Scale   = 1.0,
        Color   = 31
    }

}

Config.Zones = {

    Cloakrooms = {
        Pos     = { x = 1958.847, y = 4628.1787, z = 40.066 },
        Size  = { x = 1.5, y = 1.5, z = 1.5 },
        Color = { r = 255, g = 255, b = 255 },
        Type  = 25,
        Etat  = 0,
    },

    Vaults = {
        Pos   = { x = 1968.106, y = 4623.081, z = 40.079 },
        Size    = { x = 1.5, y = 1.5, z = 1.5 },
        Color   = { r = 255, g = 255, b = 255 },
        Type    = 25,
        Etat  = 0,
    },


    Vehicles = {
        Pos         = { x = 1930.040, y = 4635.708, z = 39.4565 },
        SpawnPoint  = { x = 1959.882, y = 4646.546, z = 39.758 },
        Size        = { x = 1.5, y = 1.5, z = 1.5 },
        Color       = { r = 255, g = 255, b = 255 },
        Type        = 25,
        Etat  = 0,
        Heading     = 58.0
    },

    VehicleDeleters = {
        Pos     = { x = 1972.991, y =4641.703, z = 39.984 },
        Size    = { x = 1.5, y = 1.5, z = 1.5 },
        Color   = { r = 255, g = 255, b = 255 },
        Type    = 25,
        Etat  = 0,
    },

    BossActions = {
        Pos     = { x = 1966.643, y = 4634.773, z = 40.141 },
        Size    = { x = 1.5, y = 1.5, z = 1.5 },
        Color   = { r = 255, g = 255, b = 255 },
        Type    = 25,
        Etat  = 0,
    },

    HoublonFarm = {
        Pos    = { x = 1886.309, y = 4858.142, z = 44.619 },
        Size   = { x = 2.5, y = 2.5, z = 2.5 },
        Color  = {r = 255, g = 255, b = 255},
        Name  = "Cultiver du houblon",
        Type   = 25,
        Etat  = 1,
    },


    TraitementBrune = {
        Pos   = { x = 407.702, y = 6496.108, z = 26.874 },
        Size  = { x = 2.5, y = 2.5, z = 2.5} ,
        Color = {r = 255, g = 255, b = 255},
        Name  = "Traitement brune",
        Type  = 25,
        Etat  = 1,
    },

    TraitementBlonde = {
        Pos   = { x= 2466.022, y=  4101.801, z= 37.064 },
        Size  = { x = 2.5, y = 2.5, z = 2.5} ,
        Color = {r = 255, g = 255, b = 255},
        Name  = "Traitement blonde",
        Type  = 25,
        Etat  = 1,
    },
    
    SellFarm = {
        Pos   = { x = 89.437, y = -1744.525, z = 29.150 },
        Size  = { x = 2.5, y = 2.5, z = 2.5 },
        Color = {r = 255, g = 255, b = 255},
        Name  = "Vendre",
        Type  = 25,
        Etat  = 1,
    },
}



-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  brasseur_outfit = {
    male = {
        ['tshirt_1'] = 63,  ['tshirt_2'] = 0,
        ['torso_1'] = 23,   ['torso_2'] = 3,
        ['decals_1'] = 3,   ['decals_2'] = 0,
        ['arms'] = 12,
        ['pants_1'] = 24,   ['pants_2'] = 5,
        ['shoes_1'] = 1,    ['shoes_2'] = 1,
        ['chain_1'] = 0,    ['chain_2'] = 0
    },
        female = {
        ['tshirt_1'] = 63,  ['tshirt_2'] = 0,
        ['torso_1'] = 23,   ['torso_2'] = 3,
        ['decals_1'] = 3,   ['decals_2'] = 0,
        ['arms'] = 12,
        ['pants_1'] = 24,   ['pants_2'] = 5,
        ['shoes_1'] = 1,   ['shoes_2'] = 1,
        ['chain_1'] = 0,  ['chain_2'] = 0
    }
 
  }
}
