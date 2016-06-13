
// --------------------------------------------------------------------------------
// ----------------- TERROR SPIDERS: EGGS (USED BY NURSE AND QUEEN TYPES) ---------
// --------------------------------------------------------------------------------

/mob/living/simple_animal/hostile/poison/terror_spider/proc/DoLayTerrorEggs(var/lay_type, var/lay_number, var/lay_crawl)
	stop_automated_movement = 1
	var/obj/effect/spider/eggcluster/terror_eggcluster/C = new /obj/effect/spider/eggcluster/terror_eggcluster(get_turf(src))
	C.spiderling_type = lay_type
	C.spiderling_number = lay_number
	C.spiderling_ventcrawl = lay_crawl
	C.faction = faction
	C.spider_myqueen = spider_myqueen
	C.master_commander = master_commander
	C.ai_playercontrol_allowingeneral = ai_playercontrol_allowingeneral
	C.enemies = enemies
	//In future, might use something like: C.name = initial(lay_type.egg_name)
	//However, right now, that doesn't work.
	if (spider_growinstantly)
		C.amount_grown = 250
		C.spider_growinstantly = 1
	spawn(10)
		stop_automated_movement = 0
	if (spider_queen_declared_war)
		C.spider_queen_declared_war = 1


/obj/effect/spider/eggcluster/terror_eggcluster
	name = "terror egg cluster"
	desc = "A cluster of tiny spider eggs. They pulse with a strong inner life, and appear to have sharp thorns on the sides."
	icon_state = "eggs"
	var/spider_growinstantly = 0
	var/spider_queen_declared_war = 0 // set to 1 by procs
	faction = list("terrorspiders")
	var/spider_myqueen = null
	var/spiderling_type = null
	var/spiderling_number = 1
	var/spiderling_ventcrawl = 1
	var/ai_playercontrol_allowingeneral = 1
	var/list/enemies = list()


/obj/effect/spider/eggcluster/terror_eggcluster/New()
	..()
	ts_egg_list += src
	spawn(50)
		if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/red)
			name = "red terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/gray)
			name = "gray terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/green)
			name = "green terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/black)
			name = "black terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/purple)
			name = "purple terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/white)
			name = "white terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/mother)
			name = "mother of terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/prince)
			name = "prince of terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/queen)
			name = "queen of terror eggs"
		else if (spiderling_type == /mob/living/simple_animal/hostile/poison/terror_spider/empress)
			name = "empress of terror eggs"


/obj/effect/spider/eggcluster/terror_eggcluster/Destroy()
	ts_egg_list -= src
	..()

/obj/effect/spider/eggcluster/terror_eggcluster/process()
	amount_grown += rand(0,2)
	if (amount_grown >= 100)
		var/num = spiderling_number
		for(var/i=0, i<num, i++)
			var/obj/effect/spider/spiderling/terror_spiderling/S = new /obj/effect/spider/spiderling/terror_spiderling(get_turf(src))
			if (spiderling_type)
				S.grow_as = spiderling_type
			S.use_vents = spiderling_ventcrawl
			S.faction = faction
			S.spider_myqueen = spider_myqueen
			S.master_commander = master_commander
			S.ai_playercontrol_allowingeneral = ai_playercontrol_allowingeneral
			S.enemies = enemies
			if (spider_queen_declared_war)
				S.spider_queen_declared_war = 1
			if (spider_growinstantly)
				S.amount_grown = 250
		var/rnum = 5 - spiderling_number
		for(var/i=0, i<rnum, i++)
			var/obj/effect/spider/spiderling/terror_spiderling/S = new /obj/effect/spider/spiderling/terror_spiderling(get_turf(src))
			S.stillborn = 1
			// the idea is that every set of eggs always spawn 5 spiderlings, but most are not going to grow up, just some do.
		qdel(src)


/obj/effect/spider/spiderling/terror_spiderling
	name = "spiderling"
	desc = "A fast-moving tiny spider, prone to making aggressive hissing sounds. Hope it doesn't grow up."
	icon_state = "spiderling"
	anchored = 0
	layer = 2.75
	health = 3
	var/spider_queen_declared_war = 0 // set to 1 by inheritance
	var/stillborn = 0
	faction = list("terrorspiders")
	var/spider_myqueen = null
	var/use_vents = 1
	var/ai_playercontrol_allowingeneral = 1
	var/list/enemies = list()


/obj/effect/spider/spiderling/terror_spiderling/New()
	..()
	spawn(50)
		var/debug_announce = 0
		if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/red)
			name = "red spiderling"
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/gray)
			name = "gray spiderling"
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/green)
			name = "green spiderling"
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/black)
			name = "black spiderling"
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/purple)
			name = "purple spiderling"
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/white)
			name = "white spiderling"
			debug_announce = 1
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/mother)
			name = "mother spiderling"
			debug_announce = 1
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/prince)
			name = "prince spiderling"
			debug_announce = 1
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/queen)
			name = "queen spiderling"
			debug_announce = 1
		else if (grow_as == /mob/living/simple_animal/hostile/poison/terror_spider/empress)
			name = "empress spiderling"
			debug_announce = 1
		ts_spiderling_list += src
		if (debug_announce)
			log_debug("[src] spawned in [get_area(src)]")


/obj/effect/spider/spiderling/terror_spiderling/Destroy()
	ts_spiderling_list -= src
	..()

/obj/effect/spider/spiderling/terror_spiderling/Bump(atom/user)
	if (istype(user, /obj/structure/table))
		loc = user.loc
	else if (istype(user, /obj/machinery/recharge_station))
		qdel(src)
	else
		..()


/obj/effect/spider/spiderling/terror_spiderling/process()
	if (travelling_in_vent)
		if (isturf(loc))
			travelling_in_vent = 0
			entry_vent = null
	else if (entry_vent)
		if (get_dist(src, entry_vent) <= 1)
			var/list/vents = list()
			for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in entry_vent.parent.other_atmosmch)
				vents.Add(temp_vent)
			if (!vents.len)
				entry_vent = null
				return
			var/obj/machinery/atmospherics/unary/vent_pump/exit_vent = pick(vents)
			if (prob(50))
				visible_message("<B>[src] scrambles into the ventillation ducts!</B>", \
								"<span class='notice'>You hear something squeezing through the ventilation ducts.</span>")
			var/original_location = loc
			spawn(rand(20,60))
				loc = exit_vent
				var/travel_time = round(get_dist(loc, exit_vent.loc) / 2)
				spawn(travel_time)
					if (!exit_vent || exit_vent.welded)
						loc = original_location
						entry_vent = null
						return
					if (prob(50))
						audible_message("<span class='notice'>You hear something squeezing through the ventilation ducts.</span>")
					spawn(travel_time)
						if (!exit_vent || exit_vent.welded)
							loc = original_location
							entry_vent = null
							return
						loc = exit_vent.loc
						entry_vent = null
						var/area/new_area = get_area(loc)
						if (new_area)
							new_area.Entered(src)
	//=================
	else if (prob(33))
		var/list/nearby = oview(10, src)
		if (nearby.len)
			var/target_atom = pick(nearby)
			walk_to(src, target_atom)
	else if (prob(10) && use_vents)
		//ventcrawl!
		for(var/obj/machinery/atmospherics/unary/vent_pump/v in view(7,src))
			if (!v.welded)
				entry_vent = v
				walk_to(src, entry_vent, 1)
				break
	if (isturf(loc))
		amount_grown += rand(0,2)
		if (amount_grown >= 100)
			if (stillborn)
				die()
			else
				if (!grow_as)
					grow_as = pick(/mob/living/simple_animal/hostile/poison/terror_spider/red,/mob/living/simple_animal/hostile/poison/terror_spider/gray,/mob/living/simple_animal/hostile/poison/terror_spider/green)
				var/mob/living/simple_animal/hostile/poison/terror_spider/S = new grow_as(loc)
				S.faction = faction
				S.spider_myqueen = spider_myqueen
				S.master_commander = master_commander
				S.ai_playercontrol_allowingeneral = ai_playercontrol_allowingeneral
				S.enemies = enemies
				if (spider_queen_declared_war)
					S.spider_queen_declared_war = 1
					if (!istype(S, /mob/living/simple_animal/hostile/poison/terror_spider/purple))
						S.idle_ventcrawl_chance = 15
				qdel(src)

// --------------------------------------------------------------------------------
// ----------------- TERROR SPIDERS: PROJECTILES ----------------------------------
// --------------------------------------------------------------------------------


/obj/item/projectile/terrorqueenspit
	name = "poisonous spit"
	damage = 0
	icon_state = "toxin"
	damage_type = TOX


/obj/item/projectile/terrorqueenspit/on_hit(var/mob/living/carbon/target)
	if (istype(target, /mob))
		var/mob/living/L = target
		if (L.reagents)
			if (L.can_inject(null,0,"chest",0))
				L.reagents.add_reagent("terror_queen_toxin",15)
		if (!istype(L, /mob/living/simple_animal/hostile/poison/terror_spider))
			L.adjustToxLoss(40) // Terror Spiders are immune to their queen's spit.


/obj/item/projectile/terrorempressspit
	name = "poisonous spit"
	damage = 0
	icon_state = "toxin"
	damage_type = TOX


/obj/item/projectile/terrorempressspit/on_hit(var/mob/living/carbon/target)
	if (istype(target, /mob))
		var/mob/living/L = target
		if (L.reagents)
			L.reagents.add_reagent("ketamine",30)
		if (!istype(L, /mob/living/simple_animal/hostile/poison/terror_spider))
			L.adjustToxLoss(60) // Terror Spiders are immune to their queen's spit.

/obj/effect/spider/terrorweb
	name = "terror web"
	desc = "it's stringy and sticky"
	icon = 'icons/effects/effects.dmi'
	anchored = 1 // prevents people dragging it
	density = 0 // prevents it blocking all movement
	health = 20 // two welders, or one laser shot (15 for the normal spider webs)
	icon_state = "stickyweb1"


/obj/effect/spider/terrorweb/New()
	if (prob(50))
		icon_state = "stickyweb2"

/obj/effect/spider/terrorweb/proc/DeCloakNearby()
	for(var/mob/living/simple_animal/hostile/poison/terror_spider/gray/G in view(6,src))
		if (G.stat != DEAD)
			G.GrayDeCloak()
			G.Aggro()

/obj/effect/spider/terrorweb/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (air_group || (height==0)) return 1
	if (istype(mover, /mob/living/simple_animal/hostile/poison/terror_spider))
		return 1
	if (istype(mover, /obj/item/projectile/terrorqueenspit))
		return 1
	if (istype(mover, /obj/item/projectile/terrorempressspit))
		return 1
	if (istype(mover, /mob/living))
		if (prob(80))
			to_chat(mover, "<span class='danger'>You get stuck in \the [src] for a moment.</span>")
			var/mob/living/M = mover
			M.Stun(5) // 5 seconds.
			M.Weaken(5) // 5 seconds.
			M.emote("scream")
			DeCloakNearby()
			return 1
		else
			return 0
	if (istype(mover, /obj/item/projectile))
		return prob(20)
	return ..()


// --------------------------------------------------------------------------------
// ----------------- TERROR SPIDERS: LOOT DROPS -----------------------------------
// --------------------------------------------------------------------------------


/obj/item/clothing/suit/armor/terrorspider_carapace
	name = "spider carapace armor"
	desc = "A carved section of terror spider carapace that can be used as crude body armor."
	icon_state = "armor-combat"
	item_state = "bulletproof"
	//DEFAULT VALUES: armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 0, rad = 0)
	armor = list(melee = 50, bullet = 30, laser = 25, energy = 10, bomb = 25, bio = 0, rad = 0)
	// our armor half as effective against lasers, but 2x as effective against bullets. Makes sense - terror spiders had to fight syndicate first, only recently encountered NT


// venom glands.

/obj/item/weapon/reagent_containers/terrorspider_parts
	icon = 'icons/mob/terrorspider.dmi'
	desc = "A body part from a terror spider."

/obj/item/weapon/reagent_containers/terrorspider_parts/toxgland_green
	name = "green terror spider venom gland"
	icon_state = "ts_venomgland"
	origin_tech = "biotech=5;materials=2;combat=4"

/obj/item/weapon/reagent_containers/terrorspider_parts/toxgland_green/New()
	reagents.add_reagent("terror_green_toxin", 15)

/obj/item/weapon/reagent_containers/terrorspider_parts/toxgland_black
	name = "black terror spider venom gland"
	icon_state = "ts_venomgland"
	origin_tech = "biotech=5;materials=2;combat=5"

/obj/item/weapon/reagent_containers/terrorspider_parts/toxgland_black/New()
	reagents.add_reagent("terror_black_toxin", 15)

/obj/item/weapon/reagent_containers/terrorspider_parts/toxgland_white
	name = "white terror spider venom gland"
	icon_state = "ts_venomgland"
	origin_tech = "biotech=6;materials=2;combat=5"

/obj/item/weapon/reagent_containers/terrorspider_parts/toxgland_white/New()
	reagents.add_reagent("terror_white_toxin", 15)


// --------------------------------------------------------------------------------
// ----------------- TERROR SPIDERS: UPLINK ITEMS ---------------------------------
// --------------------------------------------------------------------------------


/obj/machinery/power/singularity_beacon/terrorspider_beacon
	name = "psionic beacon"
	desc = "A strange beacon."
	var/ondesc = "This strange beacon pulses with an evil-looking red light."
	var/countdown = 120
	var/summoned_spiders = 0
	icontype = "beaconsynd"
	icon_state = "beaconsynd0"

/obj/machinery/power/singularity_beacon/terrorspider_beacon/attack_hand(var/mob/user as mob)
	if(anchored)
		if (active)
			to_chat(user, "<span class='warning'>[src] is already active, and there is no off button!</span>")
		else
			Activate(user)
	else
		to_chat(user, "<span class='warning'>You need to screw the beacon to the floor first!</span>")
	return

/obj/machinery/power/singularity_beacon/terrorspider_beacon/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	if(istype(W,/obj/item/weapon/screwdriver))
		if(active)
			to_chat(user, "<span class='warning'>The screwdriver does nothing!</span>")
			return
		if(anchored)
			anchored = 0
			to_chat(user, "<span class='notice'>You unscrew the beacon from the floor.</span>")
			disconnect_from_network()
			return
		else
			if(!connect_to_network())
				to_chat(user, "This device must be placed over an exposed cable.")
				return
			anchored = 1
			to_chat(user, "<span class='notice'>You screw the beacon to the floor and attach the cable.</span>")
			return
	..()
	return

/obj/machinery/power/singularity_beacon/terrorspider_beacon/Activate(mob/user = null)
	if (countdown == 0)
		to_chat(user, "This beacon has already been used up.")
		return
	if(surplus() < 1500)
		if(user)
			to_chat(user, "<span class='notice'>The connected wire doesn't have enough current.</span>")
		return
	icon_state = "[icontype]1"
	active = 1
	machines |= src
	if(user)
		to_chat(user, "<span class='notice'>You activate the beacon.</span>")

/obj/machinery/power/singularity_beacon/terrorspider_beacon/Deactivate(mob/user = null)
	icon_state = "[icontype]0"
	active = 0
	if(user)
		to_chat(user, "<span class='notice'>You deactivate the beacon.</span>")

/obj/machinery/power/singularity_beacon/terrorspider_beacon/process()
	if(!active)
		return PROCESS_KILL
	else
		if (countdown == 0)
			spawn_spiders()
			visible_message("<span class='danger'>\the [src] activates!</span>")
			explosion(get_turf(src),0,1,5,0)
			qdel(src)
		else if(surplus() > 1500)
			draw_power(1500)
			countdown--
			desc = ondesc + "<BR> A small digital display reads: <span class='danger'> [countdown] </span>"
		else
			Deactivate()

/obj/machinery/power/singularity_beacon/terrorspider_beacon/proc/spawn_spiders()
	var/spawncount = 1
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in all_vent_pumps)
		if((temp_vent.loc.z in config.station_levels) && !temp_vent.welded)
			if(temp_vent.parent.other_atmosmch.len > 50)
				vents += temp_vent
	while((spawncount >= 1) && vents.len)
		var/obj/vent = pick(vents)
		var/obj/effect/spider/spiderling/S = new(vent.loc)
		S.name = "evil-looking spiderling"
		S.grow_as = pick(/mob/living/simple_animal/hostile/poison/terror_spider/white,/mob/living/simple_animal/hostile/poison/terror_spider/mother,/mob/living/simple_animal/hostile/poison/terror_spider/prince,/mob/living/simple_animal/hostile/poison/terror_spider/queen)
		S.amount_grown = 50 // double-speed growth
		notify_ghosts("[src] has detonated in [get_area(src)], drawing a terror spiderling to [get_area(S)]")
		vents -= vent
		spawncount--
