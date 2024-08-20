Config ={}
local selectAnimDict ="anim@cop_mic_pose_001"
local selectAnimName ="chest_mic"
local radioProp;
RegisterCommand("atest", function()
    local playerPed = PlayerPedId()
    --local dict = "anim@cop_mic_pose_001"
    --local anim = "chest_mic"
    --local dict = "anim@cop_mic_pose_002"
    --local anim = "chest_mic"
    --local dict = "anim@cop_mic_pose_002_1"
    --local anim = "chest_mic_pose"
    --local dict = "anim@cop_mic_pose_002_2"
    --local anim = "chest_mic_02"
    --local dict = "anim@belt_pose_hlstr"
    --local anim = "hand_hlstr_scene"
    local dict = "anim@male@holding_radio"
    local anim = "holding_radio_clip"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)
    
	
end, false)

RegisterCommand('radioanim', function()
    local animListMenu = {}
    animListMenu[#animListMenu + 1] = { -- create non-clickable header button
        isMenuHeader = true,
        header = 'Radio Animations',
        text = "1000001",
        icon = 'fa fa-cog'
    }

    for k,v in ipairs(Config.animList) do 
        animListMenu[#animListMenu + 1] = { 
            header = v.animTitle,
            txt = '',
            icon = 'fa fa-phone',
            params = {
                event = 'lidfor:radioanim:selectAnim',
                args = {
                    animTitle = v.animTitle,
                    animDict = v.animDict,
                    animName = v.animName,
                }
            }
        }
    end
    exports['qb-menu']:openMenu(animListMenu) -- open our menu
end)

RegisterNetEvent('lidfor:radioanim:selectAnim', function(data)
    selectAnimDict= data.animDict
    selectAnimName = data.animName
end)

RegisterNetEvent('lidfor:radioanim:animPlay', function()
    local playerPed = PlayerPedId()
    if selectAnimName == "holding_radio_clip" then 
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13544876595097, 0.051973119787891, -0.029258303514433, -93.78105269127, -7.4997158143199, -36.431763377751, true, true, false, true, 1, true)
    elseif selectAnimName == "radio_left_clip" then 
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.13544876595097, 0.051973119787891, 0.029258303514433, -93.78105269127, -7.4997158143199, -36.431763377751, true, true, false, true, 1, true)
    end
    local dict = selectAnimDict
    local anim = selectAnimName
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    TaskPlayAnim(playerPed, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)
end)
RegisterNetEvent('lidfor:radioanim:animStop', function()
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    if selectAnimName == "holding_radio_clip" or selectAnimName == "radio_left_clip" then 
        DeleteObject(radioProp)
    end
end)