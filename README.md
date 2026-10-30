# Cameron's Daily Brief on AI Infrastructure

A daily read on the AI industry covering headlines, financing, and deals among frontier labs, hyperscalers, neoclouds, inference platforms, and chip makers. Modeled after Dick Cheney's brief to the President and his staff.

**Read today's brief:** https://cameron013.github.io/camerons-daily-brief-on-ai/

The site is one static page (`index.html`) plus a five-minute audio overview (`brief.mp3`). Both are overwritten every weekday morning, so the link always shows the latest brief. Public sources only.

## What's in this repository

```
index.html                       Today's brief, a single self-contained page (inline CSS, no outside requests)
brief.mp3                        Today's audio overview, overwritten daily
skill/SKILL.md                   The daily brief instructions as a reusable skill for any AI agent
templates/page-template.html     The page with every section replaced by placeholder comments
templates/audio-script-template.md   Rules and outline for the audio script
templates/scripts/make_audio.sh  Example script: audio script to brief.mp3 with xAI Grok text to speech
LICENSE                          MIT
.nojekyll                        Tells GitHub Pages to serve the files as they are
```

## Build your own

Fork this repository, point it at your own company and sector, and let an AI agent or a scheduled job write the brief every weekday.

### 1. Fork and turn on GitHub Pages

1. Fork the repository (or click "Use this template").
2. In the fork, open Settings, then Pages. Set the source to "Deploy from a branch", branch `main`, folder `/ (root)`.
3. Your brief will live at `https://<your-username>.github.io/<repo-name>/`.

### 2. Make the skill yours

Open `skill/SKILL.md` and fill in the placeholders:

- `<YOUR COMPANY>`: optional. The company you read the industry for, used only if you turn on the optional "What this means for <YOUR COMPANY>" module below.
- `<YOUR SECTOR>`: the industry the brief covers (this one covers AI compute).
- `<WATCHLIST>`: the companies and people you track, grouped into desks.
- `<YOUR THESIS>`: the three-part belief the brief tests every day.
- `<TIMEZONE>`: the zone for every date and time on the page.

Give the skill to whatever agent you use (a coding agent, an assistant with web access, or your own script around a model API).

### 3. The structure (keep the order)

| # | Section | What goes in it |
|---|---------|-----------------|
| 00 | TL:DR | Exactly three bullets, about 60 words: what happened, what it means, what to watch next. Summarize the whole brief, not just the headlines. |
| 01 | Key Numbers | Four to six figures, each with its source. |
| 02 | The Big Three | The three stories that matter most, in Axios format: headline, "What it is", "Why it matters". |
| 03 | Known knowns | Confirmed news. Each card: bull case, bear case, my call (tagged), who wins, who loses. |
| 04 | Known unknowns | Open questions, with what would answer each one and when. |
| 05 | Unknown knowns | Public facts the market is ignoring, each linked to its source. |
| 06 | Unknown unknowns | Surprises from outside the big players: challenger labs, chip startups, surprise papers. Set a bar to qualify. |
| 07 | What X is saying | Only posts cited in the day's brief, quoted with the author. |
| 08 | Compute scoreboard | Who bought which chips this window, and the money behind it. |
| 09 | Buyer Map | Fridays: six desks of buyers and the chips or vendors each chose. |
| 10 | State of the Thesis | Status (Unchanged, Revised, or Rewritten), the three parts, and the falsifiers. |
| 11 | Sources | Every source the brief used. |

The four middle sections (03 to 06) are Donald Rumsfeld's quadrants. Each one opens with a one-line explainer. Every judgment carries a confidence tag: Certain, Likely, or Guessing.

**Optional module: "What this means for <YOUR COMPANY>".** The live site does not include this module. If you build a brief for your own team, you can close each quadrant with a block of three headlines, each tagged Opportunity, Strength, Risk, Threat, or Watch, with one sentence each, framed as an outside read from public sources. The page template marks where the block goes; delete it if you skip the module. If your copy is public, think twice before adding it, since it tells readers which company you work for.

### 4. Sourcing rules

- Public sources only. Nothing from inside your company or anyone else's.
- Treat X (Twitter) posts as leads, not facts. Verify each against a primary source (a filing, a company release, a reputable outlet) before it goes in a known known.
- Link every number and claim. If something is not covered in the day's window, write "Not covered in this window" instead of guessing.
- Separate fact from opinion: the bull and bear cases are other people's arguments, "my call" is yours, and the tag says how sure you are.
- Writing style: plain English, spell out every acronym on first use, short sentences.

### 5. The audio overview

1. Write a script of about 700 to 750 words from the day's page, following `templates/audio-script-template.md`: intro with the brief name and date, Key Numbers, the Big Three, one beat for each of the other quadrants, the top opportunity and risk for your company (only with the optional module), thesis status, sign-off. Write for the ear: short sentences, numbers as words, acronyms spelled out.
2. Turn it into speech with xAI Grok text to speech (`POST https://api.x.ai/v1/tts`). The example script does this:

   ```bash
   export XAI_API_KEY=...   # from your xAI console; keep it out of the repo
   ./templates/scripts/make_audio.sh script.txt ara 0.95
   ```

   Pick a voice from `GET https://api.x.ai/v1/tts/voices`. This brief uses `ara` (warm, friendly) at speed 0.95. `aurora` (serene, steady) is a good second choice. `eve`, the default, has a British accent.
3. Check the length with ffmpeg's `ffprobe` (the script prints it). Aim for 4:30 to 5:30; change the speed or trim the script if it misses.
4. The script overwrites `brief.mp3`, so only the latest audio exists. The page's player points at `brief.mp3`, so nothing else changes.

### 6. Publishing

Each weekday, overwrite `index.html` and `brief.mp3`, commit, and push to `main`. GitHub Pages serves the new version within a minute or two. Start from `templates/page-template.html`, or copy yesterday's `index.html` and replace its content. Keep it one self-contained file: inline CSS, no outside fonts, scripts, or trackers.

### 7. Scheduling

Run the skill every weekday at 7 AM in your time zone with whatever you have:

- An AI agent that supports scheduled tasks or routines: point it at `skill/SKILL.md`.
- A cron job or a scheduled GitHub Actions workflow that calls a model API, writes `index.html` and the audio script, runs `make_audio.sh`, and pushes. Example cron line for 7 AM Monday to Friday: `0 7 * * 1-5`. GitHub Actions schedules run in UTC, so shift the hour for your zone (7 AM Pacific daylight time is `0 14 * * 1-5`).

Store your API keys as environment variables or repository secrets. Never commit them.

## License

MIT. See `LICENSE`.
