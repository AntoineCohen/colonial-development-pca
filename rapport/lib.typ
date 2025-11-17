// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography
#let std-smallcaps = smallcaps
#let std-upper = upper

// Overwrite the default `smallcaps` and `upper` functions with increased spacing between
// characters. Default tracking is 0pt.
#let smallcaps(body) = std-smallcaps(text(tracking: 0.6pt, body))
#let upper(body) = std-upper(text(tracking: 0.6pt, body))

// Colors used across the template.
#let stroke-color = luma(200)
#let fill-color = luma(250)

// TABLEAUX STYLE APA
#let heavyrulewidth = 0.08em
#let lightrulewidth = 0.05em
#let toprule = table.hline(stroke: heavyrulewidth)
#let midrule = table.hline(stroke: lightrulewidth)
#let bottomrule = table.hline(stroke: heavyrulewidth)
#let tablenote(body) = align(left, [_Note_. #body])


// This function gets your whole document as its `body`.
#let ilm(
  // The title for your work.
  title: [Your Title],
  // Author's name.
  author: "Author",
  // Affiliation (institution, university, etc.)
  affiliation: none,
  course: [course name],
  professor: [prof name],
  // The paper size to use.
  paper-size: "a4",
  // NOUVEAU PARAMÈTRE : Police par défaut
  font: ("Linux Libertine", "Liberation Serif"),
  // Date that will be displayed on cover page.
  // The value needs to be of the 'datetime' type.
  // More info: https://typst.app/docs/reference/foundations/datetime/
  // Example: datetime(year: 2024, month: 03, day: 17)
  date: none,
  // Format in which the date will be displayed on cover page.
  // More info: https://typst.app/docs/reference/foundations/datetime/#format
  // The default format will display date as: MMMM DD, YYYY
  date-format: "[month repr:long] [day padding:zero], [year repr:full]",
  // An abstract for your work. Can be omitted if you don't have one.
  abstract: none,
  // The contents for the preface page. This will be displayed after the cover page. Can
  // be omitted if you don't have one.
  preface: none,
  // The result of a call to the `outline` function or `none`.
  // Set this to `none`, if you want to disable the table of contents.
  // More info: https://typst.app/docs/reference/model/outline/
  table-of-contents: outline(),
  // Display an appendix after the body but before the bibliography.
  appendix: (
    enabled: false,
    title: "",
    heading-numbering-format: "",
    body: none,
  ),
  // The result of a call to the `bibliography` function or `none`.
  // Example: bibliography("refs.bib")
  // More info: https://typst.app/docs/reference/model/bibliography/
  bibliography: none,
  // Whether to start a chapter on a new page.
  chapter-pagebreak: true,
  // Whether to display a maroon circle next to external links.
  external-link-circle: true,
  // Raw text customization
  raw-text: (
    use-typst-defaults: false,
    // List of fonts in order of priority.
    custom-font: ("Iosevka", "Fira Mono"),
    custom-size: 9pt,
  ),
  // Display an index of figures (images).
  figure-index: (
    enabled: false,
    title: "",
  ),
  // Display an index of tables
  table-index: (
    enabled: false,
    title: "",
  ),
  // Display an index of listings (code blocks).
  listing-index: (
    enabled: false,
    title: "",
  ),
  // The content of your work.
  body,
) = {
  // Set the document's metadata.
  set document(title: title, author: author)

  // Set the body font.
  set text(size: 12pt) // default is 11pt

  // Figures
  show figure: set block(above: 2em, below: 2em)
  set figure.caption(position: top)
  show figure.caption: self => [
    #align(left)[
      *#self.supplement*
      #context [*#self.counter.display(self.numbering)*] \ #emph(self.body)
    ]
    #v(0.5em, weak: true)
  ]

  // Tables
  set table(stroke: 0pt)
  show table: tbl => {
    set block(spacing: 0.5em)
    set text(number-type: "lining", number-width: "tabular")
    tbl
  }
  // Customize raw text formatting.
  show raw: it => {
    if raw-text.at("use-typst-defaults", default: false) {
      it
    } else {
      set text(
        // Reference: Typst's default is Fira Mono at 8.8pt
        font: raw-text.at("custom-font", default: ("Iosevka", "Fira Mono")),
        size: raw-text.at("custom-size", default: 9pt),
      )
      it
    }
  }

  // Configure page size and margins.
  set page(
    paper: paper-size,
    margin: (bottom: 1.75cm, top: 2.25cm),
  )

// Cover page - custom design
page[
  #align(center)[
    #v(3cm)
    #text(size: 20pt, weight: "bold")[#title]
    #v(0.8cm)
    #text(size: 15pt)[#course]
    #v(3cm)
    #text(size: 13pt)[
      #author
      #if affiliation != none {
        v(0.5cm)
        affiliation
      }
    ]
    #v(2cm)
    #if date != none {
    text(size: 12pt)[#date.display(date-format)]
    }
    #v(2cm)
    #line(length: 60%, stroke: 0.5pt)
    #v(1cm)
    #text(size: 11pt)[
      *Enseignants :* #professor
      ]
  ]
]


  // Configure paragraph properties.
  // Default leading is 0.65em.
  // Default spacing is 1.2em.
  set par(leading: 0.7em, spacing: 1.35em, justify: true, linebreaks: "optimized")

  // Add vertical space after headings.
  show heading: it => {
    it
    v(2%, weak: true)
  }
  // Do not hyphenate headings.
  show heading: set text(hyphenate: false)

  // Show a small maroon circle next to external links.
  show link: it => {
    it
    // Workaround for ctheorems package so that its labels keep the default link styling.
    if external-link-circle and type(it.dest) != label {
      sym.wj
      h(1.6pt)
      sym.wj
      super(box(height: 3.8pt, circle(radius: 1.2pt, stroke: 0.7pt + rgb("#993333"))))
    }
  }
  // Display abstract as the second page (if defined)
  if abstract != none {
    page[
    #v(3cm)
    #align(center)[
      #text(size: 16pt, weight: "bold")[Résumé exécutif]
    ]
    #v(1cm)
    #par(justify: true, leading: 0.78em, abstract)
  ]
}

  // Display table of contents.
  if table-of-contents != none {
    table-of-contents
  }

  // Configure page numbering and footer.
  set page(
    footer: context {
      // Get current page number.
      let i = counter(page).at(here()).first()

      // Align right for even pages and left for odd.
      let is-odd = calc.odd(i)
      let aln = if is-odd {
        right
      } else {
        left
      }

      // Are we on a page that starts a chapter?
      let target = heading.where(level: 1)
      if query(target).any(it => it.location().page() == i) {
        return align(aln)[#i]
      }

      // Find the chapter of the section we are currently in.
      let before = query(target.before(here()))
      if before.len() > 0 {
        let current = before.last()
        let gap = 1.75em
        let chapter = upper(text(size: 0.68em, current.body))
        if current.numbering != none {
          if is-odd {
            align(aln)[#chapter #h(gap) #i]
          } else {
            align(aln)[#i #h(gap) #chapter]
          }
        }
      }
    },
  )

  // Configure equation numbering.
  set math.equation(numbering: "(1)")

  // Display inline code in a small box that retains the correct baseline.
  show raw.where(block: false): box.with(
    fill: fill-color.darken(2%),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // Display block code with padding.
  show raw.where(block: true): block.with(inset: (x: 5pt))

  // Break large tables across pages.
  show figure.where(kind: table): set block(breakable: false)
  // set table(
  //   // Increase the table cell's padding
  //   inset: 7pt, // default is 5pt
  //   stroke: (0.5pt + stroke-color),
  // )
  // // Use smallcaps for table header row.
  // show table.cell.where(y: 0): smallcaps

  // Wrap `body` in curly braces so that it has its own context. This way show/set rules
  // will only apply to body.
  {
    // Configure heading numbering.
    set heading(numbering: "1.")

    // Start chapters on a new page.
    show heading.where(level: 1): it => {
      if chapter-pagebreak {
        pagebreak(weak: true)
      }
      it
    }
    body
  }

  // Display appendix before the bibliography.
  if appendix.enabled {
    pagebreak()
    heading(level: 1)[#appendix.at("title", default: "Appendix")]

    // For heading prefixes in the appendix, the standard convention is A.1.1.
    let num-fmt = appendix.at("heading-numbering-format", default: "A.1.1.")

    counter(heading).update(0)
    set heading(
      outlined: false,
      numbering: (..nums) => {
        let vals = nums.pos()
        if vals.len() > 0 {
          let v = vals.slice(0)
          return numbering(num-fmt, ..v)
        }
      },
    )

    appendix.body
  }

  // Display bibliography.
  if bibliography != none {
    pagebreak()
    show std-bibliography: set text(0.85em)
    // Use default paragraph properties for bibliography.
    show std-bibliography: set par(leading: 0.65em, justify: false, linebreaks: auto)
    bibliography
  }

  // Display indices of figures, tables, and listings.
  let fig-t(kind) = figure.where(kind: kind)
  let has-fig(kind) = counter(fig-t(kind)).get().at(0) > 0
  if figure-index.enabled or table-index.enabled or listing-index.enabled {
    show outline: set heading(outlined: true)
    context {
      let imgs = figure-index.enabled and has-fig(image)
      let tbls = table-index.enabled and has-fig(table)
      let lsts = listing-index.enabled and has-fig(raw)
      if imgs or tbls or lsts {
        // Note that we pagebreak only once instead of each each individual index. This is
        // because for documents that only have a couple of figures, starting each index
        // on new page would result in superfluous whitespace.
        pagebreak()
      }

      if imgs {
        outline(
          title: figure-index.at("title", default: "Index of Figures"),
          target: fig-t(image),
        )
      }
      if tbls {
        outline(
          title: table-index.at("title", default: "Index of Tables"),
          target: fig-t(table),
        )
      }
      if lsts {
        outline(
          title: listing-index.at("title", default: "Index of Listings"),
          target: fig-t(raw),
        )
      }
    }
  }
}

// This function formats its `body` (content) into a blockquote.
#let blockquote(body) = {
  block(
    width: 100%,
    fill: fill-color,
    inset: 2em,
    stroke: (y: 0.5pt + stroke-color),
    body,
  )
}
