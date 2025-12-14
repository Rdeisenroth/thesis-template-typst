#import "requirements.typ": *
#let dState = state("darkmode", false)

#let isDarkMode() = dState.get()

#let fgcolor() = if isDarkMode() { white } else { black }

#let section-slide(
  title: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(subslide-preamble: self => {
      block(
        height: 1.99in - margin.top,
        below: 0.24in,
        width: 100% - 2in,
        align(bottom)[
          #slide-title-font(upper(if title != auto { title } else {
            utils.display-current-heading(depth: self.slide-level)
          }))
        ],
      )
    }),
  )
  self.store.is-section-slide = true
  touying-slide(self: self, config: config, repeat: repeat, setting: setting, composer: composer, ..bodies)
})

#let outline-slide() = section-slide(title: "Inhalt", d-outline())
