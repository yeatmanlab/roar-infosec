# Security Review Checklist

## Authentication and Authorization

- [ ] The change does not bypass existing authentication and authorization mechanisms.
- [ ] The change adheres to least privilege principles (e.g., ensuring minimum access rights).

## Data Handling and Confidentiality

- [ ] All sensitive data (e.g., PII, passwords, API keys) is handled securely.
- [ ] Proper encryption methods used for data at rest and in transit (e.g., TLS/HTTPS, AES-256).
- [ ] The change avoid exposing sensitive data through logs, error messages, or URLs.

## Input Validation and Output Encoding

- [ ] All inputs are properly validated and sanitized to prevent injection attacks (e.g., SQL Injection, XSS).
- [ ] All outputs are properly encoded to avoid data leaks or injection risks.

## Error Handling and Logging

- [ ] Error messages are sanitized to prevent exposing system details.
- [ ] Security-related events are logged properly (e.g., failed login attempts, access control violations).
- [ ] Logging is aligned with data privacy regulations (e.g., no logging of sensitive data).

## Dependencies and Vulnerabilities

- [ ] All third-party libraries and dependencies have been checked for known vulnerabilities (via tools like Dependabot or CodeQL).
- [ ] Dependencies are up to date.

## Access Control

- [ ] New changes are aligned with existing access control policies (e.g., Role-Based Access Control).
- [ ] The change ensures that users can only access resources and data they are permitted to access.

## Security Impact Assessment

- [ ] The potential impact of this change on overall system security been evaluated.
- [ ] The change does not introduce any new attack vectors or security risks.

## Compliance Check

- [ ] This change complies with ROAR's existing data protection regulations.
- [ ] The change does not introduce any new compliance considerations.
