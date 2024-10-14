---
title: "ROAR Data Privacy and Information Security Manual"
subject: "ROAR information security"
keywords: [Information Security, Data Privacy, ROAR]
lang: "en"
titlepage: true
titlepage-color: "8C1515"
titlepage-text-color: "FFFFFF"
...

**Version**: `{{ version }}`\
**Last Updated by Commit**: `{{ commit }}`\
**Last updated on**: `{{ commit_date }}`

## Introduction

### Purpose

This Data Privacy and Information Security Manual provides an overview of the policies and practices implemented by the ROAR team to ensure the security and privacy of data. The goal of this manual is to safeguard sensitive information, maintain regulatory compliance, and protect the confidentiality, integrity, and availability of data used in the ROAR application.

### Scope

This manual applies to all ROAR employees, contractors, and third-party vendors who interact with the ROAR platform. It covers the collection, processing, storage, transmission, and destruction of data through the ROAR platform, including but not limited to data from students, teachers, caregivers, research participants, and partner administrators.

---

## Data Privacy Policy

ROAR is committed to protecting the privacy of students, educators, and other stakeholders. This policy explains how we collect, use, share, and protect data, including personally identifiable information (PII).

### Data Collection and Use

The data that ROAR collects from users can be broadly separated into two categories:

- **Personal Data**:
  ROAR receives student information such as student names for the purpose of sharing score reports with teachers. ROAR also collects grade level and date of birth (DOB) to generate standardized scores. For research purposes, ROAR also stores demographic information, such as a student's IEP status, free and reduced lunch status, and home language. When this information is used in research, it is always deidentified before publication.

  While the ROAR application does not directly store student IP addresses, these may be logged in Firebase audit logs for security purposes. These logs could be accessed during a security incident or breach investigation to aid in tracing unauthorized access or suspicious activity.

- **Assessment Data**:
  During student interactions with the app, ROAR collects data such as item responses, response times, start and end timestamps, and user actions like keyboard presses, mouse clicks, swipes, and taps. Additionally, the app collects browser and device information (e.g., whether the device is a laptop or tablet) to ensure optimal app performance.

Assessment data is stored separately from personal data. personally identifiable information (PII). The personal data is stored in the "admin" database, while the assessment data is stored in the "assessment" database.

While this data is stored separately, it is recombined when ROAR transmits back to the student’s teacher, school administrator, or district administrator student name, grade level, scores, and support levels for the purpose of score reporting.

### User Rights

Parents and guardians have the right to opt out of participation in ROAR and request that any existing data for their student be removed. These requests are made through each student's school.

> TODO:
> Insert more specific language about the opt-out process.
> Include the steps that each team takes to respond to an opt-out data deletion request.
> Do we include other GDPR-like rights. For example do data subjects (students and their guardians) have the right to access, correct, and delete their data?

### Sharing Data

ROAR only shares data with authorized individuals or entities, such as teachers or schools, and only when necessary to transmit score reports back to educational partners.

---

## Information Security Policy

ROAR's Information Security Policy ensures that all sensitive data, including student PII and assessment data, is protected against unauthorized access, breaches, and misuse. This policy follows industry best practices and complies with [Stanford's Minimum Security Standards for Applications][stanford-minsec] (hereafter referred to as "minsec").

### Roles and Responsibilities

- **Information Security Officer**:
  - Oversee the security program
  - Conduct risk assessments
  - Ensure compliance with this manual
  - Ensure that third-party vendors comply with ROAR's security requirements and maintain necessary industry certifications.
- **Employees**:
  - Follow security best practices
  - Review this manual quarterly
  - Complete required security training
  - Enroll all personal and Stanford-owned devices used for work with [Stanford Device Registration][]. Enroll each device for use with high risk data.
  - Enable multi-factor authentication on all GitHub accounts used for ROAR development.
  - For the following following third-party vendors, enable multi-factor authentication and always use a Stanford email for authentication:
    - Google, GCP, and Firebase
    - Sentry
    - Cypress Cloud
    - Google Drive
    - Clever
    - ClassLink
    - Redivis / Stanford Data Farm

### Key Security Controls

- [**Access Control**](#access-control-policy): Role-based access control (RBAC) ensures that only authorized users can access sensitive data.
- [**Encryption**](#encryption-policy): All data is encrypted at rest using AES-256 encryption and in transit using TLS/HTTPS.
- [**Regular monitoring and auditing**](#audit-logging-and-monitoring-policy): ROAR employs regular audits and monitoring of access logs as defined in [Regular monitoring and auditing](#regular-monitoring-and auditing)
- [**Incident Response Plan**](#incident-response-plan): Defined procedures for responding to data breaches.

---

## Access Control Policy

### Role-Based Access Control (RBAC)

To protect sensitive data, access to ROAR systems is controlled based on user roles and responsibilities. The ROAR team defines the following roles:

- **Super Administrators**: Full access to all data and systems. This is restricted to ROAR employees with a need for full access.
- **District Administrators**: Access to student data for a single district only.
- **School Administrators**: Access to student data for a single school only.
- **Educators**: Access to student data for assigned classes only.
- **Researchers**: Access to de-identified data for research purposes.
- **Caregivers**: Access to only their students' data for the purpose of viewing assessment scores.
- **Participants**: Access to only their own data for the purpose of completing assessments.
  
### Multi-Factor Authentication (MFA)

In accodance with minsec, all ROAR employees must use **Stanford Duo Mobile** for multi-factor authentication when accessing privileged accounts.

### Onboarding and Offboarding

User accounts are created for new employees based on their roles. Access is removed immediately upon termination of employment or change in role.

---

## Encryption Policy

ROAR enforces strict encryption policies to protect sensitive data. All data in transit, either between the ROAR application and users, or between different ROAR storage systems, is encrypted using **TLS/HTTPS**.

Data at rest is stored in multiple possible locations. Below, we describe each location along with it's associated encryption policy and key management policy:

- **Firebase Firestore** and other **Google Cloud Platform (GCP)** services
  - Encryption: This data is encrypted using the **AES-256** encryption standard.
  - Key management: The encryption keys themselves are encrypted and rotated regularly to ensure security. The management of encryption keys is handled by Google Cloud’s internal processes, which follow strict security protocols.
- **Google Drive**
  - Description: Data shared between districts and ROAR researchers, especially via CSV file uploads, is often stored in secure, shared Google Drive folders. This data is manually imported by authorized staff into the ROAR platform when necessary, using encrypted communication channels.
  - Encryption: This data is encrypted using the **AES-256** encryption standard.
  - Key management: The encryption keys themselves are encrypted and rotated regularly to ensure security. The management of encryption keys is handled by Google Cloud’s internal processes, which follow strict security protocols.
- Employee-owned or Stanford-owned **encrypted devices**:
  - Description: ROAR employees may perform manual file handling with data that is downloaded to and processed on Stanford-managed encrypted devices. Whether this device is employee-owned or Stanford-owned, it's security is managed by Stanford. These devices are required to be registered with Stanford University and approved for use with high-risk data.
  - Encryption: Device registration includes enrollment in [Jamf][] and [BigFix][] and whole disk encryption using the operating system's native encryption facilities.
  - Key management: The use of Jamf and BigFix ensure that operating system patches and updates are deployed in a timely manner and that encryption is verified in an ongoing way that can be centrally audited. The encryption keys themselves are managed by each individual employee.
- Stanford Data Farm (Redivis)
  Description: The [Stanford Data Farm][] is a data storage and analytics platform. It integrates with other ROAR data storage through manual or automated data export from the ROAR assessment Firestore database. It contains assessment results with de-identified data only (i.e., it excludes PII). Access is restricted to authorized ROAR researchers.

---

## Incident Response Plan

In the event of a data breach or security incident, ROAR follows a detailed incident response process to contain the breach, mitigate damage, and notify affected parties. As ROAR relies on Google Cloud Platform (GCP) and Firebase for its infrastructure, the breach response procedures are aligned with Google's established protocols for handling security incidents. Additionally, ROAR follows Stanford's minimum security (minsec) requirements, which further specify steps for breach management. Here’s an overview of the procedures and response timings:

1. Detection and Reporting of a Breach
   - Monitoring and Detection: Google Cloud and Firebase utilize automated systems for constant monitoring and logging of all access and activity across their platforms. Any abnormal behavior or access patterns are flagged for immediate review by Google's security teams.
   - Incident Reporting: If ROAR detects or suspects a breach (internally or through Google's detection systems), it is required to notify relevant stakeholders, including school districts and partners, per their data use agreements.
   - Timing: Immediate detection and notification systems are in place. For suspected breaches, Stanford’s internal policies require that affected parties be informed as soon as possible, typically within 72 hours of detecting the issue.
1. Initial Response and Containment
   - Initial Assessment: Once a breach is suspected or confirmed, the vendor (Google Cloud, in this case) initiates an immediate investigation to assess the scope and impact of the incident. At the same time, ROAR’s internal team would begin containment procedures, including suspending access or isolating affected systems.
   - Containment Measures: GCP’s infrastructure provides automated tools to block further unauthorized access, including halting affected services, rotating encryption keys, or revoking compromised credentials.
   - Timing: Containment actions are typically initiated within hours of detecting the breach.
1. Investigation and Root Cause Analysis
   - Forensic Analysis: Google’s security team works on identifying the root cause of the breach using forensic tools to trace the source and scope of the compromise. They examine logs, system changes, and any unauthorized access points.
   - ROAR Team’s Role: The ROAR team collaborates with Google to provide context for the incident and ensure Stanford’s data is safeguarded. ROAR's internal team, governed by Stanford’s security policies, plays a key role in determining what data, if any, has been compromised.
   - Timing: The investigation process can take 24 to 72 hours, depending on the complexity of the breach.
1. Notification of Affected Parties
   - Stakeholder Notification: In the event that personally identifiable information (PII) or sensitive information is compromised, ROAR, following Stanford’s minsec requirements, would notify affected school districts and individuals. The notification includes the type of data affected, the estimated scope, and steps taken to mitigate further risk.
   - Timing: Stakeholders are notified within 72 hours of confirming the breach.
1. Remediation and Recovery
   - Remediation Plan: Once the breach is contained, the vendor (Google Cloud) and ROAR initiate a remediation process, which may involve restoring systems from secure backups, reconfiguring security settings, or enhancing system defenses to prevent future occurrences.
   - Data Restoration: Any lost or corrupted data is restored from encrypted backups maintained on Google Cloud’s infrastructure, and system integrity is verified before returning services to normal operation.
   - Timing: Depending on the severity, the recovery process can take between 24 hours to several days.
1. Post-Incident Review and Reporting
   - Post-Mortem Analysis: After the issue is fully resolved, ROAR and Google Cloud perform a post-mortem analysis to identify lessons learned and implement additional security measures where needed. This analysis is shared with relevant parties if necessary.
   - Reporting: ROAR provides a detailed report to stakeholders (e.g., school districts) on the nature of the breach, the steps taken to mitigate it, and the corrective actions to prevent future incidents.
   - Timing: The post-incident report is generally provided within two weeks of the breach being fully resolved.

Key Timing Overview:

- Detection/Initial Notification: Immediate; stakeholders notified within 72 hours.
- Containment: Within hours of breach detection.
- Investigation: Completed within 24 to 72 hours.
- Full Remediation and Recovery: Can take 1-5 days, depending on complexity.
- Post-Incident Report: Delivered within two weeks.

### Response Steps

1. **Detection**: Incidents are detected through automated monitoring and user reports.
1. **Containment**: Immediate actions are taken to limit exposure (e.g., disabling compromised accounts).
1. **Investigation**: Forensic analysis is conducted to identify the root cause and affected data.
1. **Notification**: Affected users and regulatory authorities are notified within 72 hours, as required by law.
1. **Remediation**: Systems are restored, and security controls are strengthened to prevent future incidents.

---

## Audit Logging and Monitoring Policy

All user activities within the ROAR system are logged to ensure transparency and traceability.

### Logging

- **Login events**, **data access**, and **data modifications** are logged in Firebase audit logs.
- IP addresses and device information may be logged for security purposes.

### Monitoring

> TODO: How long are logs maintained
> TODO: Add information about GCP monitoring
> TODO: Add information about ROAR monitoring

---

<!---
## Data Protection Impact Assessment (DPIA)

> TODO: Review this

ROAR conducts DPIAs to assess risks and implement mitigation strategies for data processing activities that involve sensitive information.

### Assessment Process

1. **Identify Risks**: Review data collection and processing activities for potential privacy risks.
1. **Mitigate Risks**: Implement controls to reduce or eliminate identified risks (e.g., anonymization, access control).
1. **Document Findings**: DPIAs are documented and updated regularly as part of compliance reviews.

---
-->

## Security Certifications

ROAR operates on Google Cloud Platform (GCP) and Firebase, which are certified under various security standards including FedRAMP Moderate, SOC 2 Type II, and ISO/IEC 27001. These platforms provide the secure infrastructure that underpins ROAR's operations, ensuring that data is stored and processed in a compliant, secure environment. We provide details below on GCP and Firebase compliance with those standards.

- FedRAMP Certification:
  - FedRAMP Level: Google Cloud Platform and Firebase are FedRAMP Moderate certified.
  - Environment: ROAR is hosted in Google Cloud Platform’s nam5 multi-region, which complies with FedRAMP requirements for government data protection.
  - Security Controls: The certification includes compliance with over 325 security controls based on NIST SP 800-53, which covers areas such as access control, incident response, data encryption, and continuous monitoring.
  - Why This Matters: FedRAMP Moderate certification ensures that GCP meets strict U.S. federal security requirements, including those related to confidentiality, integrity, and availability of cloud services.
- SOC 1/2/3 Reports:
  - SOC 2 Type II Certification: Google Cloud services, including Firebase, undergo independent audits and are certified under SOC 2 Type II standards.
  - Security Controls: This certification ensures that Google Cloud implements and enforces strict controls related to security, availability, processing integrity, confidentiality, and privacy. These include regular security audits, encryption, access control, and threat detection.
  - Why This Matters: SOC 2 Type II certification ensures that Google Cloud consistently maintains high standards for data security and privacy, making it suitable for applications like ROAR, which handle sensitive student data.
- ISO/IEC 27001:
  - Certification: Google Cloud has been certified under ISO/IEC 27001, a globally recognized standard for managing information security.
  - Security Controls: This certification covers risk management, access control, data encryption, incident management, and compliance with data protection laws.
  - Why This Matters: ISO/IEC 27001 certification demonstrates that the infrastructure used by ROAR follows international standards for managing data securely and effectively.

However, it is important to note that ROAR itself does not hold these security certifications independently. Instead, ROAR aligns its security practices with Stanford minsec. These minsec requirements ensure that ROAR adheres to best practices in data security, including encryption, access control, and regular audits, while relying on GCP and Firebase to meet industry standards for infrastructure security.

The **Information Security Officer is responsible** for ensuring that all ROAR third-party vendors, such as Google Cloud Platform, Clever, and ClassLink, maintain **SOC 2 Type II** or **ISO 27001** certifications. For each vendor, the Information Security Officer shall generate a third-party vendor assessment report that assesses the security practices of the vendor and verifies compliance with the above privacy and security standards. The Information Security Officer shall review these vendor assessments quarterly.

---

## Employee Training and Awareness Documentation

> TODO: Review this

ROAR requires all employees and contractors to complete regular training on data privacy and information security best practices.

### Training Program

- **Initial Training**: All new employees must complete security training within 30 days of hire.
- **Annual Training**: Refresher courses covering changes to security policies and new threats.
- **Role-Specific Training**: Specialized training for roles with elevated access to sensitive data.

---

## Security Risk Assessments

ROAR conducts periodic security risk assessments to identify vulnerabilities and implement corrective actions.

### Vulnerability Scanning

> TODO: Add information on Qualys vulnerability scanning

### Penetration Testing

> TODO: Add information on pen testing

---

## Business Continuity and Disaster Recovery Plan

> TODO: Fix this

ROAR maintains a disaster recovery plan to ensure the availability of services in case of system outages or disasters.

### Backup and Restoration

- **Data Backups**: Regular backups of all critical data are stored securely in Google Cloud’s geographically redundant storage.
- **Recovery Time Objective (RTO)**: ROAR aims to restore services within 24 hours of an outage.

---

## Data Flow Diagrams (DFDs)

ROAR maintains detailed data flow diagrams that describe how data moves through the system.

> TODO: link to the DFDs

[stanford-minsec]: https://uit.stanford.edu/guide/securitystandards#security-standards-applications
[Jamf]: https://uit.stanford.edu/service/StanfordJamf
[BigFix]: https://uit.stanford.edu/service/bigfix
[Stanford Device Registration]: https://uit.stanford.edu/service/registration
[Stanford Data Farm]: https://redivis.com/Stanford

> TODO: Add information on auth and using the identity platform.

While ROAR does not use SAML 2.0, we provide a modern and secure Single Sign-On (SSO) solution through OpenID Connect (OIDC), which is built on top of OAuth 2.0. OIDC is widely adopted for web and mobile applications and is considered a secure and streamlined protocol for identity management. This is the protocal that we use for integrating with SSO providers like Clever and ClassLink. This solution offers the same high level of security and ease of integration as SAML, with the added flexibility and simplicity of the OAuth framework.

## Software Development Lifecycle Security Controls

All ROAR software developers, including ROAR assessment developers, must adhere to the following security controls:

1. **Access Control** Access to GitHub must be performed using two-factor authentication and is restricted to authorized personnel.
1. **Code Review** Code changes must be reviewed and approved in order to progress through the software development life cycle (SDLC) and deploy a version to production.
1. **Code Vulnerability Scanning**: Vulnerability scans for the source code are performed to identify security issues. High/critical issues are remediated in a timely manner.
1. **Automated Tests**: A successful test result is mandatory in order to continue with the SLDC and deploy a version to the production environment.
1. **Test Failure**: In case test failures are detected, a notification is sent to relevant stakeholders. Any code change with a failed test cannot be deployed into production.
1. **Change Approval**: All code changes need to be approved/authorized, prior to being deployed into production.

## 6. Data Retention and Destruction Policy

### Data Retention

- Student PII and assessment data are retained only as long as necessary for educational and research purposes.
- Data required for compliance with legal obligations will be retained for a minimum duration as mandated by applicable laws.

### Data Destruction

- Data no longer required is securely deleted, using cryptographic wiping for electronic records.
- Paper records are shredded.

> TODO: Add onboarding/offboarding checklist info
