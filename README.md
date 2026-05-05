# Awesome Claude Multi-Agent [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

A curated list of frameworks, patterns, protocols, and case studies for multi-agent orchestration where Claude is a primary model.

*Multi-agent* here means coordinated systems of multiple agents across processes, not single-session Claude Code subagents.

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

## Foundational Reading

Primary sources from Anthropic and seminal multi-agent LLM papers that establish the concepts behind this list. Listed chronologically.

- [ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629) - Interleaves reasoning traces with tool actions; baseline for tool-using agent orchestration (ICLR 2023).
- [Reflexion: Language Agents with Verbal Reinforcement Learning](https://arxiv.org/abs/2303.11366) - Verbal self-reflection between attempts lets an actor agent learn from prior failures across episodes (NeurIPS 2023).
- [CAMEL: Communicative Agents for Mind Exploration](https://arxiv.org/abs/2303.17760) - Cooperative role-playing via inception prompting; first scalable two-agent coordination paper (NeurIPS 2023).
- [HuggingGPT: Solving AI Tasks with ChatGPT and its Friends in Hugging Face](https://arxiv.org/abs/2303.17580) - LLM controller plans tasks then delegates to specialist Hugging Face models; canonical orchestrator-of-models pattern (NeurIPS 2023).
- [Generative Agents: Interactive Simulacra of Human Behavior](https://arxiv.org/abs/2304.03442) - Twenty-five LLM agents simulate daily life with memory, reflection, and planning (UIST 2023).
- [Self-Refine: Iterative Refinement with Self-Feedback](https://arxiv.org/abs/2303.17651) - Generator, critic, and refiner roles within one model; defines the reflection pattern (NeurIPS 2023).
- [Improving Factuality and Reasoning via Multiagent Debate](https://arxiv.org/abs/2305.14325) - Multiple LLM instances debate over rounds to improve factuality and reasoning (ICML 2024).
- [AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation](https://arxiv.org/abs/2308.08155) - Framework for conversable multi-agent chat with customizable roles and tool access (ICLR 2024).
- [MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework](https://arxiv.org/abs/2308.00352) - SOP-encoded multi-agent software company with product manager, architect, and engineer roles (ICLR 2024).
- [Mixture-of-Agents Enhances Large Language Model Capabilities](https://arxiv.org/abs/2406.04692) - Layered LLM ensemble where each layer's agents read the previous layer's outputs (2024).
- [How We Built Our Multi-Agent Research System](https://www.anthropic.com/engineering/built-multi-agent-research-system) - Anthropic's engineering account of running parallel Claude orchestrator-worker research agents (2025).

## Multi-Agent Patterns and Architectures

Canonical coordination patterns with implementation references. See Foundational Reading above for the seminal papers.

- [Orchestrator-Worker](https://www.anthropic.com/news/building-effective-agents) - Lead agent plans and spawns parallel subagents; defined in Anthropic's agent design patterns guide.
- [Supervisor with Tool Routing](https://langchain-ai.github.io/langgraph/concepts/multi_agent/) - Supervisor node routes to specialized agents via tool calls; reference implementation in LangGraph.
- [Multi-Agent Debate](https://github.com/composable-models/llm_multiagent_debate) - Multiple instances independently reason then critique each other over iterative rounds.
- [Mixture-of-Agents](https://github.com/togethercomputer/MoA) - Layered aggregation where each layer's agents improve on the previous layer's proposals.
- [Blackboard](https://arxiv.org/abs/2507.01701) - Shared workspace where agents with varied roles read and write to a common store until consensus is reached.
- [Hierarchical Role-Based](https://docs.deepwisdom.ai/) - Structured agent hierarchy with defined SOPs per role; MetaGPT is the canonical implementation.
- [Reflection and Self-Critique](https://github.com/madaan/self-refine) - Actor produces output; critic proposes revisions; actor refines; loop until quality gate.

## Orchestration Frameworks

Tools and libraries that coordinate multiple Claude instances or Claude-compatible agents across processes. Listed alphabetically.

- [AG2](https://github.com/ag2ai/ag2) - Apache-licensed AutoGen community fork providing multi-agent AgentOS primitives and active development.
- [AgentScope](https://github.com/modelscope/agentscope) - Alibaba's distributed multi-agent platform with message-passing primitives, fault tolerance, and visual workflow studio.
- [AutoGen](https://github.com/microsoft/autogen) - Microsoft's conversable multi-agent framework; Claude supported via a custom model client extension.
- [CAMEL](https://github.com/camel-ai/camel) - Research framework for role-playing multi-agent systems with stateful memory and Claude support.
- [ChatDev](https://github.com/OpenBMB/ChatDev) - Chat-chain platform where agent teams with distinct roles build software end-to-end.
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) - Anthropic's official Python SDK for building Claude agents with tools, hooks, and MCP servers.
- [Claude Squad](https://github.com/smtg-ai/claude-squad) - Terminal manager for running multiple parallel Claude Code agents in isolated Git workspaces.
- [claude-flow](https://github.com/ruvnet/claude-flow) - Claude-centric swarm orchestration with multiple topologies, federation, and consensus protocols.
- [CrewAI](https://github.com/joaomdmoura/crewAI) - Role-based multi-agent framework with first-class Claude support, crew primitives, and shared memory.
- [LangGraph](https://github.com/langchain-ai/langgraph) - Stateful graph-based orchestration library supporting supervisor, swarm, and multi-agent patterns.
- [Mastra](https://github.com/mastra-ai/mastra) - TypeScript framework for agent workflows with multi-agent networks, durable execution, and first-class Claude support.
- [mcp-agent](https://github.com/lastmile-ai/mcp-agent) - Composable multi-agent framework built on the Model Context Protocol with Claude as a primary backend.
- [MetaGPT](https://github.com/FoundationAgents/MetaGPT) - SOP-driven software-team simulation; the canonical hierarchical role-based multi-agent implementation.
- [OpenHands](https://github.com/All-Hands-AI/OpenHands) - Generalist software-developer platform with AgentDelegateAction for hierarchical multi-agent task delegation.
- [Pydantic AI](https://github.com/pydantic/pydantic-ai) - Type-safe Python agent framework with delegation patterns, graph-based multi-agent flows, and Claude support.
- [smolagents](https://github.com/huggingface/smolagents) - Lightweight code-first agents library with hierarchical multi-agent support; Claude via LiteLLM.

## Subagent Collections

Curated sets of Claude Code subagents. Links to the collections only; contents are not duplicated here. Listed alphabetically.

- [agents](https://github.com/wshobson/agents) - Collection of 184 Claude Code subagents and 16 multi-agent workflow orchestrators across development domains.
- [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) - Over 100 Claude Code subagents across 10 domain categories with model routing and structured output.
- [claude-agents](https://github.com/iannuttall/claude-agents) - Seven focused subagents covering refactor, security, planning, frontend, and mentorship tasks.
- [claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents) - Set of 33 specialized subagents including an agent-organizer meta-orchestrator for parallel coordination.
- [claude-code-templates](https://github.com/davila7/claude-code-templates) - CLI for 100+ agents, slash commands, MCP integrations, and hooks for Claude Code projects.

## Skills, Hooks, and MCP for Coordination

Claude Code skills, hooks, and MCP servers specifically useful for cross-agent coordination and shared state.

- [Claude Code Sub-Agents Documentation](https://docs.anthropic.com/en/docs/claude-code/sub-agents) - Official specification for `.claude/agents/` subagent definitions with YAML frontmatter and tool gating.
- [Claude Code Advanced Patterns](https://resources.anthropic.com/hubfs/Claude%20Code%20Advanced%20Patterns_%20Subagents,%20MCP,%20and%20Scaling%20to%20Real%20Codebases.pdf) - Anthropic-authored guide to subagents, MCP, and scaling Claude Code across real codebases.
- [basic-memory](https://github.com/basicmachines-co/basic-memory) - Local-first Markdown knowledge base with MCP integration for persistent cross-agent state.
- [MCP Reference Servers](https://github.com/modelcontextprotocol/servers) - Official MCP server implementations including Memory (knowledge graph) and Sequential Thinking.
- [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) - Curated index of MCP servers across providers and languages; starting point for coordination tooling.

## Memory, State, and Communication

Shared memory layers, inter-agent messaging protocols, and persistent state systems designed for multi-agent stacks.

- [A2A Protocol](https://github.com/a2aproject/A2A) - Open Linux Foundation standard for inter-agent communication across frameworks and organizations.
- [Letta](https://github.com/letta-ai/letta) - Stateful agent platform with hierarchical memory blocks and archival storage; recommends Claude as backend.
- [mem0](https://github.com/mem0ai/mem0) - Universal memory layer with user, session, and agent tiers; integrates with CrewAI and LangGraph.
- [Redis Agent Memory Server](https://github.com/redis/agent-memory-server) - Fast session and long-term memory layer for agents backed by Redis with semantic search and MCP server interface.
- [Zep](https://github.com/getzep/zep) - Temporal knowledge-graph memory platform for agents with Graph RAG and session context management.

## Evaluation and Benchmarks

Benchmarks and eval suites that measure multi-agent system quality, reliability, and task completion.

- [AgentBench](https://github.com/THUDM/AgentBench) - Eight-environment benchmark measuring LLM-as-agent performance across web, code, and OS tasks (ICLR 2024).
- [GAIA](https://arxiv.org/abs/2311.12983) - Real-world general assistant benchmark; humans score 92%, LLM agents roughly 15–30%.
- [MARBLE](https://github.com/ulab-uiuc/MARBLE) - Benchmarks multi-agent collaboration across star, chain, tree, and graph coordination topologies (ACL 2025).
- [TheAgentCompany](https://arxiv.org/abs/2412.14161) - Benchmark of realistic enterprise software tasks measuring agent performance in a simulated company (2024).
- [τ-bench](https://github.com/sierra-research/tau-bench) - Tool-agent-user benchmark measuring agent reliability with a pass^k metric in realistic domains.
- [τ²-Bench](https://github.com/sierra-research/tau2-bench) - Dual-control conversational agent benchmark; successor to τ-bench from Sierra Research.

## Research Papers

High-impact recent work on multi-agent LLMs not already listed in Foundational Reading. For broader surveys see kyegomez/awesome-multi-agent-papers and VoltAgent/awesome-ai-agent-papers in Related Lists below.

- [ChatDev: Communicative Agents for Software Development](https://arxiv.org/abs/2307.07924) - Multi-agent software company pipeline with communicative dehallucination to reduce cross-role errors (ACL 2024).
- [AgentVerse: Facilitating Multi-Agent Collaboration](https://arxiv.org/abs/2308.10848) - Framework studying emergent social behaviors and dynamic team assembly in multi-agent settings (ICLR 2024).
- [Constitutional AI: Harmlessness from AI Feedback](https://arxiv.org/abs/2212.08073) - Two-model RLAIF loop where a critique model revises an actor; foundational Anthropic actor-critic paper (2022).
- [Sleeper Agents: Training Deceptive LLMs that Persist Through Safety Training](https://arxiv.org/abs/2401.05566) - Shows deceptive agent behaviors survive safety fine-tuning; key multi-agent trust and safety result (2024).
- [OpenHands: An Open Platform for AI Software Developers](https://arxiv.org/abs/2407.16741) - Agent platform with AgentDelegateAction enabling nested multi-agent software-development workflows (ICLR 2025).
- [Magentic-One: A Generalist Multi-Agent System for Solving Complex Tasks](https://arxiv.org/abs/2411.04468) - Microsoft's orchestrator coordinating five specialist agents for web, file, and coding tasks (2024).

## Case Studies and Production Postmortems

Engineering accounts and counter-perspectives on real multi-agent deployments. Community submissions welcome via PR — see [contributing.md](contributing.md).

- [Don't Build Multi-Agents](https://cognition.ai/blog/dont-build-multi-agents) - Cognition's argument that context-sharing failures make multi-agent unreliable for code editing (2025).
- [The AI Scientist](https://sakana.ai/ai-scientist/) - Sakana AI's autonomous research pipeline coordinating ideation, experiment, and review agents end-to-end (2024).

## Talks, Courses, and Books

Video lectures and structured courses focused on multi-agent LLM systems. Listed alphabetically.

- [AWS re:Invent 2024: Using Multiple Agents for Scalable Generative AI Applications](https://www.youtube.com/watch?v=7pvEYLW1yZw) - AWS session on coordinating multiple specialized agents for enterprise-scale generative AI workloads.
- [AI Agentic Design Patterns with AutoGen](https://learn.deeplearning.ai/courses/ai-agentic-design-patterns-with-autogen) - DeepLearning.AI course taught by AutoGen creators on multi-agent design patterns.
- [Multi AI Agent Systems with crewAI](https://www.deeplearning.ai/short-courses/multi-ai-agent-systems-with-crewai/) - DeepLearning.AI course by CrewAI founder on role, tool, and memory patterns in agent crews.
- [Practical Multi AI Agents and Advanced Use Cases with crewAI](https://www.deeplearning.ai/short-courses/practical-multi-ai-agents-and-advanced-use-cases-with-crewai/) - Advanced crewAI course covering real application architectures and production agent patterns.

## Community

Active spaces where multi-agent LLM practitioners gather.

- [r/ClaudeAI](https://www.reddit.com/r/ClaudeAI/) - Subreddit for Claude users, including threads on subagents, orchestration, and multi-agent setups.
- [AutoGen GitHub Discussions](https://github.com/microsoft/autogen/discussions) - Official forum for AutoGen architecture questions, multi-agent design, and framework updates.
- [CAMEL-AI Community](https://github.com/camel-ai/camel?tab=readme-ov-file#community) - Research community Discord and forum for multi-agent systems built on CAMEL.

## Related Lists

Adjacent awesome lists with honest scope descriptions. Cited openly, including direct competitors.

- [andyrewlee/awesome-agent-orchestrators](https://github.com/andyrewlee/awesome-agent-orchestrators) - Curated orchestrators across Claude, Codex, Gemini, and Cursor; not Claude-specific.
- [e2b-dev/awesome-ai-agents](https://github.com/e2b-dev/awesome-ai-agents) - Broad agent ecosystem index; less actively maintained since mid-2023.
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Wide-ranging index of Claude Code resources: skills, hooks, orchestrators, and subagent collections.
- [kyegomez/awesome-multi-agent-papers](https://github.com/kyegomez/awesome-multi-agent-papers) - Compilation of multi-agent research papers; broader and model-agnostic.
- [VoltAgent/awesome-ai-agent-papers](https://github.com/VoltAgent/awesome-ai-agent-papers) - Weekly-updated 2024–2026 AI agent papers covering memory, evaluation, and workflows.
