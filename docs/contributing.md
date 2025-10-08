# Contributing Guidelines
> © 2025 [Maktab-e-Digital Systems Lahore](https://github.com/medsee-uet)  
> Licensed under the Apache 2.0 License.

## Reporting Issues

Before submitting an issue, please **search existing issues** to make sure the problem hasn't already been reported.

### Bug Report Template 

If you find a defect or error, please open a new issue and use the following template to help us quickly diagnose and resolve the problem:

1.  **Summary:** A concise, one-sentence description of the bug.
2.  **Steps to Reproduce:**
    * Step 1 (e.g., Go to X screen)
    * Step 2 (e.g., Click the Y button)
    * Step 3 (e.g., Observe Z result)
3.  **Expected Behavior:** What you thought should happen.
4.  **Actual Behavior:** What actually happened, including any error messages from the console or logs.
5.  **Environment:** (e.g., OS, Browser/Version, Project Version/Commit Hash).

### Feature Request Guidelines 

Have an idea for how to improve the project? Open a new issue and follow these guidelines:

1.  **Motivation:** Clearly explain the problem this feature solves or the value it adds. *Why* do we need this?
2.  **Proposed Solution:** Describe the feature in detail. How should it work from a user's perspective?
3.  **Alternatives Considered:** Briefly mention any workarounds you have tried or alternative designs you've thought about.

### Issue Labels and Priorities 

We use labels to manage the workflow and priority of issues.

| Label | Description | Priority |
| :--- | :--- | :--- |
| `bug` | A confirmed problem or error. | High |
| `enhancement` | Request for a new feature or improvement. | Medium |
| `documentation` | Issues related to project docs, guides, or tutorials. | Low |
| `help wanted` | Issues suitable for new contributors. | Medium |
| `critical` | Blocking or severe issue causing major breakage. | **Urgent** |

### Testing Before Submission 

Before submitting any issue (bug or feature), please ensure you have:

* **Isolated the issue** by checking if it persists on the latest stable version of the project.
* **Provided minimal reproduction steps** (for bugs) or a clear explanation (for features).
* **Verified** that the bug or feature is not already addressed or implemented in the codebase.

---

## Maintaining Code Quality 

Any pull request (PR) should aim to maintain or improve the overall quality of the codebase.

* **Coding Style:** All code must adhere to the project's established style guide (e.g., use the provided linters and formatters).
* **Testing:** New features must include **unit tests**. Bug fixes should ideally include a test that fails before the fix and passes after it.
* **Commit Messages:** Use **clear, descriptive commit messages**. We recommend following the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification (e.g., `fix: correct infinite loop in widget`, `feat: add email validation`).
* **Review:** Be prepared to iterate on your code based on feedback from maintainers.
---
Licensed under the **Apache License 2.0**  
Copyright © 2025  
**[Maktab-e-Digital Systems Lahore](https://github.com/meds-ee-uet)**