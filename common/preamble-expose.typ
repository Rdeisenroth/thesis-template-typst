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
    language: "en",
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
    info-layout: info-layout.exercise(),
    design: (
      accentcolor: "9c",
      colorback: true,
      darkmode: darkmode,
    ),
    task-prefix: none,
    task-separator: ("", ""),
    headline: "title",
    show-title: true,
    subtask: "ruled",
  )

  show: tudaexercise.with(
    ..default_tudaexercise_options,
    ..tudaexercise_options,
  )

  set heading(numbering: "1.1")

  codly(..shared-codly-options(darkmode, rgb("#00549F")))
  set raw(theme: if darkmode { "halcyon.tmTheme" } else { auto })
  show: codly-init.with()
  set circle(stroke: text_color)
  set ellipse(stroke: text_color)
  set table(stroke: text_color)

  doc
}
