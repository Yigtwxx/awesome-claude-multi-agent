# Awesome Claude Multi-Agent [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

A curated list of frameworks, patterns, protocols, and case studies for multi-agent orchestration where Claude is a primary model.

*Multi-agent* here means coordinated systems of multiple agents across processes, not single-session Claude Code subagents.

Companion documents: [glossary](glossary.md) for terminology, [pitfalls](pitfalls.md) for failure modes, and [security references](SECURITY.md).

## Contents

- [Foundational Reading](#foundational-reading)
- [Multi-Agent Patterns and Architectures](#multi-agent-patterns-and-architectures)
- [Orchestration Frameworks](#orchestration-frameworks)
- [Subagent Collections](#subagent-collections)
- [Skills, Hooks, and MCP for Coordination](#skills-hooks-and-mcp-for-coordination)
- [Memory, State, and Communication](#memory-state-and-communication)
- [Standards and Protocols](#standards-and-protocols)
- [Evaluation and Benchmarks](#evaluation-and-benchmarks)
- [Observability and Debugging](#observability-and-debugging)
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

## Multi-Agent Patterns and Architectures

Canonical coordination patterns with implementation references. See Foundational Reading above for the seminal papers.

- [Blackboard](https://arxiv.org/abs/2507.01701) - Shared workspace where agents with varied roles read and write to a common store until consensus is reached.
- [Dynamic Agent Selection](https://arxiv.org/abs/2310.02170) - Agents are chosen and wired into a communication structure on the fly per task; defined by the DyLAN network.
- [Hierarchical Role-Based](https://docs.deepwisdom.ai/) - Structured agent hierarchy with defined SOPs per role; MetaGPT is the canonical implementation.
- [Mixture-of-Agents](https://github.com/togethercomputer/MoA) - Layered aggregation where each layer's agents improve on the previous layer's proposals.
- [Multi-Agent Debate](https://github.com/composable-models/llm_multiagent_debate) - Multiple instances independently reason then critique each other over iterative rounds.
- [Orchestrator-Worker](https://www.anthropic.com/news/building-effective-agents) - Lead agent plans and spawns parallel subagents; defined in Anthropic's agent design patterns guide.
- [Parallelization and Voting](https://arxiv.org/abs/2402.05120) - Independent agents answer the same query and a majority vote selects the result; accuracy scales with agent count.
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
- [claude-flow](https://github.com/ruvnet/claude-flow) - Claude-centric swarm orchestration with multiple topologies, federation, and consensus protocols.
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
- [OpenAI Agents SDK](https://github.com/openai/openai-agents-python) - Lightweight framework for multi-agent workflows with handoffs and guardrails; Claude via LiteLLM.
- [OpenHands](https://github.com/All-Hands-AI/OpenHands) - Generalist software-developer platform with AgentDelegateAction for hierarchical multi-agent task delegation.
- [Pydantic AI](https://github.com/pydantic/pydantic-ai) - Type-safe Python agent framework with delegation patterns, graph-based multi-agent flows, and Claude support.
- [smolagents](https://github.com/huggingface/smolagents) - Lightweight code-first agents library with hierarchical multi-agent support; Claude via LiteLLM.
- [Strands Agents](https://github.com/strands-agents/sdk-python) - AWS model-driven SDK with swarm, graph, and agents-as-tools multi-agent patterns; defaults to Claude on Bedrock.
- [Swarms](https://github.com/kyegomez/swarms) - Multi-agent orchestration framework with sequential, concurrent, and hierarchical workflows; Claude via LiteLLM.
- [VoltAgent](https://github.com/VoltAgent/voltagent) - TypeScript framework for supervisor and subagent multi-agent systems with built-in observability; supports Claude.

## Subagent Collections

Curated sets of Claude Code subagents. Links to the collections only; contents are not duplicated here. Listed alphabetically.

- [agents](https://github.com/wshobson/agents) - Collection of 184 Claude Code subagents and 16 multi-agent workflow orchestrators across development domains.
- [agents (contains-studio)](https://github.com/contains-studio/agents) - Department-organized Claude Code subagents spanning engineering, design, marketing, and operations roles.
- [awesome-claude-agents](https://github.com/vijaythecoder/awesome-claude-agents) - Orchestrated team of Claude Code subagents coordinating as an automated software-development crew.
- [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) - Over 100 Claude Code subagents across 10 domain categories with model routing and structured output.
- [claude-agents](https://github.com/iannuttall/claude-agents) - Seven focused subagents covering refactor, security, planning, frontend, and mentorship tasks.
- [claude-code-sub-agents](https://github.com/lst97/claude-code-sub-agents) - Set of 33 specialized subagents including an agent-organizer meta-orchestrator for parallel coordination.
- [claude-code-templates](https://github.com/davila7/claude-code-templates) - CLI for 100+ agents, slash commands, MCP integrations, and hooks for Claude Code projects.

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
- [Multiagent Finetuning: Self Improvement with Diverse Reasoning Chains](https://arxiv.org/abs/2501.05707) - Specializes a society of models through multi-agent interaction to sustain self-improvement over many rounds (2025).

## Case Studies and Production Postmortems

Engineering accounts and counter-perspectives on real multi-agent deployments. Community submissions welcome via PR — see [contributing.md](contributing.md).

- [Don't Build Multi-Agents](https://cognition.ai/blog/dont-build-multi-agents) - Cognition's argument that context-sharing failures make multi-agent unreliable for code editing (2025).
- [Building Agents with the Claude Agent SDK](https://claude.com/blog/building-agents-with-the-claude-agent-sdk) - Anthropic's account of the agent loop, context management, and subagents behind Claude Code (2025).
- [How to Think About Agent Frameworks](https://www.langchain.com/blog/how-to-think-about-agent-frameworks) - LangChain's analysis of workflow-versus-agent abstractions and context control in multi-agent design (2025).
- [Context Engineering for AI Agents](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus) - Manus team's lessons on KV-cache, tool masking, and file-based context from building their agent (2025).
- [The AI Scientist](https://sakana.ai/ai-scientist/) - Sakana AI's autonomous research pipeline coordinating ideation, experiment, and review agents end-to-end (2024).

## Talks, Courses, and Books

Video lectures and structured courses focused on multi-agent LLM systems. Listed alphabetically.

- [AI Agentic Design Patterns with AutoGen](https://learn.deeplearning.ai/courses/ai-agentic-design-patterns-with-autogen) - DeepLearning.AI course taught by AutoGen creators on multi-agent design patterns.
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
- [Latent Space](https://www.latent.space/) - AI engineering newsletter and podcast with recurring coverage of agent and multi-agent architectures.
- [r/AI_Agents](https://www.reddit.com/r/AI_Agents/) - Subreddit focused on building, orchestrating, and deploying autonomous and multi-agent systems.
- [r/ClaudeAI](https://www.reddit.com/r/ClaudeAI/) - Subreddit for Claude users, including threads on subagents, orchestration, and multi-agent setups.

## Related Lists

Adjacent awesome lists with honest scope descriptions. Cited openly, including direct competitors.

- [andyrewlee/awesome-agent-orchestrators](https://github.com/andyrewlee/awesome-agent-orchestrators) - Curated orchestrators across Claude, Codex, Gemini, and Cursor; not Claude-specific.
- [e2b-dev/awesome-ai-agents](https://github.com/e2b-dev/awesome-ai-agents) - Broad agent ecosystem index; less actively maintained since mid-2023.
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) - Wide-ranging index of Claude Code resources: skills, hooks, orchestrators, and subagent collections.
- [Jenqyang/Awesome-AI-Agents](https://github.com/Jenqyang/Awesome-AI-Agents) - Collection of LLM-powered autonomous agents, frameworks, and multi-agent systems; model-agnostic.
- [kaushikb11/awesome-llm-agents](https://github.com/kaushikb11/awesome-llm-agents) - Curated list of LLM agent frameworks; vendor-agnostic and framework-focused.
- [kyegomez/awesome-multi-agent-papers](https://github.com/kyegomez/awesome-multi-agent-papers) - Compilation of multi-agent research papers; broader and model-agnostic.
- [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) - Large index of Model Context Protocol servers across providers and languages.
- [Shubhamsaboo/awesome-llm-apps](https://github.com/Shubhamsaboo/awesome-llm-apps) - Runnable single- and multi-agent app examples across models, including Claude; cross-vendor cookbook.
- [VoltAgent/awesome-ai-agent-papers](https://github.com/VoltAgent/awesome-ai-agent-papers) - Weekly-updated 2024–2026 AI agent papers covering memory, evaluation, and workflows.
