// dnd-character-sheet.i18n.typ
// 2025 by honze & nesges, CC-BY-NC-SA
//
// This is heavy work in progress.
// The code is very rough in some places. You have been warned! ;)

// --------------------------------------------------------------------
// cli parameters:
// --input language=de|en or cc of any other language file of i18n/cc.typ
// --input format=a4|us-letter or other typst supported paper size (a4 and us-letter are the only ones tested)
// --input pregen=empty|demo or name of any other pregen file of pregen/name.typ
// --input theme=standard or name of any other theme file of themes/name.typ

// #let language   = sys.inputs.at("lang",     default: "en")
#let language   = sys.inputs.at("lang",     default: "zh")
// #let pagesize   = sys.inputs.at("format",   default: "us-letter")
#let pagesize   = sys.inputs.at("format",   default: "a4")
// #let pregen     = sys.inputs.at("pregen",   default: "empty")
#let pregen     = sys.inputs.at("pregen",   default: "demo")
#let theme      = sys.inputs.at("theme",    default: "standard")

// --------------------------------------------------------------------
// import language file and pregen values file

#import "i18n/" + language + ".typ" as i18n
#import "pregen/" + pregen + ".typ" as pregen

// --------------------------------------------------------------------
// theme setup
// todo: move to a module

#let font         = "Source Sans Pro"
#let fontsize     = 9pt // can go smaller, but 9pt is the max
// todo: font size 10pt should be doable, but currently the armor class and spellslot boxes break at that size
#let pagemargin   = 5mm
#let borderradius = 3pt

// setup variables for markers
// caveat: combinations where empty and filled fit perfectly are rare
#let check_box(checked: false, color: black) = {
  h(0.1em)
  box(
    //stroke: 0.1pt,
    width: 0.6em,
    height: 0.6em,
    polygon(
      stroke: (0.75pt + color),
      fill: if checked {color} else {none}, // TODO: Check which color would be good for theming.
      (0%, 50%),
      (50%, 0%),
      (100%, 50%),
      (50%, 100%),
    )
  )
  h(0.1em)
}
#let diamond_filled = check_box(checked: true)
#let diamond_empty(color: black) = check_box(color: color)
#let radio_box(checked: false) = {
  box(
    circle(
      radius: 0.38em,
      stroke: 0.75pt,
      fill: if checked {black} else {none}, // TODO: Check which color would be good for theming.
    )
  )
}
#let circle_empty   = radio_box()
#let circle_filled  = radio_box(checked: true)
#let checkmark      = "✓"

// setup colors
#let text_color           = black
#let tablehead_text_color = luma(67%); // gray
#let background_color     = white
#let foreground_color     = white
#let line_color           = luma(67%) // gray
#let grid_color           = luma(90%) // light gray

// setup artwork
#let artwork_page1 = image("d20.svg")
#let artwork_page2 = none

// --------------------------------------------------------------------
// page & standards setup

// set page parameters
#set page(
  pagesize,
  margin: pagemargin,
  fill: background_color
)

// set text defaults
#set text(
  lang: language,
  font: font,
  size: fontsize,
  fill: text_color
)

// set a standard fill color to all boxes
// this opens up the possibility to set a different page fill color
// caveat: some boxes have to be set to none and not all forgeground elements are boxes
// so they have to set their fill themselves
#set box(
  fill:foreground_color
)

// --------------------------------------------------------------------

// Development of new content. Unused in production documents.
#let placeholder(name, width:auto, height:auto, show_size:false) = {
  box(
    stroke: 1pt,
    inset: 3pt,
    width: width,
    height: height,
    align(center)[
      #upper(name)
      #if show_size {layout(size => [#calc.round(size.width.mm()) mm x #calc.round(size.height.mm()) mm])}
    ]
  )
}

// A field to indicate user input of values.
#let input_field(name, height:auto, alignment:start, value:"") = {
  box(
//    stroke:0.1pt,
    width: 100%,
    height: height,
    fill: none,
    place((bottom + alignment), dy:1em + 3pt, str(value)) + place(
      (bottom + alignment),
      float:true,
      box(
        width: 100%,
        stroke: (top: 0.5pt + line_color),
        inset: (top: 2pt, bottom: 3pt),
        outset: (bottom: -1pt),
        upper(text(size: 0.7em, name))
      )
    )
  )
}

// A field to indicate user checking boxes.
#let checkbox_field(name, count:1, filled:0, height:auto, alignment:start) = {
  box(
    //stroke:0.1pt,
    width: 100%,
    height: height,
    fill: none,
    place(
      (bottom + alignment),
      float:true,
      [
        #text(size:1.3em)[#for _ in range(filled) [#diamond_filled ]]
        #text(size:1.3em)[#for _ in range(count - filled) [#diamond_empty() ]]
        #box(
          width: 100%,
          inset: (top: 0pt, bottom: 3pt),
          upper(text(size: 0.7em, name))
        )
      ]
    )
  )
}

// The basic information of a character.
#let character_info() = {
  box(
    stroke: 1pt,
    width: 100%,
    height: 100%,
    inset: (top: 10pt, left: 3pt, right: 3pt, bottom:1pt), // 10pt at top is needed so that every line feels equally spaced.
    radius: borderradius,

    grid(
      columns: 2,
      rows: 1fr,
      column-gutter: 5pt,
      row-gutter: 0pt,
      grid.cell(
        colspan: 2,
        input_field(i18n.label.CHARACTERNAME, value:pregen.input.CHARACTERNAME),
      ),
      input_field(i18n.label.BACKGROUND, value:pregen.input.BACKGROUND),
      input_field(i18n.label.CLASS, value:pregen.input.CLASS),
      input_field(i18n.label.SPECIES, value:pregen.input.SPECIES),
      input_field(i18n.label.SUBCLASS, value:pregen.input.SUBCLASS),
    )
  )
}

// An ellipse for level and xp.
#let level_xp() = {
  ellipse(
    stroke: 1pt,
    width: 100%,
    height: 100%,
    // This overlaps it like in the original, but takes away importance from "character name".
    //outset: (top: -3pt, bottom: -3pt, left: 10pt, right:-15pt),
    //inset: (top: 0pt, bottom: 0pt, left: -10pt, right:15pt),
    outset: (top: 0pt, bottom: 0pt, left: -5pt, right: -5pt),
    inset: (top: 0pt, bottom: 0pt, left: 5pt, right: 5pt),
    fill: foreground_color,
    grid(
      rows:1fr,
      input_field(i18n.label.LEVEL, alignment:center, value:pregen.input.LEVEL),
      input_field(i18n.label.XP, alignment:center, value:pregen.input.XP),
    )
  )
}

// A shield for armor class and shield.
#let armor_class() = {
  box(
    height: 100%,
    width: 100%,
    inset: 5pt,
    fill: none,
    [
      #place(
        top,
        polygon(
          stroke: 1pt,
          fill: foreground_color,
          (0%, -5pt),
          (100%, -5pt),
          (100%, 70%),
          (50%, 100%+5pt),
          (0%, 70%),
        )
      )

      // TODO: this is horrible... :-D
      #upper(align(center,text(weight:"semibold", size: 0.9em, i18n.label.AC)))
      // #place((top + center), dy:2.75em, str(pregen.input.AC))
      #place((top + center), dy:1.5em, str(pregen.input.AC))
      #upper(align(center,text(size: 0.9em, baseline: 4pt, i18n.label.SHIELD)))
      #if pregen.input.SHIELD [
        #upper(align(center,text(size: 1.3em, baseline: -5pt, [#diamond_filled])))
      ] else [
        #upper(align(center,text(size: 1.3em, baseline: -5pt, [#diamond_empty()])))
      ]
    ]
  )
}

// A box to hold hit points, hit dice, and death saves.
#let hit_points_etc() = {
  box(
    width: 100%,
    height: 100%,
    stroke: 1pt,
    radius: borderradius,
    table(
      columns: (2fr, 2fr, 2fr, 3fr),
      inset: (left: 3pt, right:3pt, top:4pt, bottom:2pt),
      rows:(1fr, 35%, 35%), // TN: changed 2nd and 3rd row from 40% to 35%
      stroke: 0pt,
      table.vline(x: 1, stroke: 1pt),
      table.vline(x: 2, stroke: 1pt),
      table.vline(x: 3, stroke: 1pt),
      table.cell(
        colspan: 2,
        upper(align(center,text(weight:"semibold", size: 0.9em, i18n.label.HITPOINTS))),
      ),
      upper(align(center,text(weight:"semibold", size: 0.9em, i18n.label.HITDICE))),
      upper(align(center,text(weight:"semibold", size: 0.9em, i18n.label.DEATHSAVES))),
      [],
      input_field(i18n.label.TEMPORARY, value: pregen.input.TEMPORARY),
      input_field(i18n.label.SPENT, value: pregen.input.SPENT),
      checkbox_field(i18n.label.SUCCESSES, count: 3, filled:pregen.input.SUCCESSES ,alignment:center),
      input_field(i18n.label.CURRENT, value: pregen.input.CURRENT),
      input_field(i18n.label.MAX, value: pregen.input.MAX_HITPOINTS),
      input_field(i18n.label.MAX, value: pregen.input.MAX_HITDICE),
      checkbox_field(i18n.label.FAILURES, count: 3, filled:pregen.input.FAILURES, alignment:center),
    )
  )
}

// A bar to group elements horizontally.
#let header_bar() = {
  box(
    width: 100%,
    height: 2.5cm,
    fill:none,
    grid(
      columns: (4fr, 1fr, 1fr, 4fr),
      character_info(),
      level_xp(),
      armor_class(),
      hit_points_etc(),
    )
  )
}

// A horizontal divider to be replaced by artwork.
// TODO: Replace by a divider for the species, a D20, and a divider for the class.
#let decorations_n_dividers() = {
  box(
    //stroke: 1pt + luma(99%),
    inset: (top: 3pt, bottom: 3pt, left: 3pt, right: 3pt),
    width: 100%,
    radius: borderradius,
    fill: none,
    align(center)[
      //#upper(text(/*fill:luma(100%),*/ weight: "bold")["Decorations & Dividers"])
      #v // todo: this spacing could be removed to gain that space in lower boxes
      #place(horizon+center, dy: -5pt)[
        #artwork_page1
      ]
    ]
  )
}

// A rectangular divider to be replaced by artwork.
#let decorations_n_dividers_artwork() = {
  box(
    //stroke: 1pt + luma(99%),
    inset: (top: 0pt, bottom: 0pt, left: 0pt, right: 0pt),
    outset: 0pt,
    width: 100%,
    height: 103%,
    radius: borderradius,
    fill: none,
    //fill: luma(90%),

    align(center + horizon)[
      #artwork_page2
      //#image("dnd3.jpg")
      //#upper(text(fill:luma(100%), weight: "bold")[Decorations & Dividers Artwork])
      //#place(layout(size => text(fill:line_color, size: 2mm)[#calc.round(size.width.mm()) mm x #calc.round(size.height.mm()) mm]))
    ]
  )
}
// A rectangle for a single stat.
#let single_stat_box(name, value: "") = {
  box(
    stroke: 1pt,
    width: 100%,
    height: 1.4cm,
    radius: borderradius,
    inset: (top: 6pt, bottom: 6pt, left: 3pt, right: 3pt),
    place((top + center), dy:1.6em, str(value)) +
    align(center, upper(text(weight:"semibold", size: 0.9em, name)))
  )
}

// A general box for providing space for manual notes.
#let content_box(name, content, width:auto, height:auto, checkered:false) = {
  let box_pattern = if checkered {
    tiling(size: (2mm, 2mm))[
    #place(line(start: (0%, 0%), end: (0%, 100%), stroke: (0.1pt + grid_color)))
    #place(line(start: (0%, 0%), end: (100%, 0%), stroke: (0.1pt + grid_color)))]
  } else {
    none
  }
  box(
    radius: borderradius,
    // the surrounding box is to apply the standard box fill
    box(
      stroke: 1pt,
      radius: borderradius,
      width: width,
      height: height,
      fill: box_pattern,
      grid(
        columns: 1,
        rows:(auto, 1fr),
        box(
          stroke: 1pt,
          radius: (top-left: borderradius, top-right:borderradius),
          inset: (top: 6pt, bottom:6pt),
          width: 100%,
          align(center, upper(text(weight:"semibold", name)))
        ),
        content
      )
    )
  )
}

#let multi_stat_box(name, abilities: ((name:"", modifier:"")), score: "", modifier: "", save: "", proficient: false) = {
  box(
    stroke: 1pt,
    width: 100%,
    inset: (top: 6pt, bottom: 6pt, left: 3pt, right: 3pt),
    radius: 10pt,
    [
      #align(center, upper(text(weight:"semibold", name)))

      // score and modifier
      #box(width: 100%, height:1.4cm)[
        #place(right, dx: -10pt, dy: 7pt, rect(radius: borderradius, height: 22pt, width: 40pt, stroke: 1pt))
        #place(right, dx: -13pt, dy: 15pt, box(width:25pt, align(center, str(score))))

        #place(left, dx:  10pt, dy: -5pt, circle(radius: 18pt, stroke: 1.5pt, fill: foreground_color))
        #place(left, dx: 10pt, dy: 11pt, box(width:36pt, fill:none, align(center, str(modifier))))

        #align(center+bottom, text(size: 0.7em, upper[#i18n.label.MODIFIER_SCORE]))
      ]

      // Corner case for constitution: No abilites -> Remove bottom border of Saving Throw
      // TODO: Remove this by reframing the problem.
      #let bottomstroke = if abilities.len() == 0 { 0pt } else { 1pt }

      #box(
        stroke: (top: 1pt, bottom: bottomstroke),
        width: 100%,
        fill:none,
        outset: (left:3pt, right:3pt, top:6pt, bottom:4pt),
        text(size: 0.8em, [#if proficient [#circle_filled] else [#circle_empty]] + [ #box(width: 2.25em, height: 0.8em - 0.5pt, outset:0.5pt, stroke: (bottom: 0.5pt + line_color), align(center, str(save))) #strong[#i18n.label.SAVINGTHROW]])
      )

      #for ability in abilities [
        #let name = ability.at("name", default: "");
        #let modifier = ability.at("modifier", default: "");
        #let proficient = ability.at("proficient", default: false);

        #text(size: 0.8em, [#if proficient [#circle_filled] else [#circle_empty]] + [ #box(width: 2.25em, height: 0.8em - 0.5pt, outset:0.5pt, stroke: (bottom: 0.5pt + line_color), align(center, str(modifier))) #name ])
        #v(0em) // Explicit distance, rather than assume default.
      ]
    ]
  )
}

// A box for proficiency bonus.
#let proficiency_bonus() = {
  box(
    stroke: 1pt,
    width: 100%,
    inset: (top: 6pt, bottom: 6pt, left: 3pt, right: 3pt),
    radius: (top-left: 5pt, top-right: 5pt, bottom-left: 5pt, bottom-right: 5pt),
    height: 2.25cm,
    [
      #align(center, upper(text(weight: "semibold",[#i18n.label.PROFICIENCYBONUS])))
      #align(horizon + center, square(size: 22pt))
    ]
    + place((bottom + center), dy:-15pt, str(pregen.input.PROFICIENCYBONUS))
  )
}

// A box for heroic inspiration.
#let heroic_inspiration() = {
  box(
    stroke: 1pt,
    width: 100%,
    inset: (top: 6pt, bottom: 6pt, left: 3pt, right: 3pt),
    radius: (top-left: 5pt, top-right: 5pt, bottom-left: 30pt, bottom-right: 30pt),
    height: 2.25cm-1.5pt, // Manual adjustment to make bottom in line with charisma.
    [
      #align(center, upper(text(weight: "semibold",[#i18n.label.HEROICINSPIRATION])))
      #align(horizon + center, square(size: 11pt, if pregen.input.HEROICINSPIRATION { strong(checkmark) } ))

    ]
  )
}

// A two column layout for the abilities, etc.
#let abilities_etc() = {
  grid(
    columns: 2,
    gutter: 10pt,
    grid(
      columns: 1,
      rows: (auto, auto, auto, auto, auto), // TODO: The last one should be 1fr, but can't as parent is auto.
      gutter: 10pt,
      proficiency_bonus(),

      multi_stat_box(i18n.label.STRENGTH,
        score: pregen.input.STRENGTH_SCORE,
        modifier: pregen.input.STRENGTH_MODIFIER,
        save: pregen.input.STRENGTH_SAVE,
        proficient: pregen.input.STRENGTH_PROFICIENCY,
        abilities: (
          (name: i18n.label.ATHLETICS, modifier: pregen.input.ATHLETICS_MODIFIER, proficient: pregen.input.ATHLETICS_PROFICIENCY),
        )
      ),

      multi_stat_box(i18n.label.DEXTERITY,
        score: pregen.input.DEXTERITY_SCORE,
        modifier: pregen.input.DEXTERITY_MODIFIER,
        save: pregen.input.DEXTERITY_SAVE,
        proficient: pregen.input.DEXTERITY_PROFICIENCY,
        abilities: (
          (name: i18n.label.ACROBATICS, modifier: pregen.input.ACROBATICS_MODIFIER, proficient: pregen.input.ACROBATICS_PROFICIENCY),
          (name: i18n.label.SLEIGHTOFHAND, modifier: pregen.input.SLEIGHTOFHAND_MODIFIER, proficient: pregen.input.SLEIGHTOFHAND_PROFICIENCY),
          (name: i18n.label.STEALTH, modifier: pregen.input.STEALTH_MODIFIER, proficient: pregen.input.STEALTH_PROFICIENCY)
        )
      ),

      multi_stat_box(i18n.label.CONSTITUTION,
        score: pregen.input.CONSTITUTION_SCORE,
        modifier: pregen.input.CONSTITUTION_MODIFIER,
        save: pregen.input.CONSTITUTION_SAVE,
        proficient: pregen.input.CONSTITITION_PROFICIENCY,
        abilities: ()
      ),

      heroic_inspiration(),
    ),
    grid(
      columns: 1,
      gutter: 10pt,

      multi_stat_box(i18n.label.INTELLIGENCE,
        score: pregen.input.INTELLIGENCE_SCORE,
        modifier: pregen.input.INTELLIGENCE_MODIFIER,
        save: pregen.input.INTELLIGENCE_SAVE,
        proficient: pregen.input.INTELLIGENCE_PROFICIENCY,
        abilities: (
          (name: i18n.label.ARCANA, modifier: pregen.input.ARCANA_MODIFIER, proficient: pregen.input.ARCANA_PROFICIENCY),
          (name: i18n.label.HISTORY, modifier: pregen.input.HISTORY_MODIFIER, proficient: pregen.input.HISTORY_PROFICIENCY),
          (name: i18n.label.INVESTIGATION, modifier: pregen.input.INVESTIGATION_MODIFIER, proficient: pregen.input.INVESTIGATION_PROFICIENCY),
          (name: i18n.label.NATURE, modifier: pregen.input.NATURE_MODIFIER, proficient: pregen.input.NATURE_PROFICIENCY),
          (name: i18n.label.RELIGION, modifier: pregen.input.RELIGION_MODIFIER, proficient: pregen.input.RELIGION_PROFICIENCY),
        )
      ),

      multi_stat_box(i18n.label.WISDOM,
        score: pregen.input.WISDOM_SCORE,
        modifier: pregen.input.WISDOM_MODIFIER,
        save: pregen.input.WISDOM_SAVE,
        proficient: pregen.input.WISDOM_PROFICIENCY,
        abilities: (
          (name: i18n.label.ANIMALHANDLING, modifier: pregen.input.ANIMALHANDLING_MODIFIER, proficient: pregen.input.ANIMALHANDLING_PROFICIENCY),
          (name: i18n.label.INSIGHT, modifier: pregen.input.INSIGHT_MODIFIER, proficient: pregen.input.INSIGHT_PROFICIENCY),
          (name: i18n.label.MEDICINE, modifier: pregen.input.MEDICINE_MODIFIER, proficient: pregen.input.MEDICINE_PROFICIENCY),
          (name: i18n.label.PERCEPTION, modifier: pregen.input.PERCEPTION_MODIFIER, proficient: pregen.input.PERCEPTION_PROFICIENCY),
          (name: i18n.label.SURVIVAL, modifier: pregen.input.SURVIVAL_MODIFIER, proficient: pregen.input.SURVIVAL_PROFICIENCY),
        )
      ),

      multi_stat_box(i18n.label.CHARISMA,
        score: pregen.input.CHARISMA_SCORE,
        modifier: pregen.input.CHARISMA_MODIFIER,
        save: pregen.input.CHARISMA_SAVE,
        proficient: pregen.input.CHARISMA_PROFICIENCY,
        abilities: (
          (name: i18n.label.DECEPTION, modifier: pregen.input.DECEPTION_MODIFIER, proficient: pregen.input.DECEPTION_PROFICIENCY),
          (name: i18n.label.INTIMIDATION, modifier: pregen.input.INTIMIDATION_MODIFIER, proficient: pregen.input.INTIMIDATION_PROFICIENCY),
          (name: i18n.label.PERFORMANCE, modifier: pregen.input.PERFORMANCE_MODIFIER, proficient: pregen.input.PERFORMANCE_PROFICIENCY),
          (name: i18n.label.PERSUASION, modifier: pregen.input.PERSUASION_MODIFIER, proficient: pregen.input.PERSUASION_PROFICIENCY),
        )
      ),

    )
  )
}

#let first_page_left_part() = {
  grid(
    columns: 1,
    rows: (auto, 1fr),
    row-gutter: 10pt,
    abilities_etc(),
    content_box(i18n.label.EQUIPMENTTRAINING_PROFICIENCIES, width:100%, height:100%, checkered:true)[
      #table(
        columns: 100%,
        rows: (auto, 1fr, 1fr),
        stroke: none,
        inset: (top: 6pt, bottom: 6pt, left: 6pt, right: 6pt),
        table.cell(
          stroke: 1pt,
          fill:background_color,
          grid(
            columns: (1fr, 1fr, 1fr),
            column-gutter: 5pt,
            row-gutter: 3pt,
            upper([#i18n.label.ARMOR]),
            [ #if pregen.input.ARMOR_LIGHT [#diamond_filled] else [#diamond_empty()] #i18n.label.ARMOR_LIGHT],
            [ #if pregen.input.ARMOR_HEAVY [#diamond_filled] else [#diamond_empty()] #i18n.label.ARMOR_HEAVY],
            upper([#i18n.label.TRAINING]),
            [ #if pregen.input.ARMOR_MEDIUM [#diamond_filled] else [#diamond_empty()] #i18n.label.ARMOR_MEDIUM],
            [ #if pregen.input.SHIELDS [#diamond_filled] else [#diamond_empty()] #i18n.label.SHIELDS],
          ),
      ),
        table.hline(),
        [#upper(i18n.label.WEAPONS)] + " " + pregen.input.WEAPONS,
        table.hline(),
        [#upper(i18n.label.TOOLS)] + " " + pregen.input.TOOLS,
      )
    ],
  )
}

#let first_page_right_part() = {
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    rows:(auto, auto, auto, 1fr),
    gutter: 10pt,
    single_stat_box(i18n.label.INITIATIVE, value: pregen.input.INITIATIVE),
    single_stat_box(i18n.label.SPEED, value: pregen.input.SPEED),
    single_stat_box(i18n.label.SIZE, value: pregen.input.SIZE),
    single_stat_box(i18n.label.PASSIVEPERCEPTION, value: pregen.input.PASSIVEPERCEPTION),
    grid.cell(
      colspan: 4,
      content_box(i18n.label.WEAPONS_DAMAGE_CANTRIPS, width:100%, height:5cm)[
        #set table(
        stroke: (x, y) => (
          left: if x > 0 { 0.1pt + line_color},
          top: if y > 0 { 0.1pt + line_color},
          )
        )
        #show table.cell.where(y: 0): content => (
          text(fill: tablehead_text_color, size:0.8em)[#content]
        )
        #table(
          columns: (1fr, 1fr, 1fr),
          rows: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
            [#i18n.label.NAME],
            [#i18n.label.ATTACKBONUS_DC_DAMAGE_TYPE],
            [#i18n.label.NOTES],

            ..for line in range(pregen.input.ATTACKSLIST.len()) {(
                [#box(clip:true, outset:2pt, pregen.input.ATTACKSLIST.at(line).at(0))], [#box(clip:true, outset:2pt, pregen.input.ATTACKSLIST.at(line).at(1))], [#box(clip:true, outset:2pt, pregen.input.ATTACKSLIST.at(line).at(2))],
            )},
            ..for line in range(6-pregen.input.ATTACKSLIST.len()) {(
                [],[],[]
            )}
        )

      ]
    ),
    grid.cell(
      colspan: 4,
      content_box(i18n.label.CLASSFEATURES, width:100%, height:8cm, checkered:true)[
        #table(
          columns: (1fr, 1fr),
          stroke: 0pt,
          table.vline(x: 1, stroke: 0.5pt),
          box(
            height: 100%,
            clip: true,
            fill:none,
            pregen.input.CLASSFEATURES1
          ),
          box(
            height: 100%,
            clip: true,
            fill:none,
            pregen.input.CLASSFEATURES2
          ),
        )
      ]
    ),
    grid.cell(
      colspan: 2,
      content_box(i18n.label.SPECIESTRAITS, width:100%, height:100%, checkered:true)[#box(
            height: 100%,
            clip: true,
            inset: 5pt,
            fill:none,
            pregen.input.SPECIESTRAITS
        )]
    ),
    grid.cell(
      colspan: 2,
      content_box(i18n.label.FEATS, width:100%, height:100%, checkered:true)[#box(
            height: 100%,
            clip: true,
            inset: 5pt,
            fill:none,
            pregen.input.FEATS
        )]
    ),
  )
}

// --------------------------------------------------------------------
// FIRST PAGE
// --------------------------------------------------------------------

#grid(

  columns: (100fr, 205fr), // TODO: Find a smarter way to distribute the content evenly.
  rows:(auto, auto, 1fr),
  gutter: 10pt,
  grid.cell(
    colspan: 2,
    header_bar(),
  ),
  grid.cell(
    colspan: 2,
    decorations_n_dividers(),
  ),
  first_page_left_part(),
  first_page_right_part(),
)

#pagebreak()


// --------------------------------------------------------------------
// SECOND PAGE
// --------------------------------------------------------------------

#let legal() = {
  // TODO: Check legal stuff if it is OK to use this license.
  // par(justify: true, text(size: 0.75em)[ #i18n.label.DISCLAIMER #h(1fr) #i18n.label.COPYRIGHT])
  par(justify: true, text(size: 0.75em)[ #i18n.label.DISCLAIMER \ #i18n.label.COPYRIGHT])
}

#let spellcasting() = {
  box(
    height: 100%,
    width: 4cm,
    stroke: 1pt,
    radius: borderradius,
    [
    #set table(
      stroke: (x, y) => (
        top: if y in (1,2) { 0.5pt},
        bottom: if y in (1,2) { 0.5pt},
        left: if y in (1,2) { 0.5pt},
        right: if y in (1,2,3) and x == 0 { 0.5pt},
      )
    )

    #table(
      columns: (1cm, 1fr),
      rows: (1fr, 1fr, 1fr, 1fr),
      align: horizon,
      table.cell(
        colspan: 2,
        box(
          inset:(top:0pt,bottom:-5pt),
          input_field(i18n.label.SPELLCASTINGABILITY, height:100%, value: pregen.input.SPELLCASTINGABILITY)
        )),
        [#align(center, str(pregen.input.SPELLCASTINGMODIFIER))],upper()[#i18n.label.SPELLCASTINGMODIFIER],
        [#align(center, str(pregen.input.SPELLSAVEDC))],upper()[#i18n.label.SPELLSAVEDC],
        [#align(center, str(pregen.input.SPELLATTACKBONUS))],upper()[#i18n.label.SPELLATTACKBONUS],
      )
      ]
    )
}

#let spellslot_total(total) = {
  box(
    width: 2.5em,
    stroke: (bottom: 0.5pt + line_color),
//    height: 70%,
    outset: (bottom: 1pt),
    align(center, [#total]) )
}

#let spellslot_counter(max:4, expended:0) = {
  text(size:1.5em)[#for _ in range(expended) [#diamond_filled]]+text(size:1.5em)[#for _ in range(max - expended) [#diamond_empty()]]
}

#let second_page_left_part() = {
  grid(
    columns: 2,
    rows: (1.2cm, 2.5cm, 1fr),
    gutter: 10pt,
    grid.cell(
      rowspan: 2,
      spellcasting(),
    ),
    decorations_n_dividers_artwork(),
    content_box(i18n.label.SPELLSLOTS, width:100%, height:100%)[
      #set text(size:0.8em)
      #pad(
        left: 3pt,
        bottom:6pt,
      grid(
        columns:(8fr, 8fr, 13fr, 8fr, 8fr, 13fr, 8fr, 8fr, 11fr),
        rows:(1fr, 1fr, 1fr, 1fr),
        align: bottom,
        //stroke: 0.5pt,
        [],
        [#i18n.label.TOTAL],
        [#i18n.label.EXPENDED],
        [],
        [#i18n.label.TOTAL],
        [#i18n.label.EXPENDED],
        [],
        [#i18n.label.TOTAL],
        [#i18n.label.EXPENDED],

        // level 1
        [#i18n.label.SPELL_LEVEL1],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL1),
        spellslot_counter(max: 4, expended: pregen.input.SPELLSLOTS_LEVEL1_EXPENDED),

        // level 4
        [#i18n.label.SPELL_LEVEL4],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL4),
        spellslot_counter(max: 3, expended: pregen.input.SPELLSLOTS_LEVEL4_EXPENDED),

        // level 7
        [#i18n.label.SPELL_LEVEL7],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL7),
        spellslot_counter(max: 2, expended: pregen.input.SPELLSLOTS_LEVEL7_EXPENDED),

        // level 2
        [#i18n.label.SPELL_LEVEL2],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL2),
        spellslot_counter(max: 3, expended: pregen.input.SPELLSLOTS_LEVEL2_EXPENDED),

        // level 5
        [#i18n.label.SPELL_LEVEL5],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL5),
        spellslot_counter(max: 3, expended: pregen.input.SPELLSLOTS_LEVEL5_EXPENDED),

        // level 8
        [#i18n.label.SPELL_LEVEL8],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL8),
        spellslot_counter(max: 1, expended: pregen.input.SPELLSLOTS_LEVEL8_EXPENDED),

        // level 3
        [#i18n.label.SPELL_LEVEL3],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL3),
        spellslot_counter(max: 3, expended: pregen.input.SPELLSLOTS_LEVEL3_EXPENDED),

        // level 6
        [#i18n.label.SPELL_LEVEL6],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL6),
        spellslot_counter(max: 2, expended: pregen.input.SPELLSLOTS_LEVEL6_EXPENDED),

        // level 9
        [#i18n.label.SPELL_LEVEL9],
        spellslot_total(pregen.input.SPELLSLOTS_LEVEL9),
        spellslot_counter(max: 1, expended: pregen.input.SPELLSLOTS_LEVEL9_EXPENDED),
      )
      )
    ],
    grid.cell(
      colspan: 2,
      content_box(i18n.label.CANTRIPS_PREPAREDSPELLS, width:100%, height:100%)[
        #set table(
          stroke: (x, y) => (
            left: if x > 0 { 0.1pt + line_color},
            top: if y > 0 { 0.1pt + line_color},
          )
        )
        #show table.cell.where(y: 0): content => (
          text(fill: tablehead_text_color, size:0.8em)[#content]
        )
        #table(
          columns: (6%, 30%, 11%, 11%, 19%, 1fr),
          rows: (auto, 1fr),
          [#i18n.label.SPELL_LEVEL],
          [#i18n.label.NAME],
          [#i18n.label.CASTINGTIME],
          [#i18n.label.RANGE],
          [#i18n.label.CONCENTRATION_RITUAL_REQUIREDMATERIAL],
          [#i18n.label.NOTES],

          ..for line in range(pregen.input.SPELLLIST.len()) {
            (
            [#pregen.input.SPELLLIST.at(line).at(0)], [#pregen.input.SPELLLIST.at(line).at(1)],[#pregen.input.SPELLLIST.at(line).at(2)],[#pregen.input.SPELLLIST.at(line).at(3)],
            text(spacing: 400%, size: 1.1em)[
              #if pregen.input.SPELLLIST.at(line).at(4) { [#diamond_filled] } else { [#diamond_empty()] }#i18n.label.CONCENTRATION
              #if pregen.input.SPELLLIST.at(line).at(5) { [#diamond_filled] } else { [#diamond_empty()] }#i18n.label.RITUAL
              #if pregen.input.SPELLLIST.at(line).at(6) { [#diamond_filled] } else { [#diamond_empty()] }#i18n.label.MATERIAL
            ],
            [#pregen.input.SPELLLIST.at(line).at(7)],
            )
          },

          ..for _ in range(30-pregen.input.SPELLLIST.len()) {(
              [],[],[],[],
              text(fill: line_color, spacing: 400%, size: 1.1em)[
                #diamond_empty(color: line_color)#i18n.label.CONCENTRATION
                #diamond_empty(color: line_color)#i18n.label.RITUAL
                #diamond_empty(color: line_color)#i18n.label.MATERIAL

              ], // reduced the size a little to allow bigger font sizes
            [],
          )}

        )
      ],
    ),
  )
}

#let second_page_right_part() = {
  grid(
    columns:1,
    rows: (3.5cm, 7cm, 2cm, 1fr, 2.5cm, auto),
    gutter: 10pt,
    content_box(i18n.label.APPEARANCE, width:100%, height:100%, checkered:true)[#box(clip:true, inset:5pt, fill:none, pregen.input.APPEARANCE)],
    content_box(i18n.label.BACKSTORY_PERSONALITY, width:100%, height:100%, checkered:true)[
      #grid(
        columns: 1,
        rows:(1fr, auto),
        [#box(clip:true, inset:5pt, fill:none, pregen.input.BACKSTORY_PERSONALITY)],
        box(
          inset: (top:6pt, left: 6pt, right:6pt),
          stroke: (left:1pt, right:1pt, bottom: 1pt,),
          radius: (bottom:borderradius),
          input_field(i18n.label.ALIGNMENT, value: pregen.input.ALIGNMENT)
        )
      )
    ],
    content_box(i18n.label.LANGUAGES, width: 100%, height: 100%, checkered:true)[#box(clip:true, inset:5pt, fill:none, pregen.input.LANGUAGES)],
    content_box(i18n.label.EQUIPMENT, width: 100%, height: 100%, checkered:true)[
      #grid(
        columns: 1,
        rows:(1fr, auto),
        [#box(clip:true, inset:5pt, fill:none, pregen.input.EQUIPMENT)],
        pad(
          1pt,
        table(
          columns: 1fr,
          rows: 4,
          stroke: none,
          fill: foreground_color,
          upper(text(size: 0.7em, [#i18n.label.MAGICITEMATTUNEMENT])),
          [#diamond_empty() #pregen.input.ATUNED_MAGICITEM1],
          table.hline(stroke: 0.5pt + line_color),
          [#diamond_empty() #pregen.input.ATUNED_MAGICITEM2],
          table.hline(stroke: 0.5pt + line_color),
          [#diamond_empty() #pregen.input.ATUNED_MAGICITEM3],
        ))
      )
    ],
    content_box(i18n.label.COINS, width: 100%, height: 100%)[
       #set table(
          stroke: (x, y) => (
            top: if y == 1 { 0.5pt},
            bottom: if y == 1 { 0.5pt},
            left: if y == 1 { 0.5pt},
            right: if y == 1 { 0.5pt},
            )
          )
          #show table.cell.where(y: 0): content => (
            text(size:0.8em, content)
          )

      #pad(
        left:10pt,
        right:10pt,
        top:5pt,
      table(
        columns: (1fr, 1fr, 1fr, 1fr, 1fr ),
        rows: (auto, 0.5cm),
        column-gutter: 10pt,
        row-gutter: 0pt,
        align: center,
        [#i18n.label.COPPER], [#i18n.label.SILVER], [#i18n.label.ELECTRUM], [#i18n.label.GOLD], [#i18n.label.PLATINUM],
        [#pregen.input.COPPER], [#pregen.input.SILVER], [#pregen.input.ELECTRUM], [#pregen.input.GOLD], [#pregen.input.PLATINUM],
      )
    )
    ],
    legal()
  )
}

// The second page.
#grid(
  columns: (2fr, 1fr),
  gutter: 10pt,
  second_page_left_part(),
  second_page_right_part(),
)
