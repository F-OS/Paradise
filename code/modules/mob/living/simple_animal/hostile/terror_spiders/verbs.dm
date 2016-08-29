
/mob/living/simple_animal/hostile/poison/terror_spider/verb/ShowGuide()
	set name = "Show Guide"
	set category = "Spider"
	set desc = "Learn how to spider."
	var/list/guidelist = list()
	guidelist += "------------------------"
	guidelist += "Intro:"
	guidelist += "- Terror Spiders are a bioweapon, created when the Syndicate mixed Giant Spider and Xenomorph DNA."
	guidelist += "- Ruled by Queens, they are aggressive, and very good in melee combat."
	guidelist += " "
	guidelist += "Communications:"
	guidelist += "<B>- You speak over the Terror Spider hivemind by default. All other TS hear this. To speak common, use :9 or .9 </B>"
	guidelist += "- Terror Spiders are the nuke ops of spiders. They work as a team. Communicate regularly!"
	guidelist += " "
	guidelist += "Verbs:"
	guidelist += " - Show Guide - Shows this guide."
	guidelist += " - Web - Spins a terror web. Non-spiders get trapped if they touch a web."
	guidelist += " - Wrap - Wraps a nearby corpse or other object. Webbing a human boosts your health regeneration."
	guidelist += "------------------------"
	guidelist += " "
	to_chat(src, guidelist.Join("<BR>"))


// ---------- WEB

/mob/living/simple_animal/hostile/poison/terror_spider/verb/Web()
	set name = "Lay Web"
	set category = "Spider"
	set desc = "Spin a sticky web to slow down prey."
	visible_message("<span class='notice'>\the [src] begins to secrete a sticky substance.</span>")
	if(do_after(src, 40, target = loc))
		new /obj/effect/spider/terrorweb(loc)


/obj/effect/spider/terrorweb
	name = "terror web"
	desc = "it's stringy and sticky"
	icon = 'icons/effects/effects.dmi'
	anchored = 1 // prevents people dragging it
	density = 0 // prevents it blocking all movement
	health = 20 // two welders, or one laser shot (15 for the normal spider webs)
	icon_state = "stickyweb1"


/obj/effect/spider/terrorweb/New()
	if(prob(50))
		icon_state = "stickyweb2"

/obj/effect/spider/terrorweb/proc/DeCloakNearby()
	for(var/mob/living/simple_animal/hostile/poison/terror_spider/gray/G in view(6,src))
		if(G.stat != DEAD)
			G.GrayDeCloak()
			G.Aggro()

/obj/effect/spider/terrorweb/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1
	if(istype(mover, /mob/living/simple_animal/hostile/poison/terror_spider))
		return 1
	if(istype(mover, /obj/item/projectile/terrorqueenspit))
		return 1
	if(istype(mover, /obj/item/projectile/terrorempressspit))
		return 1
	if(istype(mover, /mob/living))
		if(prob(80))
			to_chat(mover, "<span class='danger'>You get stuck in \the [src] for a moment.</span>")
			var/mob/living/M = mover
			M.Stun(5) // 5 seconds.
			M.Weaken(5) // 5 seconds.
			DeCloakNearby()
			return 1
		else
			return 0
	if(istype(mover, /obj/item/projectile))
		return prob(20)
	return ..()



// ---------- WRAP


/mob/living/simple_animal/hostile/poison/terror_spider/verb/Wrap()
	set name = "Wrap"
	set category = "Spider"
	set desc = "Wrap up corpses (and possibly other ajacent objects)"
	DoWrap()

/mob/living/simple_animal/hostile/poison/terror_spider/proc/DoWrap()
	if(!cocoon_target)
		var/list/choices = list()
		for(var/mob/living/L in oview(1,src))
			if(Adjacent(L))
				if(L.stat == DEAD)
					choices += L
		for(var/obj/O in loc)
			if(Adjacent(O) && !O.anchored)
				if(!istype(O, /obj/effect/spider/terrorweb) && !istype(O, /obj/effect/spider/cocoon))
					choices += O
		if(ckey)
			if(choices.len)
				cocoon_target = input(src,"What do you wish to cocoon?") in null|choices
			else
				to_chat(src, "<span class='danger'>There is nothing nearby you can wrap.</span>")
	if(cocoon_target && busy != SPINNING_COCOON)
		busy = SPINNING_COCOON
		visible_message("<span class='notice'>\the [src] begins to secrete a sticky substance around \the [cocoon_target].</span>")
		stop_automated_movement = 1
		walk(src,0)
		if(do_after(src, 40, target = cocoon_target.loc))
			if(busy == SPINNING_COCOON)
				if(cocoon_target && istype(cocoon_target.loc, /turf) && get_dist(src,cocoon_target) <= 1)
					var/obj/effect/spider/cocoon/C = new(cocoon_target.loc)
					var/large_cocoon = 0
					C.pixel_x = cocoon_target.pixel_x
					C.pixel_y = cocoon_target.pixel_y
					for(var/obj/item/I in C.loc)
						I.loc = C
					for(var/obj/structure/S in C.loc)
						if(!S.anchored)
							S.loc = C
							large_cocoon = 1
					for(var/obj/machinery/M in C.loc)
						if(!M.anchored)
							M.loc = C
							large_cocoon = 1
					for(var/mob/living/L in C.loc)
						if(istype(L, /mob/living/simple_animal/hostile/poison/terror_spider))
							continue
						if(iscarbon(L))
							regen_points += regen_points_per_kill
							fed++
						large_cocoon = 1
						last_cocoon_object = 0
						L.loc = C
						C.pixel_x = L.pixel_x
						C.pixel_y = L.pixel_y
						visible_message("<span class='danger'>\the [src] sticks a proboscis into \the [L] and sucks a viscous substance out.</span>")
						break
					if(large_cocoon)
						C.icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
		cocoon_target = null
		busy = 0
		stop_automated_movement = 0

