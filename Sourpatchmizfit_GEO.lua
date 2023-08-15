-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('packets.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')


    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic+1"}
    sets.precast.JA['Life cycle'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        head="Welkin Crown",neck="Orunmila's Torque",ear1="Locuacious Earring",ear2="Enchanter's Earring +1",
        body="Shango Robe",ring1="Kishar Ring",ring2="Jhakri Ring",
        back="Swith Cape +1",waist="Witful Belt",feet="Merlinic Crackows"}

    sets.precast.FC.Cure = sets.precast.FC

    sets.precast.FC['Elemental Magic'] = sets.precast.FC

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Crepuscular Cloak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Hetairoi Ring",ring2="Karieyh Ring +1",
        back="Nantosuelta's Cape",waist="Fortia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = sets.precast.WS

    sets.precast.WS['Starlight'] = sets.precast.WS

    sets.precast.WS['Moonlight'] = sets.precast.WS


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Geomancy = {main="Idris",range="Dunna",
        head="Azimuth Hood+2",neck="Bagua Charm+1",ear1="",ear2="",
        body="Bagua Tunic+1",hands="Geomancy Mitaines +3",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Lifestream Cape",legs="Bagua Pants+1",feet="Geomancy Sandals +1",
        }
    sets.midcast.Geomancy.Indi = sets.midcast.Geomancy

    sets.midcast.Cure = {}
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {ring1="Sheltered Ring"}

    sets.midcast.Shellra = {ring1="Sheltered Ring"}

    sets.midcast['Elemental Magic'] = {shield="Ammurapi Shield",head=None,neck="Mizukage-no-Kubikazari",ear1="Regal Earring",ear2="Malignance Earring",
    body="Cohort Cape +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Mujin Band",back="Seshaw Cape",waist="Orpheus's Sash",legs="Jhakri Slops +2",feet="Amalric Nails +1",}

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Crepuscular Cloak"})
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}


    -- Idle sets

    sets.idle = {main="Idris",sub="Genmei Shield",range="Dunna",
        head="Befouled Crown",neck="Bathy Choker",ear1="Infused Earring",ear2="Genmei Earring",
        body="Jhakri Robe +2",hands="Nyame Gauntlets",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Kumbira Cape",waist="Luminary Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.idle.PDT = {main="Idris",sub="Ammurapi Shield",range="Dunna",
        head="Nyame Helm",neck="Loricate Torque +1",ear1="Flashward Earring",ear2="Genmei Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Fortified Ring",
        back="Lifestream Cape",waist="Slipor Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {
        main="Idris",
        sub="Genmei Shield",
        range="Dunna",
        head="Azimuth Hood +2",
        neck="Bagua Charm +1",
        ear1="Infused Earring",
        ear2="Handler's Earring +1",
        body="Nyame Mail",
        hands="Geomancy Mitaines +3",
        ring1="Defending Ring",
        ring2="Stikini Ring +1",
        back="Nantosuelta's Cape",
        waist="Slipor Sash",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    }

    sets.idle.PDT.Pet = {main="Idris",sub="Genmei Shield",range="Dunna",
        head="Azimuth Hood +2",neck="Bagua Charm +1",ear1="Infused Earring",ear2="Handler's Earring +1",
        body="Nyame Mail",hands="Geomancy Mitaines +3",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Nantosuelta's Cape",waist="Slipor Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {main="Idris",hands="Geomancy Mitaines +3",legs="Bagua Pants +1"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {main="Idris",hands="Geomancy Mitaines +3",legs="Bagua Pants +1"})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {main="Idris",hands="Geomancy Mitaines +3",legs="Bagua Pants +1"})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {main="Idris",hands="Geomancy Mitaines +3",legs="Bagua Pants +1"})

    sets.idle.Town = sets.idle

    sets.idle.Weak = sets.idle

    -- Defense sets

    sets.defense.PDT = {range="Dunna",
        head="Hagondes Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.defense.MDT = {range="Dunna",
        head="Nahtirah Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {range="Dunna",
        head="Zelus Tiara",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="Paguroidea Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 6)
end

