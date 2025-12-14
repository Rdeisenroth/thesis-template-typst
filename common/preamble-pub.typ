#import "requirements.typ": *
#import "metadata.typ": *
#import "commands.typ": *
#import "styling.typ": *

#let init(doc, darkmode: false) = {
  if (sys.inputs.keys().any(k => k == "darkmode")) {
    let newDState = sys.inputs.at("darkmode") == "true"
    dState.update(newDState)
    darkmode = newDState
  } else {
    dState.update(darkmode)
  }
  // set text(lang: "de")
  codly(
    // fill: luma(240),
    fill: if darkmode { rgb("162b3a") } else { black.transparentize(90%) },
    // stroke: 1pt + black,
    stroke: none,
    header: none,
    header-cell-args: (align: center, fill: accent-color),
    header-transform: x => {
      set text(fill: white)
      text(size: 11pt, fa-code(solid: true))
      h(1fr)
      textsf(x)
      h(1fr)
      text(size: 11pt, fill: accent-color, fa-code(solid: true))
    },
    // inset: (x: 3pt),
    zebra-fill: none,
    number-align: center,
    // lang-fill: white,
    languages: (
      java: (
        name: [ Java],
        color: orange,
        icon: fa-java(),
      ),
      typst: (
        name: text(fill: white)[ Typst],
        color: rgb("#191c1a"),
        icon: box(baseline: .15em, radius: 3pt, clip: true, width: 1em, height: 1em, image(
          "../pictures/typst-favicon.png",
          width: 1em,
          height: 1em,
          fit: "contain",
        )),
      ),
    ),
    // lang-outset: (x: 0pt, y: 30pt),
    // lang-outset: (x: -30pt, y: 0pt),
    lang-format: (lang, icon, color) => {
      box(
        fill: color.transparentize(if darkmode { 50% } else { 80% }),
        stroke: color + 0.5pt,
        radius: 0.32em,
        inset: 0.32em,
        outset: (x: 0em, y: 0.32em),
        {
          icon
          strong(lang)
        },
      )
    },
    number-format: i => grid.cell(
      text(white, str(i)),
      fill: rgb("#4C4C4C"), /*inset: (x: 4pt)*/
    ),
  )

  show: make-glossary
  show: equate.with(sub-numbering: true, number-mode: "label")

  show: tudapub.with(
    title: title,
    title_german: subtitle,
    author: authors.map(x => x.name).join(", "),
    // to deactivate the sub logo text set logo_sub_content_text: none,
    logo_sub_content_text: department + parbreak() + research_group,
    reviewer_names: reviewer_names,

    accentcolor: "9c",

    abstract: [
      This is a template to write your thesis with the corporate design of #link("https://www.tu-darmstadt.de/")[TU Darmstadt].
      For instructions on how to set up this template see @sec_usage.
    ],

    bib: bibliography("refs.bib", full: true), //, style: "spie")

    logo_tuda: image("../logos/tuda_logo.svg"),

    // logo_institute: image("templates/tudapub/logos/iasLogo.jpeg"),
    // logo_institute_sizeing_type: "width",

    // Set the margins of the content pages.
    // The title page is not affected by this.
    // Some example margins are defined in 'common/props.typ':
    //  - tud_page_margin_small  // same as title page margin
    //  - tud_page_margin_big
    // E.g.   margin: tud_page_margin_small,
    // E.g.   margin: (
    //   top: 30mm,
    //   left: 31.5mm,
    //   right: 31.5mm,
    //   bottom: 56mm
    // ),


    //outline_table_of_contents_style: "adapted",
    //reduce_heading_space_when_first_on_page: false
    //figure_numbering_per_chapter: false

    // Which pages to insert
    // Pages can be disabled individually.
    show_pages: (
      title_page: true,
      outline_table_of_contents: true,
      // "Erklärung zur Abschlussarbeit"
      thesis_statement_pursuant: true,
    ),

    thesis_statement_pursuant_include_english_translation: false,
    // thesis_statement_pursuant_signature: image("assets/misc/dummy_signature.svg"),

    // pages after outline that will not be included in the outline
    additional_pages_after_outline_table_of_contents: [
      == List of Symbols
      - $t$ - time
      == List of Figures
    ],
  )

  let text_color = if darkmode {
    white
  } else {
    black
  }

  let background_color = if darkmode {
    // rgb(29, 31, 33)
    rgb("293133")
  } else {
    white
  }

  set line(stroke: text_color)
  set raw(theme: if darkmode { "halcyon.tmTheme" } else { auto })

  show: codly-init.with()

  set list(
    marker: level => context {
      let fontsize = text.size
      let size = calc.max(0.1pt, fontsize / 4 * calc.pow(0.8, level - 1))
      v(size)
      rect(width: size, height: size, stroke: none, fill: accent-color)
    },
    body-indent: 3mm,
    indent: 3mm,
  )

  show figure.caption: it => context [
    #text(accent-color)[#it.supplement~#it.counter.display()#it.separator]#it.body
  ]

  set enum(spacing: 1em, numbering: "1.", indent: 5pt)

  set page(
    fill: background_color,
  )

  set text(fill: text_color)
  doc
}
