---
name: frontend-prototype-planner
description: Turn frontend prototypes, PRDs, screenshots, flowcharts, links, files, or plain-text requirements into implementation-ready Markdown construction plans, executable task cards, and unit-test blueprints. Use whenever the user asks how to build, split, estimate, schedule, choose frontend architecture, decompose pages/components/forms/state/API/permissions/data models, plan mocks, or add test cases. Planning only by default; never modifies project files unless implementation is explicitly requested. Not for pixel-perfect design restoration or direct code fixes. 适用于：前端原型/PRD/截图分析、建设方案、施工任务卡、排期/工作量评估、技术选型、组件怎么拆、单元测试用例规划。
---

# Frontend Prototype Planner

## Objective

Transform user-provided product requirements, prototypes, PRDs, screenshots, flowcharts, files, links, or plain-text descriptions into a clear frontend construction plan.

The final output must be a Markdown document that is readable by humans and AI agents. It must support implementation, review, task splitting, acceptance testing, handoff, and iterative development.

Optimize for plans that are executable, verifiable, and transferable. Do not stop at a polished overview when the requirement implies concrete frontend engineering work.

## Execution Boundary

By default, only analyze, decompose, design, and produce the frontend construction plan. Do not create, edit, delete, rename, move, format, or refactor project files unless the user explicitly asks to implement the plan, write code, generate files, apply changes to the project, or start development.

Reading project files is allowed when needed to understand whether the current directory is a frontend project and to identify the existing stack, structure, conventions, dependencies, and technical boundaries.

Treat these as document-output requests only:

- Planning, architecture, requirement analysis, requirement decomposition, implementation strategy, construction plan, 实施方案, 构建方案
- 生成实施文档, 落地方案, 开发计划, 技术方案, 前端建设方案
- 生成单元测试用例, 生成组件测试用例, 生成 `.spec.ts` 文件规划, 生成可落地的测试代码计划, 为任务卡补充测试用例, 单元测试怎么拆, 测试用例清单, 测试任务卡
- Review, refine, improve, or split a plan without asking to change code

Treat these as explicit implementation requests:

- 开始实现, 落地代码, 按方案开发, 生成页面, 修改工程, 写代码
- 实现测试代码, 生成测试文件, 写入工程, 修改 `package.json`
- Implement this, build it, code it, apply changes, generate files, start development

Saving the plan, task cards, or test plan itself as a standalone Markdown document (for example under `docs/`) when the user explicitly asks to save or export it is a document deliverable, not implementation. Never touch source code, configuration, or dependency files for that purpose.

If wording is ambiguous, choose document output and mark assumptions. Ask one concise clarification only when ambiguity would materially change the deliverable's correctness, task ownership, task count, implementation strategy, or when the next step would require modifying files.

This boundary applies to every workflow step and mode below. Mode sections do not restate it.

## Output Language

Write all descriptive plan content in the language of the user's request. If the request and the requirement materials use different languages, follow the request; default to Chinese when the conversation is mostly Chinese.

Keep structural identifiers stable for cross-agent handoff regardless of language: stable IDs such as `PAGE-001`, enum values such as `P0` / `M` / `foundation`, file paths, code, commands, and template field names stay in English.

## Inputs

Accept any of the following requirement sources:

- Prototype URL or design draft URL
- Local prototype file, image, PDF, DOCX, Markdown, HTML, spreadsheet, archive, or other readable file
- PRD URL or local PRD file
- Screenshot, wireframe, UI draft, flowchart, state diagram, table image, or interaction description
- Plain-text requirement description
- Mixed sources, such as PRD plus screenshots plus user notes

If a source cannot be accessed, state what is unavailable, list the missing information, explain impact, and continue with the available material. Do not block unless the missing content prevents meaningful analysis.

## Plan Scale

Before producing output, classify the requirement scale and size the plan to it:

- `component`: a single component, widget, or small interaction.
- `page`: one page or one small flow.
- `module`: a multi-page module or feature area.
- `system`: a complex business system, such as supply chain, approval, order, work order, finance, publishing, inventory, or admin platforms.

Scaling rules:

- Always include the core sections: source materials, source coverage audit, project context, requirement overview and decomposition, technical implementation directions for non-trivial features, data and API needs, interaction states, acceptance test matrix, risks, and assumptions.
- Include other sections only when they have real content at the chosen scale. Use the Section Applicability table in `references/output-template.md`.
- At `system` scale, the sections marked `System Mandatory` in `references/output-template.md` are mandatory even when source material is incomplete; fill them with assumptions, confidence, risks, and missing inputs.
- Below `system` scale, omit sections that would contain only assumption filler. End the plan with a one-line list of omitted sections and why each was omitted.
- If the user explicitly requests specific sections or the full output template, the user's request overrides these scale-based omission rules.
- State the chosen scale at the start of the plan.

## Workflow

### 1. Collect And Read Requirement Sources

Identify all requirement materials provided by the user.

Read the available files, links, screenshots, or text. Extract:

- Business goal
- User roles or actor categories
- Core user flows
- Page list
- Functional modules
- Data entities and relationships
- Enumerations and status values
- Forms and fields
- Tables, filters, search, sorting, pagination, and bulk actions
- Interaction states
- Validation rules
- Edge cases
- Permission or visibility rules
- State transitions and side effects
- Dependencies on backend APIs or external services
- Non-functional requirements
- Ambiguous or missing requirements

When information is inferred rather than explicitly provided, mark it as an assumption.

### 2. Audit Source Coverage

Before designing the plan, produce a source coverage audit. Make clear which sources were parsed, partially parsed, or unavailable.

Check for common gaps:

- Page body text not fully read
- Images not inspected
- Flowcharts, state diagrams, screenshots, wireframes, and table images not parsed
- Tables not converted into structured data
- Attachments, archives, or embedded files not retrieved
- Prototype links requiring login or permission
- Dynamic pages where only the first screen was read
- Collapsed sections, tabs, modals, hover states, or hidden panels not opened

If a source contains images that likely encode requirements, such as flowcharts, tables, wireframes, state diagrams, or screenshots, inspect them visually or via OCR when possible. Analyze nodes, arrows, states, labels, table cells, and UI regions when visible. If not possible, list each unparsed image as missing requirement material and classify the risk or blocker.

### 3. Detect Current Project Context

Check whether the current working directory is a frontend project.

Inspect project indicators such as:

- `package.json`
- `pnpm-lock.yaml`, `yarn.lock`, `package-lock.json`
- `vite.config.*`, `webpack.config.*`, `vue.config.*`, `nuxt.config.*`, `next.config.*`
- `tsconfig.json`
- `src/`, `pages/`, `app/`, `components/`, `views/`, `router/`, `store/`
- Electron, UniApp, Tauri, or mini-program configuration files

If the current directory is a frontend project, identify the existing technical stack:

- Framework, such as Vue, React, Svelte, Angular, UniApp, Electron, or Next.js
- Build tool, such as Vite, Webpack, Rsbuild, or Rollup
- Language, such as TypeScript or JavaScript
- UI library, such as Element Plus, Ant Design, Naive UI, Vant, or custom components
- Styling approach, such as SCSS, Less, CSS Modules, Tailwind, UnoCSS, or styled-components
- State management, such as Pinia, Vuex, Redux, Zustand, Jotai, or MobX
- Routing solution
- Charting, table, form, request, utility, and i18n libraries
- Existing directory structure and naming conventions

Use the detected stack as the default technical boundary for all later architecture decisions.

If the current directory is not a frontend project, skip project-specific inspection and recommend the most suitable frontend architecture based on requirement type, complexity, delivery cost, maintainability, ecosystem fit, and future extensibility.

### 4. Decompose Requirements With Traceability

Analyze requirements from coarse to fine:

1. Outline: business domains, page groups, major modules, and core flows
2. Detailed outline: pages, page regions, functional blocks, actions, data dependencies, and state changes
3. Fine-grained rules: fields, validation, permissions, empty/loading/error states, interaction details, side effects, and edge cases

Prefer structured decomposition over prose-only explanation.

Use stable IDs for requirement items so later agents can reference them:

- `SRC-001`
- `PAGE-001`
- `FLOW-001`
- `REGION-001`
- `RULE-001`
- `TECH-001`
- `COMP-001`
- `FORM-001`
- `MODEL-001`
- `ENUM-001`
- `STATE-001`
- `PERM-001`
- `API-001`
- `MOCK-001`
- `CASE-001`
- `MILE-001`
- `TASK-001`
- `SPEC-001`
- `RISK-001`
- `ASM-001`

Every recommended route, API, component, state field, enum, file path, or architecture decision must include a source marker or confidence marker. Do not disguise assumptions as facts.

Use source types such as:

- `Explicit`: directly stated in the source
- `Visual`: inferred from inspected image, screenshot, flowchart, or prototype
- `Existing Project`: detected from the current codebase
- `Engineering Recommendation`: proposed by the planner
- `Assumption`: inferred and needs confirmation

Use confidence values consistently:

- `High`: directly supported by explicit source material, inspected visual evidence, or detected project context.
- `Medium`: reasonable engineering inference from partial source material, common frontend conventions, or a small gap.
- `Low`: weak inference, missing source material, or a decision that should be confirmed before implementation.
- `Assumption` 默认不高于 `Medium` unless later confirmed by source material.

#### Plan Revision Rules

When revising an existing plan, preserve published IDs.

- Do not renumber existing IDs.
- Do not reuse IDs from removed or deprecated items.
- Add new items with the next available number in that ID family.
- Keep removed items only when needed for traceability and mark them as `Deprecated`.
- Include a revision summary with Added / Changed / Deprecated IDs when the user asks to refine, update, or split an existing plan.

### 5. Produce A Fine-Grained Functional Inventory

Normalize the extraction from source reading into a fine-grained inventory. Reuse the dimensions from source extraction and add only implementation-facing detail: route/page ownership, region operations, component candidates, data/API dependencies, permission points, interaction states, responsive needs, and audit or tracking needs.

Keep each item specific enough that another AI agent or engineer can implement it without re-reading the original PRD in full.

### 6. Design The Frontend Architecture

Design the implementation plan according to the detected project stack when a frontend project exists.

If no frontend project exists, choose a reasonable architecture and justify it with requirement complexity, delivery cost, maintainability, ecosystem fit, and future extensibility.

Cover route and module boundaries, region and component composition, props/events, local and shared state, state-machine and permission strategy, model/enum/form/API organization, request typing, error/loading/empty handling, caching and pagination, mock and integration strategy, performance, file structure, reusable utilities, scalability, testing, and acceptance focus.

Avoid introducing new frameworks, libraries, or abstractions when the existing project already has suitable patterns.

### 7. Deep-Dive Non-Trivial Features

For every non-trivial feature module, include a Technical Implementation Direction. Non-trivial modules include watermarking, import/export, upload, media processing, multilingual content, approval/workflow, permission-heavy actions, large tables, share/public pages, rich forms, charts, drag-and-drop, preview, and any feature involving client/server tradeoffs.

Each technical direction must cover frontend rendering strategy, backend dependency boundary, recommended implementation option, rejected or risky alternatives, data flow, component/composable/service split, edge cases, performance/security limitations, and acceptance checks.

Use `references/feature-patterns.md` to recognize technical feature patterns and assign `TECH-XXX` IDs. Do not treat the reference as a closed keyword list; infer the implementation problem behind any technical term.

Technical Option Matrix: do not limit option tradeoffs to fixed feature directions. Whenever any technical decision has more than one plausible route, include an Option Matrix. Cover alternatives across rendering strategy, state management, component extraction, API shape, caching, validation, permissions, upload/media handling, library vs native implementation, frontend vs backend boundary, infrastructure dependency, testing strategy, and rollout strategy when relevant.

Each option matrix must state the decision area, option, how it works, pros, cons, prerequisites, implementation cost, risks, recommended when, decision for this project, and why the chosen option fits the detected stack and requirements. If only one realistic option exists, say why alternatives are not practical instead of pretending there is a balanced choice.

### 8. Plan Component Extraction Deliberately

Component planning must explain what to extract, where to extract it, and what not to abstract yet.

Use these extraction principles:

- If a block is reused in three or more places, prefer a reusable component.
- If a single page has a complex stateful flow, prefer a feature component.
- Put permission checks, state-machine action availability, and button policy into a policy utility or composable instead of page templates.
- Keep pure display blocks page-local when field shape is likely to diverge.
- Put API calls in service modules. Do not call APIs directly inside presentational components.

For every extracted component or composable, reference source requirement IDs, used API IDs, used enum IDs, owned local state, emitted events, and acceptance case IDs.

Include Do Not Extract Yet items when appropriate. Explain what should not be abstracted yet, why an item should remain page-local, feature-local, or inline, and when to revisit.

### 9. Add Required Engineering Matrices

At `system` scale — complex business systems such as supply chain, approval, order, work order, finance, publishing, inventory, or admin platforms — include every section marked `System Mandatory` in `references/output-template.md`.

If a matrix has insufficient source material at `system` scale, still include it with assumptions, confidence, risks, and missing inputs. At smaller scales, follow the Plan Scale rules instead.

### 10. Design Contract-Level API Drafts

For each non-trivial API dependency, write a contract-level draft rather than only a one-line table entry.

Each API draft should include:

- ID and name
- Method
- Path
- Query
- Request Body
- Response
- Error Codes
- Used By
- Refresh Strategy
- Source
- Confidence

Include TypeScript DTO or interface examples when useful. Use existing project typing conventions if detected.

### 11. Task Card Decomposition Mode

When the user asks to split, decompose, arrange, or convert the analyzed requirements into implementation task cards, generate executable task cards as part of this skill.

Before outputting any task card, read `references/task-card-format.md`. It is the single authority for required fields, field enums, the per-card format, field quality requirements, and acceptance criteria examples.

Direct output skips the full construction plan document, not the analysis. For fresh input, still run a compact version of source reading, source coverage audit, project context detection, and requirement decomposition before splitting tasks.

#### Task Target Resolution

Determine the task target before splitting:

1. If the user names a specific module, page, feature, route, role, or prototype section, use that specified scope as the task target.
   - Examples: "首页驾驶舱", "A1", "学员端任务中心", "审批流", "内容工厂".
2. If the user does not specify a concrete module, use the same functional scope that this skill just analyzed in the current turn or previous immediately relevant planning turn.
3. If the user asks for "全量需求", "完整原型", "整个系统", "所有页面", "全链路", or similar wording, use all parsed requirement material as the task target.
4. If multiple possible scopes remain after reading the source material and conversation context, choose the smallest scope that satisfies the user's wording and mark it as an assumption. Ask only if the ambiguity would materially change task count, ownership, or implementation strategy.

#### Default Task Granularity

Unless the user requests another granularity, use AI-agent-friendly task cards.

AI-agent-friendly means:

- One task card can be completed independently by one AI agent or one frontend engineer.
- A task should usually fit within 0.5 to 1.5 working days.
- A task should have a clear file/module ownership boundary.
- A task should include enough context that the assignee does not need to reread the full prototype.
- A task must have concrete acceptance criteria and at least one verification method.
- Avoid task cards that are only vague activities such as "优化页面", "处理交互", "完善样式", or "对接接口".
- Avoid task cards so large that they contain multiple unrelated components, API contracts, and test flows.
- Avoid task cards so small that they are merely "create file", "add variable", or "rename component", unless such mechanical tasks are useful setup work.

#### Detailed Task Card Output Is Mandatory

When the user explicitly asks for task cards, construction task cards, implementation task cards, development task cards, "施工任务卡", "开发任务卡", "落地任务卡", "拆成任务卡", "任务卡呢", or similar wording, task cards are the primary deliverable.

In that case, do not compress task cards into a single wide table. Output each task card as its own detailed section with all required fields filled, following `references/task-card-format.md`. A compact dependency table is allowed before the cards, but it is not a substitute for the detailed cards.

Use the finest practical AI-agent-friendly granularity by default:

- Split by independently implementable ownership boundary.
- Split page shell, data model, service/mock, each major region, each non-trivial interaction, integration, visual QA, and tests into separate cards when they can be worked independently.
- Prefer more small, executable cards over fewer broad cards when a broad card would require unrelated components, APIs, and tests.
- Do not split into meaningless mechanical tasks such as "create file" unless that setup task unlocks parallel implementation.

#### Task Splitting Principles

Split tasks in dependency order:

1. Foundation tasks first: route, layout, theme tokens, service boundary, type models, mock data.
2. Page shell tasks next: page container, tab/router state, loading/error skeleton.
3. Feature block tasks next: each major region, component, chart, table, form, drawer, or workflow.
4. Interaction tasks next: navigation, modal/drawer behavior, keyboard shortcuts, permissions, disabled states.
5. Integration tasks next: API switch, DTO alignment, error codes, refresh strategy.
6. Quality tasks last: responsive layout, accessibility, visual QA, regression tests, build validation.

Prefer disjoint write scopes when tasks may run in parallel. Explicitly mark tasks that can be implemented in parallel after their dependencies are done.

If the split would exceed 20 task cards, first output a task index, dependency graph or dependency table, and the P0/MVP task cards. Predeclare the remaining task ID ranges and continue in later rounds without renumbering.

#### Task Card Acceptance Criteria Rules

Acceptance criteria must be observable and testable. Follow the good and bad examples in `references/task-card-format.md`. Never accept vague criteria such as "页面效果良好" or "交互正常".

#### Task Card Output Modes

If the user only asks "怎么拆", "拆成任务卡", "给任务卡", "施工任务卡", "开发任务卡", "落地任务卡", or "任务卡呢", output the detailed task cards directly instead of the full construction plan, using the Task-Card-Only Document Structure in `references/task-card-format.md`.

If the user asks for a full construction plan, include detailed task cards in the `Implementation Task Breakdown` section. Do not replace them with a single summary table.

If the user asks for project management style output, include both:

- Milestone-level grouping
- Dependency / parallelization table
- Detailed executable task card sections
- Parallelization / dependency sequence

#### Anti-Compression Rules

Compressed task cards are not executable. Follow the anti-compression rules in `references/task-card-format.md`; if space is constrained, use the Oversized Plans delivery split instead of omitting required task-card fields.

### 12. Unit Test Case Generation Mode

When the user asks for unit test cases, component test cases, `.spec.ts` planning, a test code plan, Vitest tests, Testing Library tests, test cases for task cards, 单元测试怎么拆, 测试用例清单, or 测试任务卡, generate a Unit Test Case Plan.

Default boundary per the Execution Boundary: output test design, test file planning, test task cards, and test code plans only.

Before outputting the test plan, read `references/test-plan-template.md`. It is the single authority for recommended test stacks per framework, spec file naming conventions, per-case required fields, the Git Ignore Note, and the Unit Test Case Plan output structure.

Direct output skips the full construction plan document, not test context detection or requirement linkage. For fresh input, still inspect the project context and map test targets back to source requirements or task IDs.

#### Test Context Detection

Before producing a test plan, inspect project indicators such as `package.json`, build and TypeScript config, `src/`, existing test dependencies, scripts, setup files, and framework evidence.

If the user says the project is Vue, React, or another stack, still read `package.json` to confirm.

If a test framework already exists, reuse it and do not recommend duplicate dependencies. If none exists, recommend the matching stack defaults from `references/test-plan-template.md` — for example the Vue defaults for Vue 3 + Vite + TypeScript projects and the React defaults for React + Vite + TypeScript projects.

#### Test Plan Content Requirements

When the user asks for executable unit test cases, include:

- Test target scope
- Detected project and test stack
- Required or reused test dependencies
- Test directory and `.spec.ts` naming rules
- Git ignore handling for generated or user-requested ignored `.spec.ts` files
- Each component, composable, service, data module, policy, or page and its corresponding `.spec.ts`
- Test cases inside each `.spec.ts`
- Test boundary and content not recommended for unit tests
- Executable verification commands
- Risks and assumptions

Each test case must include the per-case required fields defined in `references/test-plan-template.md`.

#### Task Card Linkage

If construction task cards already exist in the conversation, derive the unit test plan from the actual cards and preserve their task IDs and requirement IDs. Map every spec file and major test case back to the related task IDs and requirement IDs when available.

When grouping specs, map by task type rather than task number: `foundation` and `service` tasks map to data, service, and mock specs; `page` tasks map to page integration specs; `component` tasks map to component specs; `state` tasks map to policy and state specs; `integration` tasks map to DTO mapping specs.

Never assume a fixed task numbering scheme. Always use the task IDs that actually exist in the conversation.

#### Test Quality Rules

Follow the quality rules in `references/test-plan-template.md`: explain what each `.spec` tests, keep unit tests separate from E2E/browser QA, avoid broad snapshots unless requested, and make the plan specific enough for another AI agent to create the files directly.

#### Unit Test Case Output

When the user asks mainly for unit test cases or test task cards, output the Unit Test Case Plan structure from `references/test-plan-template.md` directly instead of the full construction plan.

### 13. Identify Risks And Open Questions

List unclear requirements, missing materials, and engineering risks.

For each risk or question, include:

- ID
- Type
- Description
- Impact
- Suggested resolution
- Whether implementation can proceed before it is answered
- Source or confidence

Separate true blockers from non-blocking assumptions.

### 14. Output The Construction Plan

Read `references/output-template.md` and produce the final answer as a Markdown document following that template, sized according to Plan Scale. When unsure about expected depth, ID usage, or source/confidence marking, read `references/example-plan.md` for format calibration.

The document must be optimized for AI continuation:

- Use clear headings
- Use stable IDs
- Use tables where comparison, inventory, traceability, or acceptance criteria are needed
- Keep implementation decisions explicit
- Mark assumptions clearly
- Include source and confidence for inferred items
- Avoid vague phrases such as "handle appropriately" or "optimize as needed"
- Prefer actionable engineering instructions
- Include enough context for another agent to continue implementation without asking repeated questions

#### Oversized Plans

If the full plan would not fit in a single response — very large PRDs, many modules, `system` scale with full matrices — do not silently truncate tables or drop required fields. Instead:

1. First deliver Source Materials, Source Coverage Audit, Project Context, Requirement Overview, Risks And Open Questions, and a Delivery Split Plan.
2. Predefine cross-round ID ranges for pages, flows, technical directions, APIs, tasks, cases, risks, and assumptions before detailed module delivery starts.
3. Continue by module or page group across consecutive responses, preserving the predefined IDs.
4. End every round with a `Delivery Progress` table listing delivered sections, pending sections, deferred ID ranges, and blockers.
5. Or offer to save the plan as one or more standalone Markdown document files, which is allowed per the Execution Boundary when the user explicitly agrees.

## Quality Bar

Before finalizing, verify these grouped checks:

1. Boundary and language: no project files were created or modified unless explicitly requested; plan content language follows the user; structural IDs and enums stay in English.
2. Coverage: the source coverage audit lists what was parsed, partially parsed, and not parsed; requirement-bearing images, flowcharts, and table images were inspected or explicitly listed as unparsed risks; login-blocked links, missing archives, and dynamic-page gaps are recorded as risks or blockers.
3. Stack fit: the plan follows the detected project stack and conventions when a project exists; the recommended stack is justified when none exists; no duplicate frameworks or test stacks are introduced.
4. Depth: every non-trivial feature and every extracted technical concept has a technical implementation direction with an explicit frontend/backend boundary, or is explicitly marked out of scope; every technical decision with multiple plausible routes has an option matrix, and single-route decisions explain why alternatives are not practical.
5. Traceability: stable IDs are used throughout; every inferred route, API, component, state, enum, or file path carries source and confidence; assumptions are separated from confirmed requirements; technical directions link to APIs, components, states or enums, and acceptance cases.
6. Scale completeness: all sections required by the chosen Plan Scale are present with real content; at `system` scale the System Mandatory sections are all included; pages have regions, components, actions, and data dependencies; forms have fields and validation; state-heavy entities have state machines; permission-heavy actions have a permission matrix; component extraction states what not to abstract yet.
7. Task executability: task cards follow the required format with all fields filled; scope resolution matches the user's wording; cards are dependency-ordered with parallelization guidance; acceptance criteria are observable and testable; another AI agent could implement each card without rereading the full prototype.
8. Test quality: test plans reuse the detected test stack or recommend the matching defaults; every `.spec.ts` explains what it tests rather than appearing only in a summary table; unit tests are separated from E2E, visual regression, and manual QA; specs link back to actual task IDs and requirement IDs from the conversation.
