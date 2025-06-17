#let input = (
  CHARACTERNAME                             : "Andraste Teinithra",
  BACKGROUND                                : "Merchant",
  CLASS                                     : "Sorcerer",
  SPECIES                                   : "Aasimar",
  SUBCLASS                                  : "Draconic Sorcery",

  LEVEL                                     : 12,
  XP                                        : 109000,

  AC                                        : 15,
  SHIELD                                    : false,

  TEMPORARY                                 : 12,
  SPENT                                     : 3,
  MAX_HITPOINTS                             : 98,
  MAX_HITDICE                               : "12d6",
  CURRENT                                   : 45,
  SUCCESSES                                 : 1,
  FAILURES                                  : 2,

  PROFICIENCYBONUS                          : "+4",

  STRENGTH_SCORE                            : 8,
  STRENGTH_MODIFIER                         : "-1",
  STRENGTH_SAVE                             : "-1",
  STRENGTH_PROFICIENCY                      : false,
  ATHLETICS_MODIFIER                        : "-1",
  ATHLETICS_PROFICIENCY                     : false,
  
  DEXTERITY_SCORE                           : 14,
  DEXTERITY_MODIFIER                        : "+2",
  DEXTERITY_SAVE                            : "+2",
  DEXTERITY_PROFICIENCY                     : false,
  ACROBATICS_MODIFIER                       : "+2", 
  ACROBATICS_PROFICIENCY                    : false,
  SLEIGHTOFHAND_MODIFIER                    : "+2", 
  SLEIGHTOFHAND_PROFICIENCY                 : false,
  STEALTH_MODIFIER                          : "+2",
  STEALTH_PROFICIENCY                       : false,
  
  CONSTITUTION_SCORE                        : 17,
  CONSTITUTION_MODIFIER                     : "+3",
  CONSTITUTION_SAVE                         : "+7",
  CONSTITITION_PROFICIENCY                  : true,
  
  INTELLIGENCE_SCORE                        : 12,
  INTELLIGENCE_MODIFIER                     : "+1",
  INTELLIGENCE_SAVE                         : "+1",
  INTELLIGENCE_PROFICIENCY                  : false,
  ARCANA_MODIFIER                           : "+5", 
  ARCANA_PROFICIENCY                        : true,
  HISTORY_MODIFIER                          : "+1", 
  HISTORY_PROFICIENCY                       : false,
  INVESTIGATION_MODIFIER                    : "+1", 
  INVESTIGATION_PROFICIENCY                 : false,
  NATURE_MODIFIER                           : "+1", 
  NATURE_PROFICIENCY                        : false,
  RELIGION_MODIFIER                         : "+1",
  RELIGION_PROFICIENCY                      : false,
  
  WISDOM_SCORE                              : 10, 
  WISDOM_MODIFIER                           : "+0", 
  WISDOM_SAVE                               : "+0", 
  WISDOM_PROFICIENCY                        : false,
  ANIMALHANDLING_MODIFIER                   : "+4", 
  ANIMALHANDLING_PROFICIENCY                : true,
  INSIGHT_MODIFIER                          : "+0", 
  INSIGHT_PROFICIENCY                       : false,
  MEDICINE_MODIFIER                         : "+0", 
  MEDICINE_PROFICIENCY                      : false,
  PERCEPTION_MODIFIER                       : "+0", 
  PERCEPTION_PROFICIENCY                    : false,
  SURVIVAL_MODIFIER                         : "+0",
  SURVIVAL_PROFICIENCY                      : false,
  
  CHARISMA_SCORE                            : 20, 
  CHARISMA_MODIFIER                         : "+5", 
  CHARISMA_SAVE                             : "+9", 
  CHARISMA_PROFICIENCY                      : true,
  DECEPTION_MODIFIER                        : "+5", 
  DECEPTION_PROFICIENCY                     : false,
  INTIMIDATION_MODIFIER                     : "+9", 
  INTIMIDATION_PROFICIENCY                  : true,
  PERFORMANCE_MODIFIER                      : "+5", 
  PERFORMANCE_PROFICIENCY                   : false,
  PERSUASION_MODIFIER                       : "+9",
  PERSUASION_PROFICIENCY                    : true,

  HEROICINSPIRATION                         : true,

  ARMOR_LIGHT                               : true,
  ARMOR_HEAVY                               : false,
  ARMOR_MEDIUM                              : false,
  SHIELDS                                   : false,

  WEAPONS                                   : "Simple Weapons",
  TOOLS                                     : "Navigator's Tools",

  INITIATIVE                                : "+2",
  SPEED                                     : "30 ft",
  SIZE                                      : "Medium",
  PASSIVEPERCEPTION                         : 10,

  ATTACKSLIST                              : (
                                                ("+3 Magic Quarterstaff", "+6, 1d6+2 bludgeoning", "1d8+2 with two hands"),
                                                ("Dagger", "+6, 20/60, 1d4+2 piercing", ""),
                                                ("Shocking Grasp", "+9, touch, 3d8 lightning", "VS, can't take reactions"),
                                             ),

  CLASSFEATURES1                            : "• Innate Sorcery (spell save DC +1, adv. on spell attacks for 1 min., twice betw. long rests)
• Font of Magic (use up to 12 sorcery points betw. long rests)
• Metamagic (spell effects)
• Creating Spell Slots (use 2 sorcery points for one 1st level spell slot, 3 pts. for 2nd level slot, 5 pts. 3rd level, 6 pts. 4th level, 7 pts. 5th level)
• Draconic Resilience (h.p. boost, natural AC)
• Draconic Spells (always prepared)
• Sorcerous Restoration (recover 6 sorcery points in short rest)
• ElementalAffinity (poison resistance, +5 to spells causing poison damage)
• Sorcery Incarnate (bonus action and 2 sorcery points to reuse Innate Sorcery plus two metamagic options)",
  CLASSFEATURES2                            : "Metamagic
• Seeking Spell (for 1 sorcery point, reroll missed attack spell)
• Empower Spell (for 1 sorcery point, reroll up to 5 damage dice)
• Heighten Spell (for 2 sorcery points, target saves vs. spell with disadv.)",
  
  SPECIESTRAITS                             : "• Celestial Resistance (vs. necrotic, radiant)
• Darkvision (60 feet)
• Healing Hands (4d4s by touch betw. long rests)
• Celestial Legacy (Charisma-based; Light cantrip)
• Celestial Revelation (as bonus action once betw. long rests: Heavenly Wings to fly and +4 radiant attack/spell damage; Inner Radiance to glow, 4 radiant damage within 10 ft. and +4 radiant attack/spell damage; or Necrotic Shroud to cause fear (DC CHA save) and +4 necrotic attack/spell damage)",
  
  FEATS                                     : "Lucky. Gain 4 Luck Points, each of which may give adv. on an ability check, save, or attack, or impose disadv. on one attacker targeting you. Regain expended points in a long rest.

Sorcerous Burst Cantrip. Ranged Spell Attack: +9 to hit. Hit: 3d8 choice of acid, cold, fire, lightning, poison, psychic, or thunder damage; extra d8s on rolls of 8.",

  SPELLCASTINGABILITY                       : "Charisma",
  SPELLCASTINGMODIFIER                      : "+5",
  SPELLSAVEDC                               : 17,
  SPELLATTACKBONUS                          : "+9",

  SPELLSLOTS_LEVEL1                         : 4,
  SPELLSLOTS_LEVEL1_EXPENDED                : 3,
  SPELLSLOTS_LEVEL2                         : 3,
  SPELLSLOTS_LEVEL2_EXPENDED                : 1,
  SPELLSLOTS_LEVEL3                         : 3,
  SPELLSLOTS_LEVEL3_EXPENDED                : 2,
  SPELLSLOTS_LEVEL4                         : 3,
  SPELLSLOTS_LEVEL4_EXPENDED                : 1,
  SPELLSLOTS_LEVEL5                         : 2,
  SPELLSLOTS_LEVEL5_EXPENDED                : 1,
  SPELLSLOTS_LEVEL6                         : 1,
  SPELLSLOTS_LEVEL6_EXPENDED                : 0,
  SPELLSLOTS_LEVEL7                         : "",
  SPELLSLOTS_LEVEL7_EXPENDED                : 0,
  SPELLSLOTS_LEVEL8                         : "",
  SPELLSLOTS_LEVEL8_EXPENDED                : 0,
  SPELLSLOTS_LEVEL9                         : "",
  SPELLSLOTS_LEVEL9_EXPENDED                : 0,

  SPELLLIST                                 : (
                                                  (1, "Charm Person", "action", "30ft", false, false, false, "WIS save"),
                                                  (1, "Chromatic Orb", "action", "90ft", false, false, false, "3d8 damage"),
                                                  (1, "Command", "action", "60ft", false, false, false, "WIS save"),
                                                  (1, "Mage Armor", "action", "touch", false, false, false, "AC 13 + DEX, 8h"),
                                                  (1, "Magic Missile", "action", "120ft", false, false, false, "3x 1d4+1 force"),
                                                  (1, "Shield", "reaction", "self", false, false, false, "+5 AC"),

                                                  (2, "Alter Self", "action", "self", true, false, false, "1h"),
                                                  (2, "Dragon's Breath", "bonus", "touch", true, false, false, "3d6, 20ft cone"),

                                                  (2, "Flaming Sphere", "action", "150ft", true, false, false, "DEX Save, 2d6 fire"),
                                                  (2, "Scorching Ray", "action", "120ft", false, false, false, "3x 2d6 fire"),
                                                  (2, "Spider Climb", "action", "touch", true, false, false, "1h"),
                                                  
                                                  (3, "Counterspell", "reaction", "60ft", false, false, false, "DC 10+level"),
                                                  (3, "Dispel Magic", "action", "120ft", false, false, false, "DC 10+level"),
                                                  (3, "Fear", "action", "self", true, false, false, "WIS Save"),
                                                  (3, "Fireball", "action", "150ft", false, false, false, "20ft, DEX, 8d6 fire"),
                                                  (3, "Fly", "action", "touch", true, false, false, "60ft fly speed"),
                                                  (3, "Haste", "action", "30ft", true, false, false, ""),

                                                  (4, "Arcane Eye", "action", "30ft", true, false, false, "30ft dv, 30ft move"),
                                                  (4, "Charm Monster", "action", "", false, false, false, ""),
                                                  (4, "Vitriolic Sphere", "action", "150ft", false, false, false, "DEX, 10d4+5d4 acid"),

                                                  (5, "Bigby's Hand", "action", "120ft", true, false, false, "AC 20 STR 26 DEX 10"),
                                                  (5, "Hold Monster", "action", "90ft", true, false, false, "WIS, not undead"),
                                                  (5, "Legend Lore", "10min", "self", false, false, true, ""),
                                                  (5, "Summon Dragon", "action", "60ft", true, false, true, ""),
                                                  (5, "Wall of Stone", "action", "120ft", true, false, false, ""),

                                                  (6, "Charm Monster", "action", "30ft", false, false, false, "WIS Save"),
                                                  (6, "Eyebite", "action", "self", true, false, false, "1min, WIS Save"),
                                              ),
  
  APPEARANCE                                : "A tall, bronze skinned woman with knowing, hazel eyes, a turned-up nose, a softly shaped jaw and small lips. She has toned arms, and a broad torso with chiseled abs, is bald, usually wears a custom-made jacket, has tattoos fully covering her lower legs, left hand and feet.",
  BACKSTORY_PERSONALITY                     : "After you escaped from a magical conflagration, you realized that though you were unharmed, you were not unchanged. You began to exhibit unusual abilities that you are just beginning to understand.",
  ALIGNMENT                                 : "Neutral Good",
  LANGUAGES                                 : "Common, Dwarvish, Elvish",
  EQUIPMENT                                 : "+3 Quarterstaff, two (2) daggers, spear, dungeoneer's pack (backpack, a crowbar, a hammer, 10 pitons, 10 torches, a tinderbox, 10 days' rations, waterskin, 50 feet of hempen rope on the side), navigator's tools (small spyglass, sextant, charts), arcane focus: crystal, belt pouch, set of common clothes, set of traveler's clothes, merchant's scale.",
  ATUNED_MAGICITEM1                         : "Amulet of the Planes",
  ATUNED_MAGICITEM2                         : "Ring of Shooting Stars",
  ATUNED_MAGICITEM3                         : "Robe of Scintillating Colors",

  COPPER                                    : 54,
  SILVER                                    : 63,
  ELECTRUM                                  : "",
  GOLD                                      : 7259,
  PLATINUM                                  : "",
)