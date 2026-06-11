# Task Card Format

Single authority for task card output. `SKILL.md` Task Card Decomposition Mode defines when to produce task cards and how to split them; this file defines what each card must contain and look like.

## Table Of Contents

- [Field Enums](#field-enums)
- [Required Fields](#required-fields)
- [Detailed Task Card Format](#detailed-task-card-format)
- [Field Quality Requirements](#field-quality-requirements)
- [Anti-Compression Rules](#anti-compression-rules)
- [Acceptance Criteria Examples](#acceptance-criteria-examples)
- [Task-Card-Only Document Structure](#task-card-only-document-structure)

## Field Enums

- Priority: `P0`, `P1`, `P2`
- Estimated complexity: `S`, `M`, `L`
- Estimated complexity mapping: `S` up to 0.5 working day; `M` 0.5 to 1 working day; `L` 1 to 1.5 working days. If a task exceeds 1.5 working days, split it further unless the user requests coarse planning.
- Task type: `foundation`, `data`, `page`, `component`, `service`, `state`, `interaction`, `api`, `mock`, `test`, `integration`, `polish`
- Owner recommendation: `frontend-agent`, `integration-agent`, `visual-agent`, `test-agent`
- Owner roles: `frontend-agent` for page, component, interaction, state, and UI implementation; `integration-agent` for API integration, DTO alignment, mock-to-real switching, and error-code mapping; `visual-agent` for visual QA, responsive behavior, accessibility basics, and browser verification; `test-agent` for unit/component test planning or implementation tasks.

## Required Fields

Every task card must include:

- Stable task ID, such as `TASK-001`
- Task title
- Priority
- Estimated complexity
- Task type
- Scope boundary
- Source requirement IDs or page/module IDs
- Dependencies
- Write scope files
- Inputs required
- Implementation instructions
- Deliverables
- Acceptance criteria
- Verification method
- Parallelization notes
- Owner recommendation

## Detailed Task Card Format

Every detailed task card must use this format:

```markdown
### TASK-XXX｜Task Title

| Field | Content |
| --- | --- |
| Priority / Complexity / Type | P0 / M / component |
| Scope Boundary | Included scope and explicitly excluded scope. |
| Source IDs | PAGE-001, REGION-001, API-001 |
| Dependencies | TASK-001, TASK-002 |
| Write Scope Files | Files this task may create or modify. If exact files are unknown, list expected paths and mark them as assumptions. |
| Inputs Required | Concrete data, routes, DTOs, APIs, design references, assets, or decisions needed. |
| Implementation Instructions | Concrete implementation guidance, including suggested files, components, services, composables, state, and important edge cases when project context is available. |
| Deliverables | Concrete artifacts such as components, services, types, mocks, styles, routes, tests, docs, or configuration. |
| Acceptance Criteria | Observable and testable criteria, not vague quality statements. |
| Verification Method | Concrete checks such as build, typecheck, unit/component/e2e test, browser route visit, screenshot check, mock error-state test, or manual QA step. |
| Parallelization Notes | Whether it can run in parallel, what it blocks, and what write scopes must stay separate. |
| Owner Recommendation | frontend-agent / integration-agent / visual-agent / test-agent |
```

## Field Quality Requirements

- `Scope Boundary` must say what the task owns and what it must not implement.
- `Write Scope Files` must list file-level ownership. If two tasks write the same file, mark them as serial dependencies rather than parallel tasks.
- `Inputs Required` must name concrete source data, DTOs, assets, routes, APIs, or design references.
- `Implementation Instructions` must be specific enough for an AI coding agent to start without rereading the whole prototype.
- `Deliverables` must name actual artifacts, not activities.
- `Acceptance Criteria` must include at least one observable criterion. `M` and `L` tasks should usually include 3 or more, and `S` tasks should usually include 2 or more. If a task naturally has only one meaningful criterion, state why instead of inventing filler.
- `Verification Method` must include at least one automated check when the project has scripts; otherwise include concrete browser or manual verification steps.
- `Parallelization Notes` must identify blockers and whether write scopes are disjoint.

## Anti-Compression Rules

- Never output only milestone bullets or a summary task table when the user requested task cards.
- Never replace detailed task cards with a compact table for brevity.
- Never use vague task titles such as "完善页面", "处理交互", "优化样式", or "对接接口" without precise scope, implementation instructions, and acceptance criteria.
- If response length is constrained, prioritize detailed task cards over lower-priority architecture sections. Omit optional planning sections before omitting required task-card fields. When even that is not enough, switch to the Oversized Plans delivery split from `SKILL.md` Output The Construction Plan mode.

## Acceptance Criteria Examples

These examples are illustrative only. Never copy their domain content into a real plan.

Good acceptance criteria:

- "访问 `/learner/dashboard?tab=flow` 后展示本周任务时间线、通过线 80、当前分数 68。"
- "点击 `查看高分对照` 打开抽屉；抽屉显示高分话术、评分维度和关闭按钮。"
- "`npm run build` 通过，无 TypeScript 错误。"

Bad acceptance criteria:

- "页面效果良好。"
- "交互正常。"
- "代码结构合理。"

## Task-Card-Only Document Structure

When task cards are the primary deliverable and no full construction plan was requested, use this shortened structure:

```markdown
# Implementation Task Cards

## 1. Task Target
- Target scope:
- Scope resolution rule:
- Default granularity:
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
| Case ID | Scenario | Preconditions | Steps | Expected Result | Priority |
| --- | --- | --- | --- | --- | --- |

## 6. Risks And Open Questions
| ID | Type | Description | Impact | Suggested Resolution | Blocking | Source | Confidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
```
