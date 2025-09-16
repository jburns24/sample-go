# Semantic Release Implementation Guide

## Introduction

This documentation describes how semantic-release was implemented in the `jburns24/sample-go` repository to automate versioning and releases based on commit messages, ensuring a consistent and reliable release process.

---

## Implementation Details

### Key Files in the Repository

- [`.releaserc.yaml`](file:///Users/jburns/git/sample-go/.releaserc.yaml): Main configuration for semantic-release.
- [`.github/chainguard/semantic-release.sts.yaml`](file:///Users/jburns/git/sample-go/.github/chainguard/semantic-release.sts.yaml): Octo STS trust policy for federated GitHub App tokens.
- [`.github/workflows/semantic-release.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/semantic-release.yaml): GitHub Actions workflow to run semantic-release.
- [`.github/workflows/docker-build.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/docker-build.yaml): Docker build and push workflow.
- [`.github/workflows/enforce-pr-conventional-commits.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/enforce-pr-conventional-commits.yaml): Enforces PR title format.

### External References

- [semantic-release documentation](https://semantic-release.gitbook.io/semantic-release/)
- [Octo STS GitHub App](https://github.com/apps/octo-sts)
- [action-semantic-pull-request](https://github.com/amannn/action-semantic-pull-request)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## Key Design Decisions & Trade-offs

- **Federated Auth with Octo STS:** Used Octo STS for secure, scoped GitHub App tokens. Requires installing the [Octo STS app](https://github.com/apps/octo-sts) and configuring branch protection to allow bypass.
- **Automated Release Workflow:** Releases are triggered on pushes to the default branch (`master`), using semantic-release to analyze commit messages and publish releases.
- **Enforced Conventional Commits:** PR titles are validated using [action-semantic-pull-request](https://github.com/amannn/action-semantic-pull-request) to ensure compatibility with semantic-release.
- **Squash Merging:** Enabled squash merging with PR title as the default commit message to maintain clean, meaningful commit history.
- **Branch Protection:** Configured to require PRs and status checks before merging, improving code quality and release reliability.
- **Docker Build Integration:** Automated Docker image builds and pushes are handled in a separate workflow.

**Trade-offs:**  
- Using Octo STS adds setup complexity but improves security and compliance.
- Enforcing PR title conventions may require contributor education.

---

## Component Interaction Diagram

```mermaid
flowchart TD
    Developer -->|PR with Conventional Commit Title| GitHub
    GitHub -->|PR Title Lint| action-semantic-pull-request
    GitHub -->|On Merge to master| semantic-release-workflow
    semantic-release-workflow -->|Requests Token| Octo STS
    Octo STS -->|Issues Scoped Token| semantic-release-workflow
    semantic-release-workflow -->|Publishes Release| GitHub Releases
    semantic-release-workflow -->|Triggers| Docker Build Workflow
    Docker Build Workflow -->|Builds & Pushes Image| Container Registry
```

---

## Summary of Steps

- Added semantic-release configuration and workflows.
- Integrated Octo STS for secure GitHub App authentication.
- Enforced PR title conventions using action-semantic-pull-request.
- Enabled squash merging with PR title as commit message.
- Configured branch protection and status checks.
- Automated Docker builds and pushes.

---

For more details, see the linked files and external documentation above.