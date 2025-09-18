# semantic-release Implementation Guide

## Introduction

This project uses [semantic-release](https://semantic-release.gitbook.io/semantic-release/) to automate versioning and changelog generation based on conventional commit messages. Releases are triggered by merges to the `master` branch and are fully automated via GitHub Actions, with additional security and compliance provided by [octo-sts](https://github.com/liatrio/octo-sts-guide).

---

## Implementation Details

### Key Files in the Repository

- [`.releaserc.yaml`](file:///Users/jburns/git/sample-go/.releaserc.yaml): semantic-release configuration.
- [`.github/chainguard/semantic-release.sts.yaml`](file:///Users/jburns/git/sample-go/.github/chainguard/semantic-release.sts.yaml): octo-sts trust policy for secure token federation.
- [`.github/workflows/semantic-release.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/semantic-release.yaml): GitHub Actions workflow for releases.
- [`.github/workflows/docker-build.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/docker-build.yaml): Docker build and push workflow.
- [`.github/workflows/enforce-pr-conventional-commits.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/enforce-pr-conventional-commits.yaml): Enforces PR titles to follow [Conventional Commits](https://www.conventionalcommits.org/).

### External References

- [semantic-release docs](https://semantic-release.gitbook.io/semantic-release/)
- [octo-sts guide](https://github.com/liatrio/octo-sts-guide)
- [action-semantic-pull-request](https://github.com/amannn/action-semantic-pull-request)
- [GitHub: Configure commit squashing](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/configuring-commit-squashing-for-pull-requests)

---

## Key Design Decisions & Trade-offs

- **Automated Releases:** semantic-release ensures consistent, automated versioning and changelog generation, reducing manual errors.
- **Security:** octo-sts is used for secure, least-privilege GitHub token federation, required for bypassing branch protections during automated releases.
- **Conventional Commits:** Enforced via PR title linting and squash merges, ensuring semantic-release can determine the correct version bump.
- **Branch Protections:** Branch protection rules are configured to require PRs and passing status checks, but octo-sts is allowed to bypass for releases.
- **No Manual Versioning:** Version numbers are never manually set; semantic-release determines them from commit history.

---

## Component Interaction Diagram

```mermaid
flowchart TD
    Developer -->|PR| GitHub
    GitHub -->|PR Title Lint| PR_Linter
    PR_Linter -->|Status| GitHub
    GitHub -->|Merge (Squash)| master
    master -->|Push| GitHub_Actions
    GitHub_Actions -->|semantic-release| semanticRelease
    semanticRelease -->|Needs Token| octoSTS
    octoSTS -->|Federated Token| semanticRelease
    semanticRelease -->|Release| GitHub_Releases
    semanticRelease -->|Tag| master
    semanticRelease -->|Trigger| Docker_Build
    Docker_Build -->|Build/Push| Container_Registry
```

---

## Summary of Steps

- Added semantic-release config and workflows.
- Integrated octo-sts for secure token handling.
- Enforced PR title conventions with action-semantic-pull-request.
- Enabled squash & merge with PR title as default commit message.
- Configured branch protections and status checks.
- Communicated requirements to contributors.

---

## Next Steps

- [ ] Install [octo-sts app](https://github.com/apps/octo-sts).
- [ ] Allow octo-sts to bypass branch protections if enabled.
- [ ] Communicate PR title requirements in `CONTRIBUTING.md`.