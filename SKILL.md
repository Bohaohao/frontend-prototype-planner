---
name: frontend-prototype-planner
description: Analyze frontend requirements, prototypes, PRDs, screenshots, flowcharts, links, files, or feature descriptions, then produce implementation-ready, verifiable Markdown frontend construction plans. Use for page/component/form/state/API/permission/data-model decomposition, technical implementation directions, option matrices, component extraction plans, mock and integration strategy, milestones, executable task cards, unit test case planning, .spec.ts planning, Vitest test plans, Testing Library plans, and test task cards.
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

- Planning, architecture, requirement analysis, requirement decomposition, implementation strategy, construction方案, 构建方案
- 生成实施文档, 落地方案, 开发计划, 技术方案, 前端建设方案
- 生成单元测试用例, 生成组件测试用例, 生成 `.spec.ts` 文件规划, 生成可落地的测试代码计划, 为任务卡补充测试用例, 单元测试怎么拆, 测试用例清单, 测试任务卡
- Review, refine, improve, or split a plan without asking to change code

Treat these as explicit implementation requests:

- 开始实现, 落地代码, 按方案开发, 生成页面, 修改工程, 写代码
- 实现测试代码, 生成测试文件, 写入工程, 修改 `package.json`
- Implement this, build it, code it, apply changes, generate files, start development

If the wording is ambiguous, choose document output. Ask a concise clarification only when the next step would require modifying files and the user's intent is genuinely unclear.

When producing unit test plans, default to test design, test file planning, test task cards, or test code plans only. Do not edit project files, write `.spec.ts` files, update `.gitignore`, install dependencies, or modify `package.json` unless the user explicitly requests implementation. If running in Plan Mode, only plan and never modify files.

## Inputs

Accept any of the following requirement sources:

- Prototype URL or design draft URL
- Local prototype file, image, PDF, DOCX, Markdown, HTML, spreadsheet, archive, or other readable file
- PRD URL or local PRD file
- Screenshot, wireframe, UI draft, flowchart, state diagram, table image, or interaction description
- Plain-text requirement description
- Mixed sources, such as PRD plus screenshots plus user notes

If a source cannot be accessed, state what is unavailable, list the missing information, explain impact, and continue with the available material. Do not block unless the missing content prevents meaningful analysis.

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
- `TASK-001`
- `RISK-001`
- `ASM-001`

Every recommended route, API, component, state field, enum, file path, or architecture decision must include a source marker or confidence marker. Do not disguise assumptions as facts.

Use source types such as:

- `Explicit`: directly stated in the source
- `Visual`: inferred from inspected image, screenshot, flowchart, or prototype
- `Existing Project`: detected from the current codebase
- `Engineering Recommendation`: proposed by the planner
- `Assumption`: inferred and needs confirmation

### 5. Produce A Fine-Grained Functional Inventory

Create a normalized feature inventory covering:

- Pages and routes
- Page responsibilities
- Page regions and operations
- Components
- Forms
- Tables and lists
- Filters and search
- Modals, drawers, popovers, previews, and secondary panels
- Charts or visualization modules
- Upload, download, import, export, and batch behavior
- User actions
- Entity states and transitions
- Data models and enumerations
- API dependencies and DTO shapes
- Permission points
- Validation rules
- Error, empty, loading, disabled, and success states
- Responsive or platform-specific behavior
- Audit, logging, tracking, and operation history needs

Keep each item specific enough that another AI agent or engineer can implement it without re-reading the original PRD in full.

### 6. Design The Frontend Architecture

Design the implementation plan according to the detected project stack when a frontend project exists.

If no frontend project exists, choose a reasonable architecture and justify it with requirement complexity, delivery cost, maintainability, ecosystem fit, and future extensibility.

The architecture design must cover:

- Route structure
- Page-level module boundaries
- Page region composition
- Component hierarchy
- Component props and emitted events
- Parent-child communication
- Cross-page or global state management
- State machine strategy for status-heavy domains
- Permission and action availability strategy
- Data model and enum organization
- Form model structure
- Form validation strategy
- API module organization
- Request and response typing
- Error handling strategy
- Loading and empty-state handling
- Data caching or refresh strategy
- Table/list pagination strategy
- Mock and integration strategy
- Performance optimization
- Avoiding unnecessary rendering or repeated requests
- Code splitting or lazy loading where useful
- Suggested file structure and file responsibilities
- Reusable utilities, hooks, composables, or services
- Scalability and later iteration cost
- Testing and acceptance focus

Avoid introducing new frameworks, libraries, or abstractions when the existing project already has suitable patterns.

### 7. Deep-Dive Non-Trivial Features

For every non-trivial feature module, include a Technical Implementation Direction. Non-trivial modules include watermarking, import/export, upload, media processing, multilingual content, approval/workflow, permission-heavy actions, large tables, share/public pages, rich forms, charts, drag-and-drop, preview, and any feature involving client/server tradeoffs.

Each technical direction must cover frontend rendering strategy, backend dependency boundary, recommended implementation option, rejected or risky alternatives, data flow, component/composable/service split, edge cases, performance/security limitations, and acceptance checks.

Feature Pattern Trigger: do not treat the following as a closed keyword list. While reading requirements, actively extract any technical noun, engineering mechanism, platform capability, integration point, or client/server tradeoff. Each extracted technical concept that affects implementation must receive a practical technical deep-dive with a feasible direction for the current project.

Trigger a deep-dive for terms and mechanisms such as:

- Media and asset processing: watermark, image processing, video, audio, file preview, thumbnail, compression, transcoding, OCR, PDF, canvas, print, download protection
- Data exchange: import, export, Excel, CSV, upload, download, batch operation, validation preview, error file, async task
- Content and language: multilingual content, i18n, translation, proofreading, locale fallback, rich text, template rendering
- Workflow and state: approval, workflow, state machine, task queue, audit log, rollback, recall, publish, shelf on/off
- Security and access: permission, role, capability code, row-level action, public share, token, expiry, unauthenticated route, watermark/security boundary
- Data-heavy UI: large table, virtual scroll, pagination, tree table, drag-and-drop, chart, dashboard, realtime refresh, WebSocket/SSE
- Platform integration: CDN/OSS, payment, map, notification, email/SMS, third-party auth, SSO, browser API, native bridge, mini-program, Electron

For any other technical term not listed here, infer the underlying implementation problem and produce an explicit, realistic implementation direction. Avoid generic advice. State what runs in the frontend, what must be handled by backend or infrastructure, what can be mocked, what is risky, and what should be verified.

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

For complex business systems, especially supply chain, approval, order, work order, finance, publishing, inventory, or admin systems, include these matrices even when the source is incomplete:

- Source Coverage Audit
- Implementation Readiness
- State Machine Design
- Permission Matrix
- Data Model Design
- Enum Design
- Page Detail
- Feature Technical Implementation Direction
- Option Matrix
- Component Extraction Plan
- Do Not Extract Yet
- API Contract Drafts
- Mock And Integration Strategy
- Acceptance Test Matrix
- Milestone Plan
- Suggested File Structure
- Non-Functional Requirements

If a section has insufficient source material, still include it with assumptions, confidence, risks, and missing inputs.

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

#### Task Card Required Fields

Every task card must include:

- Stable task ID, such as `TASK-001`
- Task title
- Priority: `P0`, `P1`, `P2`
- Estimated complexity: `S`, `M`, `L`
- Task type: `foundation`, `page`, `component`, `service`, `state`, `interaction`, `api`, `mock`, `test`, `integration`, `polish`
- Scope boundary
- Source requirement IDs or page/module IDs
- Dependencies
- Inputs required
- Implementation instructions
- Deliverables
- Acceptance criteria
- Verification method
- Parallelization notes
- Owner recommendation, such as `frontend-agent`, `integration-agent`, `visual-agent`, or `test-agent`

#### Detailed Task Card Output Is Mandatory

When the user explicitly asks for task cards, construction task cards, implementation task cards, development task cards, "施工任务卡", "开发任务卡", "落地任务卡", "拆成任务卡", "任务卡呢", or similar wording, task cards are the primary deliverable.

In that case, do not compress task cards into a single wide table. Output each task card as its own detailed section with all required fields filled. A compact dependency table is allowed before the cards, but it is not a substitute for the detailed cards.

Use the finest practical AI-agent-friendly granularity by default:

- Split by independently implementable ownership boundary.
- Split page shell, data model, service/mock, each major region, each non-trivial interaction, integration, visual QA, and tests into separate cards when they can be worked independently.
- Prefer more small, executable cards over fewer broad cards when a broad card would require unrelated components, APIs, and tests.
- Do not split into meaningless mechanical tasks such as "create file" unless that setup task unlocks parallel implementation.

Every detailed task card must use this format:

```markdown
### TASK-XXX｜Task Title

| Field | Content |
| --- | --- |
| Priority / Complexity / Type | P0 / M / component |
| Scope Boundary | Included scope and explicitly excluded scope. |
| Source IDs | PAGE-001, REGION-001, API-001 |
| Dependencies | TASK-001, TASK-002 |
| Inputs Required | Concrete data, routes, DTOs, APIs, design references, assets, or decisions needed. |
| Implementation Instructions | Concrete implementation guidance, including suggested files, components, services, composables, state, and important edge cases when project context is available. |
| Deliverables | Concrete artifacts such as components, services, types, mocks, styles, routes, tests, docs, or configuration. |
| Acceptance Criteria | Observable and testable criteria, not vague quality statements. |
| Verification Method | Concrete checks such as build, typecheck, unit/component/e2e test, browser route visit, screenshot check, mock error-state test, or manual QA step. |
| Parallelization Notes | Whether it can run in parallel, what it blocks, and what write scopes must stay separate. |
| Owner Recommendation | frontend-agent / integration-agent / visual-agent / test-agent |
```

Field quality requirements:

- `Scope Boundary` must say what the task owns and what it must not implement.
- `Inputs Required` must name concrete source data, DTOs, assets, routes, APIs, or design references.
- `Implementation Instructions` must be specific enough for an AI coding agent to start without rereading the whole prototype.
- `Deliverables` must name actual artifacts, not activities.
- `Acceptance Criteria` must include at least 3 checkable criteria for `M` or `L` tasks and at least 2 for `S` tasks.
- `Verification Method` must include at least one automated check when the project has scripts; otherwise include concrete browser or manual verification steps.
- `Parallelization Notes` must identify blockers and whether write scopes are disjoint.

Anti-compression rules:

- Never output only milestone bullets or a summary task table when the user requested task cards.
- Never replace detailed task cards with a compact table for brevity.
- Never use vague task titles such as "完善页面", "处理交互", "优化样式", or "对接接口" without precise scope, implementation instructions, and acceptance criteria.
- If response length is constrained, prioritize detailed task cards over lower-priority architecture sections. Omit optional planning sections before omitting required task-card fields.

#### Task Splitting Principles

Split tasks in dependency order:

1. Foundation tasks first: route, layout, theme tokens, service boundary, type models, mock data.
2. Page shell tasks next: page container, tab/router state, loading/error skeleton.
3. Feature block tasks next: each major region, component, chart, table, form, drawer, or workflow.
4. Interaction tasks next: navigation, modal/drawer behavior, keyboard shortcuts, permissions, disabled states.
5. Integration tasks next: API switch, DTO alignment, error codes, refresh strategy.
6. Quality tasks last: responsive layout, accessibility, visual QA, regression tests, build validation.

Prefer disjoint write scopes when tasks may run in parallel. Explicitly mark tasks that can be implemented in parallel after their dependencies are done.

#### Task Card Acceptance Criteria Rules

Acceptance criteria must be observable and testable.

Good acceptance criteria:

- "访问 `/learner/dashboard?tab=flow` 后展示本周任务时间线、通过线 80、当前分数 68。"
- "点击 `查看高分对照` 打开抽屉；抽屉显示高分话术、评分维度和关闭按钮。"
- "`npm run build` 通过，无 TypeScript 错误。"

Bad acceptance criteria:

- "页面效果良好。"
- "交互正常。"
- "代码结构合理。"

#### Task Card Output Modes

If the user only asks "怎么拆", "拆成任务卡", "给任务卡", "施工任务卡", "开发任务卡", "落地任务卡", or "任务卡呢", output the detailed task cards directly instead of the full construction plan.

For direct task-card output, use this shortened document structure:

```markdown
# Implementation Task Cards

## 1. Task Target
- Target scope:
- Scope resolution rule:
- Source requirement IDs:
- Assumptions:

## 2. Dependency And Parallelization
| Stage | Goal | Tasks | Can Run In Parallel | Blocking Dependencies |
| --- | --- | --- | --- | --- |

## 3. Detailed Executable Task Cards
[Use one detailed section per task card. Do not use a single wide task table.]

## 4. Minimal Deliverable Slice
State the smallest useful implementation path using task IDs.

## 5. Acceptance Test Matrix
| Case ID | Scenario | Steps | Expected Result | Priority |
| --- | --- | --- | --- | --- |

## 6. Risks And Open Questions
| ID | Type | Description | Impact | Blocking |
| --- | --- | --- | --- | --- |
```

If the user asks for a full construction plan, include detailed task cards in the `Implementation Task Breakdown` section. Do not replace them with a single summary table.

If the user asks for project management style output, include both:

- Milestone-level grouping
- Dependency / parallelization table
- Detailed executable task card sections
- Parallelization / dependency sequence

Do not modify project files while producing task cards unless the user explicitly asks to write the task cards into a file.

### 12. Unit Test Case Generation Mode

When the user asks for unit test cases, component test cases, `.spec.ts` planning, a test code plan, Vitest tests, Testing Library tests, test cases for task cards, 单元测试怎么拆, 测试用例清单, or 测试任务卡, generate a Unit Test Case Plan.

Default boundary: output test design, test file planning, test task cards, and test code plans only. Do not create `.spec.ts` files, edit `.gitignore`, install dependencies, update scripts, or change project files unless the user explicitly asks for implementation.

#### Test Context Detection

Before producing a test plan, inspect the current project context:

- `package.json`
- `vite.config.*`
- `tsconfig.*`
- `src/`
- Existing test dependencies
- Existing `vitest`, `jest`, `playwright`, or `cypress`
- Existing test scripts
- Existing `test/setup` files
- Framework: Vue, React, Svelte, Angular, Next.js, Nuxt, or other

If the user says the project is Vue, React, or another stack, still read `package.json` to confirm. If the project is Vue 3 + Vite + TypeScript and no unit test stack exists, recommend `Vitest`, `@vue/test-utils`, and `happy-dom`.

#### Vue Unit Test Defaults

For Vue 3 + Vite + TypeScript projects without an existing unit test environment, the plan must recommend:

- Dependency install: `npm install -D vitest @vue/test-utils happy-dom`
- Scripts: `"test:unit": "vitest run"` and `"test:unit:watch": "vitest"`
- Vite config: `test.environment = "happy-dom"`

If Vitest, Jest, or another test stack already exists, follow the existing framework and do not recommend duplicate dependencies.

For Vue 3, prefer colocated specs:

| Source | Spec |
| --- | --- |
| `ComponentName.vue` | `ComponentName.spec.ts` |
| `useXxx.ts` | `useXxx.spec.ts` |
| `services.ts` | `services.spec.ts` |
| `mock.ts` / data module | `mock.spec.ts` |
| `PageName.vue` | `PageName.spec.ts` |

When planning generated `.spec.ts` files, include a Git Ignore Note. If the user's workflow treats generated specs as temporary artifacts, recommend adding the relevant `.spec.ts` pattern to git ignore. If the user explicitly says `.spec.ts` files should be git-ignored, include that recommendation in the plan. Do not edit `.gitignore` unless explicitly requested.

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

Each test case must include:

- Case ID
- Tested object
- Test type: `data`, `service`, `composable`, `component`, `page integration`, or `policy`
- Mock data
- Steps
- Assertions
- Priority: `P0`, `P1`, `P2`
- Whether it depends on test environment configuration

#### Task Card Linkage

If construction task cards already exist in the conversation, derive the unit test plan from them and preserve task Source IDs or Requirement IDs:

- `TASK-001`: types, data, mock, or service
- `TASK-002`: route or tab synchronization
- `TASK-003`: page shell loading/error/empty
- `TASK-004`: API service and data refresh
- `TASK-005` to `TASK-009`: business components
- `TASK-010`: state, permission, or action policy
- `TASK-011`: integration DTO mapping
- `TASK-012`: responsive and visual acceptance

Map every spec file and major case back to related task IDs and requirement IDs when available.

#### Test Quality Rules

- Do not output only a wide summary table. Explain what each `.spec.ts` should test.
- Do not mix E2E, visual regression, or responsive screenshot testing into unit tests. Mark those separately as Playwright, browser QA, or manual QA follow-ups.
- Do not recommend broad snapshot testing unless the user explicitly asks.
- For Vue components, prioritize visible text, props rendering, emitted events, loading/error/empty states, and permission disabled states.
- For composables, prioritize state changes, request success/failure, retry behavior, and strategy function return values.
- For services, prioritize DTO mapping, error-code mapping, and mock/real API boundary.
- If corresponding components do not exist yet, use recommended component names but mark them as `Engineering Recommendation` or `Assumption`.
- If existing component names are detected, use the existing names.
- Make the test plan specific enough that another AI agent can create `.spec.ts` files directly from it.

#### Unit Test Case Output

When the user asks mainly for unit test cases or test task cards, output this structure directly:

```markdown
# Unit Test Case Plan

## 1. Test Target
- Target module:
- Source requirement IDs:
- Related task cards:
- In scope:
- Out of scope:

## 2. Detected Test Context
| Item | Result | Evidence | Impact |
| --- | --- | --- | --- |

## 3. Required Test Dependencies
| Dependency | Required | Reason | Install Command |
| --- | --- | --- | --- |

## 4. Suggested Test File Map
| Source Module / Component | Spec File | Test Type | Related Task IDs | Priority |
| --- | --- | --- | --- | --- |

## 5. Detailed Test Cases
### SPEC-001 - filename.spec.ts
| Field | Content |
| --- | --- |
| Tested Object | |
| Test Type | |
| Related Requirements | |
| Related Tasks | |
| Mock Data | |
| Test Cases | Case IDs, steps, assertions, priority, and environment dependency. |
| Assertions | |
| Edge Cases | |
| Verification Command | |

## 6. Test Data And Mock Strategy
| Mock Object | Used By | Required Fields | Notes |
| --- | --- | --- | --- |

## 7. Execution Commands
- npm run test:unit
- npm run build

## 8. Git Ignore Note
- If generated `.spec.ts` files should stay out of version control, recommend the exact `.gitignore` pattern. Do not edit files unless explicitly requested.

## 9. Risks And Assumptions
| ID | Type | Description | Impact | Blocking |
| --- | --- | --- | --- | --- |
```

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

Produce the final answer as a Markdown document. Do not modify project files during this planning workflow unless the user explicitly requests implementation or file changes.

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

## Output Template

Use this structure unless the user requests a different format:

````markdown
# Frontend Construction Plan

## 1. Source Materials
| ID | Type | Source | Status | Notes |
| --- | --- | --- | --- | --- |

## 2. Source Coverage Audit
| Source Item | Parsed | Evidence | Missing / Not Parsed | Impact |
| --- | --- | --- | --- | --- |

## 3. Project Context
### 3.1 Directory Assessment
- Current directory:
- Is frontend project:
- Evidence:

### 3.2 Detected Stack
| Category | Detected Value | Evidence | Impact |
| --- | --- | --- | --- |

### 3.3 Technical Boundary
Describe which existing project conventions must be followed.
If no frontend project exists, describe the recommended stack and explain why.

## 4. Implementation Readiness
| Area | Readiness | Reason | Needed Before Development |
| --- | --- | --- | --- |

## 5. Requirement Overview
### 5.1 Business Goal

### 5.2 User Roles Or Actors

### 5.3 Core Flows
| ID | Flow | Entry | Main Steps | Result | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- |

## 6. Requirement Decomposition
### 6.1 Outline

### 6.2 Detailed Outline

### 6.3 Fine-Grained Rules
| ID | Object | Rule | Source | Confidence | Notes |
| --- | --- | --- | --- | --- | --- |

## 7. Page And Route Design
| ID | Page | Suggested Route | Responsibility | Entry | Dependencies | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |

## 8. Page Detail
### PAGE-001 Page Name
| Region | Component | Content | Actions | Data Source | State |
| --- | --- | --- | --- | --- | --- |

## 9. Feature Technical Implementation Direction
| ID | Feature | Technical Direction | Frontend Boundary | Backend Boundary | Alternatives | Risks | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

### TECH-001 Feature Name
- Recommended approach:
- Data flow:
- Rendering / interaction strategy:
- Component / composable / service split:
- Backend dependency:
- Technical option matrix:
  | Decision Area | Option | How It Works | Pros | Cons | Prerequisites | Cost | Risks | Recommended When | Decision For This Project | Decision Rationale |
  | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
- Rejected or risky alternatives:
- Edge cases:
- Performance notes:
- Security limitations:
- Linked APIs:
- Linked components:
- Linked states / enums:
- Acceptance checks:
- Source:
- Confidence:

## 10. Component Extraction Plan
| ID | Candidate | Extract As | Reuse Sites | Responsibility | Props / Inputs | Events / Outputs | State Ownership | API Dependencies | Enum Dependencies | Acceptance Cases | Extraction Reason | Do Not Over-Abstract | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

### Do Not Extract Yet
| Item | Keep Local Because | Revisit When | Source | Confidence |
| --- | --- | --- | --- | --- |

## 11. Form Design
| ID | Form | Field | Type | Required | Validation | Default | Source | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

## 12. Data Model Design
| Entity | Field | Type | Required | Enum / Format | Description | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |

## 13. Enum Design
| Enum | Value | Label | Meaning | Used By | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- |

## 14. State Machine Design
| ID | Entity | Current State | Page / Location | Available Action | Permission | Next State | Side Effects | Source | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

## 15. Permission Matrix
| Permission ID | Action | Page | Entity State | Visible | Enabled | Backend Required | Source | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

Permission design principles:
- Do not hard-code role names unless the source explicitly requires them.
- Prefer frontend consumption of backend permission codes.
- Button visibility and enabled state should be determined by permission, entity state, data ownership, and feature flags when applicable.
- Backend permission validation remains mandatory. Frontend checks are experience controls, not security guarantees.

## 16. Data And API Design
| ID | Module | API / Data Source | Request Params | Response Data | Used By | Refresh Strategy | Source | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

### API-001 API Name
- Method:
- Path:
- Query:
- Request Body:
- Response:
- Error Codes:
- Used By:
- Refresh Strategy:
- Source:
- Confidence:

```ts
interface ExampleDto {
  id: string
}
```

## 17. State And Communication Design
Describe local state, shared state, global state, route state, cache state, state machine ownership, permission state, and component communication.

## 18. Interaction States
| ID | Scenario | Loading | Empty | Error | Disabled | Success | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

## 19. Mock And Integration Strategy
| Module | Mock Needed | Mock Shape | Switch To Real API | Notes |
| --- | --- | --- | --- | --- |

## 20. Non-Functional Requirements
| Area | Requirement | Frontend Strategy | Risk | Source | Confidence |
| --- | --- | --- | --- | --- | --- |
Cover browser compatibility, upload size, large table performance, security limitations, watermark limitations, accessibility basics, i18n extensibility, error tracking, operation logs, approval audit, and observability when relevant.

## 21. Performance And Maintainability
List specific decisions for rendering performance, request control, component splitting, lazy loading, memoization, caching, large list handling, and future extension.

## 22. Suggested File Structure
```text
src/
  views/
  components/
  services/
  stores/
  types/
  constants/
```
| Path | Responsibility | Notes |
| --- | --- | --- |

## 23. Milestone Plan
| Phase | Goal | Tasks | Deliverable | Can Demo |
| --- | --- | --- | --- | --- |

## 24. Implementation Task Breakdown

### 24.1 Task Target

- Target scope:
- Scope resolution rule:
- Default granularity:
- Source requirement IDs:
- Assumptions:

### 24.2 Dependency And Parallelization

| Stage | Goal | Tasks | Can Run In Parallel | Blocking Dependencies |
| --- | --- | --- | --- | --- |

### 24.3 Executable Task Cards

Use detailed per-card sections by default. Do not use a single wide task table unless the user explicitly asks for a compact summary.

#### TASK-001｜Task Title

| Field | Content |
| --- | --- |
| Priority / Complexity / Type | P0 / M / foundation |
| Scope Boundary | |
| Source IDs | |
| Dependencies | |
| Inputs Required | |
| Implementation Instructions | |
| Deliverables | |
| Acceptance Criteria | |
| Verification Method | |
| Parallelization Notes | |
| Owner Recommendation | |

#### TASK-002｜Task Title

| Field | Content |
| --- | --- |
| Priority / Complexity / Type | |
| Scope Boundary | |
| Source IDs | |
| Dependencies | |
| Inputs Required | |
| Implementation Instructions | |
| Deliverables | |
| Acceptance Criteria | |
| Verification Method | |
| Parallelization Notes | |
| Owner Recommendation | |

## 25. Unit Test Case Plan

### 25.1 Test Target
- Target module:
- Source requirement IDs:
- Related task cards:
- In scope:
- Out of scope:

### 25.2 Detected Test Context
| Item | Result | Evidence | Impact |
| --- | --- | --- | --- |

### 25.3 Required Test Dependencies
| Dependency | Required | Reason | Install Command |
| --- | --- | --- | --- |

### 25.4 Suggested Test File Map
| Source Module / Component | Spec File | Test Type | Related Task IDs | Priority |
| --- | --- | --- | --- | --- |

### 25.5 Detailed Test Cases
#### SPEC-001 - filename.spec.ts
| Field | Content |
| --- | --- |
| Tested Object | |
| Test Type | |
| Related Requirements | |
| Related Tasks | |
| Mock Data | |
| Test Cases | Case IDs, steps, assertions, priority, and environment dependency. |
| Assertions | |
| Edge Cases | |
| Verification Command | |

### 25.6 Test Data And Mock Strategy
| Mock Object | Used By | Required Fields | Notes |
| --- | --- | --- | --- |

### 25.7 Execution Commands
- npm run test:unit
- npm run build

### 25.8 Git Ignore Note
- If generated `.spec.ts` files should stay out of version control, recommend the exact `.gitignore` pattern. Do not edit files unless explicitly requested.

## 26. Acceptance Test Matrix
| Case ID | Scenario | Preconditions | Steps | Expected Result | Priority |
| --- | --- | --- | --- | --- | --- |

## 27. Risks And Open Questions
| ID | Type | Description | Impact | Suggested Resolution | Blocking | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |

## 28. Assumptions
| ID | Assumption | Reason | Source | Confidence | Needs Confirmation |
| --- | --- | --- | --- | --- | --- |
````

## Quality Bar

Before finalizing, verify that:

- No project files were modified unless the user explicitly requested implementation or file changes.
- The source coverage audit identifies what was parsed, partially parsed, and not parsed.
- Requirement-bearing images, flowcharts, screenshots, and table images were inspected visually or via OCR when possible.
- Unparsed images, missing archives, login-blocked links, and dynamic-page gaps are listed as risks or blockers.
- The plan follows the existing project stack when one exists.
- The recommended stack is justified when no project exists.
- Every major page has page regions, components, actions, and data dependencies.
- Every form has fields and validation strategy.
- Every non-trivial feature has a technical implementation direction, not just a requirement summary.
- All technical nouns, engineering mechanisms, platform capabilities, integrations, and client/server tradeoffs found in the source materials are either deep-dived or explicitly marked as out of scope.
- Watermark, media, upload, import, multilingual, approval, permission, large table, share/public-page, and any other detected technical features include frontend-backend boundary decisions.
- Any technical decision with multiple plausible routes includes an option/tradeoff matrix, across rendering, state, APIs, caching, validation, permissions, media/upload, library choice, frontend-backend boundary, infrastructure, testing, and rollout when relevant.
- If only one realistic route exists for a technical decision, the plan explains why alternatives are not practical.
- Feature technical directions are linked to APIs, components, states or enums, and acceptance cases.
- State-heavy entities have a state machine matrix.
- Permission-heavy actions have a permission matrix.
- Data entities and enums are explicit.
- Non-trivial API dependencies include contract-level drafts and DTO examples when useful.
- Component extraction is planned at page component, reusable business component, composable/hook, service module, and policy/strategy utility levels when relevant.
- The plan explicitly says what should not be abstracted yet.
- Extracted components reference source requirements, API IDs, enum IDs, state ownership, emitted events, and acceptance case IDs.
- Component communication is explicit.
- Mock and integration strategy is actionable.
- Non-functional requirements are covered when relevant.
- Acceptance tests cover key flows, states, permissions, errors, and edge cases.
- Unit test plans inspect the current project test stack before recommending dependencies.
- Unit test plans specify each `.spec.ts` file and what it should test, not only a wide summary table.
- Vue 3 + Vite + TypeScript projects without an existing unit test stack recommend Vitest, `@vue/test-utils`, `happy-dom`, `test:unit` scripts, and `test.environment = "happy-dom"`.
- Existing test frameworks are reused instead of recommending duplicate test stacks.
- Unit test cases include case ID, tested object, test type, mock data, steps, assertions, priority, and environment dependency.
- Unit test plans separate unit/component tests from E2E, visual regression, responsive screenshot tests, and manual QA.
- Test file planning preserves related task IDs and requirement IDs when task cards or source IDs exist.
- Milestones and tasks include priority, dependencies, deliverables, and acceptance criteria.
- Task cards resolve the correct target scope: specified module when provided, otherwise full analyzed scope when requested or implied.
- Task cards use AI-agent-friendly granularity by default.
- Each task card has concrete dependencies, implementation instructions, deliverables, acceptance criteria, and verification.
- Task cards are ordered by dependency and include parallelization guidance.
- Task cards avoid vague work items and avoid bundling unrelated implementation areas.
- Task cards are specific enough that another AI agent can implement them without rereading the full prototype.
- Suggested file structure matches the detected project stack and conventions.
- Performance and maintainability are addressed concretely.
- Ambiguities are separated from confirmed requirements.
- Every inferred route, API, component, state, enum, or file path has source and confidence.
- The Markdown can be used directly by a human engineer or another AI agent.
