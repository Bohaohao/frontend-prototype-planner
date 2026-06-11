# Example Plan Excerpt (Format Calibration Only)

This file calibrates expected depth, stable ID usage, and source/confidence marking. The domain (a notification center page), every ID, number, route, and decision below are illustrative. Never reuse this domain content, these IDs, or these numbers in a real plan.

The example assumes: `page` scale, an existing Vue 3 + Vite + TypeScript admin project, requirement source is one PRD section plus one flowchart image.

## Example: Source Coverage Audit

| Source Item | Parsed | Evidence | Missing / Not Parsed | Impact |
| --- | --- | --- | --- | --- |
| SRC-001 PRD §3 通知中心 | Parsed | 正文、字段表已读取并结构化 | — | — |
| SRC-002 已读流程图（图片） | Partially parsed | 已视觉解析节点与箭头 | 图中两处缩写无法辨认 | 已读规则置信度降为 Medium，见 RISK-001 |

## Example: Fine-Grained Rules

| ID | Object | Rule | Source | Confidence | Notes |
| --- | --- | --- | --- | --- | --- |
| RULE-001 | 通知列表 | 默认按创建时间倒序，每页 20 条，支持按类型筛选 | Explicit | High | PRD §3.2 |
| RULE-002 | 未读标记 | 打开详情抽屉即置为已读，无延时 | Visual | Medium | 来自流程图 SRC-002；PRD 未写触发时机，需确认 |

## Example: Feature Technical Implementation Direction (compact)

### TECH-001 通知全部已读

- Recommended approach: 调用批量已读 API（API-002），成功后本地将列表内 `unread` 置 false 并刷新角标，不重新拉取整页。
- Data flow: 用户点击 → `markAllRead()` (service) → 成功后 store 内更新 `unreadCount = 0` → 列表项本地置灰。
- Component / composable / service split: 按钮留在页头组件；请求与计数逻辑放 `useNotifications()`；API 调用放 `notificationService`。
- Backend dependency: 需要幂等的批量已读接口；前端不逐条循环调用。
- Technical option matrix:
  | Decision Area | Option | How It Works | Pros | Cons | Prerequisites | Cost | Risks | Recommended When | Decision For This Project | Decision Rationale |
  | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
  | 已读刷新 | 本地更新 | 成功后改 store | 无闪烁、省请求 | 与服务端可能短暂不一致 | API 成功语义明确 | S | 失败回滚遗漏会造成假已读 | 本页数据可局部更新且偏差窗口小 | 选用 | 列表数据本页自有，偏差窗口小 |
  | 已读刷新 | 重新拉取 | 成功后 refetch | 强一致 | 闪烁、多一次请求 | 列表接口稳定可重拉 | S | 高频操作时请求增加 | 服务端计算结果复杂或本地无法可靠合并 | 不选用 | 体验差，收益小 |
- Edge cases: 请求失败回滚角标；列表为空时按钮禁用。
- Linked APIs: API-002；Linked components: COMP-002；Acceptance checks: CASE-003。
- Source: Explicit（功能本身）+ Engineering Recommendation（刷新策略）
- Confidence: High

## Example: Task Card

### TASK-003｜通知列表区域组件

| Field | Content |
| --- | --- |
| Priority / Complexity / Type | P0 / M / component |
| Scope Boundary | 实现 `NotificationList` 组件：列表渲染、类型筛选、分页、空/加载/错误态。不含详情抽屉（TASK-004）、不含全部已读按钮（TASK-005）。 |
| Source IDs | PAGE-001, REGION-002, RULE-001, API-001 |
| Dependencies | TASK-001（类型与 mock）, TASK-002（页面壳） |
| Inputs Required | `NotificationDto` 类型（TASK-001 产出）、API-001 mock 数据、Element Plus 表格与分页组件 |
| Implementation Instructions | 新建 `src/views/notification/components/NotificationList.vue`；数据来自 `useNotifications()`；筛选项用 ENUM-001；分页参数走路由 query 以支持刷新保留；未读行加粗样式。 |
| Deliverables | `NotificationList.vue`、`useNotifications.ts` 中列表相关逻辑、对应样式 |
| Acceptance Criteria | 1) 访问 `/notifications` 默认展示 20 条倒序数据；2) 切换类型筛选后列表与 URL query 同步更新；3) mock 返回错误时显示错误态和重试按钮。 |
| Verification Method | `npm run build` 无 TS 错误；浏览器访问 `/notifications` 核对三条验收标准；mock 切换错误响应验证错误态。 |
| Parallelization Notes | 可与 TASK-004、TASK-005 并行；写入范围限于 `components/NotificationList.vue` 与 `useNotifications.ts` 列表段。 |
| Owner Recommendation | frontend-agent |

## Example: Test Spec Entry

### SPEC-002 - NotificationList.spec.ts

| Field | Content |
| --- | --- |
| Tested Object | `NotificationList.vue` |
| Test Type | component |
| Related Requirements | RULE-001, RULE-002 |
| Related Tasks | TASK-003 |
| Mock Data | 22 条通知（含 3 条未读、2 种类型），错误响应一份 |
| Test Cases | CASE-U-001 渲染 20 条且倒序（P0）；CASE-U-002 类型筛选后仅显示该类型（P0）；CASE-U-003 请求失败显示错误态并可重试（P1） |
| Assertions | 行数、首行时间、筛选后行内容、错误文案与重试按钮存在 |
| Edge Cases | 空列表显示空态；恰好 20 条时无第二页 |
| Verification Command | `npm run test:unit` |

## Marking Style Reminders

- Inferred items always carry `Source` + `Confidence`; never present an `Assumption` as `Explicit`.
- Cross-reference IDs instead of repeating content: a task card cites `RULE-001`, not the rule text.
- Numbers in acceptance criteria are concrete and checkable, never "正常" or "良好".
