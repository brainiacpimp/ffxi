-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachiya Kyahan +2"
    
    select_movement_feet()
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
    sets.precast.JA['Futae'] = {legs="Hattori Tekko +2"}
    sets.precast.JA['Sange'] = {legs="Mochizuki Chainmail"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Felistris Mask",
        body="Hachiya Chainmail +1",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}
        -- Uk'uxkaj Cap, Daihanshi Habaki
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        head="Whirlpool Mask",neck="Ej Necklace",
        body="Otronif Harness +1",hands="Buremte Gloves",ring1="Patricius Ring",
        back="Yokaze Mantle",waist="Chaac Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        ammo="Sapience Orb",  --2
        head="Herculean Helm",  --7
        neck="Orunmila's Torque",  --5
        ear1="Enchanter's Earring +1", --2
        ear2="Loquacious Earring",  --5
        body="Dread Jupon",  --7
        hands="Leyline Gloves",  --5
        feet="Herculean Boots",  --2
        ring1="Kishar Ring",  --4
        ring2="Rahab Ring",  --2
        waist="",
        back="",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket",neck="Magoraga Beads"})

    -- Snapshot for ranged
    sets.precast.RA = {legs="Nahtirah Trousers"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Aurgelmir Orb",
        head="Hachiya Hatsu. +3",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Gere Ring",
        ring2="Karieyh Ring +1",
        back="Yokaze Mantle",
        waist="Fotia Belt",
        legs="Nyame Flanchard",
        feet="Mpaca's Boots"
    }
    sets.precast.WS.Acc = sets.precast.WS

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Teki'] = {
        ammo="Seething Bomblet +1",
        head="Mochizuki Hatsuburi +3",
        neck="Ninja Nodowa +1",
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Gere Ring",
        ring2="Karieyh Ring +1",
        back="Sacro Mantle",
        waist="Orpheus's Sash",
        legs="Nyame Flanchard",
        feet="Herculean Boots",
    }
    sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Teki']

    sets.precast.WS['Blade: Chi'] = sets.precast.WS['Blade: Teki']

    sets.precast.WS['Blade: Jin'] = sets.precast.WS['Blade: Teki']

    sets.precast.WS['Blade: Hi'] = {
        ammo="Yetshila +1",
        head="Hachiya Hatsu. +3",
        neck="Ninja Nodowa +1",
        ear1="Lugra Earring +1",
        ear2="Odr Earring",
        body="Nyame Mail",
        hands="Mpaca's Gloves",
        ring1="Begrudging Ring",
        ring2="Regal Ring",
        back="Sacro Mantle",
        waist="Sailfi Belt +1",
        legs="Nyame Flanchard",
        feet="Mpaca's Boots",
    }

    sets.precast.WS['Blade: Shun'] = {
        ammo="Aurgelmir Orb",
        head="Mpaca's Cap",
        neck="Fotia Gorget",
        ear1="Lugra Earring +1",
        ear2="Odr Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Gere Ring",
        ring2="Regal Ring",
        back="Andartia's Mantle",
        waist="Fotia Belt",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
    }


    sets.precast.WS['Aeolian Edge'] = {
        ammo="Seething Bomblet +1",
        head="Nyame Helm",
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Dingir Ring",
        ring2="Karieyh Ring +1",
        back="Sacro Mantle",
        waist="Orpheus's Sash",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    }

    sets.precast.WS['Blade: Ei'] = {
        ammo="Seething Bomblet +1",
        head="Pixie Hairpin +1",
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        body="Nyame Mail",
        hands="Herculean Gloves",
        ring1="Archon Ring",
        ring2="Karieyh Ring +1",
        back="Yokaze Mantle",
        waist="Orpheus's Sash",
        legs="Nyame Flanchard",
        feet="Herculean Boots",
    }

    sets.precast.WS['Blade: Ku'] = {
        ammo="Seething Bomblet +1",
        head="Blistering Sallet +1",
        neck="Fotia Gorget",
        ear1="Lugra Earring +1",
        ear2="Mache Earring +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Gere Ring",
        ring2="Regal Ring",
        back="Sacro Mantle",
        waist="Fotia Belt",
        legs="Nyame Flanchard",
        feet="Mochizuki Kyahan +3",
    } 
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Felistris Mask",ear2="Loquacious Earring",
        body="Hachiya Chainmail +1",hands="Mochizuki Tekko",ring1="Prolix Ring",
        legs="Hachiya Hakama",feet="Qaaxo Leggings"}
        
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {body="Passion Jacket",back="Andartia's Mantle",feet="Hattori Kyahan"})

    sets.midcast.ElementalNinjutsu = {
        ammo="Ghastly Tathlum +1",
        head="Mochizuki Hatsuburi +3",
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Nyame Mail",
        hands="Hattori Tekko +2",
        ring1="Dingir Ring",
        ring2="Mujin Band",
        back="Apute Mantle",
        waist="Orpheus's Sash",
        legs="Nyame Flanchard",
        feet="Mochizuki Kyahan +3"
        }

    sets.midcast.ElementalNinjutsu.Resistant = sets.midcast.Ninjutsu

    sets.midcast.NinjutsuDebuff = {
        ammo="Yamarang",
        head="Hachiya Hatsu. +3",
        neck="Sanctity Necklace",
        ear1="Crepuscular Earring",
        ear2="Dignitary's Earring",
        body="Malignance Tabard",
        hands="Hattori Tekko +2",
        ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back="Sacro Mantle",
        waist="Eschan Stone",
        legs="Malignance Tights",
        feet="Malignance Boots",
        }

    sets.midcast.NinjutsuBuff = {back="Andartia's Mantle"}

    sets.midcast.RA = {
    }

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    
    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        neck="Bathy Choker",
        ear1="Infused Earring",
        ear2="Tuisto Earring",
        body="Malignance Tabard",
        hands="Nyame Gauntlets",
        ring1="Defending Ring",
        ring2="Fortified Ring",
        back="Reiki Cloak",
        waist="Sveltesse Gouriz +1",
        legs="Nyame Flanchard",
        feet="Hachiya Kyahan +2",
    }

    sets.idle.Town = sets.idle
    
    sets.idle.Weak = sets.idle
    
    -- Defense sets
    sets.defense.Evasion = {
        head="Malignance Chapeau",neck="Ej Necklace",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Beeline Ring",
        back="Yokaze Mantle",waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Whirlpool Mask",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Whirlpool Mask",neck="Twilight Torque",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}


    sets.Kiting = {feet="Hachiya Kyahan +2"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Date Shuriken",
        head="Malignance Chapeau",
        neck="Ninja Nodowa +1",
        ear1="Suppanomimi",
        ear2="Eabani Earring",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back="Andartia's Mantle",
        waist="Reiki Yotai",
        legs="Mpaca's Hose",
        feet="Malignance Boots"
    }

    sets.engaged.Acc = sets.engaged
    sets.engaged.Evasion = sets.engaged
    sets.engaged.Acc.Evasion = sets.engaged
    sets.engaged.PDT = sets.engaged
    sets.engaged.Acc.PDT = sets.engaged

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = sets.engaged
    sets.engaged.Acc.HighHaste = sets.engaged
    sets.engaged.Evasion.HighHaste = sets.engaged
    sets.engaged.Acc.Evasion.HighHaste = sets.engaged
    sets.engaged.PDT.HighHaste = sets.engaged
    sets.engaged.Acc.PDT.HighHaste = sets.engaged

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = sets.engaged
    sets.engaged.Acc.EmbravaHaste = sets.engaged
    sets.engaged.Evasion.EmbravaHaste = sets.engaged
    sets.engaged.Acc.Evasion.EmbravaHaste = sets.engaged
    sets.engaged.PDT.EmbravaHaste = sets.engaged
    sets.engaged.Acc.PDT.EmbravaHaste = sets.engaged

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {ear1="Telos Earring",ear2="Cessance Earring",waist="Windbuffet Belt +1",})
    sets.engaged.Acc.MaxHaste = sets.engaged
    sets.engaged.Evasion.MaxHaste = sets.engaged
    sets.engaged.Acc.Evasion.MaxHaste = sets.engaged
    sets.engaged.PDT.MaxHaste = sets.engaged
    sets.engaged.Acc.PDT.MaxHaste = sets.engaged


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Iga Ningi +2", back="Andartia's Mantle"}
    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(5, 3)
    else
        set_macro_page(1, 3)
    end
end

