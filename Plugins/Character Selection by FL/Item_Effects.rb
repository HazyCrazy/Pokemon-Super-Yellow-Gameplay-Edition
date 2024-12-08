#===============================================================================
# Portable Wardrobe Character Skin Key Item 
# This item is something I bothered with, because I want players to 
# choose a character design they feel best represents them
# don't forget to add in the Portable Wardrobe code block in your resource pack!
#===============================================================================

ItemHandlers::UseFromBag.add(:PORTABLEWARDROBE, proc { |item|
  overworld = [
	"trainer_POKEMONTRAINER_FRLG_Red","trainer_POKEMONTRAINER_FRLG_Leaf",
    "trainer_POKEMONTRAINER_HGSS_Ethan","trainer_POKEMONTRAINER_HGSS_Lyra",
	"trainer_POKEMONTRAINER_COLO_Wes", "trainer_POKEMONTRAINER_GSC_Kris",
	"trainer_POKEMONTRAINER_ORAS_Brendan","trainer_POKEMONTRAINER_ORAS_May",
	"trainer_POKEMONTRAINER_PL_Lucas","trainer_POKEMONTRAINER_PL_Dawn",
	"trainer_POKEMONTRAINER_BW1_Hilbert","trainer_POKEMONTRAINER_BW1_Hilda",
    "trainer_POKEMONTRAINER_B2W2_Nate","trainer_POKEMONTRAINER_B2W2_Rosa"
    ]
  
  battle = [
	"POKEMONTRAINER_FRLG_Red","POKEMONTRAINER_FRLG_Leaf",
    "POKEMONTRAINER_HGSS_Ethan","POKEMONTRAINER_HGSS_Lyra",
	"POKEMONTRAINER_COLO_Wes","POKEMONTRAINER_GSC_Kris",
	"POKEMONTRAINER_ORAS_Brendan","POKEMONTRAINER_ORAS_May",
	"POKEMONTRAINER_PL_Lucas","POKEMONTRAINER_PL_Dawn",
	"POKEMONTRAINER_BW1_Hilbert","POKEMONTRAINER_BW1_Hilda",
    "POKEMONTRAINER_B2W2_Nate","POKEMONTRAINER_B2W2_Rosa"
    ]
  result = startCharacterSelection(overworld,battle) 
  pbChangePlayer(result+1)
  pbTrainerName
  next 1
})