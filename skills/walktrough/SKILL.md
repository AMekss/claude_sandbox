---
name: walkthrough
description: Structured walkthrough of code changes, a plan proposing code changes/additions, or a codebase area. Use when the user says "walk me through", "explain these changes", "walkthrough", or wants to understand how code works.
argument-hint: "[uncommitted | branch | path | commit-hash]"
---

# Walkthrough

Give the user a structured, narrative walkthrough of code. Not a file listing — a guided tour that builds understanding incrementally.

## Determine scope

Based on `$ARGUMENTS`:

- **Empty or `uncommitted`**: Walk through uncommitted changes (`git diff` + `git diff --cached` + untracked files from `git status`).
- **A branch name**: Walk through all changes between `main` and that branch (`git diff main...$ARGUMENTS`). Use `git log main..$ARGUMENTS --oneline` for commit context.
- **A file or directory path**: Walk through the code at that path. For directories, identify the key files and their relationships.
- **A commit hash or range** (e.g. `abc123`, `abc123..def456`, `HEAD~3..HEAD`): Walk through those specific changes.

If ambiguous, check whether the argument is a path, branch, or commit — try `git rev-parse` to disambiguate, fall back to asking.

## Read the code

Read all relevant files and diffs. For large changesets, prioritize reading the actual source files over just the diff — diffs show what changed but files show how it fits together.

For diffs, also read surrounding context in the source files to understand what the changed code connects to.

## Build a linear walkthrough

This is a **linear** walkthrough — a single narrative thread where each section builds on the last. The reader should never need to mentally backtrack or hold unresolved context.

Pick the order that builds understanding most naturally:
- For features/changes: start with the motivation, then the entry point, then follow the execution path deeper
- For a codebase area: start with the data model or core abstraction, then the operations on it, then the edges (API surface, error handling)
- For a refactor: start with what it looked like before, then the insight, then the new shape

The key constraint: each section should be fully understandable given only what came before it. If section 4 requires knowledge from section 7, reorder.

### Opening

One paragraph: what is this code/change about, and what will you understand by the end of the walkthrough?

### Outline

After the opening, present a compact numbered outline of all the sections you'll cover. Each item is one line: the section name and a short phrase describing what it covers. This gives the reader a map before the journey begins.

Example format:
```
1. **Data model** — the core types and how they relate
2. **Repository layer** — persistence and query patterns
3. **API surface** — how clients interact with this
```

### Interactive pacing

After presenting the outline, walk through **one section at a time**. After each section, stop and ask the user if they have questions or want to continue. Use a simple prompt like "Questions, or shall I continue to the next section?"

Do NOT output multiple sections at once. Wait for the user's signal before proceeding.

### Sections

Group by concept, not by file. A single section might span multiple files. A single file might appear in multiple sections.

For each section:

1. **What**: What does this piece do? What problem does it solve?
2. **How**: Walk through the key logic. Quote specific code when it clarifies. Don't quote boilerplate.
3. **Why**: Design decisions, trade-offs, patterns used. If something non-obvious is happening, explain why.
4. **Bridge**: How does this lead to the next section? What question does it raise that the next section answers?

### Closing

Key takeaways. Call out anything that's:
- Particularly clever or well-designed
- Potentially confusing or surprising
- Worth remembering for future work

## Style

- Talk TO the reader, not AT them. "Notice how X connects to Y" not "X connects to Y."
- Use concrete code references (file:line) so the reader can follow along.
- Start simple, build complexity. Don't front-load jargon.
- Skip the obvious. Don't explain what `use` statements do or that a struct has fields.
- Be honest about things that are unclear, overly complex, or could be improved — flag them, don't gloss over them.
- Keep it conversational. This is a colleague explaining code over coffee, not a formal document.
