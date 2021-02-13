//#define ADD2CARGO(category, g_path, g_name, g_cost)/datum/CargoCategory/##category/New(){.=..();assortiment += new/datum/CargoGood(g_path, g_name, g_cost)};/datum/CargoCategory/##category/Name = #category

/hook/roundstart/proc/InitCargoCategories()
	for(var/path in subtypesof(/datum/CargoCategory))
		new path()
	return TRUE

/datum/CargoCategory
	var/Name
	var/list/assortiment = list()
	New()
		. = ..()
		if(Name) GLOB.CargoCategories += src
		else del(src)
		AssembleAssortiment()
	proc/AssembleAssortiment()

/datum/CargoGood
	var/Name
	var/Cost = 0
	var/Path
	New(_path, _name, _cost)
		. = ..()
		if(_path) Path = _path
		if(_name) Name = _name
		if(_cost) Cost = _cost
