# semantic-release Implementation Guide

## Introduction

This project uses [semantic-release](https://semantic-release.gitbook.io/semantic-release/) to automate versioning and releases based on conventional commit messages. This ensures consistent, reliable, and hands-off releases, reducing manual errors and improving traceability.

---

## Implementation Details

### Key Files in the Repository

- [`.releaserc.yaml`](./.releaserc.yaml): Main semantic-release configuration.
- [`.github/chainguard/semantic-release.sts.yaml`](./.github/chainguard/semantic-release.sts.yaml): Octo STS trust policy for secure GitHub token federation.
- [`.github/workflows/semantic-release.yaml`](./.github/workflows/semantic-release.yaml): GitHub Actions workflow for running semantic-release.
- [`.github/workflows/docker-build.yaml`](./.github/workflows/docker-build.yaml): Docker build and push workflow.
- [`.github/workflows/enforce-pr-conventional-commits.yaml`](./.github/workflows/enforce-pr-conventional-commits.yaml): Enforces PR titles to follow [Conventional Commits](https://www.conventionalcommits.org/).

### External References

- [semantic-release documentation](https://semantic-release.gitbook.io/semantic-release/)
- [Octo STS](https://github.com/liatrio/octo-sts-guide)
- [action-semantic-pull-request](https://github.com/amannn/action-semantic-pull-request)
- [GitHub: Configure squash merging](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/configuring-commit-squashing-for-pull-requests)

---

## Key Design Decisions & Trade-offs

- **Automated Releases:** semantic-release automates versioning and changelog generation, reducing manual intervention.
- **Security:** Uses Octo STS for secure, scoped GitHub token generation. Requires installing the [Octo STS GitHub App](https://github.com/apps/octo-sts) and updating branch protection rules to allow the app to bypass restrictions.
- **Conventional Commits Enforcement:** PR titles must follow the Conventional Commits spec, enforced via [action-semantic-pull-request](https://github.com/amannn/action-semantic-pull-request).
- **Squash Merging:** "Squash and merge" is enabled, with the PR title as the default commit message, ensuring clean commit history and proper release notes.
- **Branch Protection:** The `master` branch requires PRs and passing status checks before merging, ensuring code quality and release integrity.

---

## Component Interaction Diagram

```mermaid
flowchart TD
    Developer -->|PR with Conventional Commit Title| GitHub
    GitHub -->|PR Title Lint| PR_Linter
    PR_Linter -->|Status| GitHub
    GitHub -->|Merge PR (Squash)| master
    master -->|Push triggers| CI_Workflows
    CI_Workflows -->|semantic-release.yaml| SemanticRelease
    SemanticRelease -->|Needs Token| OctoSTS
    OctoSTS -->|Federated Token| SemanticRelease
    SemanticRelease -->|Release| GitHub_Releases
    SemanticRelease -->|Tag| master
    CI_Workflows -->|docker-build.yaml| DockerBuild
    DockerBuild -->|Build & Push| ContainerRegistry
```

---

## Summary of Actions

- Added semantic-release configuration and workflows.
- Integrated Octo STS for secure token management.
- Enforced PR title linting for Conventional Commits.
- Enabled squash merging with PR title as commit message.
- Updated branch protection rules for automation.
- Communicated new PR requirements to contributors.

---

**Next Steps:**  
- Install the [Octo STS app](https://github.com/apps/octo-sts).
- Update branch protection to allow Octo STS bypass.
- Ensure all contributors follow the new PR title convention.