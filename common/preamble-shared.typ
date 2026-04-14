#import "requirements.typ": *
#import "commands.typ": *
#import "styling.typ": *

#let shared-codly-options(darkmode, accent_fill) = (
  fill: if darkmode { rgb("162b3a") } else { black.transparentize(90%) },
  stroke: none,
  header: none,
  header-cell-args: (align: center, fill: accent_fill),
  header-transform: x => {
    set text(fill: white)
    text(size: 11pt, fa-code(solid: true))
    h(1fr)
    textsf(x)
    h(1fr)
    text(size: 11pt, fill: accent_fill, fa-code(solid: true))
  },
  zebra-fill: none,
  number-align: center,
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
    fill: rgb("#4C4C4C"),
  ),
  highlight-fill: color => if darkmode {
    color.darken(65%)
  } else {
    color.lighten(80%)
  },
)

#let shared-text-color(darkmode) = if darkmode { white } else { black }

#let shared-background-color(darkmode) = if darkmode { rgb("293133") } else { white }

#let setup-shared-styling(
  darkmode,
  accent_fill,
  list_marker_fill: none,
) = {
  if list_marker_fill == none {
    list_marker_fill = accent_fill
  }

  codly(..shared-codly-options(darkmode, accent_fill))
  set raw(theme: if darkmode { "halcyon.tmTheme" } else { auto })
  show: codly-init.with()

  show: make-glossary
  show: equate.with(sub-numbering: true, number-mode: "label")

  set list(
    marker: level => context {
      let fontsize = text.size
      let size = calc.max(0.1pt, fontsize / 4 * calc.pow(0.8, level - 1))
      v(size)
      rect(width: size, height: size, stroke: none, fill: list_marker_fill)
    },
    body-indent: 3mm,
    indent: 3mm,
  )

  set enum(spacing: 1em, numbering: "1.", indent: 5pt)
}

#let style-figure-captions(accent_fill) = {
  show figure.caption: it => context [
    #text(accent_fill)[#it.supplement~#it.counter.display()#it.separator]#it.body
  ]
}
