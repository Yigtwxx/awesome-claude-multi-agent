# Awesome Claude Multi-Agent [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

Systems in which several AI agents, with Claude among the underlying models, divide work, exchange messages, and check each other's results.

Entries range from subagents inside one Claude Code session to agent teams spread across processes and machines. Single-agent tools are included only when they help agents coordinate.

Companion documents: [glossary](glossary.md) for terminology, [pitfalls](pitfalls.md) for failure modes and counter-arguments, and [security references](security-references.md) for attacks and defenses.

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

Anthropic primary sources on agent design and the seminal papers that define the patterns used elsewhere in this list. Listed chronologically.

- [ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629) - Interleaves reasoning traces with tool actions; baseline for tool-using agent orchestration (ICLR 2023).
- [Reflexion: Language Agents with Verbal Reinforcement Learning](https://arxiv.org/abs/2303.11366) - Verbal self-reflection between attempts lets an actor agent learn from prior failures across episodes (NeurIPS 2023).
- [HuggingGPT: Solving AI Tasks with ChatGPT and its Friends in Hugging Face](https://arxiv.org/abs/2303.17580) - LLM controller plans tasks then delegates to specialist Hugging Face models; canonical orchestrator-of-models pattern (NeurIPS 2023).
- [Self-Refine: Iterative Refinement with Self-Feedback](https://arxiv.org/abs/2303.17651) - Generator, critic, and refiner roles within one model; defines the reflection pattern (NeurIPS 2023).
- [CAMEL: Communicative Agents for Mind Exploration](https://arxiv.org/abs/2303.17760) - Cooperative role-playing via inception prompting; first scalable two-agent coordination paper (NeurIPS 2023).
- [Generative Agents: Interactive Simulacra of Human Behavior](https://arxiv.org/abs/2304.03442) - Twenty-five LLM agents simulate daily life with memory, reflection, and planning (UIST 2023).
- [Improving Factuality and Reasoning via Multiagent Debate](https://arxiv.org/abs/2305.14325) - Multiple LLM instances debate over rounds to improve factuality and reasoning (ICML 2024).
- [MetaGPT: Meta Programming for a Multi-Agent Collaborative Framework](https://arxiv.org/abs/2308.00352) - SOP-encoded multi-agent software company with product manager, architect, and engineer roles (ICLR 2024).
- [AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation](https://arxiv.org/abs/2308.08155) - Framework for conversable multi-agent chat with customizable roles and tool access (ICLR 2024).
- [Mixture-of-Agents Enhances Large Language Model Capabilities](https://arxiv.org/abs/2406.04692) - Layered LLM ensemble where each layer's agents read the previous layer's outputs (2024).
- [Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) - Anthropic's reference patterns for agents: prompt chaining, routing, parallelization, orchestrator-workers, and evaluator-optimizer (2024).
- [How We Built Our Multi-Agent Research System](https://www.anthropic.com/engineering/multi-agent-research-system) - Anthropic's engineering account of running parallel Claude orchestrator-worker research agents (2025).
- [Building Multi-Agent Systems: When and How to Use Them](https://claude.com/blog/building-multi-agent-systems-when-and-how-to-use-them) - Anthropic's guidance on the three cases where multiple agents help: context isolation, parallelization, and specialization (2026).
- [Patterns and Problems in Emerging Multiagent Systems](https://www.anthropic.com/research/multiagent-systems) - Anthropic red-team study of coordination failures, homogeneity collapse, and conflict escalation among interacting agents (2026).

## Multi-Agent Patterns and Architectures

Named coordination patterns, each linked to its defining paper or a reference implementation. Listed alphabetically.

- [Blackboard](https://arxiv.org/abs/2507.01701) - Shared workspace where agents with varied roles read and write to a common store until consensus is reached.
- [Dynamic Agent Selection](https://arxiv.org/abs/2310.02170) - Agents are chosen and wired into a communication structure on the fly per task; defined by the DyLAN network.
- [Hierarchical Role-Based](https://docs.deepwisdom.ai/) - Structured agent hierarchy with defined SOPs per role; MetaGPT is the canonical implementation.
- [Market-Based Coordination](https://arxiv.org/abs/2511.17621) - Agents act as market participants trading probabilistic beliefs to converge on shared, truthful outcomes.
- [Mixture-of-Agents](https://github.com/togethercomputer/MoA) - Layered aggregation where each layer's agents improve on the previous layer's proposals.
- [Multi-Agent Debate](https://github.com/composable-models/llm_multiagent_debate) - Multiple instances independently reason then critique each other over iterative rounds.
- [Orchestrator-Worker](https://github.com/anthropics/claude-cookbooks/blob/main/patterns/agents/orchestrator_workers.ipynb) - Lead agent plans and spawns parallel subagents; Anthropic's cookbook notebook implements the pattern from Building Effective Agents.
- [Parallelization and Voting](https://arxiv.org/abs/2402.05120) - Independent agents answer the same query and a majority vote selects the result; accuracy scales with agent count.
- [Recursive Task Decomposition](https://arxiv.org/abs/2311.05772) - Tasks are decomposed into subtasks only when an agent cannot execute them directly; defined by ADaPT.
- [Reflection and Self-Critique](https://github.com/madaan/self-refine) - Actor produces output; critic proposes revisions; actor refines; loop until quality gate.
- [Sequential Handoff](https://developers.openai.com/cookbook/examples/orchestrating_agents) - One agent transfers control and context to a more specialized agent mid-conversation.
- [Supervisor with Tool Routing](https://docs.langchain.com/oss/python/langchain/multi-agent/subagents) - Central supervisor agent calls specialized subagents as tools and decides routing; documented in LangChain's multi-agent guide.

## Orchestration Frameworks

Maintained libraries, runtimes, and harnesses that coordinate several agents and support Claude. Listed alphabetically.

- [AG2](https://github.com/ag2ai/ag2) - Apache-licensed AutoGen community fork providing multi-agent AgentOS primitives and active development.
- [Agent Orchestrator](https://github.com/Untrivial-ai/agent-orchestrator) - Desktop workspace whose orchestrator plans and delegates work to coding agents in per-task worktrees with a live Kanban.
- [Agent Squad](https://github.com/2FastLabs/agent-squad) - Python, TypeScript, and Swift framework routing conversations across specialized agents, with a SupervisorAgent for team coordination; supports Anthropic.
- [AgentScope](https://github.com/agentscope-ai/agentscope) - Alibaba's distributed multi-agent platform with message-passing primitives, fault tolerance, and visual workflow studio.
- [Agno](https://github.com/agno-agi/agno) - High-performance Python framework for multi-agent teams with memory and knowledge; model-agnostic interface including Claude.
- [BeeAI Framework](https://github.com/i-am-bee/beeai-framework) - IBM-originated Python and TypeScript framework for agent workflows and multi-agent orchestration across model providers.
- [CAMEL](https://github.com/camel-ai/camel) - Research framework for role-playing multi-agent systems with stateful memory and Claude support.
- [ChatDev](https://github.com/OpenBMB/ChatDev) - Chat-chain platform where agent teams with distinct roles build software end-to-end.
- [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) - Anthropic's official Python and TypeScript SDKs for Claude agents with programmatic subagents, hooks, and MCP servers.
- [Claude Code Agent Farm](https://github.com/Dicklesworthstone/claude_code_agent_farm) - Runs 20 or more Claude Code sessions in parallel with lock-based coordination for bug-fixing and refactoring sweeps.
- [Claude Managed Agents](https://platform.claude.com/docs/en/managed-agents/multiagent-orchestration) - Anthropic-hosted coordinator delegating to up to 20 agent types in context-isolated threads that share one sandbox.
- [Claude Squad](https://github.com/smtg-ai/claude-squad) - Terminal manager for running multiple parallel Claude Code agents in isolated Git workspaces.
- [Claude Swarm](https://github.com/affaan-m/claude-swarm) - Decomposes tasks across parallel Claude Code agents with conflict detection and a rich terminal coordination UI.
- [ClawTeam](https://github.com/HKUDS/ClawTeam) - Agents spawn teammates, delegate tasks, and coordinate over file or ZeroMQ transports; runs on Claude Code and Codex.
- [Conductor](https://github.com/microsoft/conductor) - Microsoft CLI running YAML-defined multi-agent workflows on GitHub Copilot or Claude, with experimental Claude Agent SDK support.
- [CrewAI](https://github.com/crewAIInc/crewAI) - Role-based multi-agent framework with first-class Claude support, crew primitives, and shared memory.
- [Dapr Agents](https://github.com/dapr/dapr-agents) - Framework for resilient, stateful multi-agent systems with workflow orchestration on the Dapr runtime.
- [Deep Agents](https://github.com/langchain-ai/deepagents) - LangChain agent harness that delegates tasks to subagents with isolated context windows; supports Claude and other tool-calling models.
- [Gas Town](https://github.com/gastownhall/gastown) - Workspace manager coordinating 20 to 30 Claude Code agents through a Mayor coordinator, mailboxes, and a Git-backed work ledger.
- [Google ADK](https://github.com/google/adk-python) - Google's Agent Development Kit for hierarchical multi-agent systems; Claude via LiteLLM and Vertex AI.
- [Inngest AgentKit](https://github.com/inngest/agent-kit) - TypeScript framework for multi-agent networks with deterministic routing and MCP tooling; supports Claude.
- [LangGraph](https://github.com/langchain-ai/langgraph) - Stateful graph-based orchestration library supporting supervisor, swarm, and multi-agent patterns.
- [Langroid](https://github.com/langroid/langroid) - Python framework structured around multi-agent message passing and task delegation; Claude supported.
- [Mastra](https://github.com/mastra-ai/mastra) - TypeScript framework for agent workflows with multi-agent networks, durable execution, and first-class Claude support.
- [mcp-agent](https://github.com/lastmile-ai/mcp-agent) - Composable multi-agent framework built on the Model Context Protocol with Claude as a primary backend.
- [MetaGPT](https://github.com/FoundationAgents/MetaGPT) - SOP-driven software-team simulation; the canonical hierarchical role-based multi-agent implementation.
- [Microsoft Agent Framework](https://github.com/microsoft/agent-framework) - Microsoft's successor to AutoGen and Semantic Kernel for multi-agent workflows in Python and .NET.
- [Munder Difflin](https://github.com/HarnessMD/munder-difflin) - Electron harness coordinating an office of Claude Code and other CLI agents that message, route, and remember.
- [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) - Teams-first multi-agent orchestration for Claude Code with task routing across specialized agents.
- [Omnigent](https://github.com/omnigent-ai/omnigent) - Meta-harness mixing Claude Code, Codex, Cursor, and custom agents in one session under a delegating orchestrator.
- [Open Multi-Agent](https://github.com/open-multi-agent/open-multi-agent) - Self-hosted TypeScript runtime where a coordinator builds task graphs with durable approvals, consensus checks, and run records.
- [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) - Lightweight framework for multi-agent workflows with handoffs and guardrails; Claude via LiteLLM.
- [OpenHands](https://github.com/OpenHands/OpenHands) - Generalist software-developer platform with AgentDelegateAction for hierarchical multi-agent task delegation.
- [Orca](https://github.com/stablyai/orca) - Desktop and mobile environment fanning one prompt across Claude Code, Codex, and other agents in parallel worktrees.
- [Paperclip](https://github.com/paperclipai/paperclip) - Self-hosted server and UI orchestrating teams of agents with org charts, heartbeats, budgets, and delegation.
- [Pydantic AI](https://github.com/pydantic/pydantic-ai) - Type-safe Python agent framework with delegation patterns, graph-based multi-agent flows, and Claude support.
- [ruflo](https://github.com/ruvnet/ruflo) - Claude-centric agent meta-harness deploying multi-agent swarms with adaptive memory, federation, and consensus topologies.
- [smolagents](https://github.com/huggingface/smolagents) - Lightweight code-first agents library with hierarchical multi-agent support; Claude via LiteLLM.
- [Strands Agents](https://github.com/strands-agents/harness-sdk) - AWS model-driven SDK for Python and TypeScript with swarm, graph, and agents-as-tools patterns; defaults to Claude on Bedrock.
- [Superset](https://github.com/superset-sh/superset) - Desktop workspace running Claude Code, Codex, and other CLI agents in parallel Git worktrees, with diff review and pull requests.
- [swarmclaw](https://github.com/swarmclawai/swarmclaw) - Self-hosted agent runtime for autonomous swarms with memory, delegation, scheduling, and MCP tools across many model providers.
- [Swarms](https://github.com/kyegomez/swarms) - Multi-agent orchestration framework with sequential, concurrent, and hierarchical workflows; Claude via LiteLLM.
- [VoltAgent](https://github.com/VoltAgent/voltagent) - TypeScript framework for supervisor and subagent multi-agent systems with built-in observability; supports Claude.
- [Zeroshot](https://github.com/the-open-engine/zeroshot) - Executor and independent verifier agents arranged as an explicit graph with bounded repair loops; runs on Claude Code or Codex.

## Subagent Collections

Curated sets of Claude Code subagents. Links to the collections only; contents are not duplicated here. Listed alphabetically.

- [agency-agents](https://github.com/msitarzewski/agency-agents) - Department-organized agent personas for engineering, marketing, and operations, installable into Claude Code and other harnesses.
- [agents](https://github.com/wshobson/agents) - Over 200 Claude Code subagents packaged as plugins with multi-agent workflow orchestrators; exportable to other harnesses.
- [agentsys](https://github.com/agent-sh/agentsys) - Plugin set of 49 agents and 44 skills that compose into structured development pipelines for Claude Code.
- [awesome-claude-agents](https://github.com/vijaythecoder/awesome-claude-agents) - Orchestrated team of Claude Code subagents coordinating as an automated software-development crew.
- [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) - Over 160 Claude Code subagents across 10 domain categories with per-agent model routing.
- [buildwithclaude](https://github.com/davepoon/buildwithclaude) - Plugin marketplace with over 100 Claude Code subagents across 17 categories, including meta-orchestration agents, plus commands and hooks.

## Starter Templates and Examples

Runnable starting points and worked examples for assembling multi-agent Claude systems. Links only; contents are not duplicated. Listed alphabetically.

- [agent-orchestrator-template](https://github.com/shintaro-sprech/agent-orchestrator-template) - Self-evolving Claude Code subagent system that creates, merges, and promotes specialized agents per task.
- [Claude Agent SDK Demos](https://github.com/anthropics/claude-agent-sdk-demos/tree/main/research-agent) - Official Agent SDK example where a lead agent spawns parallel researcher, analyst, and report-writer subagents.
- [Claude Cookbooks Agent Patterns](https://github.com/anthropics/claude-cookbooks/tree/main/patterns/agents) - Official notebooks implementing orchestrator-workers, N-agent peer teams, and async subagent messaging with Claude.
- [Claude Quickstarts](https://github.com/anthropics/claude-quickstarts) - Official runnable Claude projects, including a two-agent autonomous coding example.
- [GPT Researcher Multi-Agent Example](https://github.com/assafelovic/gpt-researcher/tree/main/multi_agents) - LangGraph team of eight agents, led by a chief editor, that plans, researches, reviews, and publishes reports.
- [Strands Agents Samples](https://github.com/strands-agents/samples) - Official notebooks for agents-as-tools, swarm, graph, and A2A orchestration, plus multi-agent evaluation, using Claude on Bedrock.

## Skills, Hooks, and MCP for Coordination

Claude Code features, skills, hooks, and MCP tooling used to coordinate agents or connect them to shared state. Listed alphabetically.

- [Agent-MCP](https://github.com/rinadelph/Agent-MCP) - Framework for coordinating multiple specialized agents in parallel through the Model Context Protocol.
- [ccpm](https://github.com/automazeio/ccpm) - Project-management skill that turns GitHub issues into tasks executed by parallel agents in Git worktrees.
- [Claude Agent SDK Subagents](https://code.claude.com/docs/en/agent-sdk/subagents) - Programmatic subagent definitions with spawn-depth, concurrency, and spend caps for nested agent trees.
- [Claude Code Advanced Patterns](https://resources.anthropic.com/hubfs/Claude%20Code%20Advanced%20Patterns_%20Subagents,%20MCP,%20and%20Scaling%20to%20Real%20Codebases.pdf) - Anthropic-authored guide to subagents, MCP, and scaling Claude Code across real codebases.
- [Claude Code Agent Teams](https://code.claude.com/docs/en/agent-teams) - Experimental feature coordinating multiple Claude Code sessions with a shared task list and inter-agent messaging.
- [Claude Code Agent View](https://code.claude.com/docs/en/agent-view) - Dispatch and monitor many parallel background Claude Code sessions from a single screen.
- [Claude Code Dynamic Workflows](https://code.claude.com/docs/en/workflows) - JavaScript orchestration scripts that fan out up to 1,000 subagents per run with pipeline and parallel primitives and resumable runs.
- [Claude Code Hooks](https://code.claude.com/docs/en/hooks) - Lifecycle event handlers, including SubagentStop and TaskCompleted, for enforcing quality gates across agents.
- [Claude Code Run Agents in Parallel](https://code.claude.com/docs/en/agents) - Official comparison of subagents, agent view, agent teams, dynamic workflows, worktrees, and cross-session messaging.
- [Claude Code Sub-Agents Documentation](https://code.claude.com/docs/en/sub-agents) - Official specification for `.claude/agents/` subagent definitions with tool gating, worktree isolation, and nesting.
- [claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery) - Worked examples of every Claude Code hook lifecycle event and subagent control pattern.
- [MCP Reference Servers](https://github.com/modelcontextprotocol/servers) - Official MCP server implementations including Memory (knowledge graph) and Sequential Thinking.
- [superpowers](https://github.com/obra/superpowers) - Skills framework for Claude Code including subagent-driven development and parallel agent dispatch workflows.

## Memory, State, and Communication

Shared memory layers, inter-agent messaging, and persistent state systems designed for multi-agent stacks. Listed alphabetically.

- [agentmemory](https://github.com/rohitg00/agentmemory) - MCP memory server shared across Claude Code, Codex, Cursor, and other agents with per-agent scoping and knowledge graphs.
- [agmsg](https://github.com/fujibee/agmsg) - Cross-vendor messaging letting Claude Code, Codex, Gemini, and Copilot CLI sessions exchange messages through SQLite.
- [basic-memory](https://github.com/basicmachines-co/basic-memory) - Local-first Markdown knowledge base with MCP integration for persistent cross-agent state.
- [buzz](https://github.com/block/buzz) - Block's self-hostable workspace where humans and agents share channels on a signed Nostr event log.
- [Claude Code Cross-Session Messaging](https://code.claude.com/docs/en/cross-session-messaging) - Built-in tools letting independent Claude Code sessions exchange messages across terminals, machines, and the web.
- [claude-peers-mcp](https://github.com/louislva/claude-peers-mcp) - MCP server letting multiple local Claude Code instances discover and message each other ad hoc.
- [Cognee](https://github.com/topoteretes/cognee) - Memory layer that builds queryable knowledge graphs from agent interactions and documents.
- [Graphiti](https://github.com/getzep/graphiti) - Library for building real-time, temporally-aware knowledge graphs usable as shared agent memory.
- [LangMem](https://github.com/langchain-ai/langmem) - LangChain SDK giving agents long-term memory through extraction, consolidation, and cross-session retrieval.
- [Letta](https://github.com/letta-ai/letta) - Stateful agent platform with hierarchical memory blocks and archival storage; recommends Claude as backend.
- [mem0](https://github.com/mem0ai/mem0) - Universal memory layer with user, session, and agent tiers; integrates with CrewAI and LangGraph.
- [Redis Agent Memory Server](https://github.com/redis/agent-memory-server) - Session and long-term memory layer for agents backed by Redis with semantic search and an MCP interface.
- [Zep](https://github.com/getzep/zep) - Temporal knowledge-graph memory platform for agents with Graph RAG and session context management.

## Standards and Protocols

Open specifications for agent communication, discovery, and tool access across frameworks and vendors, and surveys comparing them. Listed alphabetically.

- [A Survey of Agent Interoperability Protocols](https://arxiv.org/abs/2505.02279) - Compares MCP, ACP, A2A, and ANP across architecture, security, and interaction models (2025).
- [A Technical Taxonomy of LLM Agent Communication Protocols](https://arxiv.org/abs/2606.19135) - Classifies nine open agent protocols by counterparty, payload, state, discovery, and schema flexibility (2026).
- [A2A Protocol](https://github.com/a2aproject/A2A) - Open standard at v1.0 under the Agentic AI Foundation for cross-framework agent discovery and task delegation.
- [Agent Network Protocol](https://github.com/agent-network-protocol/AgentNetworkProtocol) - Open protocol for decentralized agent discovery and secure collaboration using decentralized identifiers.
- [AGNTCY Agent Directory](https://github.com/agntcy/dir) - Distributed announce-and-discovery layer letting multi-agent systems find and describe each other.
- [Model Context Protocol](https://github.com/modelcontextprotocol/modelcontextprotocol) - Anthropic-originated open standard connecting agents to tools and data; the 2026-07-28 revision is stateless and moves Tasks to an extension.
- [Open Agent Specification](https://github.com/oracle/agent-spec) - Oracle's declarative language for agents, flows, swarms, and manager-worker teams, with LangGraph, AutoGen, and CrewAI adapters.

## Evaluation and Benchmarks

Benchmarks built for agent teams, plus the standard agent benchmarks that multi-agent systems report results on. Listed alphabetically.

- [AgentBench](https://github.com/THUDM/AgentBench) - Eight-environment benchmark measuring LLM-as-agent performance across web, code, and OS tasks (ICLR 2024).
- [AgentWebBench](https://arxiv.org/abs/2604.10938) - Benchmark where a user agent coordinates with website content agents across search, recommendation, QA, and research (ICML 2026).
- [BattleAgentBench](https://arxiv.org/abs/2408.15971) - Benchmark scoring language models on cooperation and competition across graduated multi-agent scenarios (2024).
- [Claude Opus 5 System Card: Multi-Agent Evaluations](https://www.anthropic.com/claude-opus-5-system-card) - Section 8.11 benchmarks N-agent peer teams and async-subagent harnesses against single agents on BrowseComp and ProgramBench (2026).
- [Collab-Overcooked](https://arxiv.org/abs/2502.20073) - Overcooked-based benchmark measuring how well LLM agents collaborate through natural-language coordination (EMNLP 2025).
- [GAIA](https://arxiv.org/abs/2311.12983) - General-assistant benchmark of 466 real-world questions, commonly used to evaluate multi-agent systems such as Magentic-One (ICLR 2024).
- [MARBLE](https://github.com/ulab-uiuc/MARBLE) - MultiAgentBench code measuring collaboration across star, chain, tree, and graph topologies (ACL 2025).
- [OrchBench](https://arxiv.org/abs/2607.25656) - Simulates orchestration plans without running workers; validated against real Claude Code execution at a fraction of tokens (2026).
- [PARTNR](https://arxiv.org/abs/2411.00081) - Meta benchmark of 100,000 household tasks for embodied human-robot multi-agent planning (2024).
- [Seeing the Whole Elephant](https://arxiv.org/abs/2604.22708) - TraceElephant benchmark for failure attribution in multi-agent systems using full execution traces (ACL 2026).
- [SWE-bench](https://arxiv.org/abs/2310.06770) - Benchmark of real GitHub issues widely used to evaluate single- and multi-agent coding systems (ICLR 2024).
- [TheAgentCompany](https://arxiv.org/abs/2412.14161) - Benchmark of realistic enterprise software tasks measuring agent performance in a simulated company (2024).
- [WebArena](https://arxiv.org/abs/2307.13854) - Realistic, self-hostable web environment for benchmarking autonomous agents on long-horizon tasks (2023).
- [τ-bench](https://github.com/sierra-research/tau-bench) - Tool-agent-user benchmark measuring agent reliability with a pass^k metric in realistic domains.
- [τ²-Bench](https://github.com/sierra-research/tau2-bench) - Dual-control conversational agent benchmark; successor to τ-bench from Sierra Research.

## Datasets and Environments

Reusable simulation environments and datasets for studying multi-agent coordination, distinct from the scored benchmarks above. Listed alphabetically.

- [AgentSociety](https://github.com/tsinghua-fib-lab/AgentSociety) - Simulator running thousands of LLM-driven agents in a society with economy, social media, and city environments.
- [AI Diplomacy](https://github.com/GoodStartLabs/AI_Diplomacy) - Diplomacy harness where stateful LLM agents, including Claude, negotiate, form alliances, and betray each other across seven powers.
- [AI Village](https://theaidigest.org/village) - Ongoing AI Digest experiment where Claude and other frontier models pursue shared goals through a public group chat.
- [Concordia](https://github.com/google-deepmind/concordia) - DeepMind library for generative agent-based models simulating interactions among many LLM-driven entities.
- [Cooperate or Collapse](https://arxiv.org/abs/2404.16698) - GovSim commons simulation testing whether societies of LLM agents, including Claude 3 models, sustain a shared resource (NeurIPS 2024).
- [Magentic Marketplace](https://github.com/microsoft/multi-agent-marketplace) - Microsoft simulator of LLM buyer and seller agents that measures welfare and fairness in agentic markets; supports Claude.
- [OASIS](https://github.com/camel-ai/oasis) - Social-media simulator scaling LLM-driven agents to one million users for studying group dynamics.
- [SOTOPIA](https://github.com/sotopia-lab/sotopia) - Open-ended environment where language agents role-play social scenarios and are scored on goal completion (ICLR 2024).
- [TextArena](https://github.com/TextArena/TextArena) - Over 100 single-, two-, and multi-player text games for evaluating and training LLM agents; Claude via OpenRouter.

## Observability and Debugging

Tracing, replay, and evaluation tools that can follow nested multi-agent runs. Listed alphabetically.

- [AgentOps](https://github.com/AgentOps-AI/agentops) - Session-level monitoring and replay for multi-agent systems across CrewAI, AutoGen, and other frameworks.
- [Arize Phoenix](https://github.com/Arize-ai/phoenix) - Open-source observability and evaluation for agent traces, built on OpenTelemetry.
- [Laminar](https://github.com/lmnr-ai/lmnr) - Open-source observability platform purpose-built for tracing and evaluating AI agents.
- [Langfuse](https://github.com/langfuse/langfuse) - Open-source platform tracing nested multi-agent sessions with evaluation, datasets, and prompt management.
- [LangSmith](https://www.langchain.com/langsmith/observability) - Tracing and evaluation platform that visualizes tool calls and multi-agent interactions step by step.
- [OpenLLMetry](https://github.com/traceloop/openllmetry) - OpenTelemetry-based instrumentation for tracing LLM and multi-agent applications across vendors.
- [OpenTelemetry GenAI Semantic Conventions](https://github.com/open-telemetry/semantic-conventions-genai) - Vendor-neutral OpenTelemetry conventions for agent spans, metrics, and MCP calls used by tracing backends.
- [Opik](https://github.com/comet-ml/opik) - Open-source tracing, evaluation, and dashboards for LLM applications and agentic workflows.
- [Weave](https://github.com/wandb/weave) - Weights & Biases toolkit for logging, tracing, and evaluating agentic LLM applications.

## Security, Safety, and Trust

Threats, defenses, and trust evaluations specific to coordinated multi-agent systems. The companion security references cover prompt injection and trust boundaries in more depth. Listed alphabetically.

- [A Survey on Trustworthy LLM Agents: Threats and Countermeasures](https://arxiv.org/abs/2503.09648) - Maps threats and defenses across an agent's reasoning, memory, tools, and interactions with users and other agents (2025).
- [Architecture Matters for Multi-Agent Security](https://arxiv.org/abs/2604.23459) - Empirical study of 13 multi-agent architectures showing attack success varies up to 3.8x by design (ICML 2026).
- [How We Contain Claude Across Products](https://www.anthropic.com/engineering/how-we-contain-claude) - Anthropic's sandbox architectures per product, including trust-escalation risks when subagent output is trusted over raw tool results (2026).
- [MAGPIE: Multi-Agent Contextual Privacy Evaluation](https://arxiv.org/abs/2510.15186) - Benchmark of 200 high-stakes tasks testing whether collaborating agents preserve contextual privacy (2025).
- [Red-Teaming LLM Multi-Agent Systems via Communication Attacks](https://arxiv.org/abs/2502.14847) - Agent-in-the-Middle attack compromises whole systems by intercepting and manipulating inter-agent messages (ACL 2025).
- [Seven Security Challenges in Cross-domain Multi-Agent LLM Systems](https://arxiv.org/abs/2505.23847) - Identifies seven security challenges that emerge when agents operate across organizational boundaries (2025).
- [TAMAS: Benchmarking Adversarial Risks in Multi-Agent LLM Systems](https://arxiv.org/abs/2511.05269) - Benchmark evaluating resilience and safety of multi-agent systems across adversarial attack scenarios (2025).
- [When Child Inherits: Modeling and Exploiting Subagent Spawn in Multi-Agent Networks](https://arxiv.org/abs/2605.08460) - Models how compromised parent agents propagate malicious state to spawned subagents through memory inheritance (2026).

## Research Papers

Recent, high-impact work on multi-agent LLMs not already listed in Foundational Reading. Paper collections under Related Lists go further. Listed chronologically.

- [ChatDev: Communicative Agents for Software Development](https://arxiv.org/abs/2307.07924) - Multi-agent software company pipeline with communicative dehallucination to reduce cross-role errors (ACL 2024).
- [ChatEval: Better LLM-based Evaluators through Multi-Agent Debate](https://arxiv.org/abs/2308.07201) - Multi-agent referee team that debates to evaluate text quality more reliably than a single judge (2023).
- [AgentVerse: Facilitating Multi-Agent Collaboration](https://arxiv.org/abs/2308.10848) - Framework studying emergent social behaviors and dynamic team assembly in multi-agent settings (ICLR 2024).
- [Large Language Model based Multi-Agents: A Survey](https://arxiv.org/abs/2402.01680) - Surveys multi-agent LLM systems across communication, profiling, and capability-enhancement mechanisms (IJCAI 2024).
- [Language Agents as Optimizable Graphs](https://arxiv.org/abs/2402.16823) - Represents multi-agent systems as graphs and automatically optimizes their topology and prompts; GPTSwarm (ICML 2024).
- [Chain of Agents: LLMs Collaborating on Long-Context Tasks](https://arxiv.org/abs/2406.02818) - Worker agents process long-context segments sequentially and a manager agent synthesizes the result (NeurIPS 2024).
- [Scaling Large Language Model-based Multi-Agent Collaboration](https://arxiv.org/abs/2406.07155) - Organizes agents into directed-graph networks and finds a collaborative scaling law past a thousand agents (ICLR 2025).
- [OpenHands: An Open Platform for AI Software Developers](https://arxiv.org/abs/2407.16741) - Agent platform with AgentDelegateAction enabling nested multi-agent software-development workflows (ICLR 2025).
- [Optima: Optimizing Effectiveness and Efficiency for LLM-Based Multi-Agent Systems](https://arxiv.org/abs/2410.08115) - Training framework improving communication efficiency and performance of multi-agent systems (2024).
- [AFlow: Automating Agentic Workflow Generation](https://arxiv.org/abs/2410.10762) - Automates workflow design with Monte Carlo tree search over code-represented agent workflows (ICLR 2025).
- [Magentic-One: A Generalist Multi-Agent System for Solving Complex Tasks](https://arxiv.org/abs/2411.04468) - Microsoft's orchestrator coordinating five specialist agents for web, file, and coding tasks (2024).
- [A Survey on LLM-based Multi-Agent System: Recent Advances and New Frontiers in Application](https://arxiv.org/abs/2412.17481) - Surveys recent LLM multi-agent systems across coordination mechanisms and application domains (2024).
- [Multiagent Finetuning: Self Improvement with Diverse Reasoning Chains](https://arxiv.org/abs/2501.05707) - Specializes a society of models through multi-agent interaction to sustain self-improvement over many rounds (ICLR 2025).
- [Multi-Agent Collaboration Mechanisms: A Survey of LLMs](https://arxiv.org/abs/2501.06322) - Surveys how LLM-based agents coordinate through collaboration mechanisms, structures, types, and protocols (2025).
- [Multi-agent Architecture Search via Agentic Supernet](https://arxiv.org/abs/2502.04180) - Samples query-dependent multi-agent architectures from a learned probabilistic supernet rather than one fixed design (ICML 2025).
- [Why Do Multi-Agent LLM Systems Fail?](https://arxiv.org/abs/2503.13657) - Introduces the MAST taxonomy of fourteen multi-agent failure modes from over a thousand annotated traces (NeurIPS 2025).
- [Which Agent Causes Task Failures and When?](https://arxiv.org/abs/2505.00212) - Defines automated failure attribution for multi-agent systems and releases the Who&When dataset of annotated failure logs (ICML 2025).
- [AgentsNet: Coordination and Collaborative Reasoning in Multi-Agent LLMs](https://arxiv.org/abs/2507.08616) - Benchmarks whether agent networks can self-organize coordination and collaborative reasoning as they scale (2025).
- [Beyond the Strongest LLM: Multi-Turn Multi-Agent Orchestration vs. Single LLMs on Benchmarks](https://arxiv.org/abs/2509.23537) - Finds multi-turn multi-agent orchestration matches or exceeds the strongest single model on GPQA, IFEval, and MuSR (2025).
- [MAS-Orchestra: Understanding and Improving Multi-Agent Reasoning Through Holistic Orchestration](https://arxiv.org/abs/2601.14652) - RL-trained orchestrator emits an entire multi-agent system in one pass; MASBench isolates when teams beat single agents (ICML 2026).
- [Multi-Agent Teams Hold Experts Back](https://arxiv.org/abs/2602.01011) - Self-organizing LLM teams underperform their own strongest member by up to 41% through integrative compromise (ICML 2026).
- [Beyond Individual Intelligence: Surveying Collaboration, Failure Attribution, and Self-Evolution](https://arxiv.org/abs/2605.14892) - Survey organizing multi-agent LLM work into capability, integration, failure attribution, and self-evolution stages (2026).
- [The Ringelmann Effect in Multi-Agent LLM Systems](https://arxiv.org/abs/2606.02646) - Scaling law estimating how many nominal agents contribute independent evidence; debate gains come from re-evaluation (2026).

## Case Studies and Production Postmortems

First-hand engineering accounts of building and running multi-agent systems, including arguments against them. Listed alphabetically.

- [A Harness for Every Task: Dynamic Workflows in Claude Code](https://claude.dev/blog/a-harness-for-every-task-dynamic-workflows-in-claude-code/) - Claude Code team on generating per-task orchestration scripts that fan out, verify adversarially, and synthesize across subagents (2026).
- [Building a C Compiler with a Team of Parallel Claudes](https://www.anthropic.com/engineering/building-c-compiler) - Sixteen Claude agents in containers coordinate through Git and lock files to build a 100,000-line C compiler (2026).
- [Building Agents with the Claude Agent SDK](https://claude.com/blog/building-agents-with-the-claude-agent-sdk) - Anthropic's account of the agent loop, context management, and subagents behind Claude Code (2025).
- [Devin Can Now Manage Devins](https://cognition.com/blog/devin-can-now-manage-devins) - Cognition's coordinator Devin scopes work, delegates to managed Devins in isolated VMs, then merges results (2026).
- [Don't Build Multi-Agents](https://cognition.com/blog/dont-build-multi-agents) - Cognition's argument that context-sharing failures make multi-agent unreliable for code editing (2025).
- [Harness Design for Long-Running Application Development](https://www.anthropic.com/engineering/harness-design-long-running-apps) - Anthropic's planner, generator, and evaluator agent harness for multi-sprint app development, separating worker from judge (2026).
- [How to Think About Agent Frameworks](https://www.langchain.com/blog/how-to-think-about-agent-frameworks) - LangChain's analysis of workflow-versus-agent abstractions and context control in multi-agent design (2025).
- [Multi-Agent Systems in the LLMOps Database](https://www.zenml.io/llmops-tags/multi-agent-systems) - ZenML's curated collection of real-world multi-agent production deployments across many industries.
- [Scaling Managed Agents: Decoupling the Brain from the Hands](https://www.anthropic.com/engineering/managed-agents) - Anthropic's architecture separating the model harness, sandbox, and session log so agents can hand sandboxes to one another (2026).
- [The AI Scientist](https://sakana.ai/ai-scientist/) - Sakana AI's autonomous research pipeline coordinating ideation, experiment, and review agents end-to-end (2024).
- [What 1,200 Production Deployments Reveal About LLMOps](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025) - ZenML's vendor-neutral analysis of multi-agent orchestration patterns that survive production (2025).

## Talks, Courses, and Books

Recorded talks, structured courses, and published books on multi-agent LLM systems. Listed alphabetically.

- [Agent Skills with Anthropic](https://www.deeplearning.ai/courses/agent-skills-with-anthropic) - DeepLearning.AI course with Anthropic on skills across Claude Code, API, and Agent SDK, including context-isolated subagents.
- [Agentic Architectural Patterns for Building Multi-Agent Systems](https://www.packtpub.com/en-us/product/agentic-architectural-patterns-for-building-multi-agent-systems-9781806029563) - Packt book by Ali Arsanjani and Juan Pablo Bustos on coordination, fault tolerance, and hierarchical multi-agent architectures (2026).
- [Agentic Design Patterns](https://link.springer.com/book/10.1007/978-3-032-01402-3) - Springer book by Antonio Gulli covering 21 agent patterns, including multi-agent collaboration and inter-agent communication (2025).
- [AI Agentic Design Patterns with AutoGen](https://learn.deeplearning.ai/courses/ai-agentic-design-patterns-with-autogen) - DeepLearning.AI course taught by AutoGen creators on multi-agent design patterns.
- [AI Agents in Action](https://www.manning.com/books/ai-agents-in-action) - Manning book on building, orchestrating, and deploying autonomous multi-agent systems (2025).
- [AI Engineer Europe 2026: The Multi-Agent Architecture That Actually Ships](https://www.youtube.com/watch?v=ow1we5PzK-o) - Factory's Luke Alvoeiro on orchestrator, worker, and validator roles connected by structured handoffs.
- [AI Engineer Summit 2025: How We Build Effective Agents](https://www.youtube.com/watch?v=D7_ipDqhtwk) - Anthropic's Barry Zhang on when agents pay off, ending with subagents and multi-agent collaboration.
- [AI Engineer World's Fair 2025: UX Design Principles for Semi-Autonomous Multi-Agent Systems](https://www.youtube.com/watch?v=fmZWvE7yDZo) - Microsoft Research's Victor Dibia on user control and interface design for multi-agent systems.
- [AWS re:Invent 2024: Using Multiple Agents for Scalable Generative AI Applications](https://www.youtube.com/watch?v=7pvEYLW1yZw) - AWS session on coordinating multiple specialized agents for enterprise-scale generative AI workloads.
- [Build a Multi-Agent System from Scratch](https://www.manning.com/books/build-a-multi-agent-system-from-scratch) - Manning early-access book building agent infrastructure, then connecting agents through MCP and A2A (2026).
- [Building Applications with AI Agents](https://www.oreilly.com/library/view/building-applications-with/9781098176495/) - O'Reilly book by Michael Albada on multi-agent design, including manager, hierarchical, and actor-critic coordination (2025).
- [Claude Code: A Highly Agentic Coding Assistant](https://www.deeplearning.ai/courses/claude-code-a-highly-agentic-coding-assistant) - DeepLearning.AI course with Anthropic covering subagents and parallel Claude sessions in Git worktrees.
- [Introduction to Subagents](https://anthropic.skilljar.com/introduction-to-subagents) - Free Anthropic Academy course on creating, scoping, and delegating work to Claude Code subagents.
- [Multi AI Agent Systems with crewAI](https://www.deeplearning.ai/courses/multi-ai-agent-systems-with-crewai) - DeepLearning.AI course by CrewAI founder on role, tool, and memory patterns in agent crews.
- [Practical Multi AI Agents and Advanced Use Cases with crewAI](https://www.deeplearning.ai/courses/practical-multi-ai-agents-and-advanced-use-cases-with-crewai) - Advanced crewAI course covering real application architectures and production agent patterns.

## Community

Active forums, chats, subreddits, and newsletters where practitioners discuss multi-agent systems. Listed alphabetically.

- [Agentic AI Foundation Working Groups](https://aaif.io/working-groups) - Linux Foundation body hosting MCP and A2A, with working groups on agent observability, identity, reliability, and security.
- [CAMEL-AI Community](https://github.com/camel-ai/camel?tab=readme-ov-file#community) - Research community Discord and forum for multi-agent systems built on CAMEL.
- [Claude Discord](https://discord.com/invite/6PPFFzqPDZ) - Official Claude community server for real-time help and project sharing.
- [CrewAI Community Forum](https://community.crewai.com/) - Official forum for CrewAI users discussing crews, flows, and multi-agent application design.
- [LangChain Forum](https://forum.langchain.com/) - Official community forum for LangChain and LangGraph, including multi-agent architecture discussions.
- [Latent Space](https://www.latent.space/) - AI engineering newsletter and podcast with recurring coverage of agent and multi-agent architectures.
- [r/AI_Agents](https://www.reddit.com/r/AI_Agents/) - Subreddit focused on building, orchestrating, and deploying autonomous and multi-agent systems.
- [r/ClaudeAI](https://www.reddit.com/r/ClaudeAI/) - Subreddit for Claude users, including threads on subagents, orchestration, and multi-agent setups.
- [r/ClaudeCode](https://www.reddit.com/r/ClaudeCode/) - Subreddit for Claude Code users, including agent teams, workflows, and subagent orchestration threads.

## Related Lists

Adjacent awesome lists, including direct competitors, each with a one-line note on how its scope differs. Listed alphabetically.

- [Agent-Analytics/awesome-multi-agent-orchestrators](https://github.com/Agent-Analytics/awesome-multi-agent-orchestrators) - Directory of multi-agent orchestrators, coding-agent workspaces, and runtimes; cross-vendor and includes closed products.
- [ai-boost/awesome-a2a](https://github.com/ai-boost/awesome-a2a) - Resources, SDKs, and sample agents for the A2A protocol; protocol-specific rather than Claude-specific.
- [andyrewlee/awesome-agent-orchestrators](https://github.com/andyrewlee/awesome-agent-orchestrators) - Curated orchestrators across Claude, Codex, Gemini, and Cursor; not Claude-specific.
- [ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) - Large index of Claude Skills, tools, and resources; broad Claude tooling, not multi-agent-specific.
- [e2b-dev/awesome-ai-agents](https://github.com/e2b-dev/awesome-ai-agents) - Broad index of autonomous agent projects and frameworks; model-agnostic and not multi-agent-specific.
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Wide-ranging index of Claude Code resources: skills, hooks, orchestrators, and subagent collections.
- [Jenqyang/Awesome-AI-Agents](https://github.com/Jenqyang/Awesome-AI-Agents) - Collection of LLM-powered autonomous agents, frameworks, and multi-agent systems; model-agnostic.
- [kaushikb11/awesome-llm-agents](https://github.com/kaushikb11/awesome-llm-agents) - Curated list of LLM agent frameworks; vendor-agnostic and framework-focused.
- [kyegomez/awesome-multi-agent-papers](https://github.com/kyegomez/awesome-multi-agent-papers) - Compilation of multi-agent research papers; broader and model-agnostic.
- [luo-junyu/Awesome-Agent-Papers](https://github.com/luo-junyu/Awesome-Agent-Papers) - Survey-linked collection of LLM agent papers across construction, collaboration, evolution, and security; model-agnostic.
- [nibzard/awesome-agentic-patterns](https://github.com/nibzard/awesome-agentic-patterns) - Catalogue of agentic AI design patterns backed by public references; broader than multi-agent and model-agnostic.
- [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) - Large index of Model Context Protocol servers across providers and languages.
- [Shubhamsaboo/awesome-llm-apps](https://github.com/Shubhamsaboo/awesome-llm-apps) - Runnable single- and multi-agent app examples across models, including Claude; cross-vendor cookbook.
- [VoltAgent/awesome-ai-agent-papers](https://github.com/VoltAgent/awesome-ai-agent-papers) - Weekly-updated 2024–2026 AI agent papers covering memory, evaluation, and workflows.

## Contributing

Suggestions are welcome. Read the [contribution guidelines](CONTRIBUTING.md) first; most proposals are declined for lacking a multi-agent dimension or recent activity.
