#===============================================================================
# Trainer Generator
#===============================================================================
module TrainerGenerator_Settings
    # Should it ask for the party count?
    PARTY_ASK = false
    # If not asked, party min and max size to randomize
    PARTY_MIN = 6
    PARTY_MAX = 6

    # Should it ask for the base level?
    LEVEL_ASK = false
    # If not, base level
    LEVEL_DEFAULT = 90

    # Should it ask to create new trainer?
    ASK_NEW_TRAINER = true
    # Should it ask you to accept new trainer's party?
    CONFIRM_NEW_TRAINER = true

    # Generations used
    GENERATIONS = (1..9).to_a
    # Should it use only base form?
    USE_ONLY_BASE_FORM = true
    # Should it use only baby Pokemon (unevolved)?
    USE_ONLY_BABY = false

    # Blacklist of Pokemon
    BLACKLIST = [
        :ARCEUS
    ]

    # An array of lose texts
    LOSE_TEXTS = [
      "Aww man, I thought I had a chance.",
      "I suppose I am the loser.",
      "Wow, you're pretty strong!",
      "Those were some cool moves!",
      "Pfft. Before I could get serious, I lost!",
      "OK! I give up!",
      "I lost. I lost!",
      "I'm glad I got to see your Pokemon!",
      "Hmm. This is disappointing.",
      "Ow, ow, ow!",
      "Just as I thought, you're tough!",
      "Argh, I can't do anymore...",
      "Looks like you're the stronger one...",
      "Way to go!",
      "That's too bad.",
      "Just what I expected.",
      "Oh... That's disappointing!",
      "That's odd.",
      "...Humph! Are you happy you won?",
      "Tch! I tried to rush things...",
      "Argh! You're too strong!",
      "I was not expecting to lose that hard.",
      "Aack! My Pokemon!",
      "I was no match...",
      "Didn't I train enough?",
      "I see. So you can battle that way.",
      "That's strange. I won before.",
      "I was whipped...",
      "...Hmmm...",
      "Yow! You're too strong!",
      "This can't be true!",
      "Gaah!",
      "Yikes! Not fast enough!",
      "What an amazing battle!",
      "Phew...",
      "Pretty impressive! I'm sure you can go anywhere with that skill!",
      "You're too much!",
      "Good battle!",
      "Gwa ha ha! I lost.",
      "I can't move anymore...",
      "That's shocking!",
      "Whew... Good battle.",
      "Oh, yikes! We lost!",
      "Whatever!",
      "Heh, I guess I didn't try hard enough.",
      "I lost that one!",
      "Gulp! This is a bleak moment.",
      "Mercy!",
      "Tch! I took you too lightly!",
      "Uh-oh! I was also sunk by indecision!",
      "Ayeeee!",
      "Uww... I blew it.",
      "Impresive...",
      "We give up! You're the winner!",
      "Looks like we underestimated you",
      "Oh, so close! I almost had you!",
      "...did I win?",
      "Oh... I lost... you're not weak...",
      "Oh, dear! I wanted to win!",
      "Yikes! Sorry!",
      "... ... I'll go train some more...",
      "Yaha! I lost!",
      "I was no match...",
      "Uwahauwaha!",
      "Nyuraahahhaah",
      "You never saw me...",
      "Uwaaah! Eeek!",
      "Grr! I lost that...",
      "Oh... I lost...",
      "Peace--even though I lost!",
      "I did not expect to lose this battle.",
      "Ugh, why do I always keep losing these battles?",
      "No way!",
      "Aww, darn it!",
      "You cheated! It's that simple.",
      "I should've guessed you would cheat.",
      "I thought I was prepared for anything!",
      "I can't accept defeat like this...",
      "I knew you would win.",
      "Wow, you're too good!",
      "This can't be happening.",
      "Wow! You're super impressive.",
      "Hang on, this makes no sense..."
    ]

    # An array of possible Items
    ITEM_WHITELIST = [
      :MEGARING,
	  :DYNAMAXBAND,
	  :ZRING,
	  :TERAORB
    ]
end