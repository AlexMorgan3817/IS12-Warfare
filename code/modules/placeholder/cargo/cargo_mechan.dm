GLOBAL_LIST_EMPTY(cargo_pads)
GLOBAL_LIST_EMPTY(CargoCategories)

#define TOPIC_HREF(title, href) "<a href='?src=\ref[src];[href]'>[title]</a>"

/proc/Add2CargoPads(faction as text, obj/structure/cargo_pad/pad)
	if(!GLOB.cargo_pads.Find(faction))
		GLOB.cargo_pads[faction] = list()
	GLOB.cargo_pads[faction] += pad
	pad.faction = faction

/proc/RemoveFromCargoPads(faction as text, pad)
	if(!GLOB.cargo_pads.Find(faction))
		GLOB.cargo_pads[faction] = list()
	GLOB.cargo_pads[faction] -= pad

/proc/GetCargoPadsByFaction(faction as text)
	if(GLOB.cargo_pads.Find(faction))
		return GLOB.cargo_pads[faction]

/obj/machinery/kaos/cargo_machine
	var/faction
	var/datum/CargoCategory/SelectedCategory
	var/Money = 0
	var/list/AllowedCurrencies = list(/obj/item/stack/teeth/human = 20)
	attackby(obj/item/W, mob/user, click_params)
		if(AllowedCurrencies.Find(W?.type))
			if(user.unEquip(W))
				var/cost = AllowedCurrencies[W.type]
				if(isstack(W))
					var/obj/item/stack/S = W
					cost *= S.amount
				Money += cost
				qdel(W)
				. = TRUE
		if(!.)
			. = ..()

	attack_hand(mob/user as mob)
		. = ..()
		interact(user)
	interact(user as mob)
		if(..()) return
		if(stat & (NOPOWER|BROKEN)) return
		var/window_id = "CargoConsole"
		var/dat = "Balance: [Money]<br>"

		for(var/datum/CargoCategory/category in GLOB.CargoCategories)
			dat += TOPIC_HREF("[category.Name]", "category=[GLOB.CargoCategories.Find(category)]") + "|"
		dat += "<hr>"

		if(istype(SelectedCategory))
			dat += "<table style='border: #424224 solid 1px; background: #323200aa; margin: auto'><tr><th>Name<th>Cost"
			for(var/datum/CargoGood/good in SelectedCategory.assortiment)
				dat += "<tr><th>[TOPIC_HREF("[good.Name]", "buy=[SelectedCategory.assortiment.Find(good)]")]<th>[good.Cost]"
			dat += "</table>"

		user << browse(dat, "window=[window_id];size=500x300")

	OnTopic(user, href_list)
		var/category_index = text2num(href_list["category"])
		if(isnum(category_index) && length(GLOB.CargoCategories) >= category_index)
			var/datum/CargoCategory/category2select = GLOB.CargoCategories[category_index]
			if(istype(category2select))
				SelectedCategory = category2select
				. = TOPIC_REFRESH
		if(istype(SelectedCategory))
			var/good_index = text2num(href_list["buy"])
			if(isnum(good_index) && length(SelectedCategory.assortiment) >= good_index)
				var/datum/CargoGood/good = SelectedCategory.assortiment[good_index]
				if(istype(good) && Money >= good.Cost)
					Buy(good)
					. = TOPIC_REFRESH
		if(. == TOPIC_REFRESH)
			interact(usr)

	proc/Buy(datum/CargoGood/good)
		var/list/pad = pick(GetCargoPadsByFaction(faction))
		if(istype(pad, /obj/structure/cargo_pad))
			Money = max(Money - good.Cost, 0)
			var/atom/movable/G = new good.Path(pad)
			G.dropInto(pad)
			return G

/obj/machinery/kaos/cargo_machine/red
	faction = "RED"
/obj/machinery/kaos/cargo_machine/blue
	faction = "BLUE"

/obj/effect/landmark/cargo
	var/faction
	Initialize()
		var/obj/structure/cargo_pad = locate(/obj/structure/cargo_pad) in get_turf(src)
		if(cargo_pad) Add2CargoPads(faction, cargo_pad)
		. = ..()

/obj/structure/cargo_pad
	var/faction
	Destroy()
		RemoveFromCargoPads(faction, src)
		. = ..()

/obj/effect/landmark/cargo/red/faction = "RED"
/obj/effect/landmark/cargo/blue/faction = "BLUE"

/obj/effect/landmark/red_cargo/parent_type = /obj/effect/landmark/cargo/red
/obj/effect/landmark/blue_cargo/parent_type = /obj/effect/landmark/cargo/blue
