datum/directive/terminations/alien_fraud
	special_orders = list(
		"Suspend financial accounts of all Tesau and Unathi personnel.",
		"Transfer their payrolls to the station account.",
		"Terminate their employment.")

	proc/is_alien(mob/M)
		var/species = M.get_species()
		return species == "Tesau" || species == "Unathi"

datum/directive/terminations/alien_fraud/get_crew_to_terminate()
	var/list/aliens[0]
	for(var/mob/M in player_list)
		if (M.is_ready() && is_alien(M) && M != mode.head_loyalist.current)
			aliens.Add(M)
	return aliens

datum/directive/terminations/alien_fraud/get_description()
	return {"
		<p>
			An extensive conspiracy network aimed at defrauding the USN of large amounts of funds has been uncovered
			operating within [system_name()]. Human personnel are not suspected to be involved. Further information is classified.
		</p>
	"}

datum/directive/terminations/alien_fraud/meets_prerequisites()
	// There must be at least one Tesau and at least one Unathi, but the total
	// of the Tesaus and Unathi combined can't be more than 1/3rd of the crew.
	var/tesau = 0
	var/unathi = 0
	for(var/mob/M in player_list)
		var/species = M.get_species()
		if(species == "Tesau")
			tesau++
		if(species == "Unathi")
			unathi++

	if (!tesau || !unathi)
		return 0

	return (tesau + unathi) <= (player_list.len / 3)
