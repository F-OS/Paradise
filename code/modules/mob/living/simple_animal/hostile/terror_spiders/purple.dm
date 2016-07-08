
// --------------------------------------------------------------------------------
// ----------------- TERROR SPIDERS: T2 PURPLE TERROR -----------------------------
// --------------------------------------------------------------------------------
// -------------: ROLE: guarding queen nests
// -------------: AI: returns to queen if too far from her.
// -------------: SPECIAL: chance to stun on hit
// -------------: TO FIGHT IT: shoot it from range, bring friends!
// -------------: CONCEPT:http://tvtropes.org/pmwiki/pmwiki.php/Main/PraetorianGuard
// -------------: SPRITES FROM: FoS, http://nanotrasen.se/phpBB3/memberlist.php?mode=viewprofile&u=386

/mob/living/simple_animal/hostile/poison/terror_spider/purple
	name = "Praetorian spider"
	desc = "An ominous-looking purple spider."
	spider_role_summary = "Guards the nest of the Queen of Terror."
	ai_target_method = TS_DAMAGE_BRUTE
	egg_name = "purple spider eggs"
	altnames = list("Nest Guardian spider")

	icon_state = "terror_purple"
	icon_living = "terror_purple"
	icon_dead = "terror_purple_dead"
	maxHealth = 300
	health = 300
	melee_damage_lower = 15
	melee_damage_upper = 25
	move_to_delay = 6
	idle_ventcrawl_chance = 0 // stick to the queen!
	spider_tier = 2

	ai_ventcrawls = 0


/mob/living/simple_animal/hostile/poison/terror_spider/purple/death(gibbed)
	if(spider_myqueen)
		var/mob/living/simple_animal/hostile/poison/terror_spider/queen/Q = spider_myqueen
		if(Q.health > 0 && !Q.ckey)
			if(get_dist(src,Q) > 20)
				if(!degenerate && !Q.degenerate)
					degenerate = 1
					Q.DoLayTerrorEggs(/mob/living/simple_animal/hostile/poison/terror_spider/purple,1,0)
					visible_message("<span class='notice'> [src] chitters in the direction of [Q]!</span>")
	..()


/mob/living/simple_animal/hostile/poison/terror_spider/purple/ShowGuide()
	..()
	to_chat(src, "PURPLE TERROR guide:")
	to_chat(src, "- You guard the nest of the all important Terror Queen! You are very robust, with a chance to stun on hit, but should stay with the queen at all times.")
	to_chat(src, "- <b>If the queen dies, you die!</b>")

/mob/living/simple_animal/hostile/poison/terror_spider/purple/spider_specialattack(var/mob/living/carbon/human/L, var/poisonable)
	if(prob(10))
		visible_message("<span class='danger'> [src] rams into [L], knocking them to the floor! </span>")
		L.Weaken(5)
		L.Stun(5)
	else
		..()


/mob/living/simple_animal/hostile/poison/terror_spider/purple/spider_special_action()
	if(prob(5))
		if(spider_myqueen)
			var/mob/living/simple_animal/hostile/poison/terror_spider/queen/Q = spider_myqueen
			if(Q.health > 0 && !Q.ckey)
				if(get_dist(src,Q) > 15 || z != Q.z)
					if(!degenerate && !Q.degenerate)
						degenerate = 1
						Q.DoLayTerrorEggs(/mob/living/simple_animal/hostile/poison/terror_spider/purple,1,0)
						//visible_message("<span class='notice'> [src] chitters in the direction of [Q]!</span>")