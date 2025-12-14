#import "requirements.typ": *
#import "styling.typ": *
#let slimsf(body) = text(
  font: "Roboto",
  fallback: false,
  weight: "light",
  body,
)
#let textsf(body) = text(
  font: "Roboto",
  fallback: false,
  weight: "regular",
  body,
)

#let fatsf(body) = text(
  font: "Roboto",
  fallback: false,
  weight: "bold",
  body,
)

#let emojifont(body) = text(
  font: "Noto Color Emoji",
  fallback: false,
  weight: "regular",
  body,
)

#let LaTeX = {
  let A = (
    offset: (
      x: -0.33em,
      y: -0.3em,
    ),
    size: 0.7em,
  )
  let T = (
    x_offset: -0.12em,
  )
  let E = (
    x_offset: -0.2em,
    y_offset: 0.23em,
    size: 1em,
  )
  let X = (
    x_offset: -0.1em,
  )
  [L#h(A.offset.x)#text(size: A.size, baseline: A.offset.y)[A]#h(T.x_offset)T#h(E.x_offset)#text(size: E.size, baseline: E.y_offset)[E]#h(X.x_offset)X]
}

#let accent-color = rgb(tuda_colors.at("9c")) // TU Darmstadt Teal

// counter for definitions
#let definition_counter = counter("definition")

#let definition(..args) = context clue(
  title: {
    definition_counter.step()
    fatsf[Definition #context definition_counter.display()]
  },
  accent-color: accent-color,
  header-color: accent-color.transparentize(if dState.get() { 60% } else { 80% }),
  border-color: accent-color.transparentize(80%),
  icon: emojifont(emoji.pencil),
  ..args,
)

#let codeWithCompiledOutput(path) = {
  path = "../" + path
  let filename = path.split("/").last()
  let svgpath = path.replace(".typ", ".svg")
  grid(
    columns: (1fr, 1fr),
    gutter: .5em,
    align: center + horizon,
    [
      #codly(header: [#filename])
      #raw(read(path), lang: "typst", block: true)
    ],
    [
      #box(stroke: accent-color + 12pt, radius: 3pt, image(svgpath, width: auto, height: 90%, fit: "contain"))
    ],
  )
}

#let codeAndOutput(code, title: none, split: 70%) = context showybox(
  fill: gray,
  title: if title == none { none } else {
    text(size: 14pt, fa-code(solid: true))
    h(1fr)
    textsf(title)
    h(1fr)
    text(size: 14pt, fa-code(solid: true))
  },
  frame: (
    body-color: none,
    title-color: accent-color,
    body-inset: 0pt,
    thickness: 0pt,
  ),
  title-style: (
    color: white,
    sep-thickness: 0pt,
  ),
  radius: 5pt,
  body-style: (
    color: if dState.get() { white } else { black },
  ),
  box(
    clip: true,
    inset: 0pt,
    outset: 0pt,
    radius: (top-left: 0pt, top-right: 0pt, bottom-left: 5pt, bottom-right: 5pt),
    grid(
      columns: (1fr * split * 2, 1fr),
      gutter: 0em,
      align: left + horizon,
      grid.cell(
        fill: if dState.get() { rgb("162b3a") } else { black.transparentize(90%) },
        {
          codly(header: none, radius: 0pt, lang-outset: (x: 0pt, y: 12pt))
          code
        },
      ),
      grid.cell(
        inset: (x: 1em, y: 1em),
        fill: if dState.get() { rgb("#2D404E") } else { rgb("#D0D5D8") },
        {
          eval("[" + code.text + "]")
        },
      ),
    ),
  ),
)

#let goodqrcode(
  content,
  width: auto,
  height: auto,
  color: auto,
  background: auto,
  error-correction: "M",
) = qr-code(
  content,
  width: width,
  height: height,
  color: if color == auto { fgcolor() } else { color },
  background: if background == auto { rgb("#00000000") } else { background },
  error-correction: error-correction,
)

#let urlfigure(content, caption: none) = {
  let res = ()
  if (caption != none) {
    res.push(caption)
  }
  res.push(link(content))
  figure(
    goodqrcode(content),
    caption: res.join[\ ],
  )
}

#let urlslide(
  content,
  caption: none,
) = {
  v(1fr)
  urlfigure(content, caption: caption)
  v(1fr)
}

#let urlslide2(
  content1,
  content2,
  caption1: none,
  caption2: none,
) = {
  v(1fr)
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align: center + horizon,
    urlfigure(content1, caption: caption1), urlfigure(content2, caption: caption2),
  )
  v(1fr)
}

#let urlslide3(
  content1,
  content2,
  content3,
  caption1: none,
  caption2: none,
  caption3: none,
) = {
  v(1fr)
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1em,
    align: center + horizon,
    urlfigure(content1, caption: caption1),
    urlfigure(content2, caption: caption2),
    urlfigure(content3, caption: caption3),
  )
  v(1fr)
}
