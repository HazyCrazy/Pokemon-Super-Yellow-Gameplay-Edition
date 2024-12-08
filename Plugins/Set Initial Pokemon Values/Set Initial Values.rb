module Battle::CatchAndStoreMixin

  def pbStorePokemon(pkmn)
    # Nickname the Pokémon (unless it's a Shadow Pokémon)
    if !pkmn.shadowPokemon?
      if $PokemonSystem.givenicknames == 0 &&
         pbDisplayConfirm(_INTL("Would you like to give a nickname to {1}?", pkmn.name))
        nickname = @scene.pbNameEntry(_INTL("{1}'s nickname?", pkmn.speciesName), pkmn)
        pkmn.name = nickname
      end
    end

	if pbSafariState.steps > 0
		# Set initial values.
		if pbConfirmMessage(_INTL("Would you like to set initial values for {1}?",pkmn.name))
			#pbDisplay(_INTL("What Nature would you like on {1}?",pkmn.name))
			commands = []
			ids = []
			GameData::Nature.each do |nature|
			if nature.stat_changes.length == 0
				commands.push(_INTL("{1} (---)", nature.real_name))
			else
				plus_text = ""
				minus_text = ""
				nature.stat_changes.each do |change|
				if change[1] > 0
					plus_text += "/" if !plus_text.empty?
					plus_text += GameData::Stat.get(change[0]).name_brief
				elsif change[1] < 0
					minus_text += "/" if !minus_text.empty?
					minus_text += GameData::Stat.get(change[0]).name_brief
				end
				end
				commands.push(_INTL("{1} (+{2}, -{3})", nature.real_name, plus_text, minus_text))
			end
			ids.push(nature.id)
			end
			commands.push(_INTL("[Reset]"))
			cmd = ids.index(pkmn.nature_id || ids[0])
			loop do
			msg = _INTL("What Nature would you like on {1}?", pkmn.name)
			cmd = pbMessage(msg, commands, cmd)
			break if cmd < 0
			if cmd >= 0 && cmd < commands.length - 1   # Set nature
				pkmn.nature = ids[cmd]
				break
			elsif cmd == commands.length - 1   # Reset
				pkmn.nature = nil
				break
			end
			end  
			pkmn.calc_stats
			#pbDisplay(_INTL("{1}'s Nature has been set to {2}",pkmn.name,newnature))
			abils = pkmn.getAbilityList
			abil1 = nil
			abil2 = nil
			abils.each do |i|
			abil1 = i[0] if i[1] == 0
			abil2 = i[0] if i[1] == 1
			end
			if abil1.nil? || abil2.nil? || pkmn.hasHiddenAbility?
				#pbDisplay(_INTL("You can't set another ability for {1}.",pkmn.name))
			else
				ability_commands = []
				abil_cmd = 0
				abils.each do |i|
				break if i[1]>1 && !Settings::SIPN_HIDDEN_ABILITIES
				ability_commands.push(((i[1] < 2) ? "" : "(H) ") + GameData::Ability.get(i[0]).name)
				abil_cmd = ability_commands.length - 1 if pkmn.ability_id == i[0]
				end
				abil_cmd = pbMessage(_INTL("Choose an ability."), ability_commands, abil_cmd)
				#next if abil_cmd < 0
				pkmn.ability_index = abils[abil_cmd][1]
				pkmn.ability = nil
			end
			if PluginManager.installed?("Independent Hidden Power Type")
				#pbDisplay(_INTL("What would be the preferred Hidden Power type of {1}?",pkmn.name))
				commands = []
				types = []
				GameData::Type.each do |t|
					if !t.pseudo_type && ![:PLAGUE, :SHADOW].include?(t.id)
					commands.push(t.name)
					types.push(t.id) 
				end
				end
				commands.push(_INTL("Cancel"))
				cmd = types.index(pkmn.hptype) || 0
				cmd = pbMessage(_INTL("Choose the type of {1}'s Hidden Power.",pkmn.name), commands, -1, nil, cmd)
				if cmd >=0 && cmd<types.length && pkmn.hptype != types[cmd]
				pkmn.hptype = types[cmd]
				#scene.pbDisplay(_INTL("{1}'s Hidden Power has been set to {2}.",pokemon.name, pokemon.hptype))
				else
					# canceled
				end
			end	
		end	  
	else
		# Set initial values.
		if pbDisplayConfirm(_INTL("Would you like to set initial values for {1}?",pkmn.name))
			#pbDisplay(_INTL("What Nature would you like on {1}?",pkmn.name))
			commands = []
			ids = []
			GameData::Nature.each do |nature|
			if nature.stat_changes.length == 0
				commands.push(_INTL("{1} (---)", nature.real_name))
			else
				plus_text = ""
				minus_text = ""
				nature.stat_changes.each do |change|
				if change[1] > 0
					plus_text += "/" if !plus_text.empty?
					plus_text += GameData::Stat.get(change[0]).name_brief
				elsif change[1] < 0
					minus_text += "/" if !minus_text.empty?
					minus_text += GameData::Stat.get(change[0]).name_brief
				end
				end
				commands.push(_INTL("{1} (+{2}, -{3})", nature.real_name, plus_text, minus_text))
			end
			ids.push(nature.id)
			end
			commands.push(_INTL("[Reset]"))
			cmd = ids.index(pkmn.nature_id || ids[0])
			loop do
			msg = _INTL("What Nature would you like on {1}?", pkmn.name)
			cmd = pbShowCommands(msg, commands, cmd)
			break if cmd < 0
			if cmd >= 0 && cmd < commands.length - 1   # Set nature
				pkmn.nature = ids[cmd]
				break
			elsif cmd == commands.length - 1   # Reset
				pkmn.nature = nil
				break
			end
			end  
			pkmn.calc_stats
			#pbDisplay(_INTL("{1}'s Nature has been set to {2}",pkmn.name,newnature))
			abils = pkmn.getAbilityList
			abil1 = nil
			abil2 = nil
			abils.each do |i|
			abil1 = i[0] if i[1] == 0
			abil2 = i[0] if i[1] == 1
			end
			if abil1.nil? || abil2.nil? || pkmn.hasHiddenAbility?
				#pbDisplay(_INTL("You can't set another ability for {1}.",pkmn.name))
			else
				ability_commands = []
				abil_cmd = 0
				abils.each do |i|
				break if i[1]>1 && !Settings::SIPN_HIDDEN_ABILITIES
				ability_commands.push(((i[1] < 2) ? "" : "(H) ") + GameData::Ability.get(i[0]).name)
				abil_cmd = ability_commands.length - 1 if pkmn.ability_id == i[0]
				end
				abil_cmd = pbShowCommands(_INTL("Choose an ability."), ability_commands, abil_cmd)
				#next if abil_cmd < 0
				pkmn.ability_index = abils[abil_cmd][1]
				pkmn.ability = nil
			end
			if PluginManager.installed?("Independent Hidden Power Type")
				#pbDisplay(_INTL("What would be the preferred Hidden Power type of {1}?",pkmn.name))
				commands = []
				types = []
				GameData::Type.each do |t|
					if !t.pseudo_type && ![:PLAGUE, :SHADOW].include?(t.id)
					commands.push(t.name)
					types.push(t.id) 
				end
				end
				commands.push(_INTL("Cancel"))
				cmd = types.index(pkmn.hptype) || 0
				cmd = pbMessage(_INTL("Choose the type of {1}'s Hidden Power.",pkmn.name), commands, -1, nil, cmd)
				if cmd >=0 && cmd<types.length && pkmn.hptype != types[cmd]
				pkmn.hptype = types[cmd]
				#scene.pbDisplay(_INTL("{1}'s Hidden Power has been set to {2}.",pokemon.name, pokemon.hptype))
				else
					# canceled
				end
			end	
		end	
	end	
    # Store the Pokémon
    if pbPlayer.party_full? && (@sendToBoxes == 0 || @sendToBoxes == 2)   # Ask/must add to party
      cmds = [_INTL("Add to your party"),
              _INTL("Send to a Box"),
              _INTL("See {1}'s summary", pkmn.name),
              _INTL("Check party")]
      cmds.delete_at(1) if @sendToBoxes == 2
      loop do
        cmd = pbShowCommands(_INTL("Where do you want to send {1} to?", pkmn.name), cmds, 99)
        break if cmd == 99   # Cancelling = send to a Box
        cmd += 1 if cmd >= 1 && @sendToBoxes == 2
        case cmd
        when 0   # Add to your party
          pbDisplay(_INTL("Choose a Pokémon in your party to send to your Boxes."))
          party_index = -1
          @scene.pbPartyScreen(0, (@sendToBoxes != 2), 1) { |idxParty, _partyScene|
            party_index = idxParty
            next true
          }
          next if party_index < 0   # Cancelled
          party_size = pbPlayer.party.length
          # Send chosen Pokémon to storage
          # NOTE: This doesn't work properly if you catch multiple Pokémon in
          #       the same battle, because the code below doesn't alter the
          #       contents of pbParty(0), only pbPlayer.party. This means that
          #       viewing the party in battle after replacing a party Pokémon
          #       with a caught one (which is possible if you've caught a second
          #       Pokémon) will not show the first caught Pokémon in the party
          #       but will still show the boxed Pokémon in the party. Correcting
          #       this would take a surprising amount of code, and it's very
          #       unlikely to be needed anyway, so I'm ignoring it for now.
          send_pkmn = pbPlayer.party[party_index]
          stored_box = @peer.pbStorePokemon(pbPlayer, send_pkmn)
          pbPlayer.party.delete_at(party_index)
          box_name = @peer.pbBoxName(stored_box)
          pbDisplayPaused(_INTL("{1} has been sent to Box \"{2}\".", send_pkmn.name, box_name))
          # Rearrange all remembered properties of party Pokémon
          (party_index...party_size).each do |idx|
            if idx < party_size - 1
              @initialItems[0][idx] = @initialItems[0][idx + 1]
              $game_temp.party_levels_before_battle[idx] = $game_temp.party_levels_before_battle[idx + 1]
              $game_temp.party_critical_hits_dealt[idx] = $game_temp.party_critical_hits_dealt[idx + 1]
              $game_temp.party_direct_damage_taken[idx] = $game_temp.party_direct_damage_taken[idx + 1]
            else
              @initialItems[0][idx] = nil
              $game_temp.party_levels_before_battle[idx] = nil
              $game_temp.party_critical_hits_dealt[idx] = nil
              $game_temp.party_direct_damage_taken[idx] = nil
            end
          end
          break
        when 1   # Send to a Box
          break
        when 2   # See X's summary
          pbFadeOutIn {
            summary_scene = PokemonSummary_Scene.new
            summary_screen = PokemonSummaryScreen.new(summary_scene, true)
            summary_screen.pbStartScreen([pkmn], 0)
          }
        when 3   # Check party
          @scene.pbPartyScreen(0, true, 2)
        end
      end
    end
    # Store as normal (add to party if there's space, or send to a Box if not)
    stored_box = @peer.pbStorePokemon(pbPlayer, pkmn)
    if stored_box < 0
      pbDisplayPaused(_INTL("{1} has been added to your party.", pkmn.name))
      @initialItems[0][pbPlayer.party.length - 1] = pkmn.item_id if @initialItems
      return
    end
    # Messages saying the Pokémon was stored in a PC box
    box_name = @peer.pbBoxName(stored_box)
    pbDisplayPaused(_INTL("{1} has been sent to Box \"{2}\"!", pkmn.name, box_name))
  end
  
end



def pbNicknameAndStore(pkmn)
  if pbBoxesFull?
    pbMessage(_INTL("There's no more room for Pokémon!\1"))
    pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
    return
  end
  $player.pokedex.set_seen(pkmn.species)
  $player.pokedex.set_owned(pkmn.species)  
  pbNickname(pkmn)
	# Set initial values.
    if pbConfirmMessage(_INTL("Would you like to set initial values for {1}?",pkmn.name))
		#pbDisplay(_INTL("What Nature would you like on {1}?",pkmn.name))
		commands = []
		ids = []
		GameData::Nature.each do |nature|
		  if nature.stat_changes.length == 0
			commands.push(_INTL("{1} (---)", nature.real_name))
		  else
			plus_text = ""
			minus_text = ""
			nature.stat_changes.each do |change|
			  if change[1] > 0
				plus_text += "/" if !plus_text.empty?
				plus_text += GameData::Stat.get(change[0]).name_brief
			  elsif change[1] < 0
				minus_text += "/" if !minus_text.empty?
				minus_text += GameData::Stat.get(change[0]).name_brief
			  end
			end
			commands.push(_INTL("{1} (+{2}, -{3})", nature.real_name, plus_text, minus_text))
		  end
		  ids.push(nature.id)
		end
		commands.push(_INTL("[Reset]"))
		cmd = ids.index(pkmn.nature_id || ids[0])
		loop do
		  msg = _INTL("What Nature would you like on {1}?", pkmn.name)
		  cmd = pbMessage(msg, commands, cmd)
		  break if cmd < 0
		  if cmd >= 0 && cmd < commands.length - 1   # Set nature
			pkmn.nature = ids[cmd]
			break
		  elsif cmd == commands.length - 1   # Reset
			pkmn.nature = nil
			break
		  end
		end  
		pkmn.calc_stats
		#pbDisplay(_INTL("{1}'s Nature has been set to {2}",pkmn.name,newnature))
		abils = pkmn.getAbilityList
		abil1 = nil
		abil2 = nil
		abils.each do |i|
		  abil1 = i[0] if i[1] == 0
		  abil2 = i[0] if i[1] == 1
		end
		if abil1.nil? || abil2.nil? || pkmn.hasHiddenAbility?
			#pbDisplay(_INTL("You can't set another ability for {1}.",pkmn.name))
		else
			ability_commands = []
			abil_cmd = 0
			abils.each do |i|
			  break if i[1]>1 && !Settings::SIPN_HIDDEN_ABILITIES
			  ability_commands.push(((i[1] < 2) ? "" : "(H) ") + GameData::Ability.get(i[0]).name)
			  abil_cmd = ability_commands.length - 1 if pkmn.ability_id == i[0]
			end
			abil_cmd = pbMessage(_INTL("Choose an ability."), ability_commands, abil_cmd)
			#next if abil_cmd < 0
			pkmn.ability_index = abils[abil_cmd][1]
			pkmn.ability = nil
		end
		if PluginManager.installed?("Independent Hidden Power Type")
			#pbDisplay(_INTL("What would be the preferred Hidden Power type of {1}?",pkmn.name))
			commands = []
			types = []
			GameData::Type.each do |t|
				if !t.pseudo_type && ![:PLAGUE, :SHADOW].include?(t.id)
				commands.push(t.name)
				types.push(t.id) 
			end
			end
			commands.push(_INTL("Cancel"))
			cmd = types.index(pkmn.hptype) || 0
			cmd = pbMessage(_INTL("Choose the type of {1}'s Hidden Power.",pkmn.name), commands, -1, nil, cmd)
			if cmd >=0 && cmd<types.length && pkmn.hptype != types[cmd]
			pkmn.hptype = types[cmd]
			#scene.pbDisplay(_INTL("{1}'s Hidden Power has been set to {2}.",pokemon.name, pokemon.hptype))
			else
				# canceled
			end
		end	
    end	  
  pbStorePokemon(pkmn)
end

class PokemonEggHatch_Scene

  def pbMain
    pbBGMPlay("Evolution")
    # Egg animation
    updateScene(Graphics.frame_rate * 15 / 10)
    pbPositionHatchMask(0)
    pbSEPlay("Battle ball shake")
    swingEgg(4)
    updateScene(Graphics.frame_rate * 2 / 10)
    pbPositionHatchMask(1)
    pbSEPlay("Battle ball shake")
    swingEgg(4)
    updateScene(Graphics.frame_rate * 4 / 10)
    pbPositionHatchMask(2)
    pbSEPlay("Battle ball shake")
    swingEgg(8, 2)
    updateScene(Graphics.frame_rate * 4 / 10)
    pbPositionHatchMask(3)
    pbSEPlay("Battle ball shake")
    swingEgg(16, 4)
    updateScene(Graphics.frame_rate * 2 / 10)
    pbPositionHatchMask(4)
    pbSEPlay("Battle recall")
    # Fade and change the sprite
    fadeTime = Graphics.frame_rate * 4 / 10
    toneDiff = (255.0 / fadeTime).ceil
    (1..fadeTime).each do |i|
      @sprites["pokemon"].tone = Tone.new(i * toneDiff, i * toneDiff, i * toneDiff)
      @sprites["overlay"].opacity = i * toneDiff
      updateScene
    end
    updateScene(Graphics.frame_rate * 3 / 4)
    @sprites["pokemon"].setPokemonBitmap(@pokemon) # Pokémon sprite
    @sprites["pokemon"].x = Graphics.width / 2
    @sprites["pokemon"].y = 264
    @pokemon.species_data.apply_metrics_to_sprite(@sprites["pokemon"], 1)
    @sprites["hatch"].visible = false
    (1..fadeTime).each do |i|
      @sprites["pokemon"].tone = Tone.new(255 - (i * toneDiff), 255 - (i * toneDiff), 255 - (i * toneDiff))
      @sprites["overlay"].opacity = 255 - (i * toneDiff)
      updateScene
    end
    @sprites["pokemon"].tone = Tone.new(0, 0, 0)
    @sprites["overlay"].opacity = 0
    # Finish scene
    frames = (GameData::Species.cry_length(@pokemon) * Graphics.frame_rate).ceil
    @pokemon.play_cry
    updateScene(frames + 4)
    pbBGMStop
    pbMEPlay("Evolution success")
    @pokemon.name = nil
    pbMessage(_INTL("\\se[]{1} hatched from the Egg!\\wt[80]", @pokemon.name)) { update }
    # Record the Pokémon's species as owned in the Pokédex
    was_owned = $player.owned?(@pokemon.species)
    $player.pokedex.register(@pokemon)
    $player.pokedex.set_owned(@pokemon.species)
    $player.pokedex.set_seen_egg(@pokemon.species)
    # Show Pokédex entry for new species if it hasn't been owned before
    if Settings::SHOW_NEW_SPECIES_POKEDEX_ENTRY_MORE_OFTEN && !was_owned && $player.has_pokedex
      pbMessage(_INTL("{1}'s data was added to the Pokédex.", @pokemon.name)) { update }
      $player.pokedex.register_last_seen(@pokemon)
      pbFadeOutIn {
        scene = PokemonPokedexInfo_Scene.new
        screen = PokemonPokedexInfoScreen.new(scene)
        screen.pbDexEntry(@pokemon.species)
      }
    end
	# Set initial values.
    if pbConfirmMessage(_INTL("Would you like to set initial values for {1}?",@pokemon.name))
		#pbDisplay(_INTL("What Nature would you like on {1}?",@pokemon.name))
		commands = []
		ids = []
		GameData::Nature.each do |nature|
		  if nature.stat_changes.length == 0
			commands.push(_INTL("{1} (---)", nature.real_name))
		  else
			plus_text = ""
			minus_text = ""
			nature.stat_changes.each do |change|
			  if change[1] > 0
				plus_text += "/" if !plus_text.empty?
				plus_text += GameData::Stat.get(change[0]).name_brief
			  elsif change[1] < 0
				minus_text += "/" if !minus_text.empty?
				minus_text += GameData::Stat.get(change[0]).name_brief
			  end
			end
			commands.push(_INTL("{1} (+{2}, -{3})", nature.real_name, plus_text, minus_text))
		  end
		  ids.push(nature.id)
		end
		commands.push(_INTL("[Reset]"))
		cmd = ids.index(@pokemon.nature_id || ids[0])
		loop do
		  msg = _INTL("What Nature would you like on {1}?", @pokemon.name)
		  cmd = pbMessage(msg, commands, cmd)
		  break if cmd < 0
		  if cmd >= 0 && cmd < commands.length - 1   # Set nature
			@pokemon.nature = ids[cmd]
			break
		  elsif cmd == commands.length - 1   # Reset
			@pokemon.nature = nil
			break
		  end
		end  
		@pokemon.calc_stats
		#pbDisplay(_INTL("{1}'s Nature has been set to {2}",@pokemon.name,newnature))
		abils = @pokemon.getAbilityList
		abil1 = nil
		abil2 = nil
		abils.each do |i|
		  abil1 = i[0] if i[1] == 0
		  abil2 = i[0] if i[1] == 1
		end
		if abil1.nil? || abil2.nil? || @pokemon.hasHiddenAbility?
			#pbDisplay(_INTL("You can't set another ability for {1}.",@pokemon.name))
		else
			ability_commands = []
			abil_cmd = 0
			abils.each do |i|
			  break if i[1]>1 && !Settings::SIPN_HIDDEN_ABILITIES
			  ability_commands.push(((i[1] < 2) ? "" : "(H) ") + GameData::Ability.get(i[0]).name)
			  abil_cmd = ability_commands.length - 1 if @pokemon.ability_id == i[0]
			end
			abil_cmd = pbMessage(_INTL("Choose an ability."), ability_commands, abil_cmd)
			#next if abil_cmd < 0
			@pokemon.ability_index = abils[abil_cmd][1]
			@pokemon.ability = nil
		end
		if PluginManager.installed?("Independent Hidden Power Type")
			#pbDisplay(_INTL("What would be the preferred Hidden Power type of {1}?",@pokemon.name))
			commands = []
			types = []
			GameData::Type.each do |t|
				if !t.pseudo_type && ![:PLAGUE, :SHADOW].include?(t.id)
				commands.push(t.name)
				types.push(t.id) 
			end
			end
			commands.push(_INTL("Cancel"))
			cmd = types.index(@pokemon.hptype) || 0
			cmd = pbMessage(_INTL("Choose the type of {1}'s Hidden Power.",@pokemon.name), commands, -1, nil, cmd)
			if cmd >=0 && cmd<types.length && @pokemon.hptype != types[cmd]
			@pokemon.hptype = types[cmd]
			#scene.pbDisplay(_INTL("{1}'s Hidden Power has been set to {2}.",pokemon.name, pokemon.hptype))
			else
				# canceled
			end
		end	
    end	  	
    # Nickname the Pokémon
    if $PokemonSystem.givenicknames == 0 &&
       pbConfirmMessage(
         _INTL("Would you like to nickname the newly hatched {1}?", @pokemon.name)
       ) { update }
      nickname = pbEnterPokemonName(_INTL("{1}'s nickname?", @pokemon.name),
                                    0, Pokemon::MAX_NAME_SIZE, "", @pokemon, true)
      @pokemon.name = nickname
      @nicknamed = true
    end    
  end
  
end  

class PokemonTrade_Scene

  def pbTrade
    was_owned = $player.owned?(@pokemon2.species)
    $player.pokedex.register(@pokemon2)
    $player.pokedex.set_owned(@pokemon2.species)
    pbBGMStop
    @pokemon.play_cry
    speciesname1 = GameData::Species.get(@pokemon.species).name
    speciesname2 = GameData::Species.get(@pokemon2.species).name
    pbMessageDisplay(@sprites["msgwindow"],
                     _ISPRINTF("{1:s}\r\nID: {2:05d}   OT: {3:s}\\wtnp[0]",
                               @pokemon.name, @pokemon.owner.public_id, @pokemon.owner.name)) { pbUpdate }
    pbMessageWaitForInput(@sprites["msgwindow"], 50, true) { pbUpdate }
    pbPlayDecisionSE
    pbScene1
    pbMessageDisplay(@sprites["msgwindow"],
                     _INTL("For {1}'s {2},\r\n{3} sends {4}.\1", @trader1, speciesname1, @trader2, speciesname2)) { pbUpdate }
    pbMessageDisplay(@sprites["msgwindow"],
                     _INTL("{1} bids farewell to {2}.", @trader2, speciesname2)) { pbUpdate }
    pbScene2
    pbMessageDisplay(@sprites["msgwindow"],
                     _ISPRINTF("{1:s}\r\nID: {2:05d}   OT: {3:s}\1",
                               @pokemon2.name, @pokemon2.owner.public_id, @pokemon2.owner.name)) { pbUpdate }
    pbMessageDisplay(@sprites["msgwindow"],
                     _INTL("Take good care of {1}.", speciesname2)) { pbUpdate }
    # Show Pokédex entry for new species if it hasn't been owned before
    if Settings::SHOW_NEW_SPECIES_POKEDEX_ENTRY_MORE_OFTEN && !was_owned && $player.has_pokedex
      pbMessageDisplay(@sprites["msgwindow"],
                       _INTL("{1}'s data was added to the Pokédex.", speciesname2)) { pbUpdate }
      $player.pokedex.register_last_seen(@pokemon2)
	# Set initial values.
    if pbConfirmMessage(_INTL("Would you like to set initial values for {1}?",@pokemon2.name))
		#pbDisplay(_INTL("What Nature would you like on {1}?",@pokemon2.name))
		commands = []
		ids = []
		GameData::Nature.each do |nature|
		  if nature.stat_changes.length == 0
			commands.push(_INTL("{1} (---)", nature.real_name))
		  else
			plus_text = ""
			minus_text = ""
			nature.stat_changes.each do |change|
			  if change[1] > 0
				plus_text += "/" if !plus_text.empty?
				plus_text += GameData::Stat.get(change[0]).name_brief
			  elsif change[1] < 0
				minus_text += "/" if !minus_text.empty?
				minus_text += GameData::Stat.get(change[0]).name_brief
			  end
			end
			commands.push(_INTL("{1} (+{2}, -{3})", nature.real_name, plus_text, minus_text))
		  end
		  ids.push(nature.id)
		end
		commands.push(_INTL("[Reset]"))
		cmd = ids.index(@pokemon2.nature_id || ids[0])
		loop do
		  msg = _INTL("What Nature would you like on {1}?", @pokemon2.name)
		  cmd = pbMessage(msg, commands, cmd)
		  break if cmd < 0
		  if cmd >= 0 && cmd < commands.length - 1   # Set nature
			@pokemon2.nature = ids[cmd]
			break
		  elsif cmd == commands.length - 1   # Reset
			@pokemon2.nature = nil
			break
		  end
		end  
		@pokemon2.calc_stats
		#pbDisplay(_INTL("{1}'s Nature has been set to {2}",@pokemon2.name,newnature))
		abils = @pokemon2.getAbilityList
		abil1 = nil
		abil2 = nil
		abils.each do |i|
		  abil1 = i[0] if i[1] == 0
		  abil2 = i[0] if i[1] == 1
		end
		if abil1.nil? || abil2.nil? || @pokemon2.hasHiddenAbility?
			#pbDisplay(_INTL("You can't set another ability for {1}.",@pokemon2.name))
		else
			ability_commands = []
			abil_cmd = 0
			abils.each do |i|
			  break if i[1]>1 && !Settings::SIPN_HIDDEN_ABILITIES
			  ability_commands.push(((i[1] < 2) ? "" : "(H) ") + GameData::Ability.get(i[0]).name)
			  abil_cmd = ability_commands.length - 1 if @pokemon2.ability_id == i[0]
			end
			abil_cmd = pbMessage(_INTL("Choose an ability."), ability_commands, abil_cmd)
			#next if abil_cmd < 0
			@pokemon2.ability_index = abils[abil_cmd][1]
			@pokemon2.ability = nil
		end
		if PluginManager.installed?("Independent Hidden Power Type")
			#pbDisplay(_INTL("What would be the preferred Hidden Power type of {1}?",@pokemon2.name))
			commands = []
			types = []
			GameData::Type.each do |t|
				if !t.pseudo_type && ![:PLAGUE, :SHADOW].include?(t.id)
				commands.push(t.name)
				types.push(t.id) 
			end
			end
			commands.push(_INTL("Cancel"))
			cmd = types.index(@pokemon2.hptype) || 0
			cmd = pbMessage(_INTL("Choose the type of {1}'s Hidden Power.",@pokemon2.name), commands, -1, nil, cmd)
			if cmd >=0 && cmd<types.length && @pokemon2.hptype != types[cmd]
			@pokemon2.hptype = types[cmd]
			#scene.pbDisplay(_INTL("{1}'s Hidden Power has been set to {2}.",pokemon.name, pokemon.hptype))
			else
				# canceled
			end
		end	
    end	  	
      pbFadeOutIn {
        scene = PokemonPokedexInfo_Scene.new
        screen = PokemonPokedexInfoScreen.new(scene)
        screen.pbDexEntry(@pokemon2.species)
        pbEndScreen(false)
      }
    end
  end
end

	  