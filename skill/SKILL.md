---
name: daily-industry-brief
description: Use this every weekday morning (or when asked) to write a presidential-style daily brief on <YOUR SECTOR> for readers at <YOUR COMPANY>, publish it as a single static web page, and record a five-minute audio overview. Covers the section order, sourcing rules, writing rules, the audio script, and publishing to GitHub Pages.
---

# Daily industry brief

A daily read on <YOUR SECTOR> covering headlines, financing, and deals among the companies on <WATCHLIST>. The model is the morning intelligence brief a senior official gets: depth, understanding, and a clear view, not a news roundup. Every major story moves from situation to understanding to view to implications.

## Inputs to fill in once

- `<YOUR COMPANY>`: optional. The company the brief reads the industry for, used only by the optional module below.
- `<YOUR SECTOR>`: the industry covered.
- `<WATCHLIST>`: companies and people to track, grouped into six desks (example for AI compute: Frontier labs, Hyperscalers, Neoclouds, Training and inference platforms, Enterprise distributors, Silicon makers).
- `<YOUR THESIS>`: a three-part belief about where the sector is going, plus two or three falsifiers that would prove it wrong.
- `<TIMEZONE>`: every date and time on the page uses this zone.
- `<SITE URL>`: where the page is published (for example a GitHub Pages site).

## Window and sourcing

1. The window runs from the previous brief to now (on Monday, from Friday's brief).
2. Public sources only. Never use internal or confidential information from <YOUR COMPANY> or anyone else. If the optional module is on, frame every "What this means for <YOUR COMPANY>" line as an outside read.
3. Sweep primary sources first: company newsrooms and blogs, regulatory filings, earnings calendars, then reputable outlets, then X (Twitter).
4. Treat X posts as leads. Verify each against a primary source before it becomes a known known. A post quoted in "What X is saying" is quoted as opinion, with the author's handle.
5. Every number and claim gets a link in Sources. If something is not covered in the window, write "Not covered in this window". Never guess, never fill gaps from memory.
6. Tag every judgment Certain, Likely, or Guessing.

## Writing rules

- Plain English, short sentences, scannable. Spell out every acronym the first time it appears in page order.
- Headlines are sentences that say what happened, not bare labels.
- Bull and bear cases are other people's arguments; "My call" is the brief's own view, with its tag.
- No em dashes or en dashes. Use commas, periods, or colons.
- Do not start sentences with "It".
- No repeated content across sections: the quadrants extend the Big Three, they do not restate it.

## Sections, in this order

Number every header `NN | Title` (00 to 11), with the number in the accent color. A collapsed table of contents lists the same numbered entries.

**Header**: the title, a one-paragraph description, a date line ("<Month D, YYYY>. Public sources only. Refreshed every weekday morning."), then the audio player.

**00 | TL:DR**: exactly three bullets, about 60 words in total. (1) What happened, (2) what it means, (3) what to watch next. Summarize the whole brief: the Big Three, the quadrants, and the thesis status.

**01 | Key Numbers**: one lead sentence, then four to six figures, each with a label and its source.

**02 | The Big Three**: the three stories that matter most. Each card: headline, "What it is", "Why it matters", and two links ("Read more" to an AI assistant prompt or search, and "See it on X" to a live X search).

**03 | Known knowns**: explainer line "Confirmed news this window." Up to five cards; the first three are the debate behind the Big Three. Each card: bull case, bear case, my call (tagged), who wins, who loses.

**04 | Known unknowns**: explainer line "Questions we know matter but can't answer yet, with what will answer them and when." A table: open question, what would answer it, when (date and time in <TIMEZONE>). Include earnings dates, rulings, launches, and the thesis tripwires.

**05 | Unknown knowns**: explainer line "Public facts the market is underweighting." Each item: a title, two sentences, a confidence tag, and a link to its source.

**06 | Unknown unknowns**: explainer line "Surprises from outside the big players." Challenger labs, startups, surprise papers. Bar to qualify: a credible public claim that would change prices, capacity, or the competitive order if it holds. If nothing clears the bar, say so in one line.

**Optional module, off by default: "What this means for <YOUR COMPANY>"**. Turn it on only when the owner asks for it. When on, each quadrant (03 to 06) ends with this block: caption "An outside read from public sources." Three headlines, each tagged Opportunity, Strength, Risk, Threat, or Watch, each with one sentence. When off, leave it out entirely, and keep the brief neutral: no lines written from one company's point of view. In a public copy, leave it off unless the owner wants readers to know their employer.

**07 | What X is saying**: only posts cited in the day's brief. Quote, author and handle, one-line note.

**Behind the Tab** (optional, after section 07): follow-ups on questions the reader asked the previous day, answered with sources. Leave it out when there were no questions.

**08 | Compute scoreboard** (or the sector's equivalent): a table of product category, buyer this window, and the financing behind it. Categories with no news read "Not covered in this window".

**09 | Buyer Map**: Friday format. Rows grouped by the six desks: company, desk, what they did, what they chose, one-line view. Optional filters by desk and by product. List companies on <WATCHLIST> with no news instead of inventing rows.

**10 | State of the Thesis**: a status line "Thesis status: Unchanged, Revised, or Rewritten (<date>)". Unchanged means nothing tested it. Revised means new evidence reshaped one part. Rewritten means a falsifier actually happened. Then the three parts of <YOUR THESIS>, each with its status, the belief, key evidence, and a supporting note. Then a table of falsifiers: what would answer each one, and its status.

**11 | Sources**: every link used, with title and site.

## Audio overview

1. Write a script of 700 to 750 words from the finished page, following `templates/audio-script-template.md`.
2. Generate speech with xAI Grok text to speech: `POST https://api.x.ai/v1/tts` with `text`, `voice_id`, `language` "en", and optional `speed`. Read the key from the `XAI_API_KEY` environment variable; never write it into a file. `templates/scripts/make_audio.sh` does this.
3. Check the length with `ffprobe`. Target 4:30 to 5:30; adjust the speed (0.7 to 1.5) or the script if it misses.
4. Overwrite `brief.mp3`, so only the latest audio exists.

## Publishing

1. Write the page as one self-contained `index.html` (start from `templates/page-template.html`): inline CSS, no outside fonts, scripts, images, or trackers, readable on a phone and in dark mode. The audio player is `<audio controls src="brief.mp3">`.
2. Overwrite `index.html` and `brief.mp3`, commit to `main`, and push. GitHub Pages serves from the repository root.
3. Before pushing, check: zero em or en dashes, no sentence starting with "It", every acronym spelled out on first use, every section present in order, no secrets or personal details in the repository.

## Schedule

Run every weekday at 7 AM <TIMEZONE> from any agent that supports scheduled runs, or from cron (`0 7 * * 1-5`). Do not post, email, or message anyone about the brief unless the owner asks.
