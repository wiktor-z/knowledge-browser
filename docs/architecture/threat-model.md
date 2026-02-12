# Threat Model (Local-First)

## Security Goals
- Keep user knowledge data local by default
- Prevent accidental data exfiltration
- Enforce least privilege across services and runtime identities
- Preserve auditability of data processing and access paths

## Trust Boundaries
- Host machine and local Docker runtime are trusted operational boundaries
- External networks and third-party APIs are untrusted by default
- Any optional external integration must be explicit and configurable

## Key Risks and Mitigations
1. **Secrets leakage**
   - Mitigation: no secrets committed; use environment variables and `.env` files excluded by git.
2. **Unintended outbound calls**
   - Mitigation: no required external dependencies in core runtime; document and gate optional integrations.
3. **Data overexposure via logs**
   - Mitigation: structured logs with deliberate field selection; avoid dumping raw payloads.
4. **Privilege escalation inside containers**
   - Mitigation: keep service responsibilities narrow and avoid unnecessary capabilities.

## Milestone 0 Posture
Milestone 0 provides baseline controls and local-only defaults. Advanced controls (SBOM, image signing, runtime policy enforcement) are deferred to later milestones.
