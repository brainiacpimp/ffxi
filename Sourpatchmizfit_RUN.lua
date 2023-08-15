-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'DD', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Regen', 'Refresh', 'Turtle')

	select_default_macro_book()
end


function init_gear_sets()
    sets.enmity = {
        ammo="Sapience Orb", --2
        ear1="Friomisi Earring", --2 
        hands="Futhark Mitons", --3
        ring2="Supershear Ring", --5
        feet="Erilaz Greaves +2", --6 
    }
    --SIRD +10 Merits Caps @ 103
    sets.SIRD = {
        ammo="Staunch Tathlum +1", --11
        head="Erilaz Galea +2", --15
        ear1="Friomisi Earring",
        neck="Moonlight Necklace", --15
        body="Taeon Tabard", --7
        hands="Regal Gauntlets", --10
        ring1="Evanescence Ring", --5
        ring2="Supershear Ring",
        waist="Audumbla Sash", --10
        legs="Carmine Cuisses +1", --20
        feet="Erilaz Greaves +2",

    } --103

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {
        head="Thaumas Hat", 
        neck="Eddy Necklace", 
        ear1="Novio Earring", 
        ear2="Friomisi Earring",
        body="Vanir Cotehardie", 
        ring1="Acumen Ring", 
        ring2="Omega Ring",
        back="Evasionist's Cape", 
        waist="Yamabuki-no-obi", 
        legs="Iuitl Tights +1", 
        feet="Qaaxo Leggings"
    }
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {back="Evasionist Cape"}
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +2",}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    --Caps @ 70
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Carmine Mask +1", --14
        neck="Baetyl Pendent", --4
        ear1="Loquacious Earring",
        ear2="Enchanter's Earring +1", --2
        body="Erilaz Surcoat +2", --10
        hands="Leyline Gloves", --5
        ring1="Kishar Ring", --4
        ring2="Rahab Ring", --2
        --waist="Al Zahbi Sash",
        legs="Ayanmo Cosciales +1",
        feet="Carmine Greaves +1" --8
    }  --@55

    sets.precast.FC['Enhancing Magic'] = {
        ammo="Sapience Orb", --2
        head="Carmine Mask +1", --14
        neck="Baetyl Pendent", --4
        ear1="Loquacious Earring",
        ear2="Enchanter's Earring +1",
        body="Erilaz Surcoat +2", --7
        hands="Leyline Gloves", --5
        ring1="Kishar Ring", --4
        ring2="Rahab Ring", --2
        waist="Siegel Sash",
        legs="Doyen Pants",
        feet="Carmine Greaves +1"
    }
    


	-- Weaponskill sets
    sets.precast.WS = {
        sub="Utu Grip",
        ammo="Knobkerrie",
        head="Adhemar Bonnet +1", 
        neck="Fotia Gorget", 
        ear1="Moonshade Earring", 
        ear2="Thrud Earring",
        body="Nyame Mail", 
        hands="Nyame Gauntlets", 
        ring1="Niqmaddu Ring", 
        ring2="Regal Ring",
        back="Phalangite Mantle", 
        waist="Fotia Belt", 
        legs="Nyame Flanchard", 
        feet="Ayanmo Gamberas +1",
    }

    sets.precast.WS['Resolution'] = {
        sub="Utu Grip",
        ammo="Seething Bomblet +1",
        head="Blistering Sallet +1", 
        neck="Fotia Gorget", 
        ear1="Moonshade Earring", 
        ear2="Sherida Earring",
        body="Herculean Vest", 
        hands="Herculean Gloves", 
        ring1="Niqmaddu Ring", 
        ring2="Epona's Ring",
        back="Phalangite Mantle", 
        waist="Fotia Belt", 
        legs="Samnuha Tights", 
        feet="Herculean Boots",
    }
    
    sets.precast.WS['Dimidiation'] = {
        sub="Utu Grip",
        ammo="Knobkierrie",
        head="Herculean Helm", 
        neck="Fotia Gorget", 
        ear1="Moonshade Earring", 
        ear2="Sherida Earring",
        body="Nyame Mail", 
        hands="Nyame Gauntlets", 
        ring1="Niqmaddu Ring", 
        ring2="Karieyh Ring +1",
        back="Kayapa Cape", 
        waist="Fotia Belt", 
        legs="Nyame Flanchard", 
        feet="Thereoid Greaves",
    }
    
    --sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
    --sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {
        head="Carmine Mask +1", --11
        neck="Melic torque", --10
        ear1="Andoaa Earring", --5
        hands="Runeist Mitons +1",
        back="Evasionist's Cape",
        waist="Siegel Sash",
        legs="Carmine Cuisses +1"
    }

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {head="Runeist Bandeau +1",neck="Sacro Gorget",ear1="Erilaz Earring",legs="Futhark Trousers +1"})
    sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'],{waist="Siegel Sash"} )
    sets.midcast.Cure = set_combine(sets.SIRD,{neck="Sacro Gorget", hands="Rawhide Gloves",})
    sets.midcast.Flash = sets.SIRD
    sets.midcast['Blue Magic'] = sets.SIRD

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {sub="Refined Grip +1", ammo='Staunch Tathlum +1',
            head="Nyame Helm", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Odnowa Earring +1",
            body="Erilaz Surcoat +2", hands="Turms Mittens +1", ring1="Moonbeam Ring", ring2="Moonbeam ring",
            back="Reiki Cloak", waist="Flume Belt", legs="Carmine Cuisses +1", feet="Turms Leggings +1"}

    sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1", waist="Fucho-no-obi"})

    sets.idle.Turtle = {sub="Refined Grip +1", ammo='Staunch Tathlum +1',
    head="Nyame Helm", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Odnowa Earring +1",
    body="Erilaz Surcoat +2", hands="Nyame Gauntlets", ring1="Moonbeam Ring", ring2="Defending ring",
    back="Reiki Cloak", waist="Flume Belt", legs="Nyame Flanchard", feet="Nyame Sollerets"}
           
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {legs="Carmine Cuisses +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {sub="Utu Grip", ammo="Coiste Bodhar",
            head="Adhemar Bonnet +1", neck="Anu Torque", ear1="Sherida Earring", ear2="Cessance Earring",
            body="Erilaz Surcoat +2", hands="Turms Mittens +1", ring1="Moonbeam Ring", ring2="Moonbeam Ring",
            back="Evasionist's Cape", waist="Sailfi Belt +1", legs="Erilaz Leg Guards +2", feet="Turms Leggings +1"}
    sets.engaged.DD = set_combine(sets.engaged, {body="Ashera Harness",})
    sets.engaged.PDT = {sub="Refined Grip +1",ammo="Staunch Tathlum +1",
            head="Nyame Helm", neck="Loricate Torque +1", ear1="Genmei Earring", ear2="Odnowa earring +1",
            body="Erilaz Surcoat +2", hands="Turms Mittens +1", ring1="Moonbeam Ring", ring2="Moonbeam Ring",
            back="Evasionist's Cape", waist="Flume Belt", legs="Erilaz Leg Guards +2", feet="Turms Leggings +1"}
    sets.engaged.MDT = {
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Sanare Earring",
            body="Runeist Coat +1", hands="Umuthi Gloves", ring1="Dark Ring", ring2="Dark Ring",
            back="Mubvumbamiri mantle", waist="Flume Belt", legs="Runeist Trousers +1", feet="Iuitl Gaiters +1"}
    sets.engaged.repulse = {back="Repulse Mantle"}

end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end


function job_aftercast(spell)
    if not spell.interrupted then
        if spell.type == 'Rune' then
            update_timers(spell)
        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
            reset_timers()
        elseif spell.name == "Swipe" then
            send_command(trim(1))
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book	
	set_macro_page(1, 13)
    send_command('@wait 5;input /lockstyleset 9')
	
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
    local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
        local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)





