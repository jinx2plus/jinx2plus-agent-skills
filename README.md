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

The repository contains only skill instructions and their needed reference files. It excludes credentials, database contents, project data, and generated artifacts. A few domain skills intentionally retain operational path examples such as `/data2/ksafer`.
