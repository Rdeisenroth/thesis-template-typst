#import "requirements.typ": *
#import "metadata.typ": *
#import "commands.typ": *
#import "styling.typ": *
#import "preamble-shared.typ": *

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
  setup-shared-styling(darkmode, accent-color)

  let text_color = shared-text-color(darkmode)
  let background_color = shared-background-color(darkmode)
  set line(stroke: text_color)
  set page(fill: background_color)
  set text(fill: text_color)

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

  codly(..shared-codly-options(darkmode, accent-color))
  set raw(theme: if darkmode { "halcyon.tmTheme" } else { auto })
  show: codly-init.with()

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
  set circle(stroke: text_color)
  set ellipse(stroke: text_color)
  set table(stroke: text_color)

  style-figure-captions(accent-color)

  let background_color = shared-background-color(darkmode)
  set line(stroke: text_color)
  set page(fill: background_color)
  set text(fill: text_color)

  doc
}
