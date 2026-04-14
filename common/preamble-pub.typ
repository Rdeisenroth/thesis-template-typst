#import "requirements.typ": *
#import "metadata.typ": *
#import "commands.typ": *
#import "styling.typ": *
#import "preamble-shared.typ": *

#let init(doc, darkmode: false, tudapub_options: (:)) = {
  if (sys.inputs.keys().any(k => k == "darkmode")) {
    let newDState = sys.inputs.at("darkmode") == "true"
    dState.update(newDState)
    darkmode = newDState
  } else {
    dState.update(darkmode)
  }

  setup-shared-styling(darkmode, accent-color)

  let text_color = shared-text-color(darkmode)
  let background_color = shared-background-color(darkmode)
  let logo_sub_content = if darkmode {
    [
      #set text(weight: "regular", size: 9.96pt, fill: black)
      #department
      #parbreak()
      #research_group
    ]
  } else {
    department + parbreak() + research_group
  }

  // Apply early so title-page separators pick up dark-mode stroke color.
  set line(stroke: text_color)
  set page(fill: background_color)
  set text(fill: text_color)

  let default_tudapub_options = (
    title: title,
    title_height: 4.5em, // TODO: adjust title height. Default for shorter titles is 3.5em
    title_german: subtitle,
    author: authors.map(x => x.name).join(", "),
    // to deactivate the sub logo text set logo_sub_content_text: none,
    logo_sub_content_text: logo_sub_content,
    reviewer_names: reviewer_names,
    accentcolor: "9c",
    abstract: none,
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
    margin: tud_page_margin_small,
    date_of_submission: submission_date,
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

  show: tudapub.with(
    ..default_tudapub_options,
    ..tudapub_options,
  )

  codly(..shared-codly-options(darkmode, accent-color))
  set raw(theme: if darkmode { "halcyon.tmTheme" } else { auto })
  show: codly-init.with()
  // Re-apply after tudapub/codly transforms because they reset some draw defaults.
  set circle(stroke: text_color)
  set ellipse(stroke: text_color)
  set table(stroke: text_color)
  set line(stroke: text_color)

  style-figure-captions(accent-color)

  doc
}
