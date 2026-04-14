#import "requirements.typ": *
#import "metadata.typ": *
#import "commands.typ": *
#import "styling.typ": *
#import "preamble-shared.typ": *

#let init(doc, darkmode: false, tudaexercise_options: (:)) = {
  if (sys.inputs.keys().any(k => k == "darkmode")) {
    let newDState = sys.inputs.at("darkmode") == "true"
    dState.update(newDState)
    darkmode = newDState
  } else {
    dState.update(darkmode)
  }

  setup-shared-styling(
    darkmode,
    rgb("#00549F"),
    list_marker_fill: rgb("#00549F"),
  )

  let text_color = shared-text-color(darkmode)

  let default_tudaexercise_options = (
    language: "eng",
    logo: image("../logos/tuda_logo.svg"),
    info: (
      title: title,
      subtitle: subtitle,
      author: authors.map(x => x.name),
      date: submission_date,
      term: none,
      sheet: none,
      group: none,
      tutor: none,
      lecturer: none,
    ),
    title-sub: title-sub.exercise(),
    design: (
      accentcolor: "9c",
      colorback: true,
      darkmode: darkmode,
    ),
    task-prefix: none,
    show-title: true,
    subtask: "plain",
  )

  show: tudaexercise.with(
    ..default_tudaexercise_options,
    ..tudaexercise_options,
  )

  codly(..shared-codly-options(darkmode, rgb("#00549F")))
  set raw(theme: if darkmode { "halcyon.tmTheme" } else { auto })
  show: codly-init.with()
  set circle(stroke: text_color)
  set ellipse(stroke: text_color)
  set table(stroke: text_color)

  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    if it.numbering != none {
      let num = counter(heading).display(it.numbering)
      tuda-section([#num #it.body])
    } else {
      tuda-section(it.body)
    }
  }
  show heading.where(level: 2): it => {
    if it.numbering != none {
      let num = counter(heading).display(it.numbering)
      tuda-subsection([#num #it.body])
    } else {
      tuda-subsection(it.body)
    }
  }

  doc
}
