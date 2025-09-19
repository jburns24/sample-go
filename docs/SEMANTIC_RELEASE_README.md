# semantic-release Implementation Guide

## Introduction

This project uses **semantic-release** to automate versioning and changelog generation based on commit messages, ensuring consistent releases and reducing manual effort. The setup integrates with GitHub Actions, enforces Conventional Commits via PR titles, and leverages octo-sts for secure GitHub token management.

---

## Implementation Details

### Key Files in the Repository

- [`.releaserc.yaml`](file:///Users/jburns/git/sample-go/.releaserc.yaml): semantic-release configuration.
- [`.github/chainguard/semantic-release.sts.yaml`](file:///Users/jburns/git/sample-go/.github/chainguard/semantic-release.sts.yaml): octo-sts trust policy for GitHub token federation.
- [`.github/workflows/semantic-release.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/semantic-release.yaml): GitHub Actions workflow for semantic-release.
- [`.github/workflows/docker-build.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/docker-build.yaml): Docker build and push workflow.
- [`.github/workflows/enforce-pr-conventional-commits.yaml`](file:///Users/jburns/git/sample-go/.github/workflows/enforce-pr-conventional-commits.yaml): PR title linter workflow.

### External References

- [semantic-release documentation](https://semantic-release.gitbook.io/semantic-release/)
- [octo-sts GitHub App](https://github.com/apps/octo-sts)
- [action-semantic-pull-request](https://github.com/amannn/action-semantic-pull-request)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

## Key Design Decisions & Trade-offs

- **Automated Releases:** semantic-release automates versioning and changelog generation, reducing manual errors.
- **Security:** octo-sts is used for secure, scoped GitHub token issuance, requiring the octo-sts app and branch protection bypass configuration.
- **PR Title Enforcement:** PR titles must follow the Conventional Commits spec, enforced via GitHub Actions, ensuring semantic-release can determine release types.
- **Squash & Merge:** Repository is configured to squash PRs, using the PR title as the commit message for clear, consistent history.
- **Branch Protections:** `master` branch requires PRs and passing status checks, including the PR title linter.

**Trade-offs:**
- Enforcing PR title conventions may require contributor education.
- octo-sts setup adds initial complexity but improves security.

---

## Component Interaction Diagram

```mermaid
flowchart TD
    Developer -->|PR with Conventional Commit title| GitHub
    GitHub -->|PR Title Linter| PR_Lint_Workflow
    PR_Lint_Workflow -->|Status Check| GitHub
    GitHub -->|Merge PR (Squash & Merge)| master
    master -->|Push Event| Semantic_Release_Workflow
    Semantic_Release_Workflow -->|octo-sts Action| octo-sts
    octo-sts -->|Federated Token| Semantic_Release_Workflow
    Semantic_Release_Workflow -->|semantic-release| Release
    Release -->|Tag/Release| GitHub
    Semantic_Release_Workflow -->|Trigger Docker Build| Docker_Build_Workflow
```

---

## Summary of Actions

- Added semantic-release configuration and workflows.
- Integrated octo-sts for secure token management.
- Enforced PR title conventions with action-semantic-pull-request.
- Enabled squash & merge with PR title as commit message.
- Configured branch protections and status checks.
- Communicated new PR title requirements to contributors.

---

**Next Steps:**  
- Install the [octo-sts app](https://github.com/apps/octo-sts).
- Update branch protections to allow octo-sts to bypass restrictions if needed.