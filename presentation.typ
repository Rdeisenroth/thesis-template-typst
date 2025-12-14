#import "common/preamble-slides.typ": *
#show: doc => init(doc, darkmode: false) // you can also overwrite dark mode with input parameter

#title-slide()
// #slide(align(center + horizon, fatsf(text(size: 64pt)[
//   Gude
// ])))
#outline-slide()
= Einführung
== Was ist Typst?
#align(center + horizon, {
  // text(size: 64pt)[Typst]
  text(fill: rgb("#239dad"), image("pictures/typst-logo-colored.svg", width: 10em))
  // v(-2em)
  // slimsf(
  text(font: "Gentium", ipa.text(delim: "/")[
    t a I p s t
  ])
  // )
  v(2em)
  [Typst ist eine Programmiersprache zur Erstellung von PDF-Dokumenten und Websites. Erstveröffentlicht 2023 von der #link("https://typst.app")[Typst GmbH], Sitz in Berlin.@typstAbout]
})
== Idee hinter Typst
- Typst-Quellcode wird zu PDF, SVG oder HTML Datei *kompiliert*
- Häufig verwendeten Code in Funktionen/Paketen zusammenfassen
- Man erhält *exakt* das, was man beschreibt
- Automatisierung ist einfach und mächtig
== Anwendungsmöglichkeiten
- Abschlussarbeiten (z.B. Thesis)#footnote[Wobei #LaTeX immernoch der De-facto-Standard ist]
- Hausübungsabgaben
- Zusammenfassungen
- Präsentationen (wie diese)
- Handouts
- Wissenschaftliches Zeichnen (z.B. Schaltplan, Diagramme, Moleküle, $dots$)
- Vektorgrafiken
- Musik komponieren
- $dots$
= Vor- und Nachteile von Typst
== Allgemeine Vorteile
- Einfache (nachträgliche) Änderung des Design
- Automatisierung
- Schnelles kompillieren (vor Allen gegenüber #LaTeX)
- Fußnoten, Referenzen, Formatierung, $dots$ sind einfach zu managen
- Formeln zu tippen ist intuitiv und einfach
- Stabil auch bei sehr großen Dokumenten
- Plattformunabhängig
- Kleine installationsgröße
- Open Source, Aktive Entwicklung, Gute Dokumentation und Beispiele
== Allgemeine Nachteile
- Kein WYSIWYG-Editor (What You See Is What You Get)
  - Bis man Änderungen sieht, kann es dauern
  - Steile Lernkurve
- Noch nicht so weit verbreitet wie #LaTeX
- Einige vertraute Pakete fehlen noch
- Noch nicht überall für Paper akzeptiert (z.B. Arxiv)
- Mehr Text, um Dinge zu beschreiben
== Komplexität

#context {
  figure(
    cetz.canvas({
      cetz.draw.set-style(axes: (
        stroke: if isDarkMode() { white } else { black },
        x: (label: (anchor: "south-east", offset: -0.4)),
        y: (label: (anchor: "north-west", offset: -0.4)),
      ))
      plot.plot(
        size: (20, 10),
        name: "Dokumentenkomplexität vs Aufwand",
        x-tick-step: none,
        y-tick-step: none,
        x-label: "Komplexität des Dokuments",
        y-label: "Aufwand",
        axis-style: "left",
        x-min: 0,
        x-max: 10,
        y-min: 0,
        y-max: 4,
        legend: (20, 10),
        legend-anchor: "north-east",
        legend-style: (
          fill: if isDarkMode() { white.darken(80%) } else { black.lighten(80%) },
          stroke: none,
          radius: 3pt,
          padding: .3em,
        ),
        {
          plot.add(
            line: (type: "spline", samples: 100, tension: 0.52),
            style: (stroke: rgb(tuda_colors.at("3a")) + 2pt),
            (
              (0, 0.4),
              (.5, 2),
              (2, 2.3),
              (5, 2.5),
              (10, 2.9),
            ),
            label: LaTeX,
          )
          plot.add(
            line: (type: "spline", samples: 100, tension: 0.52),
            style: (stroke: rgb("#239DAD") + 2pt),
            (
              (0, 0.3),
              (1.5, 1.5),
              (4, 2.1),
              (6, 2.65),
              (8, 2.75),
              (10, 2.8),
              (12, 2.9),
            ),
            label: [Typst],
          )
          plot.add(
            line: (type: "spline", samples: 100, tension: 0.5, epsilon: 0.5),
            style: (stroke: rgb(tuda_colors.at("8a")) + 2pt),
            domain: (0, 1),
            (
              (0, 0.2),
              (2, .5),
              (4, 2.5),
              (8, 8.6),
            ),
            label: "Word",
          )
        },
      )
    }),
    caption: [Dokumentenkomplexität #LaTeX vs Typst vs Word],
  )
}

== Typst vs. LaTeX
- Angenehmer zu schreiben
- Schneller zu kompilieren
- Schlechteres Ökosystem

== Questions
#align(center + horizon, text(size: 34pt)[
  Thank you for your attention!\
  Do you have any questions

  #v(1fr)
  #text(size: 87pt, fa-question(solid: true))
  #v(1fr)
])
== Kursmaterialien
#context {
  urlslide3(
    caption1: "Typst Online verwenden",
    "https://typst.app",
    caption2: "Typst lokal installieren",
    "https://github.com/typst/typst?tab=readme-ov-file#installation",
    caption3: "Workshop-Materialien",
    "https://github.com/Rdeisenroth/Typst-Workshop#typst-workshop",
  )
}
#pagebreak()
#bibliography("common/refs.bib", title: "References")
