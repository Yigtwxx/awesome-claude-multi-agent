# Awesome Claude Multi-Agent [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

A curated list of frameworks, patterns, protocols, and case studies for multi-agent orchestration where Claude is a primary model.

*Multi-agent* here means coordinated systems of multiple agents across processes, not single-session Claude Code subagents. See [contributing.md](contributing.md) for the quality bar and entry format.

## Contents

- [Foundational Reading](#foundational-reading)
- [Multi-Agent Patterns and Architectures](#multi-agent-patterns-and-architectures)
- [Orchestration Frameworks](#orchestration-frameworks)
- [Subagent Collections](#subagent-collections)
- [Skills, Hooks, and MCP for Coordination](#skills-hooks-and-mcp-for-coordination)
- [Memory, State, and Communication](#memory-state-and-communication)
- [Evaluation and Benchmarks](#evaluation-and-benchmarks)
- [Research Papers](#research-papers)
- [Case Studies and Production Postmortems](#case-studies-and-production-postmortems)
- [Talks, Courses, and Books](#talks-courses-and-books)
- [Community](#community)
- [Related Lists](#related-lists)

## Foundational Reading

Primary sources from Anthropic and seminal multi-agent LLM papers that establish the concepts behind this list. Listed chronologically.

- [ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629) - Interleaves reasoning traces with tool actions; baseline for tool-using agent orchestration. (ICLR 2023)
- [CAMEL: Communicative Agents for Mind Exploration](https://arxiv.org/abs/2303.17760) - Cooperative role-playing via inception prompting; first scalable two-agent coordination paper. (NeurIPS 2023)
- [Generative Agents: Interactive Simulacra of Human Behavior](https://arxiv.org/abs/2304.03442) - Twenty-five LLM agents simulate daily life with memory, reflection, and planning. (UIST 2023)
- [Self-Refine: Iterative Refinement with Self-Feedback](https://arxiv.org/abs/2303.17651) - Generator, critic, and refiner roles within one model; defines the reflection pattern. (NeurIPS 2023)
- [Improving Factuality and Reasoning via Multiagent Debate](https://arxiv.org/abs/2305.14325) - Multiple LLM instances debate over rounds to improve factuality and reasoning. (ICML 2024)
- [AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation](https://arxiv.org/abs/2308.08155) - Framework for conversable multi-agent chat with customizable roles and tool access. (ICLR 2024)
- [MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework](https://arxiv.org/abs/2308.00352) - SOP-encoded multi-agent software company with product manager, architect, and engineer roles. (ICLR 2024)
- [Mixture-of-Agents Enhances Large Language Model Capabilities](https://arxiv.org/abs/2406.04692) - Layered LLM ensemble where each layer's agents read the previous layer's outputs. (2024)
- [How We Built Our Multi-Agent Research System](https://www.anthropic.com/engineering/built-multi-agent-research-system) - Anthropic's engineering account of running parallel Claude orchestrator-worker research agents. (2025)

## Multi-Agent Patterns and Architectures

Canonical references for each coordination pattern. One to three entries per pattern map the pattern to its primary implementation reference.

- [Orchestrator-Worker](https://www.anthropic.com/engineering/built-multi-agent-research-system) - Lead Claude plans and spawns parallel subagents; Anthropic's own production writeup defines the pattern.
- [Supervisor with Tool Routing](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/multi_agent/agent_supervisor.md) - Supervisor node routes to specialized agents via tool calls; reference implementation in LangGraph.
- [Multi-Agent Debate](https://arxiv.org/abs/2305.14325) - Multiple instances independently reason then critique each other over iterative rounds.
- [Mixture-of-Agents](https://arxiv.org/abs/2406.04692) - Layered aggregation where each layer's agents improve on the previous layer's proposals.
- [Hierarchical Role-Based](https://arxiv.org/abs/2308.00352) - Structured agent hierarchy with defined SOPs per role; MetaGPT is the canonical implementation.
- [Reflection and Self-Critique](https://arxiv.org/abs/2303.17651) - Actor produces output; critic proposes revisions; actor refines; loop until quality gate.

## Orchestration Frameworks

Tools and libraries that coordinate multiple Claude instances or Claude-compatible agents across processes. Listed alphabetically.

- [AG2](https://github.com/ag2ai/ag2) - Apache-licensed AutoGen community fork providing multi-agent AgentOS primitives and active development.
- [AutoGen](https://github.com/microsoft/autogen) - Microsoft's conversable multi-agent framework; Claude supported via a custom model client extension.
- [CAMEL](https://github.com/camel-ai/camel) - Research framework for role-playing multi-agent systems with stateful memory and Claude support.
- [ChatDev](https://github.com/OpenBMB/ChatDev) - Chat-chain platform where agent teams with distinct roles build software end-to-end.
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) - Anthropic's official Python SDK for building Claude agents with tools, hooks, and MCP servers.
- [Claude Squad](https://github.com/smtg-ai/claude-squad) - Terminal manager for running multiple parallel Claude Code agents in isolated git workspaces.
- [claude-flow](https://github.com/ruvnet/claude-flow) - Claude-centric swarm orchestration with multiple topologies, federation, and consensus protocols.
- [CrewAI](https://github.com/joaomdmoura/crewAI) - Role-based multi-agent framework with first-class Claude support, crew primitives, and shared memory.
- [LangGraph](https://github.com/langchain-ai/langgraph) - Stateful graph-based orchestration library supporting supervisor, swarm, and multi-agent patterns.
- [MetaGPT](https://github.com/FoundationAgents/MetaGPT) - SOP-driven software-team simulation; the canonical hierarchical role-based multi-agent implementation.
- [OpenHands](https://github.com/All-Hands-AI/OpenHands) - Generalist software-developer platform with AgentDelegateAction for hierarchical multi-agent task delegation.
- [smolagents](https://github.com/huggingface/smolagents) - Lightweight code-first agents library with hierarchical multi-agent support; Claude via LiteLLM.

## Subagent Collections

Curated sets of Claude Code subagents. Links to the collections only; contents are not duplicated here. Listed alphabetically.

- [claude-code-templates](https://github.com/davila7/claude-code-templates) - CLI for 100+ agents, slash commands, MCP integrations, and hooks for Claude Code projects.
- [claude-agents](https://github.com/iannuttall/claude-agents) - Seven focused subagents covering refactor, security, planning, frontend, and mentorship tasks.
- [claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents) - 33 specialized subagents including an agent-organizer meta-orchestrator for parallel coordination.
- [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) - 100+ Claude Code subagents across 10 domain categories with model routing and structured output.
- [agents](https://github.com/wshobson/agents) - 184 Claude Code subagents and 16 multi-agent workflow orchestrators across development domains.

## Skills, Hooks, and MCP for Coordination

Claude Code skills, hooks, and MCP servers specifically useful for cross-agent coordination and shared state.

- [Claude Code Sub-Agents Documentation](https://docs.anthropic.com/en/docs/claude-code/sub-agents) - Official specification for `.claude/agents/` subagent definitions with YAML frontmatter and tool gating.
- [Claude Code Advanced Patterns](https://resources.anthropic.com/hubfs/Claude%20Code%20Advanced%20Patterns_%20Subagents,%20MCP,%20and%20Scaling%20to%20Real%20Codebases.pdf) - Anthropic-authored guide to subagents, MCP, and scaling Claude Code across real codebases.
- [basic-memory](https://github.com/basicmachines-co/basic-memory) - Local-first Markdown knowledge base with MCP integration for persistent cross-agent state.
- [MCP Reference Servers](https://github.com/modelcontextprotocol/servers) - Official MCP server implementations including Memory (knowledge graph) and Sequential Thinking.
- [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) - Curated index of MCP servers across providers and languages; starting point for coordination tooling.

## Memory, State, and Communication

Shared memory layers, inter-agent messaging protocols, and persistent state systems designed for multi-agent stacks.

## Evaluation and Benchmarks

Benchmarks and eval suites that measure multi-agent system quality, reliability, and collaboration.

## Research Papers

High-impact recent work on multi-agent LLMs. For a broader survey see [kyegomez/awesome-multi-agent-papers](https://github.com/kyegomez/awesome-multi-agent-papers) and [VoltAgent/awesome-ai-agent-papers](https://github.com/VoltAgent/awesome-ai-agent-papers).

## Case Studies and Production Postmortems

Engineering accounts of real multi-agent Claude deployments, with details on architecture and lessons learned.

## Talks, Courses, and Books

Video lectures, structured courses, and books focused on multi-agent LLM systems.

## Community

Active spaces where multi-agent LLM practitioners gather.

## Related Lists

Adjacent awesome lists with honest scope descriptions. Cited openly, including direct competitors.
