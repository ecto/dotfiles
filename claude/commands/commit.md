---
name: commit
description: Create a git commit with a well-crafted message
---

# Commit

Create git commits with clear, conventional commit messages.

## Workflow

### 1. Analyze Changes

```bash
git status
git diff --cached  # staged
git diff           # unstaged
```

### 2. Clean Up Debug Statements

Before committing, remove or convert debug statements:

- **Remove**: `console.log`, `dbg!`, `println!` added during development
- **Convert** (if useful long-term): Use proper logging (`tracing` for Rust, project logger for TS)

### 3. Commit in Logical Chunks

Group related changes into separate commits:

- Each commit = one logical change
- Don't mix unrelated changes
- Order commits to tell a coherent story
- Ask for clarification if grouping is unclear

### 4. Create Commits

Format: `<type>(<scope>): <description>`

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `refactor`: Code restructuring (no behavior change)
- `test`: Add/update tests
- `chore`: Tooling, dependencies, build config
- `style`: Code style (formatting, no logic change)
- `perf`: Performance improvement

**Examples**:
- `feat(auth): add OAuth2 login flow`
- `fix(api): handle timeout on slow connections`
- `refactor(utils): extract date formatting helpers`

### 5. Verify

After committing, run verification appropriate to the project:

```bash
# Rust
cargo check && cargo clippy && cargo test

# TypeScript
npm run lint && npm run build
```

If verification fails: fix issues and amend or create a fixup commit.

## Guidelines

- Keep summary under 50 characters
- Use imperative mood ("Add feature" not "Added feature")
- Body explains *why*, not *what*
- Never commit secrets (.env, credentials, API keys)
- Always include Co-Authored-By line
