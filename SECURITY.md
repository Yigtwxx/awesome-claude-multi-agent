# Security

Multi-agent orchestration systems amplify the attack surface of single-agent deployments. When agents invoke tools, call external APIs, read untrusted documents, and pass results to other agents, a single injected instruction can propagate across the entire pipeline. This document collects verified security references focused on that expanded attack surface.

For vulnerabilities or concerns specific to entries in this list, open a [GitHub Security Advisory](https://github.com/Yigtwxx/awesome-claude-multi-agent/security/advisories/new) on this repository.

## Prompt Injection and Trust Boundaries

- [Mitigate Jailbreaks and Prompt Injections](https://docs.anthropic.com/en/docs/test-and-evaluate/strengthen-guardrails/mitigate-jailbreaks) - Anthropic's official guidance on detecting and blocking prompt injection in Claude deployments.
- [Not What You've Signed Up For: Compromising Real-World LLM-Integrated Applications with Indirect Prompt Injection Attacks](https://arxiv.org/abs/2302.12173) - First systematic demonstration of indirect prompt injection against real LLM-integrated applications; foundational attack taxonomy (2023).
- [Prompt Injection](https://simonwillison.net/series/prompt-injection/) - Simon Willison's ongoing series tracking prompt injection attack patterns and defenses; coined the term.
- [Defeating Prompt Injections by Design](https://arxiv.org/abs/2503.18813) - CaMeL system separates control flow from data flow, providing verifiable prompt injection protection evaluated on AgentDojo (2025).

## MCP and Orchestration Layer Security

- [MCP Security Best Practices](https://modelcontextprotocol.io/specification/draft/basic/security_best_practices) - Official MCP security specification covering confused deputy, SSRF, session hijacking, token passthrough, and scope minimization.

## Agent System Safety

- [Trustworthy Agents in Practice](https://www.anthropic.com/research/trustworthy-agents) - Anthropic's five-principle framework for safe agents: human control, value alignment, secure interactions, transparency, and privacy (2026).
