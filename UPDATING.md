# How to update the website

## Adding a talk

Edit `_data/talks.yml`. Add a new entry at the top:

```yaml
- date: "2026-11-01"
  text: "Conference Name in City, State"
```

The date format is `YYYY-MM-DD`. Use an approximate date if the exact day is unknown — it is only used for sorting. The 5 most recent talks (by date) appear as "Recent and upcoming talks"; the rest collapse under "older talks".

## Adding a news item

Edit `_data/news.yml`. Add a new entry at the top. There are three formats:

**Plain text (no link):**
```yaml
- date: "2026-11-01"
  text: "Some plain text announcement."
```

**Single link:**
```yaml
- date: "2026-11-01"
  url: "https://arxiv.org/abs/..."
  link_text: "Title of the paper"
  post: "accepted at Journal Name"
```

You can also add a `pre:` field for text before the link:
```yaml
- date: "2026-11-01"
  pre: "Student Name's paper,"
  url: "https://arxiv.org/abs/..."
  link_text: "Title of the paper"
  post: "now available on arXiv"
```

**Complex (multiple links or unusual formatting):**
```yaml
- date: "2026-11-01"
  html: "Raw HTML goes here, e.g. <a href='...'>link</a> and more text."
```

The 12 most recent news items (by date) appear in the main list; the rest collapse under "older news".

## Adjusting how many items appear as "recent"

In `index.html`, find:

- `limit: 5` — controls how many talks appear as recent (change 5 to any number)
- `limit: 12` — controls how many news items appear as recent (change 12 to any number)

## Adding a paper to the research page

Edit `_data/papers.yml`. Add a new entry at the top (below the comment block). The minimal entry for a submitted paper with no preprint:

```yaml
- key: "lastname2026title"
  title: "Full paper title"
  authors: "Coauthor, A. B. and <strong>Molstad, A. J.</strong>"
  year: "2026+"
  venue: "Submitted"
```

For a published paper with links and BibTeX (copy BibTeX directly from Google Scholar or journal):

```yaml
- key: "lastname2026title"
  title: "Full paper title"
  authors: "<strong>Molstad, A. J.</strong> and Coauthor, A. B."
  year: "2026"
  venue: "Journal Name"
  links:
    - label: "pdf"
      url: "https://..."
    - label: "software"
      url: "https://github.com/..."
  bibtex: |
    @article{lastname2026title,
      title   = {Full paper title},
      author  = {Molstad, Aaron J. and Coauthor, Anne B.},
      journal = {Journal Name},
      year    = {2026},
      volume  = {1},
      pages   = {1--20},
      doi     = {10.xxxx/xxxxx}
    }
```

**Author formatting:**
- Bold your name: `<strong>Molstad, A. J.</strong>`
- Equal contribution marker: `<sup>❈</sup>` after the name

**Key rules:**
- `key` must be unique across all entries — use `lastnameYEARword` convention
- Papers appear on the page in the order they are listed in the file — add new papers at the top
- The `bibtex` block uses YAML literal syntax (`|`); paste BibTeX indented by 4 spaces
- For `&` in BibTeX (e.g., journal names), write `\&` as you would in LaTeX

## Styling

- Font, background color, and page width: `css/main.scss`
- Header styles: `_sass/_header.scss`
- Mobile layout: `_sass/_mobile-header.scss`

## Publishing

After any edits, push to GitHub:

```
git add -A
git commit -m "your message"
git push
```

The live site at ajmolstad.github.io updates within about a minute.
