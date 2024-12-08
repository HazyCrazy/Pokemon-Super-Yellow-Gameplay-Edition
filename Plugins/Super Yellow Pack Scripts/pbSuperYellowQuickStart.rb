# For Super Yellow Gameplay Edition, these scipts cut the shit
# and gives the player all the Pokemon out of the gate,
# including every item in the game, to cover every possible 
# specfic Pokemon a player needs. I don't care too much 
# for the player having every item in the game,
# in the context of Super Yellow Gameplay Edition.
# Let them mess with every item if they want.

def pbDemoPartyQuickStart
	party = []
    species = [:UNOWN, :SPINDA, :BASTIODON, :SPIDOPS, :SOLROCK, :TROPIUS]
    species.each { |id| party.push(id) if GameData::Species.exists?(id) }
    $player.party.clear
    # Generate Pokémon of each species at level 20
	# For Super Yellow, everything is Level 100 
    party.each do |spec|
      pkmn = Pokemon.new(spec, 100)
      $player.party.push(pkmn)
      $player.pokedex.register(pkmn)
      $player.pokedex.set_owned(spec)
      case spec
      when :UNOWN
		pkmn.learn_move(:COSMICPOWER)
        pkmn.learn_move(:ANCIENTPOWER)
		pkmn.learn_move(:COREENFORCER)
		pkmn.learn_move(:HIDDENFORCE)
      when :SPINDA
        pkmn.learn_move(:RETURN)
        pkmn.learn_move(:DRAINPUNCH)
		pkmn.learn_move(:VICTORYDANCE)
		pkmn.learn_move(:EGGBOMB)
      when :BASTIODON
        pkmn.learn_move(:BODYSLAM)
        pkmn.learn_move(:IRONDEFENSE)
        pkmn.learn_move(:BODYPRESS)
        pkmn.learn_move(:STEALTHROCK)
      when :SPIDOPS
        pkmn.learn_move(:STICKYWEB)
        pkmn.learn_move(:LEECHLIFE)
        pkmn.learn_move(:KNOCKOFF)
		pkmn.learn_move(:SPIKES)
		when :SOLROCK
        pkmn.learn_move(:GEOMANCY)
        pkmn.learn_move(:ARMORCANNON)
        pkmn.learn_move(:CHARGEBEAM)
		pkmn.learn_move(:PSYSHOCK)
		when :TROPIUS
        pkmn.learn_move(:SWORDSDANCE)
        pkmn.learn_move(:LEAFBLADE)
        pkmn.learn_move(:OUTRAGE)
		pkmn.learn_move(:EARTHQUAKE)
      end
      pkmn.record_first_moves
    end
    pbMessage(_INTL("You have been given a full team of Pokémon. Pick up the Ball in front of you, and they will follow you!"))
end

def pbAllPokemonQuickStart
	added = 0
    box_qty = $PokemonStorage.maxPokemon(0)
    completed = true
    GameData::Species.each do |species_data|
      sp = species_data.species
      f = species_data.form
      # Record each form of each species as seen and owned
      if f == 0
        if species_data.single_gendered?
          g = (species_data.gender_ratio == :AlwaysFemale) ? 1 : 0
          $player.pokedex.register(sp, g, f, 0, false)
          $player.pokedex.register(sp, g, f, 1, false)
        else   # Both male and female
          $player.pokedex.register(sp, 0, f, 0, false)
          $player.pokedex.register(sp, 0, f, 1, false)
          $player.pokedex.register(sp, 1, f, 0, false)
          $player.pokedex.register(sp, 1, f, 1, false)
        end
        $player.pokedex.set_owned(sp, false)
      elsif species_data.real_form_name && !species_data.real_form_name.empty?
        g = (species_data.gender_ratio == :AlwaysFemale) ? 1 : 0
        $player.pokedex.register(sp, g, f, 0, false)
        $player.pokedex.register(sp, g, f, 1, false)
      end
      # Add Pokémon (if form 0, i.e. one of each species)
      next if f != 0
      if added >= Settings::NUM_STORAGE_BOXES * box_qty
        completed = false
        next
      end
      added += 1
      $PokemonStorage[(added - 1) / box_qty, (added - 1) % box_qty] = Pokemon.new(sp, 100)
    end
    $player.pokedex.refresh_accessible_dexes
    pbMessage(_INTL("Storage boxes were filled with one Pokémon of each species. All 1025 Pokémon!"))
    if !completed
      pbMessage(_INTL("Note: The number of storage spaces ({1} boxes of {2}) is less than the number of species.",
                      Settings::NUM_STORAGE_BOXES, box_qty))
    end
end

def pbAllItemsQuickStart
	params = ChooseNumberParams.new
    params.setRange(1, Settings::BAG_MAX_PER_SLOT)
    params.setInitialValue(1)
    params.setCancelValue(0)
    qty = pbMessageChooseNumber(_INTL("Choose the number of items. (Please Set to 900)"), params)
    if qty > 0
      $bag.clear
      # NOTE: This doesn't simply use $bag.add for every item in turn, because
      #       that's really slow when done in bulk.
      pocket_sizes = Settings::BAG_MAX_POCKET_SIZE
      bag = $bag.pockets   # Called here so that it only rearranges itself once
      GameData::Item.each do |i|
        next if !pocket_sizes[i.pocket - 1] || pocket_sizes[i.pocket - 1] == 0
        next if pocket_sizes[i.pocket - 1] > 0 && bag[i.pocket].length >= pocket_sizes[i.pocket - 1]
        item_qty = (i.is_important?) ? 1 : qty
        bag[i.pocket].push([i.id, item_qty])
      end
      # NOTE: Auto-sorting pockets don't need to be sorted afterwards, because
      #       items are added in the same order they would be sorted into.
      pbMessage(_INTL("The Bag was filled with {1} of each item.", qty))
    end
end

def pbBasicPlayerFeaturesQuickStart
	$player.has_pokedex = true
	$player.has_running_shoes = true
end

def pbPumbInAllItems
	params = ChooseNumberParams.new
    params.setRange(1, Settings::BAG_MAX_PER_SLOT)
    params.setInitialValue(1)
    params.setCancelValue(0)
    qty = pbMessageChooseNumber(_INTL("Choose the number of items."), params)
    if qty > 0
      $bag.clear
      # NOTE: This doesn't simply use $bag.add for every item in turn, because
      #       that's really slow when done in bulk.
      pocket_sizes = Settings::BAG_MAX_POCKET_SIZE
      bag = $bag.pockets   # Called here so that it only rearranges itself once
      GameData::Item.each do |i|
        next if !pocket_sizes[i.pocket - 1] || pocket_sizes[i.pocket - 1] == 0
        next if pocket_sizes[i.pocket - 1] > 0 && bag[i.pocket].length >= pocket_sizes[i.pocket - 1]
        item_qty = (i.is_important?) ? 1 : qty
        bag[i.pocket].push([i.id, item_qty])
      end
      # NOTE: Auto-sorting pockets don't need to be sorted afterwards, because
      #       items are added in the same order they would be sorted into.
      pbMessage(_INTL("The Bag was filled with {1} of each item.", qty))
    end
end 

def pbDumpOutAllItems 
	$bag.clear
    pbMessage(_INTL("The Bag was cleared."))
end 
