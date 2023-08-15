-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
	get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	
	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.IdleMode:options('Normal')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
    
    --update_combat_form()

	select_default_macro_book(1, 2)

    send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^[')
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
    --Augmnents
    Brigantia = {}
    Brigantia.TP = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+28 Attack+20','"Double Attack."+10','Damage taken -5%',}}
    Brigantia.WS = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    Despair = {}
    Despair.TP = { name="Despair Helm", augments={'STR+12','VIT+7','Haste+2%'}}

    Carmine = {}
    Carmine.Idle = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6'}}

    Taeon = {}
    Taeon.WS = { name="Taeon Tights", augments={'Weapon Skill Acc.+3'}}

    Valorous = {}
    Valorous.body = { name="Valorous Mail", augments={'Accuracy+9','Attack+18','Mag. Acc.+19','Weapon skill damage +6%'}}
    Valorous.head = { name="Valorous Mask", augments={'INT+10','Mag. Acc.+14','"Mag. Atk. Bns."+14','Critical hit rate +1%','Weapon skill damage +5%',}}
    
    Moonshade = {}
    Moonshade.TP = { name="Moonshade earring", augments={'Accuracy+4','TP Bonus +250'}}

    --sets.CapacityMantle = {back="Aptitude Mantle +1"}

    sets.TreasureHunter = { 
        ammo="Perfect Lucky Egg", 
        waist="Chaac Belt",
        legs="Volte Hose",
     }

    -- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets +3"}
    
    sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +3" }

	sets.precast.JA.Jump = {
        ammo="Coiste Bodhar",
		head="Flamma Zucchetto +2",
        neck="Dragoon's Collar +1",
        ear1="Sherida Earring",
        ear2="Thrud Earring",
        hands="Vishap Finger Gauntlets +2",
        body="Vishap Mail +2",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
		back=Brigantia.TP,
        waist="Ioskeha Belt +1",
        legs="Pteroslaver Brais +1",
        feet="Vishap Greaves +2"
    }

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {}) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {})
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {})
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {
        hands="Peltast's Vambraces", 
        head="Vishap Armet +2",
        feet="Pteroslaver Greaves +1"
    }

	sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +1"}
	
    sets.precast.JA['Spirit Surge'] = {body="Pteroslaver Mail +1"}
	
	-- Healing Breath sets
	sets.midcast.Pet['Restoring Breath'] = {
		head="Vishap Armet +2",
        neck="Dragoon's Collar +1",
        hands="Vishap Finger Gauntlets +2",
        back=Brigantia.TP,
    }

   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        ammo="Knobkierrie",
        head="Nyame Helm", 
        neck="Dragoon's Collar +1",
        ear1="Ishvara Earring",
        ear2="Thrud Earring",
		body="Nyame Mail",
        hands="Pteroslaver Finger Gauntlets +3",
        ring1="Karieyh Ring +1",
        ring2="Regal Ring",
		back=Brigantia.WS,
        waist="Fotia Belt",
        legs="Vishap Brais +3",
        feet="Sulevia's Leggings +2"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        ammo="Crepuscular Pebble",
        head="Flamma Zucchetto +2", 
        neck="Dragoon's Collar +1", 
        body="Nyame Mail",
        ear1="Sherida Earring", 
        ear2="Peltast's Earring +1",
        ring1="Niqmaddu Ring",
        hands="Gleti's Gauntlets", 
        back=Brigantia.TP, 
        legs="Gleti's Greaves", 
        feet="Flamma Gambieras +2",
    })

    sets.precast.WS["Camlann's Torment"] = sets.precast.WS

	sets.precast.WS['Drakesbane'] = sets.precast.WS
    
    sets.precast.WS['Impulse Drive'] = sets.precast.WS

    sets.precast.WS['Geirskogul'] = sets.precast.WS

    sets.precast.WS['Sonic Thrust'] = sets.precast.WS

    sets.precast.WS['Wheeling Thrust'] = sets.precast.WS

    sets.precast.WS['Vorpal Thrust'] = sets.precast.WS

	sets.precast.WS['Penta Thrust'] = sets.precast.WS

    sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS, {head=Valorous.head,neck="Baetyl Pendant",})

    sets.precast.WS['Savage Blade'] = {
        ammo="Crepusclar Pebble",
        head="Nyame Helm", 
        neck="Dragoon's Collar +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
		body="Nyame Mail",
        hands="Pteroslaver Finger Gauntlets +3",
        ring1="Karieyh Ring +1",
        ring2="Ephramad's Ring",
		back=Brigantia.WS,
        waist="Kentarch Belt +1",
        legs="Vishap Brais +3",
        feet="Nyame Sollerets"  
    }


	
	-- Sets to return to when not performing an action.
	
	-- Idle sets
	sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Nyame Helm",
        neck="Loricate Torque +1",
        ear1="Infused Earring",
        ear2="Eabani Earring",
   	    body="Gleti's Cuirass",
        hands="Nyame Gauntlets",
        ring1="Defender Ring",
        ring2="Warp Ring",
		back=Brigantia.TP,
        waist="Flume Belt",
        legs=Carmine.Idle,
        feet="Gleti's Boots"
    }

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {
        sets.idle
    }

	sets.idle.Field = {
        sets.idle
    }

	sets.idle.Weak = {
        sets.idle
    }
	
	-- Defense sets
	

	sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
        grip="Utu Grip",
        ammo="Coiste Bodhar",
		head="Flamma Zucchetto +2",
        neck="Dragoon's Collar +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
		body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        ring1="Niqmaddu Ring",
        ring2="Moonbeam Ring",
		back=Brigantia.TP,
        waist="Ioskeha Belt +1",
        legs="Sulevia's cuisses +2",
        feet="Flamma Gambieras +2"
    }

    sets.engaged.DT = {
        grip="Utu Grip",
        ammo="Coiste Bodhar",
        head="Nyame Helm",
        neck="Dragoon Collar +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
   	    body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Niqmaddu Ring",
        ring2="Petrov Ring",
        back=Brigantia.TP,
        waist="Ioskeha Belt +1",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    }

    sets.precast.RA = { ammo='Aureole' }


end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

function job_pet_precast(spell, action, spellMap, eventArgs)

end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.HybridMode.value == 'PDT' then
        meleeSet = sets.engaged.DT
    end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        equip(sets.engaged)
    else
        equip(sets.idle)
    end
end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
end

function job_update(cmdParams, eventArgs)
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
    
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		--category == 4 or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 2)
        send_command('@wait 5;input /lockstyleset 1')
    elseif player.sub_job == 'SAM' then
    	set_macro_page(1, 2)
        send_command('@wait 5;input /lockstyleset 1')
    else
    	set_macro_page(1, 2)
        send_command('@wait 5;input /lockstyleset 1')
    end
end
