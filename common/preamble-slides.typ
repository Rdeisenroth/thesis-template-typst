#import "requirements.typ": *
#import "metadata.typ": *
#import "commands.typ": *
#import "styling.typ": *

#let handout = sys.inputs.keys().any(k => k == "handout") and sys.inputs.at("handout") == "true"
#let init(doc, darkmode: false) = {
  if (sys.inputs.keys().any(k => k == "darkmode")) {
    let newDState = sys.inputs.at("darkmode") == "true"
    dState.update(newDState)
    darkmode = newDState
  } else {
    dState.update(darkmode)
  }
  set text(lang: "de")
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

  let header = self => pad(left: margin.left, right: margin.right, align(top)[
    #if self.store.enable-header {
      v(0.39in)
      let headerstr = ()
      headerstr.push(self.info.short-title)
      if (not self.store.is-section-slide) {
        headerstr.push(utils.display-current-short-heading(level: 1))
      }
      // let curhd = utils.display-current-short-heading(level: 1)
      // headerstr.push(curhd)
      // headerstr.push(str(self.slide-level))
      header-font(upper(headerstr.join(" / ")))
    }
    #place(top + right, dx: 0.34in, dy: 0.2in)[#block(height: 0.99in, self.info.logo)]
  ])

  let new-section-slide(body) = touying-slide-wrapper(self => {
    let body = {
      grid(
        columns: 100%,
        rows: (
          4.32in - margin.top,
          1.18in,
          1.18in,
        ),
        gutter: (0in, 0.05in),
        grid.cell([]),
        grid.cell(align: bottom, slide-title-font(upper(utils.display-current-heading(level: 1)))),
        grid.cell(align: top, subtitle-font([]))
      )
    }
    self.store.is-section-slide = true
    touying-slide(self: self, body)
    self.store.is-section-slide = false
  })

  show: not-tudabeamer-2023-theme.with(
    config-info(
      title: {
        title
        speaker-note[
          - Authors:
            - Andreas Brodner
            - Ruben Deisenroth
          - Topic: #title #subtitle
          - Gruppe: FB 20 - Computer Science D120
          - Gleich kommt Inhaltsverzeichnis(Was euch erwartet)
        ]
      },
      short-title: [Typst Workshop],
      subtitle: subtitle,
      author: authors.map(x => x.name).join(", "),
      short-author: authors.map(x => x.shortname).join(", "),
      date: datetime.today(),
      department: [FB 20 -- Computer Science],
      institute: [Technische Universität Darmstadt],
      // logo: text(fallback: true, size: 0.75in, emoji.cat.face),
      logo: image(if darkmode { "../logos/tuda_logo-dark.svg" } else { "../logos/tuda_logo.svg" }, height: 100%),
    ),
    config-common(
      show-notes-on-second-screen: if handout { none } else { right },
      handout: handout,
      new-section-slide-fn: new-section-slide,
    ),
    config-page(
      header: header,
    ),
    config-store(
      enable-header: true,
      is-section-slide: false,
    ),
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
