# Pitfalls

Multi-agent systems introduce coordination overhead, context fragmentation, and reliability challenges that single-agent designs do not have. This document collects honest counter-perspectives and documented failure modes. Read these before committing to a multi-agent architecture — the argument for going multi-agent should survive contact with this list.

## Honest Counter-Perspectives

- [Don't Build Multi-Agents](https://cognition.ai/blog/dont-build-multi-agents) - Cognition's argument that context isolation failures make multi-agent systems unreliable for code editing tasks (2025).
- [Multi-Agents: What's Actually Working](https://cognition.ai/blog/multi-agents-working) - Follow-up arguing writes must stay single-threaded; additional agents should contribute intelligence, not independent actions (2026).

## Empirical Failure Mode Research

- [Why Do Multi-Agent LLM Systems Fail?](https://arxiv.org/abs/2503.13657) - Taxonomy of 14 failure modes across system design, inter-agent misalignment, and task verification categories; inter-agent misalignment is the top failure mode (2025).
- [When Single-Agent with Skills Replace Multi-Agent Systems and When They Fail](https://arxiv.org/abs/2601.04748) - Shows single-agent with a skill library matches multi-agent performance at lower cost; identifies a phase-transition scaling limit as library size grows (2026).
- [Single-agent or Multi-agent Systems? Why Not Both?](https://arxiv.org/abs/2505.18286) - Demonstrates that performance gains from multi-agent over single-agent narrow significantly as underlying model capability improves (2025).
