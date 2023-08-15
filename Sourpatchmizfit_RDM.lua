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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
    send_command('@wait 5;input /lockstyleset 13')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    Sucellos = {}
    Sucellos.TP = { name="Sucellos's Cape", augments={'DEX+20', 'Accuracy+30 Attack+20', '"Duel Wield"+10',}}
    Sucellos.WS = { name="Sucellos's Cape", augments={'STR+21', 'Accuracy+20 Attack+20', 'Weapon skill damage+10%',}}
    Sucellos.Magic = { name="Sucellos's Cape", augments={'MND+21', 'Mag. Acc.+20 Mag. Dmg.+20', '"Mag. Atk. Bns."+10',}}

    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard +3"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +1",
        body="Atrophy Tabard +3",
        }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Impatiens",
        head="Atrophy Chapeau +1",neck="Baetyl Pendant",ear1="Enchanter's Earring +1",ear2="Loquacious Earring",
        body="Shango Robe",hands="Leyline Gloves",ring1="Prolix Ring", ring2="Kishar Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Ayanmo Cosciales +1",feet="Carmine Greaves +1"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Crepuscular Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Crepuscular Pebble",
        head="Nyame Helm",neck="Republican Platinum Medal",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Ilabrat Ring",ring2="Karieyh Ring +1",
        back=Sucellos.WS,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = sets.precast.WS 

    sets.precast.WS['Savage Blade'] = {ammo="Crepuscular Pebble",
        head="Nyame Helm",neck="Republican Platinum Medal",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Ilabrat Ring",ring2="Karieyh Ring +1",
        back=Sucellos.WS,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.precast.WS['Sanguine Blade'] = {ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Karieyh Ring +1",
        back=Sucellos.Magic,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Amalric Nails +1"}

    sets.precast.WS['Seraph Blade'] = {ammo="Ghastly Tathlum +1",
        head="Nyame Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Regal Earring",
        body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Acumen Ring",ring2="Karieyh Ring +1",
        back=Sucellos.Magic,waist="Orpheus's Sash",legs="Lethargy Fuseau +2",feet="Amalric Nails +1"}

    sets.precast.WS['Chant du Cygne'] = {ammo="Yetshila +1",
        head="Blistering Sallet +1",neck="Fotia Gorget",ear1="Sherida's Earring",ear2="Mache Earring +1",
        body="Ayanmo Corazza +2",hands="Atrophy Gloves +3",ring1="Ilabrat Ring",ring2="Begrudging Ring",
        back=Sucellos.WS,waist="Fotia Belt",legs="Zoar Subligar +1",feet="Thereoid Greaves"}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Atrophy Chapeau +1",ear2="Loquacious Earring",
        body="Vitivation Tabard +3",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt"}

    sets.midcast.Cure = {ammo="Staunch Tathlum +1",
        neck="Loricate Torque +1",
        body="Vrikodara Jupon",ring1="Naji's Loop",ring2="Stikini Ring +1",
        back="Ghostfyre Cape",waist="Witful Belt",legs="Atrophy Tights +1",feet="Skaoi Boots"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        head="Befouled Crown",neck="Melic Torque",ear1="Andoaa Earring",
        body="Viti. Tabard +3",hands="Atrophy Gloves +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=Sucellos.Magic,waist="Siegel Sash",legs="Carmine Cuisses +1",feet="Leth. Houseaux +2"}

    sets.midcast.Refresh = {body="Atrophy Tabard +3",legs="Leth. Fuseau +1",feet="Inspirited Boots"}

    sets.midcast.Stoneskin = {head="Umuthi Hat",hands="Atrophy Gloves +3",back=Sucellos.Magic,waist="Siegel Sash",legs="Doyen Pants",}
    
    sets.midcast['Enfeebling Magic'] = {ammo="Regal Gem",
        head="Viti. Chapeau +3",neck="Duelist's Torque +1",ear1="Snotra Earring",ear2="Malignance Earring",
        body="Atrophy Tabard +3",hands="Kaykaus Cuffs +1",ring1="Stikini Ring +1",ring2="Kishar Ring",
        back=Sucellos.Magic,waist="Obstinate Sash",legs="Chironic Hose",feet="Viti. Boots +3"}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +3"})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +3"})
    
    sets.midcast['Elemental Magic'] = {ammo="Ghastly Tathlum +1",
        head=empty,neck="Sibyl Scarf",ear1="Friomisi Earring",ear2="Malignance Earring",
        body="Cohort Cloak +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back=Sucellos.Magic,waist="Orpheus's Sash",legs="Jhakri Slops +2",feet="Amalric Nails +1"}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Crepuscular Cloak"})

    sets.midcast['Dark Magic'] = {
        head="Pixie Hairpin +1",body="Lethargy Sayon +2",neck="Erra Pendant",ring1="Archon Ring",ring2="Kishar Ring",
        }

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {body="Viti. Tabard +3",hands="Atrophy Gloves +3",neck="Duelist's Torque +1",back=Sucellos.Magic,feet="Lethargy Houseaux +2"}
        
    sets.buff.ComposureOther = {head="Lethargy Chappel +2",
        body="Lethargy Sayon +2",hands="Atrophy Gloves +3",
        legs="Lethargy Fuseau +1",feet="Lethargy Houseaux +2"}

    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",
        head="Vitivation Chapeau +3",neck="Wiglen Gorget",
        body="Atrophy Tabard +3",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head="Vitiation Chapeau +3",neck="Elite Royal Collar",ear1="Genmei Earring",ear2="Infused Earring",
        body="Atrophy Tabard +3",hands="Malignance Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Reiki Cloak",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}

    sets.idle.Town = sets.idle
    
    sets.idle.Weak = sets.idle

    sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Bliaut +1",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}

    sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
        head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Gendewitha Caubeen +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}
    
    
    -- Defense sets
    sets.defense.PDT = {
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Atrophy Tabard +2",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    sets.engaged = {ammo="Coiste Bodhar",
        head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Hollow Earring",ear2="Suppanomimi",
        body="Malignance Tabard",hands="Ayanmo Manopolas +2",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back="Ghostfyre Cape",waist="Orpheus's Sash",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.Defense = {ammo="Demonry Stone",
        head="Atrophy Chapeau +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Atrophy Tabard +2",hands="Atrophy Gloves +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Kayapa Cape",waist="Goading Belt",legs="Osmium Cuisses",feet="Atrophy Boots +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end

