---
name: remember
description: Record a durable agent preference or rule in an AGENTS.md at the matching scope, from the global ~/.dotfiles/agents/AGENTS.md down to the current directory. Invoke when an agent misbehaves and the correction should be persisted.
disable-model-invocation: true
argument-hint: [misbehavior you observed, or the rule to record]
---

# Remember: record an agent rule

Persist a user preference or behavioral rule in an agent instructions file.

Input: $ARGUMENTS

## Steps

1. **Identify the rule.** Use the input above; if empty, infer it from the
   misbehavior just discussed in the conversation. Ask only if neither
   yields a clear candidate.

2. **Determine the target file.** Candidates are the AGENTS.md files in
   each directory on the logical path from $HOME down to the current
   directory (symlinks under $HOME count; a directory with no logical
   path under $HOME has only the home rung). The home rung is
   ~/.dotfiles/agents/AGENTS.md - the default, applied globally. Pick a
   narrower rung when the rule's scope calls for it, preferring rungs
   that already contain an AGENTS.md; ask if the intended scope is
   unclear.

   "Locally" means unsynced. Only two local targets exist (local
   variants are only loaded from the current directory, or globally via
   ~/.claude/rules/):

   - home rung: ~/.dotfiles/agents/AGENTS.local.md
   - current directory, if version controlled: AGENTS.local.md

   Elsewhere use plain AGENTS.md: in an unversioned directory it is
   already unsynced (say so when confirming); at a version-controlled
   parent rung the local intent cannot be satisfied - say so and offer
   the two local targets or a tracked AGENTS.md at that rung.

3. **Draft the rule.** Read the target file, then write one concise bullet
   in the imperative, generalized past the specific incident, matching the
   file's existing style. If an existing bullet already covers the topic,
   amend it instead. Place it under the best-fitting existing `##` heading;
   suggest a new heading only if none fits.

4. **Confirm, then apply.** Show the exact bullet and placement and get the
   user's approval (AskUserQuestion) before editing the file.

5. **Ensure the symlink.** Each target is loaded via exactly one symlink;
   after writing, create it if missing. Never replace an existing regular
   file or a symlink pointing elsewhere - report the conflict instead.

   | File written                       | Ensure                                     |
   |------------------------------------|--------------------------------------------|
   | ~/.dotfiles/agents/AGENTS.md       | ~/.claude/CLAUDE.md points at it           |
   | ~/.dotfiles/agents/AGENTS.local.md | ~/.claude/rules/local.md points at it      |
   | any other AGENTS.md                | sibling CLAUDE.md points at it             |
   | current dir AGENTS.local.md        | sibling CLAUDE.local.md points at it       |

6. **Report.** Quote the final rule and where it landed. Do not commit or
   stage anything.
