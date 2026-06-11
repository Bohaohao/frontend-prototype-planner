# Construction Plan Output Template

Single authority for the full construction plan structure. `SKILL.md` Output The Construction Plan mode defines when to produce the plan and how to size it via Plan Scale; this file defines the section layout and table schemas.

## Table Of Contents

- [Section Applicability](#section-applicability)
- [Template](#template)

## Section Applicability

Include a section only when the chosen Plan Scale and its condition apply. `all` means every scale. `page+`, `module+` mean that scale and larger.

| # | Section | Scale | Condition | System Mandatory |
| --- | --- | --- | --- | --- |
| 1 | Source Materials | all | Always | Yes |
| 2 | Source Coverage Audit | all | Always | Yes |
| 3 | Project Context | all | Always | Yes |
| 4 | Implementation Readiness | module+ | When real blockers exist | Yes |
| 5 | Requirement Overview | all | Always; 5.3 Core Flows from `page` up | Yes |
| 6 | Requirement Decomposition | all | Always | Yes |
| 7 | Page And Route Design | page+ | — | No |
| 8 | Page Detail | page+ | — | Yes |
| 9 | Feature Technical Implementation Direction | all | When any non-trivial feature exists | Yes |
| 10 | Component Extraction Plan | page+ | At `component` scale only when extraction is the question | Yes |
| 11 | Form Design | all | When forms exist | No |
| 12 | Data Model Design | page+ | When data entities exist | Yes |
| 13 | Enum Design | page+ | When enums or status values exist | Yes |
| 14 | State Machine Design | all | When state-heavy entities exist | Yes |
| 15 | Permission Matrix | all | When permission-controlled actions exist | Yes |
| 16 | Data And API Design | all | Always | Yes |
| 17 | State And Communication Design | page+ | — | No |
| 18 | Interaction States | all | Always | No |
| 19 | Mock And Integration Strategy | page+ | — | Yes |
| 20 | Non-Functional Requirements | module+ | When the source states NFRs | Yes |
| 21 | Performance And Maintainability | module+ | When data-heavy UI exists | No |
| 22 | Suggested File Structure | page+ | — | Yes |
| 23 | Milestone Plan | module+ | — | Yes |
| 24 | Implementation Task Breakdown | module+ | Any scale when the user asks for tasks | No |
| 25 | Unit Test Case Plan | — | When the user asks for tests; optional at module+ | No |
| 26 | Acceptance Test Matrix | all | Always | Yes |
| 27 | Risks And Open Questions | all | Always | Yes |
| 28 | Assumptions | all | Always | No |

For `component` scale, the minimum useful section set is Source Materials, Source Coverage Audit, Project Context, Requirement Overview, Requirement Decomposition, Feature Technical Implementation Direction when non-trivial, Component Extraction Plan when extraction is the question, Interaction States, Acceptance Test Matrix, Risks And Open Questions, and Assumptions.

Plan Scale signals:

| Scale | Typical Signals |
| --- | --- |
| component | One component, one widget, or one small interaction with limited local state. |
| page | One page, route, or short flow with several regions and shared page state. |
| module | Multi-page feature area, multiple roles, API contracts, permissions, or milestones. |
| system | Cross-module business system with state machines, permission-heavy actions, many entities, or long delivery phases. |

Keep the section numbering from this template even when sections are omitted, and list omitted sections with reasons at the end of the plan as required by Plan Scale.

## Template

Use this structure unless the user requests a different format:

````markdown
# Frontend Construction Plan

Plan scale: component | page | module | system

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
| ID | Phase | Goal | Tasks | Deliverable | Can Demo |
| --- | --- | --- | --- | --- | --- |

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

Output one detailed section per task card using the Detailed Task Card Format from `references/task-card-format.md`, with all required fields filled. Do not use a single wide task table unless the user explicitly asks for a compact summary.

When the full split would exceed 20 task cards, first deliver a task index, dependency graph or dependency table, and the P0/MVP task cards. Continue remaining cards in later rounds while preserving predeclared task IDs.

### 24.4 Minimal Deliverable Slice

List the smallest useful implementation path using task IDs, including required foundation, page shell, primary interaction, integration or mock boundary, and verification tasks.

## 25. Unit Test Case Plan

Include this section when tests are in scope. Use the Unit Test Case Plan structure from `references/test-plan-template.md`, renumbered as 25.x subsections.

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
