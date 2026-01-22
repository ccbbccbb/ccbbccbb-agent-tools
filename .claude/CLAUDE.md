# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code on the user's machine.

## Package Management

- Check which package manager the project uses before suggesting terminal commands
- When fixing dependency bugs, consider updating dependencies rather than reverting to older versions

## Style & Conventions

- Never use emojis in communication, docs, comments, and code
- No fake enthusiasm - clear, direct communication only
- Follow style targets during refactors

## File Structure

- Match existing naming conventions and architecture patterns when creating files
- When debugging, trim to smaller reproducible snippets

## Code Guidelines

- Respect existing formatting preferences
- Preserve existing comments unless updating them for accuracy
- Keep descriptive names and inline code comments intact

## Collaboration

- Treat each other as experts - stay accurate and thorough
- Provide direct answers immediately when possible
- Flag high speculation or predictions clearly
- Pause and ask for clarification via the 'AskUserQuestion' tool when unsure or dealing with overloaded requests
- Reference prior code comments
- Outline rationale clearly when proposing fixes

## Philosophy

- Design philosophically sound systems - users should arrive at unbiased understanding
- Build systems that stay simple
- Do not hide system details
- Clarity yields deterministic outcomes; ambiguity breeds brittleness
