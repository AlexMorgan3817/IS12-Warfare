#define CARGO_GUNS_CATEGORY Guns

/datum/CargoCategory/Guns/Name = "Guns"
/datum/CargoCategory/Guns/AssembleAssortiment()
	. = ..()
	assortiment += list(
		new/datum/CargoGood(
			/obj/item/gun/projectile/automatic/machinepistol,
			"Mk.2 Soulburn SMG",
			100
		),
		new/datum/CargoGood(
			/obj/item/gun/projectile/shotgun/pump/shitty,
			"WTX Frontier Special",
			100
		),
		new/datum/CargoGood(
			/obj/item/gun/projectile/shotgun/pump/shitty/sawn,
			"Sawn Off WTX Frontier Special",
			100
		),
		new/datum/CargoGood(
			/obj/item/gun/projectile/shotgun/pump/boltaction/shitty/bayonet,
			"Mark I Stormrider",
			100
		),
		new/datum/CargoGood(
			/obj/item/gun/projectile/shotgun/doublebarrel,
			"MS Doom",
			100
		)
	)
		

/*
ADD2CARGO(CARGO_GUNS_CATEGORY,\
	/obj/item/gun/projectile/automatic/machinepistol, \
		"Mk.2 Soulburn SMG",\
			100\
	)
ADD2CARGO(CARGO_GUNS_CATEGORY,\
	/obj/item/gun/projectile/shotgun/pump/shitty,\
		"WTX Frontier Special",\
			100\
	)
ADD2CARGO(CARGO_GUNS_CATEGORY,\
	/obj/item/gun/projectile/shotgun/pump/shitty/sawn,\
		"Sawn Off WTX Frontier Special",\
			100\
	)
ADD2CARGO(CARGO_GUNS_CATEGORY,\
	/obj/item/gun/projectile/shotgun/pump/boltaction/shitty/bayonet,\
		"Mark I Stormrider",\
			100\
	)
ADD2CARGO(CARGO_GUNS_CATEGORY,\
	/obj/item/gun/projectile/shotgun/doublebarrel,\
		"MS Doom",\
			100\
	)
*/