# Awesome Claude Multi-Agent [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

A curated list of frameworks, patterns, protocols, and case studies for multi-agent orchestration where Claude is a primary model.

*Multi-agent* here means coordinated systems of multiple agents across processes, not single-session Claude Code subagents.

Companion documents: [glossary](glossary.md) for terminology, [pitfalls](pitfalls.md) for failure modes, and [security references](SECURITY.md).

## Contents

- [Foundational Reading](#foundational-reading)
- [Multi-Agent Patterns and Architectures](#multi-agent-patterns-and-architectures)
- [Orchestration Frameworks](#orchestration-frameworks)
- [Subagent Collections](#subagent-collections)
- [Starter Templates and Examples](#starter-templates-and-examples)
- [Skills, Hooks, and MCP for Coordination](#skills-hooks-and-mcp-for-coordination)
- [Memory, State, and Communication](#memory-state-and-communication)
- [Standards and Protocols](#standards-and-protocols)
- [Evaluation and Benchmarks](#evaluation-and-benchmarks)
- [Datasets and Environments](#datasets-and-environments)
- [Observability and Debugging](#observability-and-debugging)
- [Security, Safety, and Trust](#security-safety-and-trust)
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
- [MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework](https://arxiv.org/abs/2308.00352) - SOP-encoded multi-agent software company with product manager, architect, and engineer roles (ICLR 2024).
- [AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation](https://arxiv.org/abs/2308.08155) - Framework for conversable multi-agent chat with customizable roles and tool access (ICLR 2024).
- [Mixture-of-Agents Enhances Large Language Model Capabilities](https://arxiv.org/abs/2406.04692) - Layered LLM ensemble where each layer's agents read the previous layer's outputs (2024).
- [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) - Anthropic's reference patterns for agents: prompt chaining, routing, parallelization, orchestrator-workers, and evaluator-optimizer (2024).
- [How We Built Our Multi-Agent Research System](https://www.anthropic.com/engineering/built-multi-agent-research-system) - Anthropic's engineering account of running parallel Claude orchestrator-worker research agents (2025).
- [Building Multi-Agent Systems: When and How to Use Them](https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them) - Anthropic's guidance on the three cases where multiple agents help: context isolation, parallelization, and specialization (2026).

## Multi-Agent Patterns and Architectures

Canonical coordination patterns with implementation references. See Foundational Reading above for the seminal papers.

- [Blackboard](https://arxiv.org/abs/2507.01701) - Shared workspace where agents with varied roles read and write to a common store until consensus is reached.
- [Dynamic Agent Selection](https://arxiv.org/abs/2310.02170) - Agents are chosen and wired into a communication structure on the fly per task; defined by the DyLAN network.
- [Hierarchical Role-Based](https://docs.deepwisdom.ai/) - Structured agent hierarchy with defined SOPs per role; MetaGPT is the canonical implementation.
- [Market-Based Coordination](https://arxiv.org/abs/2511.17621) - Agents act as market participants trading probabilistic beliefs to converge on shared, truthful outcomes.
- [Mixture-of-Agents](https://github.com/togethercomputer/MoA) - Layered aggregation where each layer's agents improve on the previous layer's proposals.
- [Multi-Agent Debate](https://github.com/composable-models/llm_multiagent_debate) - Multiple instances independently reason then critique each other over iterative rounds.
- [Orchestrator-Worker](https://www.anthropic.com/news/building-effective-agents) - Lead agent plans and spawns parallel subagents; defined in Anthropic's agent design patterns guide.
- [Parallelization and Voting](https://arxiv.org/abs/2402.05120) - Independent agents answer the same query and a majority vote selects the result; accuracy scales with agent count.
- [Recursive Task Decomposition](https://arxiv.org/abs/2311.05772) - Tasks are decomposed into subtasks only when an agent cannot execute them directly; defined by ADaPT.
- [Reflection and Self-Critique](https://github.com/madaan/self-refine) - Actor produces output; critic proposes revisions; actor refines; loop until quality gate.
- [Sequential Handoff](https://developers.openai.com/cookbook/examples/orchestrating_agents) - One agent transfers control and context to a more specialized agent mid-conversation.
- [Supervisor with Tool Routing](https://langchain-ai.github.io/langgraph/concepts/multi_agent/) - Supervisor node routes to specialized agents via tool calls; reference implementation in LangGraph.

## Orchestration Frameworks

Tools and libraries that coordinate multiple Claude instances or Claude-compatible agents across processes. Listed alphabetically.

- [AG2](https://github.com/ag2ai/ag2) - Apache-licensed AutoGen community fork providing multi-agent AgentOS primitives and active development.
- [AgentScope](https://github.com/modelscope/agentscope) - Alibaba's distributed multi-agent platform with message-passing primitives, fault tolerance, and visual workflow studio.
- [Agno](https://github.com/agno-agi/agno) - High-performance Python framework for multi-agent teams with memory and knowledge; model-agnostic interface including Claude.
- [Atomic Agents](https://github.com/BrainBlend-AI/atomic-agents) - Schema-driven framework for building and chaining modular agents into multi-agent pipelines; Claude via Instructor.
- [AutoGen](https://github.com/microsoft/autogen) - Microsoft's conversable multi-agent framework; Claude supported via a custom model client extension.
- [BeeAI Framework](https://github.com/i-am-bee/beeai-framework) - IBM-originated Python and TypeScript framework for agent workflows and multi-agent orchestration across model providers.
- [CAMEL](https://github.com/camel-ai/camel) - Research framework for role-playing multi-agent systems with stateful memory and Claude support.
- [ChatDev](https://github.com/OpenBMB/ChatDev) - Chat-chain platform where agent teams with distinct roles build software end-to-end.
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) - Anthropic's official Python SDK for building Claude agents with tools, hooks, and MCP servers.
- [Claude Squad](https://github.com/smtg-ai/claude-squad) - Terminal manager for running multiple parallel Claude Code agents in isolated Git workspaces.
- [Claude Swarm](https://github.com/affaan-m/claude-swarm) - Decomposes tasks across parallel Claude Code agents with conflict detection and a rich terminal coordination UI.
- [Conductor](https://github.com/microsoft/conductor) - Microsoft CLI for defining and running multi-agent workflows on the Anthropic Agents SDK and GitHub Copilot SDK.
- [CrewAI](https://github.com/joaomdmoura/crewAI) - Role-based multi-agent framework with first-class Claude support, crew primitives, and shared memory.
- [Dapr Agents](https://github.com/dapr/dapr-agents) - Framework for resilient, stateful multi-agent systems with workflow orchestration on the Dapr runtime.
- [Google ADK](https://github.com/google/adk-python) - Google's Agent Development Kit for hierarchical multi-agent systems; Claude via LiteLLM and Vertex AI.
- [Inngest AgentKit](https://github.com/inngest/agent-kit) - TypeScript framework for multi-agent networks with deterministic routing and MCP tooling; supports Claude.
- [LangGraph](https://github.com/langchain-ai/langgraph) - Stateful graph-based orchestration library supporting supervisor, swarm, and multi-agent patterns.
- [Langroid](https://github.com/langroid/langroid) - Python framework structured around multi-agent message passing and task delegation; Claude supported.
- [Mastra](https://github.com/mastra-ai/mastra) - TypeScript framework for agent workflows with multi-agent networks, durable execution, and first-class Claude support.
- [mcp-agent](https://github.com/lastmile-ai/mcp-agent) - Composable multi-agent framework built on the Model Context Protocol with Claude as a primary backend.
- [MetaGPT](https://github.com/FoundationAgents/MetaGPT) - SOP-driven software-team simulation; the canonical hierarchical role-based multi-agent implementation.
- [Microsoft Agent Framework](https://github.com/microsoft/agent-framework) - Microsoft's successor to AutoGen and Semantic Kernel for multi-agent workflows in Python and .NET.
- [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) - Teams-first multi-agent orchestration for Claude Code with task routing across specialized agents.
- [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) - Lightweight framework for multi-agent workflows with handoffs and guardrails; Claude via LiteLLM.
- [OpenHands](https://github.com/All-Hands-AI/OpenHands) - Generalist software-developer platform with AgentDelegateAction for hierarchical multi-agent task delegation.
- [Pydantic AI](https://github.com/pydantic/pydantic-ai) - Type-safe Python agent framework with delegation patterns, graph-based multi-agent flows, and Claude support.
- [ruflo](https://github.com/ruvnet/ruflo) - Claude-centric agent meta-harness deploying multi-agent swarms with adaptive memory, federation, and consensus topologies.
- [smolagents](https://github.com/huggingface/smolagents) - Lightweight code-first agents library with hierarchical multi-agent support; Claude via LiteLLM.
- [Strands Agents](https://github.com/strands-agents/sdk-python) - AWS model-driven SDK with swarm, graph, and agents-as-tools multi-agent patterns; defaults to Claude on Bedrock.
- [swarmclaw](https://github.com/swarmclawai/swarmclaw) - Self-hosted agent runtime for autonomous swarms with memory, delegation, scheduling, and MCP tools across many model providers.
- [Swarms](https://github.com/kyegomez/swarms) - Multi-agent orchestration framework with sequential, concurrent, and hierarchical workflows; Claude via LiteLLM.
- [VoltAgent](https://github.com/VoltAgent/voltagent) - TypeScript framework for supervisor and subagent multi-agent systems with built-in observability; supports Claude.

## Subagent Collections

Curated sets of Claude Code subagents. Links to the collections only; contents are not duplicated here. Listed alphabetically.

- [agents](https://github.com/wshobson/agents) - Collection of 184 Claude Code subagents and 16 multi-agent workflow orchestrators across development domains.
- [agents (contains-studio)](https://github.com/contains-studio/agents) - Department-organized Claude Code subagents spanning engineering, design, marketing, and operations roles.
- [awesome-claude-agents](https://github.com/vijaythecoder/awesome-claude-agents) - Orchestrated team of Claude Code subagents coordinating as an automated software-development crew.
- [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) - Over 100 Claude Code subagents across 10 domain categories with model routing and structured output.
- [claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents) - Set of 33 specialized subagents including an agent-organizer meta-orchestrator for parallel coordination.
- [claude-code-subagents](https://github.com/0xfurai/claude-code-subagents) - Over 100 production-ready domain-specific subagents for Claude Code across languages, frameworks, and infrastructure.
- [claude-code-templates](https://github.com/davila7/claude-code-templates) - CLI for 100+ agents, slash commands, MCP integrations, and hooks for Claude Code projects.

## Starter Templates and Examples

Runnable starting points and worked examples for assembling multi-agent Claude systems. Links only; contents are not duplicated. Listed alphabetically.

- [agent-orchestrator-template](https://github.com/shintaro-sprech/agent-orchestrator-template) - Self-evolving Claude Code subagent system that creates, merges, and promotes specialized agents per task.
- [Anthropic Cookbook Agent Patterns](https://github.com/anthropics/anthropic-cookbook/tree/main/patterns/agents) - Official notebooks implementing orchestrator-workers and related multi-agent patterns with Claude.
- [Claude Quickstarts](https://github.com/anthropics/claude-quickstarts) - Official runnable Claude projects, including a two-agent autonomous coding example.

## Skills, Hooks, and MCP for Coordination

Claude Code skills, hooks, and MCP servers specifically useful for cross-agent coordination and shared state.

- [Agent Skills](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) - Anthropic's open standard for packaging reusable instructions and code that agents load on demand.
- [Agent-MCP](https://github.com/rinadelph/Agent-MCP) - Framework for coordinating multiple specialized agents in parallel through the Model Context Protocol.
- [Claude Code Advanced Patterns](https://resources.anthropic.com/hubfs/Claude%20Code%20Advanced%20Patterns_%20Subagents,%20MCP,%20and%20Scaling%20to%20Real%20Codebases.pdf) - Anthropic-authored guide to subagents, MCP, and scaling Claude Code across real codebases.
- [Claude Code Agent Teams](https://code.claude.com/docs/en/agent-teams) - Official feature coordinating multiple Claude Code sessions with a shared task list and inter-agent messaging.
- [Claude Code Agent View](https://code.claude.com/docs/en/agent-view) - Dispatch and monitor many parallel background Claude Code sessions from a single screen.
- [Claude Code Hooks](https://code.claude.com/docs/en/hooks) - Lifecycle event handlers, including SubagentStop and TaskCompleted, for enforcing quality gates across agents.
- [Claude Code Sub-Agents Documentation](https://code.claude.com/docs/en/sub-agents) - Official specification for `.claude/agents/` subagent definitions with YAML frontmatter and tool gating.
- [claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery) - Worked examples of every Claude Code hook lifecycle event and subagent control pattern.
- [FastMCP](https://github.com/jlowin/fastmcp) - Pythonic framework for building Model Context Protocol servers and clients that expose tools to agents.
- [MCP Reference Servers](https://github.com/modelcontextprotocol/servers) - Official MCP server implementations including Memory (knowledge graph) and Sequential Thinking.
- [mcp-use](https://github.com/mcp-use/mcp-use) - Framework for building MCP apps and connecting agents to any MCP server, with Claude support.
- [Serena](https://github.com/oraios/serena) - MCP server giving agents semantic code retrieval and editing across a shared codebase.

## Memory, State, and Communication

Shared memory layers, inter-agent messaging, and persistent state systems designed for multi-agent stacks.

- [basic-memory](https://github.com/basicmachines-co/basic-memory) - Local-first Markdown knowledge base with MCP integration for persistent cross-agent state.
- [claude-peers-mcp](https://github.com/louislva/claude-peers-mcp) - MCP server letting multiple local Claude Code instances discover and message each other ad hoc.
- [Cognee](https://github.com/topoteretes/cognee) - Memory layer that builds queryable knowledge graphs from agent interactions and documents.
- [Graphiti](https://github.com/getzep/graphiti) - Library for building real-time, temporally-aware knowledge graphs usable as shared agent memory.
- [LangMem](https://github.com/langchain-ai/langmem) - LangChain SDK giving agents long-term memory through extraction, consolidation, and cross-session retrieval.
- [Letta](https://github.com/letta-ai/letta) - Stateful agent platform with hierarchical memory blocks and archival storage; recommends Claude as backend.
- [mem0](https://github.com/mem0ai/mem0) - Universal memory layer with user, session, and agent tiers; integrates with CrewAI and LangGraph.
- [Redis Agent Memory Server](https://github.com/redis/agent-memory-server) - Session and long-term memory layer for agents backed by Redis with semantic search and an MCP interface.
- [Zep](https://github.com/getzep/zep) - Temporal knowledge-graph memory platform for agents with Graph RAG and session context management.

## Standards and Protocols

Open standards for inter-agent communication, discovery, and tool access across frameworks and vendors.

- [A Survey of Agent Interoperability Protocols](https://arxiv.org/abs/2505.02279) - Compares MCP, ACP, A2A, and ANP across architecture, security, and interaction models (2025).
- [A2A Protocol](https://github.com/a2aproject/A2A) - Open Linux Foundation standard for inter-agent communication across frameworks and organizations.
- [Agent Network Protocol](https://github.com/agent-network-protocol/AgentNetworkProtocol) - Open protocol for decentralized agent discovery and secure collaboration using decentralized identifiers.
- [AGNTCY Agent Directory](https://github.com/agntcy/dir) - Distributed announce-and-discovery layer letting multi-agent systems find and describe each other.
- [Model Context Protocol](https://github.com/modelcontextprotocol/modelcontextprotocol) - Anthropic's open standard connecting agents to tools, data, and context sources.

## Evaluation and Benchmarks

Benchmarks and eval suites that measure multi-agent system quality, reliability, and task completion.

- [AgentBench](https://github.com/THUDM/AgentBench) - Eight-environment benchmark measuring LLM-as-agent performance across web, code, and OS tasks (ICLR 2024).
- [AgentBoard](https://arxiv.org/abs/2401.13178) - Analytical benchmark with fine-grained progress metrics for multi-turn LLM agents across nine tasks (NeurIPS 2024).
- [AppWorld](https://arxiv.org/abs/2407.18901) - Simulated world of nine apps and 457 APIs for benchmarking interactive coding agents (ACL 2024).
- [BattleAgentBench](https://arxiv.org/abs/2408.15971) - Benchmark scoring language models on cooperation and competition across graduated multi-agent scenarios (2024).
- [Collab-Overcooked](https://arxiv.org/abs/2502.20073) - Overcooked-based benchmark measuring how well LLM agents collaborate through natural-language coordination (EMNLP 2025).
- [GAIA](https://arxiv.org/abs/2311.12983) - Real-world general assistant benchmark; humans score 92%, LLM agents roughly 15–30%.
- [MARBLE](https://github.com/ulab-uiuc/MARBLE) - MultiAgentBench code measuring collaboration across star, chain, tree, and graph topologies (ACL 2025).
- [PARTNR](https://arxiv.org/abs/2411.00081) - Meta benchmark of 100,000 household tasks for embodied human-robot multi-agent planning (2024).
- [SWE-bench](https://arxiv.org/abs/2310.06770) - Benchmark of real GitHub issues widely used to evaluate single- and multi-agent coding systems (ICLR 2024).
- [TheAgentCompany](https://arxiv.org/abs/2412.14161) - Benchmark of realistic enterprise software tasks measuring agent performance in a simulated company (2024).
- [WebArena](https://arxiv.org/abs/2307.13854) - Realistic, self-hostable web environment for benchmarking autonomous agents on long-horizon tasks (2023).
- [τ-bench](https://github.com/sierra-research/tau-bench) - Tool-agent-user benchmark measuring agent reliability with a pass^k metric in realistic domains.
- [τ²-Bench](https://github.com/sierra-research/tau2-bench) - Dual-control conversational agent benchmark; successor to τ-bench from Sierra Research.

## Datasets and Environments

Reusable simulation environments and datasets for studying multi-agent coordination, distinct from the scored benchmarks above. Listed alphabetically.

- [AgentSociety](https://github.com/tsinghua-fib-lab/AgentSociety) - Simulator running thousands of LLM-driven agents in a society with economy, social media, and city environments.
- [Concordia](https://github.com/google-deepmind/concordia) - DeepMind library for generative agent-based models simulating interactions among many LLM-driven entities.
- [OASIS](https://github.com/camel-ai/oasis) - Social-media simulator scaling LLM-driven agents to one million users for studying group dynamics.
- [SOTOPIA](https://github.com/sotopia-lab/sotopia) - Open-ended environment where language agents role-play social scenarios and are scored on goal completion (ICLR 2024).

## Observability and Debugging

Tracing, monitoring, and replay tools for understanding failures in multi-step, multi-agent systems.

- [AgentOps](https://github.com/AgentOps-AI/agentops) - Session-level monitoring and replay for multi-agent systems across CrewAI, AutoGen, and other frameworks.
- [Arize Phoenix](https://github.com/Arize-ai/phoenix) - Open-source observability and evaluation for agent traces, built on OpenTelemetry.
- [Laminar](https://github.com/lmnr-ai/lmnr) - Open-source observability platform purpose-built for tracing and evaluating AI agents.
- [Langfuse](https://github.com/langfuse/langfuse) - Open-source platform tracing nested multi-agent sessions with evaluation, datasets, and prompt management.
- [LangSmith](https://www.langchain.com/langsmith) - Tracing and evaluation platform that visualizes tool calls and multi-agent interactions step by step.
- [OpenLLMetry](https://github.com/traceloop/openllmetry) - OpenTelemetry-based instrumentation for tracing LLM and multi-agent applications across vendors.
- [Opik](https://github.com/comet-ml/opik) - Open-source tracing, evaluation, and dashboards for LLM applications and agentic workflows.
- [Weave](https://github.com/wandb/weave) - Weights & Biases toolkit for logging, tracing, and evaluating agentic LLM applications.

## Security, Safety, and Trust

Threats, defenses, and trust evaluations specific to coordinated multi-agent systems. The companion security references cover prompt injection and trust boundaries in more depth. Listed alphabetically.

- [A Survey on Trustworthy LLM Agents: Threats and Countermeasures](https://arxiv.org/abs/2503.09648) - Maps threats and defenses across an agent's reasoning, memory, tools, and interactions with users and other agents (2025).
- [MAGPIE: Multi-Agent Contextual Privacy Evaluation](https://arxiv.org/abs/2510.15186) - Benchmark of 200 high-stakes tasks testing whether collaborating agents preserve contextual privacy (2025).
- [Red-Teaming LLM Multi-Agent Systems via Communication Attacks](https://arxiv.org/abs/2502.14847) - Agent-in-the-Middle attack compromises whole systems by intercepting and manipulating inter-agent messages (ACL 2025).
- [Seven Security Challenges in Cross-domain Multi-Agent LLM Systems](https://arxiv.org/abs/2505.23847) - Identifies seven security challenges that emerge when agents operate across organizational boundaries (2025).
- [TAMAS: Benchmarking Adversarial Risks in Multi-Agent LLM Systems](https://arxiv.org/abs/2511.05269) - Benchmark evaluating robustness and safety of multi-agent systems across adversarial attack scenarios (2025).

## Research Papers

High-impact recent work on multi-agent LLMs not already listed in Foundational Reading. For broader surveys see kyegomez/awesome-multi-agent-papers and VoltAgent/awesome-ai-agent-papers in Related Lists below. Listed chronologically.

- [Constitutional AI: Harmlessness from AI Feedback](https://arxiv.org/abs/2212.08073) - Two-model RLAIF loop where a critique model revises an actor; foundational Anthropic actor-critic paper (2022).
- [ChatDev: Communicative Agents for Software Development](https://arxiv.org/abs/2307.07924) - Multi-agent software company pipeline with communicative dehallucination to reduce cross-role errors (ACL 2024).
- [AgentVerse: Facilitating Multi-Agent Collaboration](https://arxiv.org/abs/2308.10848) - Framework studying emergent social behaviors and dynamic team assembly in multi-agent settings (ICLR 2024).
- [ChatEval: Better LLM-based Evaluators through Multi-Agent Debate](https://arxiv.org/abs/2308.07201) - Multi-agent referee team that debates to evaluate text quality more reliably than a single judge (2023).
- [Sleeper Agents: Training Deceptive LLMs that Persist Through Safety Training](https://arxiv.org/abs/2401.05566) - Shows deceptive agent behaviors survive safety fine-tuning; key multi-agent trust and safety result (2024).
- [Large Language Model based Multi-Agents: A Survey](https://arxiv.org/abs/2402.01680) - Surveys multi-agent LLM systems across communication, profiling, and capability-enhancement mechanisms (IJCAI 2024).
- [Language Agents as Optimizable Graphs](https://arxiv.org/abs/2402.16823) - Represents multi-agent systems as graphs and automatically optimizes their topology and prompts; GPTSwarm (ICML 2024).
- [Chain of Agents: LLMs Collaborating on Long-Context Tasks](https://arxiv.org/abs/2406.02818) - Worker agents process long-context segments sequentially and a manager agent synthesizes the result (NeurIPS 2024).
- [Scaling Large Language Model-based Multi-Agent Collaboration](https://arxiv.org/abs/2406.07155) - Organizes agents into directed-graph networks and finds a collaborative scaling law past a thousand agents (ICLR 2025).
- [OpenHands: An Open Platform for AI Software Developers](https://arxiv.org/abs/2407.16741) - Agent platform with AgentDelegateAction enabling nested multi-agent software-development workflows (ICLR 2025).
- [Optima: Optimizing Effectiveness and Efficiency for LLM-Based Multi-Agent Systems](https://arxiv.org/abs/2410.08115) - Training framework improving communication efficiency and performance of multi-agent systems (2024).
- [AFlow: Automating Agentic Workflow Generation](https://arxiv.org/abs/2410.10762) - Automates workflow design with Monte Carlo tree search over code-represented agent workflows (ICLR 2025).
- [Magentic-One: A Generalist Multi-Agent System for Solving Complex Tasks](https://arxiv.org/abs/2411.04468) - Microsoft's orchestrator coordinating five specialist agents for web, file, and coding tasks (2024).
- [A Survey on LLM-based Multi-Agent System: Recent Advances and New Frontiers in Application](https://arxiv.org/abs/2412.17481) - Surveys recent LLM multi-agent systems across coordination mechanisms and application domains (2024).
- [Multiagent Finetuning: Self Improvement with Diverse Reasoning Chains](https://arxiv.org/abs/2501.05707) - Specializes a society of models through multi-agent interaction to sustain self-improvement over many rounds (2025).
- [Multi-Agent Collaboration Mechanisms: A Survey of LLMs](https://arxiv.org/abs/2501.06322) - Surveys how LLM-based agents coordinate through collaboration mechanisms, structures, types, and protocols (2025).
- [Multi-agent Architecture Search via Agentic Supernet](https://arxiv.org/abs/2502.04180) - Samples query-dependent multi-agent architectures from a learned probabilistic supernet rather than one fixed design (ICML 2025).
- [Why Do Multi-Agent LLM Systems Fail?](https://arxiv.org/abs/2503.13657) - Introduces the MAST taxonomy of fourteen multi-agent failure modes from over a thousand annotated traces (NeurIPS 2025).
- [AgentsNet: Coordination and Collaborative Reasoning in Multi-Agent LLMs](https://arxiv.org/abs/2507.08616) - Benchmarks whether agent networks can self-organize coordination and collaborative reasoning as they scale (2025).
- [Beyond the Strongest LLM: Multi-Turn Multi-Agent Orchestration vs. Single LLMs on Benchmarks](https://arxiv.org/abs/2509.23537) - Finds multi-turn multi-agent orchestration can outperform the strongest single model on benchmarks (2025).
- [IMAGINE: Integrating Multi-Agent System into One Model](https://arxiv.org/abs/2510.14406) - Distills multi-agent coordination into a single model for complex reasoning and planning (2025).

## Case Studies and Production Postmortems

Engineering accounts and counter-perspectives on real multi-agent deployments. Community submissions welcome via PR — see [contributing.md](contributing.md).

- [Don't Build Multi-Agents](https://cognition.ai/blog/dont-build-multi-agents) - Cognition's argument that context-sharing failures make multi-agent unreliable for code editing (2025).
- [Building Agents with the Claude Agent SDK](https://claude.com/blog/building-agents-with-the-claude-agent-sdk) - Anthropic's account of the agent loop, context management, and subagents behind Claude Code (2025).
- [How to Think About Agent Frameworks](https://www.langchain.com/blog/how-to-think-about-agent-frameworks) - LangChain's analysis of workflow-versus-agent abstractions and context control in multi-agent design (2025).
- [Context Engineering for AI Agents](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus) - Manus team's lessons on KV-cache, tool masking, and file-based context from building their agent (2025).
- [Multi-Agent Systems in the LLMOps Database](https://www.zenml.io/llmops-tags/multi-agent-systems) - ZenML's curated collection of real-world multi-agent production deployments across many industries.
- [What 1,200 Production Deployments Reveal About LLMOps](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025) - ZenML's vendor-neutral analysis of multi-agent orchestration patterns that survive production (2025).
- [The AI Scientist](https://sakana.ai/ai-scientist/) - Sakana AI's autonomous research pipeline coordinating ideation, experiment, and review agents end-to-end (2024).

## Talks, Courses, and Books

Video lectures and structured courses focused on multi-agent LLM systems. Listed alphabetically.

- [Agentic Architectural Patterns for Building Multi-Agent Systems](https://books.google.com/books/about/Agentic_Architectural_Patterns_for_Build.html?id=Usa2EQAAQBAJ) - Book of agentic design patterns for coordination, fault tolerance, and hierarchical multi-agent architectures (2026).
- [AI Agentic Design Patterns with AutoGen](https://learn.deeplearning.ai/courses/ai-agentic-design-patterns-with-autogen) - DeepLearning.AI course taught by AutoGen creators on multi-agent design patterns.
- [AI Agents in Action](https://www.manning.com/books/ai-agents-in-action) - Manning book on building, orchestrating, and deploying autonomous multi-agent systems (2025).
- [AI Agents in LangGraph](https://www.deeplearning.ai/short-courses/ai-agents-in-langgraph/) - DeepLearning.AI and LangChain course on building agent control flow from scratch and in LangGraph.
- [AWS re:Invent 2024: Using Multiple Agents for Scalable Generative AI Applications](https://www.youtube.com/watch?v=7pvEYLW1yZw) - AWS session on coordinating multiple specialized agents for enterprise-scale generative AI workloads.
- [Hugging Face Agents Course](https://huggingface.co/learn/agents-course) - Free course covering agent fundamentals and frameworks (smolagents, LangGraph, LlamaIndex) with hands-on builds.
- [Long-Term Agentic Memory with LangGraph](https://www.deeplearning.ai/short-courses/long-term-agentic-memory-with-langgraph/) - DeepLearning.AI course on adding semantic, episodic, and procedural memory to agents.
- [Multi AI Agent Systems with crewAI](https://www.deeplearning.ai/short-courses/multi-ai-agent-systems-with-crewai/) - DeepLearning.AI course by CrewAI founder on role, tool, and memory patterns in agent crews.
- [Practical Multi AI Agents and Advanced Use Cases with crewAI](https://www.deeplearning.ai/short-courses/practical-multi-ai-agents-and-advanced-use-cases-with-crewai/) - Advanced crewAI course covering real application architectures and production agent patterns.
- [Serverless Agentic Workflows with Amazon Bedrock](https://www.deeplearning.ai/short-courses/serverless-agentic-workflows-with-amazon-bedrock/) - DeepLearning.AI course on deploying scalable serverless agent workflows with tools and guardrails.

## Community

Active spaces where multi-agent LLM practitioners gather.

- [AutoGen GitHub Discussions](https://github.com/microsoft/autogen/discussions) - Official forum for AutoGen architecture questions, multi-agent design, and framework updates.
- [CAMEL-AI Community](https://github.com/camel-ai/camel?tab=readme-ov-file#community) - Research community Discord and forum for multi-agent systems built on CAMEL.
- [CrewAI Community Forum](https://community.crewai.com/) - Official forum for CrewAI users discussing crews, flows, and multi-agent application design.
- [LangChain Forum](https://forum.langchain.com/) - Official community forum for LangChain and LangGraph, including multi-agent architecture discussions.
- [Latent Space](https://www.latent.space/) - AI engineering newsletter and podcast with recurring coverage of agent and multi-agent architectures.
- [r/AI_Agents](https://www.reddit.com/r/AI_Agents/) - Subreddit focused on building, orchestrating, and deploying autonomous and multi-agent systems.
- [r/ClaudeAI](https://www.reddit.com/r/ClaudeAI/) - Subreddit for Claude users, including threads on subagents, orchestration, and multi-agent setups.

## Related Lists

Adjacent awesome lists with honest scope descriptions. Cited openly, including direct competitors.

- [andyrewlee/awesome-agent-orchestrators](https://github.com/andyrewlee/awesome-agent-orchestrators) - Curated orchestrators across Claude, Codex, Gemini, and Cursor; not Claude-specific.
- [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) - Large index of Claude Skills, tools, and resources; broad Claude tooling, not multi-agent-specific.
- [e2b-dev/awesome-ai-agents](https://github.com/e2b-dev/awesome-ai-agents) - Broad agent ecosystem index; less actively maintained since mid-2023.
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Wide-ranging index of Claude Code resources: skills, hooks, orchestrators, and subagent collections.
- [Jenqyang/Awesome-AI-Agents](https://github.com/Jenqyang/Awesome-AI-Agents) - Collection of LLM-powered autonomous agents, frameworks, and multi-agent systems; model-agnostic.
- [kaushikb11/awesome-llm-agents](https://github.com/kaushikb11/awesome-llm-agents) - Curated list of LLM agent frameworks; vendor-agnostic and framework-focused.
- [kyegomez/awesome-multi-agent-papers](https://github.com/kyegomez/awesome-multi-agent-papers) - Compilation of multi-agent research papers; broader and model-agnostic.
- [luo-junyu/Awesome-Agent-Papers](https://github.com/luo-junyu/Awesome-Agent-Papers) - Survey-linked collection of LLM agent papers across construction, collaboration, evolution, and security; model-agnostic.
- [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) - Large index of Model Context Protocol servers across providers and languages.
- [rahulvrane/awesome-claude-agents](https://github.com/rahulvrane/awesome-claude-agents) - Meta-index of Claude Code subagent collections, setup guides, and orchestration tutorials.
- [Shubhamsaboo/awesome-llm-apps](https://github.com/Shubhamsaboo/awesome-llm-apps) - Runnable single- and multi-agent app examples across models, including Claude; cross-vendor cookbook.
- [VoltAgent/awesome-ai-agent-papers](https://github.com/VoltAgent/awesome-ai-agent-papers) - Weekly-updated 2024–2026 AI agent papers covering memory, evaluation, and workflows.
