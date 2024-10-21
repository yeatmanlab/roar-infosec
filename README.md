# ROAR Information Security and Data Privacy Repository

This repository is dedicated to managing the key documentation and automated workflows for ROAR's information security and data privacy efforts. It includes policies, procedures, and GitHub Actions designed to ensure compliance with privacy regulations and maintain robust security practices throughout ROAR's software development lifecycle.

## Repository Contents

- [LICENSE](./LICENSE): The LICENSE for this repository
- [Makefile](./Makefile): A Makefile to generate pdf versions of markdown documents.
- [README.md](./README.md): This README.md file
- [employee-lifecycle](./employee-lifecycle): Checklists to aid in the onboarding, offboarding, and regular account review of ROAR employees
  - [account-review-checklist.md](./employee-lifecycle/account-review-checklist.md)
  - [offboarding-checklist.md](./employee-lifecycle/offboarding-checklist.md)
  - [onboarding-checklist.md](./employee-lifecycle/onboarding-checklist.md)
- [github-templates](./github-templates/)
  - [security-review.md](./github-templates/security-review.md): A security review checklist that must be reviewed before ROAR software changes are deployed into production
- [roar-bcdr.md](./roar-bcdr.md): ROAR's business continuity and disaster recovery plan in markdown format
- [roar-bcdr.pdf](./roar-bcdr.pdf): ROAR's business continuity and disaster recovery plan in PDF format
- [roar-data-privacy-and-information-security-manual.md](./roar-data-privacy-and-information-security-manual.md): ROAR's data privacy and information security manual in markdown format
- [roar-data-privacy-and-information-security-manual.pdf](./roar-data-privacy-and-information-security-manual.pdf): ROAR's data privacy and information security manual in PDF format
- [roar-sdlc.md](./roar-sdlc.md): ROAR's Software Development Lifecycle policies and procedures in markdown format.
- [roar-sdlc.pdf](./roar-sdlc.pdf): ROAR's Software Development Lifecycle policies and procedures in PDF format.
- [sisa-training-log.md](./sisa-training-log.md): A training log documenting ROAR developers' completion of required Stanford Information Security Academy Training
- [vendor-assessments](./vendor-assessments/): A directory containing markdown and PDF versions of ROAR's third-party vendor information security assessments.
- [.github/workflows](./.github/workflows/): GitHub workflows. See below for further details.

## GitHub Actions

The [.github/workflows](./.github/workflows/) directory contains GitHub action workflows that enforce some of ROAR's information security policies:

- Quarterly document review:
  - [infosec-doc-review.yml](./.github/workflows/infosec-doc-review.yml)
    This workflow generates a GitHub issue every quarter asking ROAR leadership to review and, if necessary, update the documents in this repository.
  - [request-employee-acknowledgment.yml](./.github/workflows/request-employee-acknowledgment.yml) and [acknowledgment-request-template.md](./.github/workflows/acknowledgment-request-template.md)
    This workflow reminds the ROAR information security officer to generate issues a batch of issues, one for each ROAR employee, requesting that each employee review the documents in this repository.
  - [log-acknowledgment.yml](./.github/workflows/log-acknowledgment.yml)
    When employees commend "Confirmed" on the aforesaid issue, this workflow automatically closes the issue and logs their acknowledgment in the acknowledgment log.

- Managing employee lifecycles
  - [onboarding.yml](./.github/workflows/onboarding.yml)
    This manually triggered workflow generates an employee onboarding checklist as a GitHub issue and assigns it to the ROAR information security officer.
  - [offboarding.yml](./.github/workflows/offboarding.yml)
    This manually triggered workflow generates an employee offboarding checklist as a GitHub issue and assigns it to the ROAR information security officer.
  - [quarterly-account-review.yml](./.github/workflows/quarterly-account-review.yml)
    This workflow opens a GitHub issue every quarter requiring that the ROAR information security officer reviews employee accounts and access.

- Developer training
  - [request-sisa-training.yml](./.github/workflows/request-sisa-training.yml) and [sisa-training-request-template.md](./.github/workflows/sisa-training-request-template.md)
    This workflow automatically opens issues to request that ROAR developers complete their annual Stanford Information Security Academy (SISA) training and log completion in the repository's training log.
