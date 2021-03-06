
// --------------------------------------------------------------------------------
// ----------------- TERROR SPIDERS: T2 WHITE TERROR ------------------------------
// --------------------------------------------------------------------------------
// -------------: ROLE: stealthy reproduction
// -------------: AI: injects a venom that makes you grow spiders in your body, then retreats
// -------------: SPECIAL: stuns you on first attack - vulnerable to groups while it does this
// -------------: TO FIGHT IT: blast it before it can get away
// -------------: CONCEPT: http://tvtropes.org/pmwiki/pmwiki.php/Main/BodyHorror
// -------------: SPRITES FROM: FoS, http://nanotrasen.se/phpBB3/memberlist.php?mode=viewprofile&u=386

/mob/living/simple_animal/hostile/poison/terror_spider/white
	name = "White Terror spider"
	desc = "An ominous-looking white spider, its ghostly eyes and vicious-looking fangs are the stuff of nightmares."
	spider_role_summary = "Rare, bite-and-run spider that infects hosts with spiderlings"
	ai_target_method = TS_DAMAGE_POISON

	icon_state = "terror_white"
	icon_living = "terror_white"
	icon_dead = "terror_white_dead"
	maxHealth = 100
	health = 100
	melee_damage_lower = 5
	melee_damage_upper = 15
	move_to_delay = 4
	ventcrawler = 1
	spider_tier = TS_TIER_2
	loot = list(/obj/item/clothing/accessory/medal)

/mob/living/simple_animal/hostile/poison/terror_spider/white/LoseTarget()
	stop_automated_movement = 0
	attackstep = 0
	attackcycles = 0
	..()

/mob/living/simple_animal/hostile/poison/terror_spider/white/death(gibbed)
	if(!hasdied)
		if(spider_uo71)
			UnlockBlastDoors("UO71_Bridge", "UO71 Bridge is now unlocked!")
	..()


/mob/living/simple_animal/hostile/poison/terror_spider/white/spider_specialattack(mob/living/carbon/human/L, poisonable)
	if(!poisonable)
		..()
		return
	var/inject_target = pick("chest","head")
	if(L.stunned || L.paralysis || L.can_inject(null,0,inject_target,0))
		if(!IsInfected(L))
			new /obj/item/organ/internal/body_egg/terror_eggs(L)
			if(!ckey)
				LoseTarget()
				walk_away(src,L,2,1)


/mob/living/simple_animal/hostile/poison/terror_spider/proc/IsInfected(mob/living/carbon/C)
	if(C.get_int_organ(/obj/item/organ/internal/body_egg))
		return 1
	return 0
