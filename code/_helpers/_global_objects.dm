

var/datum/gear_tweak/color/gear_tweak_free_color_choice_
/proc/gear_tweak_free_color_choice()
	if(!gear_tweak_free_color_choice_) gear_tweak_free_color_choice_ = new()
	return gear_tweak_free_color_choice_
// Might work in 511 assuming x=y=5 gets implemented.
