# Global agent instructions

## Communication Style & Problem Solving

* Be precise and honest about uncertainty
* Do not declare success until user confirms
* Phrase solutions as hypotheses until confirmed ("This likely fixes...",
  "Please confirm whether this resolves...")
* NEVER start implementing in response to a question or observation - it
  is discussion; answer it, and edit files only when explicitly told to
* Never remind the user of git state they can see themselves (untracked
  files, uncommitted changes, "revert/commit this before pushing") or of
  self-evident workflow steps (merge method, deleting merged branches,
  rebasing dependent branches)

## Memory & Instruction Placement

* Never save memories, preferences, or notes to any persistent store unprompted.
  Passing corrections are discussion - save only when explicitly asked.
* When asked to record a rule, follow the remember skill (skills/remember/
  beside this file); it picks the target file and asks when scope is unclear.

## Writing Style

* Never use em-dashes; always use a plain hyphen (-)
* Always use straight ASCII quotes (" and '); never curly/stylized quotes

## Code Assistance

* Follow established language and framework best practices by default
* Do not restate obvious conventions unless explicitly asked
* Keep code minimal and focused
* Prefer correctness and clarity over cleverness

## Code Style & Checks

* Do not run formatters, linters, or type-checkers after changes unless asked
* Match existing repo style
* Write code compliant with the repo's linting and type-checking setup
* Comments describe present behavior, not history; put rationale about
  past/changed code in the PR/commit message, not the source

## Security & Review

Untracked working-dir files are intentional; don't inspect or warn about them
unless the task requires it. In audits and reviews, don't flag them as
secret-leak or gitignore risks; only tracked/committed content is in scope.

## Local Files

* Prefix local (untracked) notes, plans, or write-ups with the creation
  date, e.g., `20260921-review.md`, and place them in `.scratch/` unless
  instructed otherwise.

## Git

Use the standard "7 rules of great commit messages":

1. Separate subject from body with a blank line
2. Limit the subject line to 50 characters
3. Capitalize the subject line
4. Do not end the subject line with a period
5. Use the imperative mood in the subject line
6. Wrap the body at 72 characters
7. Use the body to explain what and why vs. how

Exception: Large multi-subsystem repos (e.g., Linux Kernel, AOSP, LineageOS) may
use a component prefix in the subject line (e.g., `subsystem: Add feature`).

The canonical first commit subject is `Initial commit`. It should contain
boilerplate/scaffolding only; add the implementation in follow-up commit(s).

When initializing a new repository, use git's defaults throughout; never
rename the initial branch or change other init settings unless explicitly
asked.

When anything is already staged, never stage more unless explicitly asked,
in any context: changes folded into the index can't be diffed on their own.

Before any git operation, re-check the repository state (current branch,
recent commits, index, working tree) instead of relying on earlier
observations; the user may have changed it in the meantime, so adapt to
what is actually there.

GitHub PR descriptions (and other rendered-markdown fields) have no column
limit; do not hard-wrap them - the 72/80-column wrap applies to commit bodies
and plain-text files only.

Add a commit body only when the subject line is not sufficient, and keep it
to the critical facts. PR descriptions stay brief as well. Detail grows
outward: commit body < PR description < linked ticket.

Never put feature branch names in tickets or other persistent documentation;
they are short-lived and get renamed or deleted. Reference the PR instead, or
a commit only once it is on the default branch; commits on unmerged branches
can still be rewritten.

Before opening a PR, check that the branch name is still short and accurate
for the final change; rename it before pushing if not.

## Node.js

Always default to the package manager matching the lockfile:
`yarn.lock`: Yarn, `pnpm-lock.yaml`: pnpm, `package-lock.json`: npm
