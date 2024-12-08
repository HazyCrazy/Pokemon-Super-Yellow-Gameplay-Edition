#===============================================================================
# Trainer Generator
#===============================================================================
# TRAINERS - Trainer types included
# GUARANTEED - A Pokemon guaranteed to have
# WHITELIST - All the Pokemon that can be used
# ONLYTYPE - The only type the trainer uses
# EGGGROUP - Filter by egg groups
# LEARNMOVE - Uses only Pokemon that can learn this move by level up
# MAINPOKEMON - Pokemon added to the list after all filters (Can be used to add new species or to increase the chances for a specie)
# POWER -Base total stats the Pokemon should have
# SPECIAL (VARIED) - Use different types over the party
# SPECIAL (COMBINATION) - Use a combination of types over the party
# SPECIAL (COLLECTOR) - All Pokemon in the party are the same specie
#===============================================================================
module TrainerClasses_Types
    ACETRAINER = {
        :TRAINERS => [:ACEDUO,:ACETRAINER_F,:ACETRAINER_F2,:ACETRAINER_3,:ACETRAINER_M,:ACETRAINER_M2,:ACETRAINER_M3,:COOLCOUPLE,:COOLTRAINER_M,:COOLTRAINER_F],
        :SPECIAL => [:VARIED]
    }
    AROMALADY = {
        :TRAINERS => [:AROMALADY,:AROMALADY2],
		:SPECIAL => [:VARIED]
    }
    ARTIST = {
        :TRAINERS => [:ARTIST_F,:ARTIST_M],
		:SPECIAL => [:VARIED]
    }
    BACKPACKER = {
        :TRAINERS => [:BACKPACKER],
        :SPECIAL => [:VARIED]
    }
    BATTLEGIRL = {
        :TRAINERS => [:BATTLEGIRL,:BATTLEGIRL2,:BATTLEGIRL3],
		:SPECIAL => [:VARIED]
    }
    BEAUTY = {
        :TRAINERS => [:BEAUTY,:BEAUTY2,:BEAUTY3,:BEAUTY4],
		:SPECIAL => [:VARIED]
    }
    BIKER = {
        :TRAINERS => [:BIKER,:BIKER2],
		:SPECIAL => [:VARIED]
    }
    BIRDKEEPER = {
        :TRAINERS => [:BIRDKEEPER,:BIRDKEEPER2,:BIRDKEEPER3,:BIRDKEEPER4],
        :SPECIAL => [:VARIED]
    }
    BLACKBELT = {
        :TRAINERS => [:BLACKBELT,:BLACKBELT2,:BLACKBELT3],
        :SPECIAL => [:VARIED]
    }
    BREEDER = {
        :TRAINERS => [:BREEDER_F,:BREEDER_F2,:BREEDER_F3,:BREEDER_F4,:BREEDER_M,:BREEDER_M2],
        :SPECIAL => [:VARIED]
    }
    BUGCATCHER = {
        :TRAINERS => [:BUGCATCHER,:BUGCATCHER2,:BUGCATCHER3,:BUGMANIAC],
        :SPECIAL => [:VARIED]
    }
    BURGLAR = {
        :TRAINERS => [:BURGLAR,:BURGLAR2],
		:SPECIAL => [:VARIED]
    }
    BUTLER = {
        :TRAINERS => [:BUTLER],
        :SPECIAL => [:VARIED]
    }
    CAMERAMAN = {
        :TRAINERS => [:CAMERAMAN],
        :SPECIAL => [:VARIED]
    }
    CAMPER = {
        :TRAINERS => [:CAMPER_F,:CAMPER_M,:CAMPER_M2,:CAMPER_M3],
        :SPECIAL => [:VARIED]
    }
    CHANELLER = {
        :TRAINERS => [:CHANELLER],
        :SPECIAL => [:VARIED]
    }
    CHEF = {
        :TRAINERS => [:CHEF],
        :SPECIAL => [:VARIED]
    }
    COLLECTOR = {
        :TRAINERS => [:COLLECTOR],
        :SPECIAL => [:VARIED]
    }
    CRUSHTRAINER = {
        :TRAINERS => [:CRUSHGIRL,:CRUSHKIN,:CRUSHKIN2],
        :SPECIAL => [:VARIED]
    }
    CUEBALL = {
        :TRAINERS => [:CUEBALL],
        :SPECIAL => [:VARIED]
    }
    CUTECOUPLE = {
        :TRAINERS => [:CUTECOUPLE],
        :SPECIAL => [:VARIED]
    }
    DELINQUENT = {
        :TRAINERS => [:DELINQUENT],
        :SPECIAL => [:VARIED]
    }
    DIVER = {
        :TRAINERS => [:DIVER_F,:DIVER_M],
        :SPECIAL => [:VARIED]
    }
    DRAGONTAMER = {
        :TRAINERS => [:DRAGONTAMER],
        :SPECIAL => [:VARIED]
    }
    ENGINEER = {
        :TRAINERS => [:ENGINEER],
        :SPECIAL => [:VARIED]
    }
    EXPERT = {
        :TRAINERS => [:EXPERT_F,:EXPERT_M],
        :SPECIAL => [:VARIED]
    }
    FAIRYTALEGIRL = {
        :TRAINERS => [:FAIRYTALEGIRL],
        :SPECIAL => [:VARIED]
    }
    FISHERMAN = {
        :TRAINERS => [:FISHERMAN,:FISHERMAN2,:FISHERMAN3,:FISHERMAN4],
        :SPECIAL => [:VARIED]
    }
    FURISODEGIRL = {
        :TRAINERS => [:FURISODEGIRL,:FURISODEGIRL2,:FURISODEGIRL3,:FURISODEGIRL4],
        :SPECIAL => [:VARIED]
    }
    GAMBLER = {
        :TRAINERS => [:GAMBLER],
        :SPECIAL => [:VARIED]
    }
    GARDENER = {
        :TRAINERS => [:GARDENER],
        :SPECIAL => [:VARIED]
    }
    GENTLEMAN = {
        :TRAINERS => [:GENTLEMAN,:GENTLEMAN2,:GENTLEMAN3,:GENTLEMAN4],
        :SPECIAL => [:VARIED]
    }
    GUITARIST = {
        :TRAINERS => [:GUITARIST],
        :SPECIAL => [:VARIED]
    }
    HEXMANIAC = {
        :TRAINERS => [:HEXMANIAC],
        :SPECIAL => [:VARIED]
    }
    HIKER = {
        :TRAINERS => [:HIKER,:HIKER2,:HIKER3],
        :SPECIAL => [:VARIED]
    }
    INTERVIEWERS = {
        :TRAINERS => [:INTERVIEWERS],
		:SPECIAL => [:VARIED]
    }
    JUGGLER = {
        :TRAINERS => [:JUGGLER],
		:SPECIAL => [:VARIED]
    }
    KINDLER = {
        :TRAINERS => [:KINDLER],
        :SPECIAL => [:VARIED]
    }
    LADY = {
        :TRAINERS => [:LADY,:LADY2,:LADY3,:LADY4],
        :SPECIAL => [:VARIED]
    }
    LASS = {
        :TRAINERS => [:LASS,:LASS2,:LASS3],
        :SPECIAL => [:VARIED]
    }
    MAID = {
        :TRAINERS => [:MAID],
        :SPECIAL => [:VARIED]
    }
    MEDIUM = {
        :TRAINERS => [:MEDIUM],
        :SPECIAL => [:VARIED]
    }
    NINJABOY = {
        :TRAINERS => [:NINJABOY],
        :SPECIAL => [:VARIED]
    }
    OFFICELADY = {
        :TRAINERS => [:OFFICELADY],
		:SPECIAL => [:VARIED]
    }
    OWNER = {
        :TRAINERS => [:OWNER],
        :SPECIAL => [:VARIED]
    }
    PAINTER = {
        :TRAINERS => [:PAINTER,:PAINTER2],
        :SPECIAL => [:VARIED]
    }
    PARASOLLADY = {
        :TRAINERS => [:PARASOLLADY],
        :SPECIAL => [:VARIED]
    }
    PICNICKER = {
        :TRAINERS => [:PICNICKER,:PICNICKER2],
		:SPECIAL => [:VARIED]
    }
    POKEFAN = {
        :TRAINERS => [:POKEFAN_F,:POKEFAN_F2,:POKEFAN_M,:POKEFAN_M2],
        :SPECIAL => [:VARIED]
    }
    POKEMANIAC = {
        :TRAINERS => [:POKEMANIAC,:POKEMANIAC2],
        :SPECIAL => [:VARIED]
    }
    PRESCHOOLER = {
        :TRAINERS => [:PRESCHOOLER_F,:PRESCHOOLER_M],
        :SPECIAL => [:VARIED]
    }
    PSYCHIC = {
        :TRAINERS => [:PSYCHIC_F,:PSYCHIC_F2,:PSYCHIC_F3,:PSYCHIC_M,:PSYCHIC_M2],
        :SPECIAL => [:VARIED]
    }
    PUNKTRAINER = {
        :TRAINERS => [:PUNKTRAINER_F,:PUNKTRAINER_M],
        :SPECIAL => [:VARIED] 
    }
    RANGER = {
        :TRAINERS => [:RANGER_F,:RANGER_F2,:RANGER_F3,:RANGER_M,:RANGER_M2,:RANGER_M3],
       :SPECIAL => [:VARIED]
    }
    REPORTER = {
        :TRAINERS => [:REPORTER],
        :SPECIAL => [:VARIED]
    }
    RICHBOY = {
        :TRAINERS => [:RICHBOY,:RICHBOY2],
        :SPECIAL => [:VARIED]
    }
    RISINGSTAR = {
        :TRAINERS => [:RISINGSTAR_F,:RISINGSTAR_M],
        :SPECIAL => [:VARIED]
    }
    ROCKER = {
        :TRAINERS => [:ROCKER,:ROCKER2],
        :SPECIAL => [:VARIED]
    }
    ROLLERSKATER = {
        :TRAINERS => [:ROLLERSKATER_F,:ROLLERSKATER_M],
        :SPECIAL => [:VARIED]
    }
    ROUGHNECK = {
        :TRAINERS => [:ROUGHNECK],
        :SPECIAL => [:VARIED]
    }
    RUINMANIAC = {
        :TRAINERS => [:RUINMANIAC,:RUINMANIAC2,:RUINMANIAC3],
        :SPECIAL => [:VARIED]
    }
    SAILOR = {
        :TRAINERS => [:SAILOR,:SAILOR2,:SAILOR3],
        :SPECIAL => [:VARIED]
    }
    SCHOOLKID = {
        :TRAINERS => [:SCHOOLBOY,:SCHOOLBOY2,:SCHOOLBOY3,:SCHOOLBOY4,:SCHOOLBOY5,:SCHOOLGIRL,:SCHOOLGIRL2,:SCHOOLGIRL3,:SCHOOLGIRL4],
        :SPECIAL => [:VARIED]
    }
    SCIENTIST = {
        :TRAINERS => [:SCIENTIST_F,:SCIENTIST_M,:SCIENTIST_M2,:SCIENTIST_M3],
        :SPECIAL => [:VARIED]
    }
    SISANDBRO = {
        :TRAINERS => [:SISANDBRO],
        :SPECIAL => [:VARIED]
    }
    SKYTRAINER = {
        :TRAINERS => [:SKYTRAINER_F,:SKYTRAINER_M],
        :SPECIAL => [:VARIED]
    }
    SOCIALITE = {
        :TRAINERS => [:SOCIALITE],
        :SPECIAL => [:VARIED]
    }
    STREETTHUG = {
        :TRAINERS => [:STREETTHUG],
       :SPECIAL => [:VARIED]
    }
    SUPERNERD = {
        :TRAINERS => [:SUPERNERD,:SUPERNERD2,:SUPERNERD3],
        :SPECIAL => [:VARIED]
    }
    SWIMMER = {
        :TRAINERS => [:SWIMMER_F,:SWIMMER_F2,:SWIMMER_F3,:SWIMMER_F4,:SWIMMER_F5,:SWIMMER_M,:SWIMMER_M2,:SWIMMER_M3],
        :SPECIAL => [:VARIED]
    }
    TAMER = {
        :TRAINERS => [:TAMER],
        :SPECIAL => [:VARIED]
    }
    TEACHER = {
        :TRAINERS => [:TEACHER],
        :SPECIAL => [:VARIED]
    }
    TEAMMATES = {
        :TRAINERS => [:TEAMMATES],
        :SPECIAL => [:VARIED]
    }
    TOURIST = {
        :TRAINERS => [:TOURIST_F,:TOURIST_F2,:TOURIST_M],
		:SPECIAL => [:VARIED]
    }
    TRIATHLETE_SWIMMING = {
        :TRAINERS => [:TRIATHLETE],
       :SPECIAL => [:VARIED]
    }
    TRIATHLETE_RUNNING = {
        :TRAINERS => [:TRIATHLETE2],
        :SPECIAL => [:VARIED]
    }
    TRIATHLETE_RIDING = {
        :TRAINERS => [:TRIATHLETE3],
        :SPECIAL => [:VARIED]
    }
    TUBER = {
        :TRAINERS => [:TUBER_F,:TUBER_F2,:TUBER_F3,:TUBER_M,:TUBER_M2,:TUBER_M3],
        :SPECIAL => [:VARIED]
    }
    TWINS = {
        :TRAINERS => [:TWINS,:TWINS2,:TWINS3],
        :SPECIAL => [:VARIED]
    }
    VETERAN = {
        :TRAINERS => [:VETERAN_F,:VETERAN_M],
		:SPECIAL => [:VARIED]
    }
    WAITER = {
        :TRAINERS => [:WAITER,:WAITRESS],
       :SPECIAL => [:VARIED]
    }
    WORKER = {
        :TRAINERS => [:WORKER,:WORKER2],
        :SPECIAL => [:VARIED]
    }
    YOUNGCOUPLE = {
        :TRAINERS => [:YOUNGCOUPLE,:YOUNGCOUPLE2],
		:SPECIAL => [:VARIED]
    }
    YOUNGSTER = {
        :TRAINERS => [:YOUNGSTER,:YOUNGSTER2,:YOUNGSTER3],
       :SPECIAL => [:VARIED]
    }
end