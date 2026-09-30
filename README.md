# jinx2plus-agent-skills

Portable personal `SKILL.md` collection for Codex and Gajae Code.

## Included skills

| Skill | Purpose |
| --- | --- |
| `tamspython-geospatial` | TAMSPython, PostGIS, DTG, EPSG:32652, and topology-safe processing |
| `ksafer-hwpx-manual` | KSAFER HWPX manual edits with structure and layout validation |
| `kordoc` | Korean HWP/HWPX document workflows |
| `rhwp-cli` | HWP/HWPX inspection and rendering through rhwp |
| `pdf` | PDF creation, inspection, and visual QA |
| `graphify` | Codebase graph analysis and repository navigation |

`patina` is intentionally not vendored. It is a standalone project with its own CLI, scripts, and large research artifacts; install it separately from its maintained upstream source, then keep its installation under the same host skill directory.

## Install

Clone this private repository on the destination computer, then install for the target agent.

```bash
git clone https://github.com/jinx2plus/jinx2plus-agent-skills.git
cd jinx2plus-agent-skills
./install.sh codex
./install.sh gajae
```

Windows PowerShell:

```powershell
git clone https://github.com/jinx2plus/jinx2plus-agent-skills.git
Set-Location jinx2plus-agent-skills
.\install.ps1 codex
.\install.ps1 gajae
```

The installer stops if a same-named skill already exists. Use `--force` only when replacing it intentionally.

For Gajae Code, skills install to `~/.gjc/agent/skills`; start a new `gjc` session afterwards. For Codex, skills install to `~/.codex/skills`; start a new Codex task afterwards.

## Updating

```bash
git pull --ff-only
./install.sh codex --force
./install.sh gajae --force
```

The repository contains only skill instructions and their needed reference files. It excludes credentials, database contents, project data, and generated artifacts. Domain skills use `KSAFER_SERVER_ROOT` as a server-root alias.

## Verified local agent environment

The following was checked on the source Windows computer on 2026-09-30. Model access and model names can change with an account, provider, or local configuration update.

| Surface | Verified version or configured default | Use here |
| --- | --- | --- |
| Codex CLI | `codex-cli 0.159.2`; `gpt-6-astra`, reasoning `low` | Main coding harness and personal-skill host |
| Gajae Code | WSL `gjc/0.18.1`; `openai-codex/gpt-5.4:medium` | Interactive coding-agent runtime |
| Gajae model profiles | `qwen3.8-max` at `medium`/`high`; `glm-5.2:high` | Alternative local Gajae profiles |
| Orca | `1.4.217` | Project, worktree, terminal, and agent-runtime orchestration UI |
| OMO | `5.0.1` (Senpi engine `2026.9.27`) | Multi-agent harness and orchestration CLI |
| Grok Agent | `agent` CLI `1.0.44` | Alternate coding-agent CLI |

### Typical workflows

Codex runs directly against the Windows workspace. Install the skills, then start a new task so the skill catalog is reloaded:

```powershell
.\install.ps1 codex
codex
```

Gajae Code runs in WSL on this computer. Install the skills to its canonical user scope, open a new WSL terminal, and start `gjc`. Invoke an installed skill as `/skill:<name>` when needed.

```bash
./install.sh gajae
gjc
# example: /skill:tamspython-geospatial
```

Use Orca when one project needs worktree isolation or a managed terminal session. Configure its agent runtime to WSL before selecting Gajae Code, because this machine's `gjc` executable is installed in WSL. OMO and the Grok Agent are separate command-line harnesses; start them from a terminal in the target repository and let each retain its own credentials and model configuration.
