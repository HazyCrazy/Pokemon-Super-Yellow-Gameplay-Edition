#===============================================================================
# * Near-Universal TMs - by FL (Credits will be apreciated)
#===============================================================================
#
# This script is for Pokémon Essentials. It makes all pokémon, except a few 
# specific ones, learn the near universal moves as TM/TR/HM/Tutor, so it's not
# necessary to add the move to the PBS learnset.
#
#== INSTALLATION ===============================================================
#
# Put it above main OR convert into a plugin. No need to add/remove anything
# from PBS.
#
#===============================================================================

if !PluginManager.installed?("Near-Universal TMs")
  PluginManager.register({                                                 
    :name    => "Near-Universal TMs",                                        
    :version => "1.0",                                                     
    :link    => "https://www.pokecommunity.com/showthread.php?t=492298",             
    :credits => "FL"
  })
end

NEAR_UNIVERSAL_TUTOR_MOVES = [
  :TERABLAST,:ATTRACT,:BIDE,:CAPTIVATE,:CELEBRATE,:CHARM,:CONFIDE,:CURSE,:DETECT,:WISH,:EGGBOMB,
  :ENDURE,:FALSESWIPE,:FACADE,:FLATTER,:FLING,:FRUSTRATION,:HEADBUTT,:HIDDENFORCE,:HIDDENPOWER,
  :HOLDBACK,:HOLDHANDS,:METRONOME,:NATURALGIFT,:NATUREPOWER,:PLAYNICE,:POWERSHIFT,:POWERSPLIT,
  :POWERSWAP,:POWERTRICK,:FINALGAMBIT,:PROTECT,:REFLECTTYPE,:REST,:RETURN,:SECRETPOWER,:SLACKOFF,
  :TOXIC,:LUCKYCHANT,:SPLASH,:SUBSTITUTE,:SWAGGER,:SYNCHRONOISE,:TERRAINPULSE,:WEATHERBALL,:WORKUP,
  :COURTCHANGE,:BESTOW,:COMEUPPANCE,:HAZE,:TERANORMAL,:TERAFIRE,:TERAFIGHTING,:TERAWATER,
  :TERAFLYING,:TERAGRASS,:TERAPOISON,:TERAELECTRIC,:TERAGROUND,:TERAPSYCHIC,:TERAROCK,:TERAICE,
  :TERABUG,:TERADRAGON,:TERAGHOST,:TERADARK,:TERASTEEL,:TERAFAIRY
  #:ATTRACT,:BIDE,:CAPTIVATE,CELEBRATE,:CONFIDE,:CURSE,:DOUBLETEAM,:DOUBLEEDGE,EGGBOMB,:ENDURE,
  #:FACADE,:FRUSTRATION,:HEADBUTT,:HELPINGHAND,:HIDDENPOWER,:MIMIC,:NATURALGIFT,
  #:PROTECT,:RAGE,:REST,:RETURN,:ROUND,:SECRETPOWER,:SLEEPTALK,:SNORE,
  #:SUBSTITUTE,:SWAGGER,:TAKEDOWN,:TERABLAST,:TOXIC
]

# :TERABLAST,:CELEBRATE,:CONFIDE,:EGGBOMB,:FALSESWIPE,:FLING,:FRUSTRATION,:HIDDENFORCE,:HIDDENPOWER,:HOLDBACK,:HOLDHANDS,:METRONOME,:NATURALGIFT,:NATUREPOWER,:PLAYNICE,:POWERSHIFT,:POWERSPLIT,:POWERSWAP,:POWERTRICK,:PRESENT,:PROTECT,:REFLECTTYPE,:SECRETPOWER,:SLACKOFF,:SLEEPTALK,:SNORE,:SPLASH,:SUBSTITUTE,:SYNCHRONOISE,:TERRAINPULSE,:WEATHERBALL,:WORKUP

# Ignores forms
NEAR_INCOMPATIBLE_TUTOR_SPECIES = [
  :DITTO
  #:CATERPIE,:METAPOD,:WEEDLE,:KAKUNA,:MAGIKARP,:DITTO,:UNOWN,:WOBBUFFET,
  #:SMEARGLE,:WURMPLE,:SILCOON,:CASCOON,:WYNAUT,:BELDUM,:KRICKETOT,:BURMY,
  #:COMBEE,:TYNAMO,:SCATTERBUG,:SPEWPA,:COSMOG,:COSMOEM,:BLIPBUG,:APPLIN
]

class Pokemon
  alias :_compatible_with_move_FL_near :compatible_with_move?
  def compatible_with_move?(move_id)
    if (
      NEAR_UNIVERSAL_TUTOR_MOVES.include?(move_id) &&
      !NEAR_INCOMPATIBLE_TUTOR_SPECIES.include?(@species)
    )
      return true
    end
    return _compatible_with_move_FL_near(move_id)
  end
end