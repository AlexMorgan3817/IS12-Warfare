/obj/item/gun/projectile/automatic/machinepistol/medic
/obj/item/gun/projectile/shotgun/pump/shitty/medic
/obj/item/gun/projectile/shotgun/pump/shitty/sawn/medic
/obj/item/gun/projectile/shotgun/pump/boltaction/shitty/bayonet/medic
/obj/item/gun/projectile/shotgun/doublebarrel/medic

/datum/gear/medic
	display_name = "MED: Mk.2 Soulburn SMG"
	path = /obj/item/gun/projectile/automatic/machinepistol/medic
	sort_category = "Medic"
	cost = 150
	allowed_roles = list(/datum/job/soldier/blue_soldier/medic, /datum/job/soldier/red_soldier/medic)

/datum/gear/medic/pump
	display_name = "MED: WTX Frontier Special"
	path = /obj/item/gun/projectile/shotgun/pump/shitty
	cost = 120

/datum/gear/medic/pump/sawn
	display_name = "MED: Sawn Off WTX Frontier Special"
	path = /obj/item/gun/projectile/shotgun/pump/shitty/sawn/medic
	cost = 150

/datum/gear/medic/pump/bayonet
	display_name = "MED: Mark I Stormrider"
	path = /obj/item/gun/projectile/shotgun/pump/boltaction/shitty/bayonet/medic
	cost = 150

/datum/gear/medic/doublebarrel
	display_name = "MED: MS Doom"
	path = /obj/item/gun/projectile/shotgun/doublebarrel/medic
	cost = 200
