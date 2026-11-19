# Assemble

Signup + check-in app primarily for the LBS Kreativa Gymnasiet LAN (February) but the app is also designed in the end to be easily forkable. Students sign up, guardians of under-18s sign a consent form (DocuSeal), organisers manage everything in an admin, and the door checks people in by name or QR.

Simon is learning Rails with this project. When you introduce a Rails concept for the first time (a callback, a concern, Turbo Streams, etc.), explain it in 1–2 sentences. Don't lecture, don't repeat explanations.

## Stack

- Ruby 3.4 (mise), Rails 8.1, PostgreSQL
- Hotwire: Turbo (frames, streams) + Stimulus. Importmap, **no Node, no bundler, no npm/bun**
- Tailwind v4 via `tailwindcss-rails`. **Tailwind classes only. No custom CSS files, no `@apply` soup.** The only CSS is the `@theme` block in `app/assets/tailwind/application.css`
- ViewComponent for every UI component, `class_variants` for variants, `tailwind_merge` when merging caller classes
- Solid Queue for jobs, Solid Cache. No Redis
- Auth: `passwordless` gem (magic links) for organisers only. Participants have no accounts, they use a personal token link
- Deploy: Coolify, Rails' own Dockerfile

Prefer a well-maintained gem over writing it ourselves. Ask before adding a gem that isn't listed in "Gems" below.

## Commands

```
bin/dev                  # server + tailwind watcher
bin/rails test           # tests
bin/rails test:system    # system tests
bin/rubocop -a           # lint (rubocop-rails-omakase)
bin/rails db:migrate
```

Dev mail: letter_opener_web at `/letter_opener`. Jobs: mission_control-jobs at `/admin/jobs`.

## Gems

view_component · class_variants · tailwind_merge · passwordless · docuseal · rqrcode · pagy · pg_search · phonelib · paper_trail · letter_opener_web (dev) · mission_control-jobs · strong_migrations · passkit + google-apis-walletobjects_v1 (wallet passes, last)

## Design system

Source of truth: Figma file https://www.figma.com/design/4LuZXDL2hDihFSI4aLYzYl, page **LBS UI Kit**. It has foundations, every component, all screens (P1–P5, A1–A10, M1–M3) and the plan board. If a screen or component exists there, match it. Don't invent new patterns.

### Fonts

- `font-display` = Big Shoulders Text, **Bold**. Headings only (page titles, section titles, step titles)
- `font-sans` = Onest. Everything people read as words: body, labels, input values, names, links
- `font-mono` = JetBrains Mono. Data and machine parts: buttons (keys), statuses, tabs, counts, times, ages, e-mails in tables, table keys

### Colour: each colour has exactly one job

| Token | Job |
|---|---|
| `cyan` | action + focus (primary button, links, focus ring, selected) |
| `green` | consent ok |
| `yellow` | waiting |
| `magenta` / `magenta-t` (text) | problem, blocks entry |
| `orange` | the LAN mark only. Never a state |

Surfaces: `bg`, `bg-2`, `field`. Lines: `line`, `line-2` (dividers), `edge` (control borders). Text: `fg`, `fg-2`, `fg-3`. Dark shades: `cyan-d`, `green-d`, `yellow-d`, `magenta-d` (pane fills, text on filled keys).

**Never use green/magenta for anything that isn't consent / blocked.** Win/loss, success toasts etc. use `fg` vs `fg-3`.

### Rules

1. Status = glyph + word, always (`StatusComponent`)
2. Gutter mark: a 3px bar on the left edge (yellow or magenta) means "needs attention". Content inset 16px
3. Pane (box with title cut into the top border) only for a message you have to act on
4. Uppercase tracked mono (`text-t1 uppercase tracking-[.08em] text-fg-3`) only for table keys and fact keys
5. One filled cyan (primary) button per view
6. Type sizes: `text-t1`…`text-t7` = 12 13 15 17 20 24 40. Spacing uses Tailwind's default scale: 1 2 3 4 6 8 12 (4 8 12 16 24 32 48), page padding 5 (20px). Radius `rounded-xs` (2px)
7. Dark only. Min tap target 44px, inputs 52px, block buttons 56px

### Components (Figma name → ViewComponent)

Button → `ButtonComponent` (style: primary/secondary/ghost/danger/text, size: default/block) · Field → `FieldComponent` (text/select/textarea, wraps label → hint → error → control) · Status → `StatusComponent` (none/sent/opened/ok/na/stop/in) · Pane → `PaneComponent` (yellow/magenta) · Alert Pane · Flash · Dialog · Checkbox / Radio / Check Row / Team Option · Disclosure · Badge · Kbd · Lockup · Top Bar · Admin Top · Admin Nav / Tab · Filter Item / Filter Bar · Search · Crumbs · Back Link · Section Head · Empty State · Table Header / Table Row · KV Row · Fact Row · Step · Seats · Member Row · Team Head · Door Row · Door Status Bar · Scan View · QR Code · Ticket

Components live in `app/components/`, one `.rb` + `.html.erb` each. Variants go through `class_variants`, not if/else string building. Accept a `class:` arg and merge it with `tailwind_merge`.

## Domain

- **Signup**: student_name, student_email (unique), date_of_birth, grade, emergency_contact_name/phone, guardian_name/email, swish_number, gear (array), gear_note, status, docuseal_submission_id, signing_url, sent_at, signed_at, error_message, consent_method/note/recorded_by/recorded_at, checked_in_at/by, check_in_code (unique, 24 chars), confirmation_sent_at, manage token
- **Game**: name (unique, case-insensitive), description, team_size (1 = solo), position
- **Team**: belongs_to game, name (unique per game), created_by_organiser
- **Entry**: signup + game (unique together) + team (nullable = "söker lag")
- **Organiser**: email, last_login_at
- Event info (name, dates, place, price, contact email) lives in credentials/ENV, read through one config object

### Consent status (Rails enum)

`pending` Inte skickad · `sent` Väntar på underskrift · `opened` Öppnad · `completed` Underskriven · `manual` Godkänt manuellt · `not_required` Behövs inte (18+) · `declined` Avböjd · `expired` / `failed` Behöver åtgärd

- `consent_ok?` = completed, manual or not_required
- Age is calculated **on the first day of the LAN**, not today. 18+ on that day = not_required
- Checked in is separate (`checked_in_at`). Only `consent_ok?` people can be checked in. Never twice
- DocuSeal webhook moves sent → opened → completed/declined. We send our own guardian email (`send_email: false` on the submission)

## Copy + language

- **All UI text, emails and flash messages in Swedish.** Code, comments, commit messages, variable names in English
- Write "LAN:et", "Min anmälan", "vårdnadshavare". Address the user as "du"
- No em dashes in UI copy. Use commas, periods or a middle dot (·)
- Error messages say what to do, not what went wrong ("Skriv vårdnadshavarens e-post", not "Ogiltig e-post")

## Testing

Build first, test after, but these must be tested **before signups open to real people**:
- age on LAN day (including birthdays during the LAN)
- `consent_ok?` for every status
- DocuSeal webhook payload → status
- check-in rules (blocked can't check in, no double check-in)
- team capacity (can't join a full team)

Minitest + Capybara (Rails default). No RSpec.

## Don't

- Don't write custom CSS or add a JS build step
- Don't add npm/bun/yarn anything
- Don't use colours outside their job (see table)
- Don't create accounts or passwords for participants
- Don't leak whether an e-mail is signed up (forms that take an e-mail answer the same either way)
- Don't commit secrets. Use `bin/rails credentials:edit`
- Don't add to the plan of the application without asking. The plan is in Figma, not in code, figma is found at https://www.figma.com/design/4LuZXDL2hDihFSI4aLYzYl/LBS-Tjofs
- Don't make changes without being explicitly assigned. If you see a bug or missing feature, ask first.