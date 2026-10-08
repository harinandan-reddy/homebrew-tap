# homebrew-tap

Personal Homebrew tap. Add it once with `brew tap harinandan-reddy/tap`, or use the full name in each install command as shown below.

## SigNoz MCP Server

A formula for the [SigNoz MCP server](https://github.com/SigNoz/signoz-mcp-server). It lets MCP clients such as Claude or Cursor query your SigNoz observability data. The formula installs the prebuilt release binary for macOS and Linux, on both Intel (amd64) and ARM (arm64).

    brew install harinandan-reddy/tap/signoz-mcp-server

A GitHub Actions workflow checks for new SigNoz releases and bumps the formula version and checksums automatically.

## JetBrains Junie CLI

Casks for the [Junie CLI](https://www.jetbrains.com/junie), JetBrains' coding agent. They support macOS only. Each cask installs one release channel and puts a `junie` command on your PATH. The casks conflict with each other, so only one channel can be installed at a time.

    brew install --cask harinandan-reddy/tap/junie          # release
    brew install --cask harinandan-reddy/tap/junie@eap      # EAP
    brew install --cask harinandan-reddy/tap/junie@nightly  # nightly

- `junie` is the stable release channel. Use it unless you need newer features.
- `junie@eap` is the early access channel. It gets new features before the stable release and may have bugs.
- `junie@nightly` is the nightly channel. It is the newest and least tested build.

The `junie` command is a small wrapper that turns off Junie's built-in self-update, so Homebrew handles upgrades. Casks are used instead of formulas because Homebrew would break the code signature on Junie's macOS app bundle, and macOS would then refuse to run it. A script in `.github/gen.sh` regenerates the casks from the JetBrains GitHub releases, and a scheduled workflow commits any changes.

Uninstalling normally keeps your settings and logs in `~/.junie`. Uninstall with `--zap` to delete that directory too.

## SCIP tools

Formulas for the [SCIP](https://github.com/scip-code/scip) code intelligence protocol.

    brew install harinandan-reddy/tap/scip       # SCIP CLI
    brew install harinandan-reddy/tap/scip-java  # indexer for Java, Scala and Kotlin

- `scip` is the SCIP command line tool. It installs the prebuilt release binary for macOS and Linux, on Intel and ARM.
- `scip-java` is the [SCIP indexer for Java, Scala and Kotlin](https://github.com/scip-code/scip-java). It installs the release launcher and depends on Homebrew's `openjdk`, which it uses to run.

The same GitHub Actions workflow checks for new releases of both and bumps the formula version and checksums automatically.

## cc-sessions

A formula for [cc-sessions](https://github.com/chronologos/cc-sessions), a fast command line tool that lists and resumes Claude Code sessions across all projects. It installs the prebuilt release binary for macOS and Linux. Upstream ships only an ARM build for macOS, so Intel Macs run it under Rosetta.

    brew install harinandan-reddy/tap/cc-sessions

The same GitHub Actions workflow checks for new releases and bumps the formula version and checksums automatically.

## codegraph

A formula for [codegraph](https://github.com/colbymchenry/codegraph), a local code knowledge graph that AI coding agents query instead of searching files. It installs the prebuilt release bundle, which includes its own Node runtime, for macOS and Linux on ARM and Intel.

    brew install harinandan-reddy/tap/codegraph

The same GitHub Actions workflow checks for new releases and bumps the formula version and checksums automatically.

## abtop

A formula for [abtop](https://github.com/graykode/abtop), a terminal monitor like htop for AI coding agents. It shows Claude Code and Codex CLI sessions, token use, context window, rate limits, and open ports. It installs the prebuilt release binary for macOS and Linux on ARM and Intel.

    brew install harinandan-reddy/tap/abtop

The same GitHub Actions workflow checks for new releases and bumps the formula version and checksums automatically.

## Launchyard

A cask for [Launchyard](https://github.com/jayhickey/Launchyard), a native macOS app for managing launchd services. It needs macOS 14 or newer. The app is not notarized, so the cask prints the command to clear the quarantine flag if macOS blocks it.

    brew install --cask harinandan-reddy/tap/launchyard

The same GitHub Actions workflow bumps the cask version and checksum automatically. The checksum comes from the digest GitHub shows for the release asset.
