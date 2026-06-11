# Unit Test Plan Template And Stack Defaults

Single authority for unit test plan output. `SKILL.md` workflow step 12 defines when to produce the test plan and how to detect project context; this file defines the recommended stacks, naming conventions, per-case fields, and output structure.

## Framework Reuse Rule

If Vitest, Jest, or another test stack already exists in the project, follow the existing framework, scripts, and conventions. Do not recommend duplicate or parallel test stacks.

## Vue Unit Test Defaults

For Vue 3 + Vite + TypeScript projects without an existing unit test environment, recommend:

- Dependency install: `npm install -D vitest @vue/test-utils happy-dom`
- Scripts: `"test:unit": "vitest run"` and `"test:unit:watch": "vitest"`
- Vite config: `test.environment = "happy-dom"`

Prefer colocated specs:

| Source | Spec |
| --- | --- |
| `ComponentName.vue` | `ComponentName.spec.ts` |
| `useXxx.ts` | `useXxx.spec.ts` |
| `services.ts` | `services.spec.ts` |
| `mock.ts` / data module | `mock.spec.ts` |
| `PageName.vue` | `PageName.spec.ts` |

## React Unit Test Defaults

For React + Vite + TypeScript projects without an existing unit test environment, recommend:

- Dependency install: `npm install -D vitest @testing-library/react @testing-library/jest-dom @testing-library/user-event jsdom`
- Scripts: `"test:unit": "vitest run"` and `"test:unit:watch": "vitest"`
- Vite config: `test.environment = "jsdom"` (`happy-dom` is also acceptable) plus a `test.setupFiles` entry that imports `@testing-library/jest-dom`

Prefer colocated specs:

| Source | Spec |
| --- | --- |
| `ComponentName.tsx` | `ComponentName.spec.tsx` |
| `useXxx.ts` | `useXxx.spec.ts` |
| `services.ts` | `services.spec.ts` |
| `mock.ts` / data module | `mock.spec.ts` |
| `PageName.tsx` | `PageName.spec.tsx` |

For Next.js projects, reuse the existing Jest or Vitest setup when present; otherwise recommend Vitest with the same Testing Library stack and mark the choice as `Engineering Recommendation`.

## Other Stacks

For Svelte, Angular, Nuxt, UniApp, or other frameworks, follow the existing project test setup first. If none exists, recommend the framework's current ecosystem default — for example Vitest plus the framework's Testing Library binding for Svelte and Nuxt — and mark the recommendation as `Engineering Recommendation`.

## Git Ignore Note

When planning generated `.spec.ts` files, include a Git Ignore Note in the plan. If the user's workflow treats generated specs as temporary artifacts, recommend the exact `.spec.ts` ignore pattern to add. If the user explicitly says `.spec.ts` files should be git-ignored, include that recommendation in the plan. Do not edit `.gitignore` unless explicitly requested.

## Per-Case Required Fields

Each test case must include:

- Case ID: use the `CASE-` prefix and keep IDs unique across the whole plan, including the acceptance test matrix
- Tested object
- Test type: `data`, `service`, `composable`, `component`, `page integration`, or `policy`
- Mock data
- Steps
- Assertions
- Priority: `P0`, `P1`, `P2`
- Whether it depends on test environment configuration

## Unit Test Case Plan Structure

When the test plan is the primary deliverable, output this structure directly. When it is section 25 of a full construction plan, renumber the subsections as 25.x.

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
