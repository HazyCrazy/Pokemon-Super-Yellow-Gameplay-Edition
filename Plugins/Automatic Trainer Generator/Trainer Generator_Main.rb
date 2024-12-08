#===============================================================================
# Trainer Generator
#===============================================================================
class TrainerGenerator
  def getTrainer(trainer_type)
    trainer_class = nil
    TrainerClasses_Types.constants.map{ |trainer| trainer_class = trainer if TrainerClasses_Types.const_get(trainer)[:TRAINERS].include?(trainer_type.to_sym)}
    trainer_class = :YOUNGSTER if !trainer_class
    return TrainerClasses_Types.const_get(trainer_class)
  end

  def randomizeTeam(trainer,pokemon_count)
    pokemon_team = []
    available_pokemon = []
    choose_gen = TrainerGenerator_Settings::GENERATIONS
    GameData::Species.each do |s|
      available_pokemon.push(s) if choose_gen.include?(s.generation) && !TrainerGenerator_Settings::BLACKLIST.include?(s.id)
    end
    trainer[:GUARANTEED].each{ |pokemon| pokemon_team.push(GameData::Species.try_get(pokemon).id) && pokemon_count -= 1 } if !(trainer[:GUARANTEED]).nil?
    available_pokemon = available_pokemon.select{ |pokemon| trainer[:WHITELIST].include?(pokemon.id)} if !(trainer[:WHITELIST]).nil?
    available_pokemon = available_pokemon.select{ |pokemon| (trainer[:ONLYTYPE] & pokemon.types).length > 0} if !(trainer[:ONLYTYPE]).nil?
    available_pokemon = available_pokemon.select{ |pokemon| (trainer[:EGGGROUP] & pokemon.egg_groups).length > 0} if !(trainer[:EGGGROUP]).nil?
    available_pokemon = available_pokemon.select{ |pokemon| (pokemon.base_stats[:ATTACK]+pokemon.base_stats[:DEFENSE]+pokemon.base_stats[:SPEED]+pokemon.base_stats[:SPECIAL_DEFENSE]+pokemon.base_stats[:SPECIAL_ATTACK]+pokemon.base_stats[:HP]) > trainer[:POWER]} if !(trainer[:POWER]).nil?
    available_pokemon = available_pokemon.select{ |pokemon| (trainer[:SPECIAL][(trainer[:SPECIAL].index :COMBINATION)+1] & pokemon.types).length > 0} if (!(trainer[:SPECIAL]).nil? && trainer[:SPECIAL].include?(:COMBINATION))
    available_pokemon = available_pokemon.select{ |pokemon| pokemon.id == pokemon.get_baby_species} if TrainerGenerator_Settings::USE_ONLY_BABY
    available_pokemon = available_pokemon.select{ |pokemon| pokemon.form == 0} if TrainerGenerator_Settings::USE_ONLY_BASE_FORM
    trainer[:MAINPOKEMON].map { |pokemon| available_pokemon.push(GameData::Species.try_get(pokemon))} if !(trainer[:MAINPOKEMON]).nil?
    available_pokemon = available_pokemon.select{ |pokemon| (pokemon.moves.map{ |move| move[1]} & trainer[:LEARNMOVE]).length > 0} if !(trainer[:LEARNMOVE]).nil?
    available_pokemon = available_pokemon.sort_by{ |pokemon| pokemon.base_stats[:ATTACK]+pokemon.base_stats[:DEFENSE]+pokemon.base_stats[:SPEED]+pokemon.base_stats[:SPECIAL_DEFENSE]+pokemon.base_stats[:SPECIAL_ATTACK]+pokemon.base_stats[:HP]}
    available_pokemon = available_pokemon.sort_by{ |pokemon| -pokemon.catch_rate }
    for i in 0...pokemon_count
      rarity = rand(1..6) - 3
      rarity = 0 if rarity < 0
      rarity += 1 if rarity%2==1
      rarity /= 2
      rarity = available_pokemon.length-1 if rarity > (available_pokemon.length-1)
      index = rarity.to_i * (available_pokemon.length/3) + rand(0...(available_pokemon.length/3))
      pokemon_team.push(available_pokemon[index].id)
      if !trainer[:SPECIAL].nil?
        for j in 0...trainer[:SPECIAL].length
          case trainer[:SPECIAL][j]
          when :COLLECTOR
            for m in 0...(pokemon_count-1)
              pokemon_team.push(available_pokemon[index].id)
            end
            return pokemon_team
          when :VARIED
            available_pokemon = available_pokemon.select{ |pokemon| (GameData::Species.try_get(pokemon_team[i]).types & pokemon.types).length == 0}
          when :COMBINATION
            available_pokemon = available_pokemon.select{ |pokemon| !pokemon.types.include?((GameData::Species.try_get(pokemon_team[i]).types & trainer[:SPECIAL][j+1])[0])}
          end
        end
      end
    end
    return pokemon_team
  end
end

def randomizeTrainer(trainer_type,pokemon_count = 3)
  trainer_generator = TrainerGenerator.new
  pokemon_list = trainer_generator.randomizeTeam(trainer_generator.getTrainer(trainer_type),pokemon_count)
  return pokemon_list
end

def evolvePokemon(pokemon)
  pokemon.species = GameData::Species.get(pokemon.species).get_baby_species # revert to the first stage
  2.times do |stage|
    evolutions = GameData::Species.get(pokemon.species).get_evolutions(false)

    # Checks if the species only evolve by level up
    other_evolving_method = false
    evolutions.length.times { |i|
      if evolutions[i][1] != :Level
        other_evolving_method = true
      end
    }

    if !other_evolving_method # Species that evolve by level up
      if pokemon.check_evolution_on_level_up != nil
        pokemon.species = pokemon.check_evolution_on_level_up
      end
    else  # For species with other evolving methods
      # Checks if the pokemon is in it's midform and defines the level to evolve
      level = rand(7..15)*(stage+1)

      if pokemon.level >= level
        if evolutions.length == 1         # Species with only one possible evolution
          pokemon.species = evolutions[0][0]
        elsif evolutions.length > 1
          pokemon.species = evolutions[rand(0, evolutions.length - 1)][0]
        end
      end
    end
  end
  return pokemon
end

def pbNewTrainer(tr_type, tr_name, tr_version, save_changes = true)
  if TrainerGenerator_Settings::PARTY_ASK
    party_params = ChooseNumberParams.new
    party_params.setRange(1,6)
    party_params.setDefaultValue(3)
    party_count = pbMessageChooseNumber(_INTL("How many Pokemons should {1} have? (max. #{party_params.maxNumber})",tr_name),party_params)
  else
    party_count = rand(TrainerGenerator_Settings::PARTY_MIN,TrainerGenerator_Settings::PARTY_MAX)
  end
  if TrainerGenerator_Settings::LEVEL_ASK
    level_params = ChooseNumberParams.new
    level_params.setRange(1,GameData::GrowthRate.max_level)
	level_params.setDefaultValue(TrainerGenerator_Settings::LEVEL_DEFAULT)
    default_level = pbMessageChooseNumber(_INTL("Set the default Pokemon level for {1}'s party (max. #{level_params.maxNumber}).",tr_name),level_params)
  else
    default_level = TrainerGenerator_Settings::LEVEL_DEFAULT
  end
  pokemon_list = []
  loop do
    pokemon_list = randomizeTrainer(tr_type,party_count)
    for i in 0...pokemon_list.length
      pokemon_list[i] = evolvePokemon(Pokemon.new(pokemon_list[i],default_level+rand(0..1+i)))
    end
    if TrainerGenerator_Settings::CONFIRM_NEW_TRAINER && pbConfirmMessage(_INTL("{1}?",pokemon_list.map{ |pokemon| pokemon.name}.join(", ")))
      break
    end
  end
  party = []
  for i in 0...pokemon_list.length
    party.push([pokemon_list[i].species,pokemon_list[i].level])
  end
  trainer = [tr_type, tr_name, [], party, tr_version]
  lose_text = TrainerGenerator_Settings::LOSE_TEXTS[rand(0...TrainerGenerator_Settings::LOSE_TEXTS.length)]
  if save_changes
    trainer_hash = {
      :trainer_type    => tr_type,
      :real_name       => tr_name,
      :version         => tr_version,
      :real_lose_text  => lose_text,
      :pokemon         => [],
      :items           => [],
      :pbs_file_suffix => "generated"
    }
    party.each do |pkmn|
      trainer_hash[:pokemon].push(
        {
          :species => pkmn[0],
          :level   => pkmn[1]
        }
      )
    end
    item_count = rand(5) - 3
    item_count = 0 if item_count < 0
    for i in 0...item_count
      trainer_hash[:items].push(TrainerGenerator_Settings::ITEM_WHITELIST[rand(0...TrainerGenerator_Settings::ITEM_WHITELIST.length)])
    end
    # Add trainer's data to records
    trainer_hash[:id] = [trainer_hash[:trainer_type], trainer_hash[:real_name], trainer_hash[:version]]
    GameData::Trainer.register(trainer_hash)
    GameData::Trainer.save
    pbConvertTrainerData
    pbMessage(_INTL("The Trainer's data was added to the list of battles and in PBS/trainers_generated.txt."))
  end
  return trainer
end

alias missing_trainer_script pbMissingTrainer
def pbMissingTrainer(tr_type, tr_name, tr_version)
  if TrainerGenerator_Settings::ASK_NEW_TRAINER || !$DEBUG
    missing_trainer_script(tr_type, tr_name, tr_version)
  else
    pbNewTrainer(tr_type, tr_name, tr_version)
  end
end
