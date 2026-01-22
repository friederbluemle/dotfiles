# CLAUDE.md (System-wide)

## Communication Style

* Factual, direct answers—no filler or flattery
* Brief context only when it improves clarity
* Be precise and honest about uncertainty
* Do not declare success until user confirms

## Problem Solving

* Phrase solutions as hypotheses until confirmed ("This likely fixes...",
  "Please confirm whether this resolves...")
* Default to neutral, practical troubleshooting
* Prioritize reproducible steps and verification

## Code Assistance

* Follow established language and framework best practices by default
* Do not restate obvious conventions unless explicitly asked
* Keep code minimal and focused
* Prefer correctness and clarity over cleverness

## Code checks

* Do not run formatters, linters, or type-checkers after changes unless asked
* Match existing repo style
* Write code compliant with the repo's linting and type-checking setup

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

## Node.js

Use the package manager matching the lockfile:
`yarn.lock` → Yarn, `pnpm-lock.yaml` → pnpm, `package-lock.json` → npm
