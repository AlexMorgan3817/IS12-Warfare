#define CKEYWHITELIST "data/ckey_whitelist.txt"

/hook/startup/proc/loadCkeyWhitelist()
	load_ckey_whitelist()
	return 1

/proc/load_ckey_whitelist()
	log_and_message_admins("Loading ckey_whitelist")
	ckey_whitelist = list()
	var/list/Lines = file2list(CKEYWHITELIST)
	for(var/line in Lines)
		if(!length(line))
			continue

		var/ascii = text2ascii(line,1)

		if(copytext(line,1,2) == "#" || ascii == 9 || ascii == 32)//# space or tab
			continue

		ckey_whitelist.Add(ckey(line))

	if(!ckey_whitelist.len)
		log_and_message_admins("ckey_whitelist: empty or missing.")
		ckey_whitelist = null
	else
		log_and_message_admins("ckey_whitelist: [ckey_whitelist.len] entrie(s).")

/proc/check_ckey_whitelisted(var/ckey)
	return (ckey_whitelist && (ckey in ckey_whitelist) )

/datum/admins/proc/ToggleCkeyWhitelist()
	set category = "Server"
	set name = "Toggle ckey Whitelist"
	set desc="Toggles the ckey Whitelist on and off."

	config.useckeywhitelist = !config.useckeywhitelist
	if(config.useckeywhitelist)
		load_ckey_whitelist()
		to_world("<B>The pool is now closed.</B>")
		log_and_message_admins("[key_name(usr)] enabled the ckey whitelist.")
	else
		ckey_whitelist = null
		to_world("<B>The pool is now open.</B>")
		log_and_message_admins("[key_name(usr)] disabled the ckey whitelist.")

/datum/admins/proc/toggle_panic_bunker()
	set category = "Server"
	set name = "Toggle Panic Bunker"
	set desc= "Toggles whether or not new players can join."

	config.private_party = !config.private_party

	if(config.private_party)
		to_world("<B>The pool is now closed.</B>")
		log_and_message_admins("[key_name(usr)] enabled the panic bunker.")
	else
		to_world("<B>The pool is now open.</B>")
		log_and_message_admins("[key_name(usr)] disabled the panic bunker.")

/datum/admins/proc/ReloadCkeyWhitelist()
	set category = "Server"
	set name = "Reload ckey Whitelist"
	set desc="Reloads the ckey Whitelist."

	load_ckey_whitelist()
	log_and_message_admins("[key_name(usr)] has reloaded the ckey whitelist.")

//[downstream]
/proc/SanitizeCkeyList(L)
	for(var/k in L)
		k = ckey(k)
		if(!length(k))
			L -= k
	return L

/proc/Add2CkeyWhitelist(_key)
	_key = ckey(_key)
	var/list/whitelist_file
	if(fexists(CKEYWHITELIST))
		whitelist_file = file2list(CKEYWHITELIST)
	else
		whitelist_file = list()
	if(islist(whitelist_file) && !whitelist_file.Find(_key))
		whitelist_file |= _key
		if(fexists(CKEYWHITELIST))
			fdel(CKEYWHITELIST)
		text2file(jointext(SanitizeCkeyList(whitelist_file), "\n"), CKEYWHITELIST)
		load_ckey_whitelist()
		return TRUE

/proc/RemoveCkeyFromWhiteList(_key)
	_key = ckey(_key)
	var/list/whitelist_file = file2list(CKEYWHITELIST)
	if(length(whitelist_file) && whitelist_file.Find(_key))
		whitelist_file -= _key
		if(fexists(CKEYWHITELIST))
			fdel(CKEYWHITELIST)
		text2file(jointext(SanitizeCkeyList(whitelist_file), "\n"), CKEYWHITELIST)
		load_ckey_whitelist()
		return TRUE

/client/proc/addckey2wl()
	set category = "Server"
	set name = "Whitelist: Add Ckey To Whitelist"
	set desc = "Adds Ckey To ckey Whitelist."

	var/_ckey = input("Input ckey to add", "Whilelist") as null|text
	if(_ckey)
		Add2CkeyWhitelist(_ckey)

/client/proc/removeckeyfromwl()
	set category = "Server"
	set name = "Whitelist: Remove Ckey From Whitelist"
	set desc = "Remove ckey from ckeywhitelist."

	var/_ckey = input("Input ckey to remove", "Whilelist") in ckey_whitelist
	if(_ckey)
		RemoveCkeyFromWhiteList(_ckey)

//[/downstream]
#undef CKEYWHITELIST