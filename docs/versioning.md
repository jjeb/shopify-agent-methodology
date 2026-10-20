# Versioning and Releases

Shopify Agent Methodology uses repository-wide Semantic Versioning. All six
MVP roles are released together because their contracts, references, routing,
and validators are designed as one coordinated package.

## Source of truth

The current version is the single value in [`VERSION`](../VERSION). It must be
an `X.Y.Z` SemVer value, optionally with a pre-release or build suffix.

The changelog is [`CHANGELOG.md`](../CHANGELOG.md). Keep an `Unreleased`
section at the top and add a dated section when preparing a release.

## Version increments

- **Patch** (`0.1.1`): documentation corrections, link fixes, validator fixes,
  generated-reference refreshes, or other backward-compatible corrections.
- **Minor** (`0.2.0`): new roles, workflows, evaluation capabilities, or
  backward-compatible behavior that expands the package.
- **Major** (`1.0.0` or later): breaking skill names, package layout, install
  behavior, role contracts, or routing semantics.

During the `0.x` phase, a minor release may still contain deliberate contract
changes, but the changelog must call them out clearly.

## Release procedure

1. Update `VERSION` and move the completed entries from `Unreleased` into a
   dated version section in `CHANGELOG.md`.
2. Regenerate and verify skill-local references:

   ```bash
   python3 scripts/sync-skill-references.py
   python3 scripts/sync-skill-references.py --check
   ```

3. Run the complete validation suite from [`CONVENTIONS.md`](../CONVENTIONS.md).
4. Commit the release contents with an imperative message, for example:
   `release: v0.2.0`.
5. Create an annotated tag matching the version file:

   ```bash
   git tag -a v$(tr -d '\n' < VERSION) -m "Release v$(tr -d '\n' < VERSION)"
   git push origin main --follow-tags
   ```

6. The tag workflow validates the tag and creates the GitHub release with
   generated release notes.

Never reuse a published version tag. If a release has a mistake, increment the
patch version and publish a new tag.

## Development versions

Use SemVer pre-release values such as `0.2.0-rc.1` when a public candidate
needs testing. Do not publish arbitrary branch names as versions. Unreleased
work remains under `## [Unreleased]` until its version is selected.
