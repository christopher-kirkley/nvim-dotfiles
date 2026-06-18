# Branch-vs-base review with diffview.nvim

## Goal

Review the files changed in a branch — the way GitHub's "Files changed" tab
works — from inside Neovim, instead of bouncing to the browser and back. The
trigger is reviewing work (often produced by cloud agents) that is already
committed on a branch.

## Scope

In scope:
- A focused "changed files" review view showing **branch vs base** changes
  (all files differing between the current branch and its merge-base with the
  default branch), including already-committed changes.

Out of scope (explicitly deferred):
- A persistent sidebar file tree for general navigation. Telescope already
  covers name-based navigation; revisit only if a structural map is missed.
- Migrating the plugin manager from vim-plug to lazy.nvim. Orthogonal cleanup.
- Adopting the LazyVim distribution. Its default explorer shows working-tree
  status (not branch-vs-base) and for this goal would still require diffview.

## Approach

Use `sindrets/diffview.nvim`, which is purpose-built for reviewing a git
revision range as a file panel plus side-by-side diffs. Chosen over:
- **fugitive** (already installed): can do it via `:Git difftool <range>` +
  quickfix, but the file list is transient and command-driven rather than a
  persistent review panel.
- **neo-tree git_status source**: reflects working-tree status only, so it
  misses committed changes — wrong fit for branch-vs-base.

## Plugins

Added to the existing vim-plug block in `init.vim`:
- `sindrets/diffview.nvim` — the review tool.
- `nvim-tree/nvim-web-devicons` — filetype icons in the file panel.

`nvim-lua/plenary.nvim` is already installed (used by telescope).

## Config layout

Follows the existing split in this config:
- `init.vim`: the two `Plug` lines, and the `nnoremap` keymaps (alongside the
  existing `<leader>ff` / `<leader>fg` mappings).
- `lua/init.lua`: `require('diffview').setup{}` plus a `ReviewBranch`
  user-command that performs base detection.

## Base-branch detection

A `:ReviewBranch` user-command auto-detects the base so the workflow is
identical across repos that use `main` vs `master`:

1. Try, in order: `origin/main`, `origin/master`, `main`, `master`.
   Use the first that resolves via `git rev-parse --verify --quiet <ref>`.
2. Open `:DiffviewOpen <base>...HEAD`.

The `...` (triple-dot) range gives PR semantics: only what the current branch
added since it diverged from the base, not unrelated changes that landed on the
base afterward.

If no base ref resolves (e.g. not a git repo, or none of the candidates exist),
the command reports a clear message and does nothing.

## Keymaps (new `<leader>g` "git" namespace)

- `<leader>gd` → `:ReviewBranch<CR>` — review current branch vs detected base.
- `<leader>gD` → `:DiffviewOpen ` (left on the command line) — review against a
  base typed by hand, e.g. a tag or `HEAD~3`.
- `<leader>gh` → `:DiffviewFileHistory %<CR>` — history of the current file.
- `<leader>gc` → `:DiffviewClose<CR>` — close the review view.

## Workflow

Open Neovim in the repo → `<leader>gd` → file panel lists every changed file vs
base → `j`/`k` + `Enter` to walk files and read side-by-side diffs → jump into
the real file to edit → `<leader>gc` to close.

## Verification

1. `:PlugInstall` succeeds and `:Diffview*` commands exist.
2. On a branch with commits ahead of the base, `<leader>gd` opens a panel
   listing exactly the changed files, with diffs rendering.
3. Icons render (web-devicons active).
4. `<leader>gc` closes cleanly.
5. Sanity check independent of branch state: `<leader>gD HEAD~3<CR>` shows the
   last three commits' changes.

Note: on `master` with only uncommitted edits, `<leader>gd` correctly shows
nothing vs base (you are on the base); test against a feature branch or via the
`HEAD~3` check above.
