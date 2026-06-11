# Frontend Prototype Planner

[中文](#中文) | [English](#english)

---

## 中文

`frontend-prototype-planner` 是一个通用 Agent Skill，同一份格式同时兼容 OpenAI Codex 与 Anthropic Claude Code，用于把前端原型、PRD、截图、流程图、页面模块、任务卡或纯文本需求，转化为可实施、可验证、可交接的前端建设方案。

它默认是**规划型 skill**：只输出 Markdown 方案、任务卡、测试用例计划或 `.spec.ts` 文件规划，不会修改你的工程文件。只有当用户明确要求“写代码 / 生成文件 / 写入工程 / 修改 package.json / 落地代码 / 实现测试代码”时，才进入代码实现。

### 核心能力

- 前端需求解析：页面、路由、组件、表单、状态、权限、数据模型、API、交互状态。
- 资料完整性审计：识别 PRD、原型、截图、流程图、附件、动态页面等是否成功解析。
- 复杂功能技术实施方案：针对水印、导入导出、多语言、审批流、权限、分享页、大表格、媒体处理等技术点给出前后端边界和实现方向。
- 全技术方向 Option Matrix：当渲染、状态、API、缓存、权限、组件抽取、库选型、基础设施、测试策略等存在多种方案时，输出取舍矩阵。
- 组件抽取规划：区分页内组件、业务组件、基础组件、composable/hook、service、policy utility，并说明哪些暂时不该抽象。
- 工程任务卡：把施工计划拆成 AI agent / 前端工程师可直接执行的任务卡。
- 单元测试用例计划：为 Vue / React 等前端工程生成可落地的 `.spec.ts` 规划、测试文件映射、测试用例清单、mock 策略和验证命令。
- 方案规模自适应：按组件 / 页面 / 模块 / 系统四档需求规模裁剪输出章节，小需求不会产出全量矩阵填充物。
- 输出语言跟随用户：方案正文跟随用户提问语言；ID、枚举值、模板字段名等结构化标识保持英文，便于跨 agent 交接。

### 目录结构

```text
frontend-prototype-planner/
├── SKILL.md                       # 核心工作流与模式规则，必须保留
├── references/
│   ├── output-template.md         # 完整建设方案模板与章节适用范围
│   ├── task-card-format.md        # 任务卡字段与格式的权威定义
│   ├── test-plan-template.md      # 测试计划模板与各栈默认配置
│   └── example-plan.md            # 格式校准示例（仅供对照）
├── agents/
│   └── openai.yaml                # Codex UI 元信息（Claude Code 自动忽略）
├── README.md                      # 中英双语使用说明
├── .gitignore                     # 仓库忽略规则
└── .gitattributes                 # 文本换行规则
```

### 安装方式（Codex）

#### 方式一：克隆到 Codex 全局 skills 目录

macOS / Linux:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
git clone <your-repo-url> "${CODEX_HOME:-$HOME/.codex}/skills/frontend-prototype-planner"
```

Windows PowerShell:

```powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
New-Item -ItemType Directory -Force -Path (Join-Path $codexHome "skills") | Out-Null
git clone <your-repo-url> (Join-Path $codexHome "skills\frontend-prototype-planner")
```

#### 方式二：下载 ZIP 后复制

把解压后的 `frontend-prototype-planner` 文件夹复制到：

```text
$CODEX_HOME/skills/frontend-prototype-planner
```

如果没有设置 `CODEX_HOME`，默认通常是：

```text
~/.codex/skills/frontend-prototype-planner
```

Windows 常见路径：

```text
C:\Users\<YourName>\.codex\skills\frontend-prototype-planner
```

安装后请**重启 Codex**，让新 skill 被重新加载。

### 安装方式（Claude Code）

个人级（所有项目可用）：

macOS / Linux:

```bash
mkdir -p ~/.claude/skills
git clone <your-repo-url> ~/.claude/skills/frontend-prototype-planner
```

Windows PowerShell:

```powershell
New-Item -ItemType Directory -Force -Path (Join-Path $HOME ".claude\skills") | Out-Null
git clone <your-repo-url> (Join-Path $HOME ".claude\skills\frontend-prototype-planner")
```

项目级（仅当前项目可用）：把整个 `frontend-prototype-planner` 文件夹复制到项目的 `.claude/skills/frontend-prototype-planner`。

安装后**新开一个会话**即生效，无需重启应用。

### 基本用法

在 Codex 中可以直接说：

```text
使用 $frontend-prototype-planner 分析这个前端原型，并输出可实施、可验证、可交接的建设方案。
```

也可以针对具体模式提问：

```text
使用 $frontend-prototype-planner，把这个 PRD 拆成前端施工任务卡。
```

```text
使用 $frontend-prototype-planner，为刚才的任务卡生成 Vue 3 + Vitest 单元测试用例计划。
```

```text
使用 $frontend-prototype-planner，为这个 React 页面生成 Testing Library 组件测试规划。
```

在 Claude Code 中：

- 自动触发：直接描述需求，例如“分析这个前端原型，输出可实施、可验证的建设方案”，Claude 会根据 skill 的 description 自动调用。
- 显式调用：输入 `/frontend-prototype-planner`，或说“使用 frontend-prototype-planner skill 把这个 PRD 拆成施工任务卡”。

`$frontend-prototype-planner` 写法仅适用于 Codex；在 Claude Code 中请使用上面两种方式。

### 默认边界

默认只生成文档，不改项目文件：

- 前端建设方案
- 技术实施方向
- 组件抽取规划
- API 草案
- Mock / 联调策略
- 施工任务卡
- 单元测试用例计划
- `.spec.ts` 文件规划

只有用户明确要求以下行为时，才允许进入代码实现：

- 写代码
- 生成页面
- 修改工程
- 生成测试文件
- 写入工程
- 修改 `package.json`
- 实现测试代码
- 落地代码

例外：用户明确要求把方案、任务卡或测试计划本身保存为独立 Markdown 文档（例如放在 `docs/` 下）属于文档交付，不算进入代码实现；此时也不会触碰源码、配置或依赖文件。

### 单元测试规划能力

当用户提出这些需求时，skill 会进入 “Unit Test Case Generation Mode”：

- 生成单元测试用例
- 生成组件测试用例
- 生成 `.spec.ts` 文件规划
- 生成可落地的测试代码计划
- 为任务卡补充测试用例
- 为 Vue 工程设计 Vitest 测试
- 为 React 工程设计 Testing Library 测试
- 单元测试怎么拆
- 测试用例清单
- 测试任务卡

生成测试计划前，skill 会要求先检测：

- `package.json`
- `vite.config.*`
- `tsconfig.*`
- `src/`
- 已有测试依赖
- 已有测试脚本
- 已有 test setup
- 是否已有 Vitest / Jest / Playwright / Cypress
- 当前工程是 Vue、React、Svelte、Angular、Next.js、Nuxt 或其他栈

如果是 Vue 3 + Vite + TypeScript 且没有单元测试环境，默认推荐：

```bash
npm install -D vitest @vue/test-utils happy-dom
```

并建议：

```json
{
  "scripts": {
    "test:unit": "vitest run",
    "test:unit:watch": "vitest"
  }
}
```

以及在 `vite.config.ts` 中配置：

```ts
test: {
  environment: "happy-dom"
}
```

如果是 React + Vite + TypeScript 且没有单元测试环境，默认推荐：

```bash
npm install -D vitest @testing-library/react @testing-library/jest-dom @testing-library/user-event jsdom
```

并在 `vite.config.ts` 中配置 `test.environment = "jsdom"`，以及引入 `@testing-library/jest-dom` 的 setup 文件。

如果工程已有测试框架，优先沿用现有测试框架，不重复推荐依赖。其他栈的默认值见 `references/test-plan-template.md`。

### 校验 Skill

如果你已经安装了 Codex 自带的 `skill-creator`，可以在仓库的父目录下运行官方校验脚本（相对路径以父目录为基准）：

Windows PowerShell:

```powershell
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
python (Join-Path $codexHome "skills\.system\skill-creator\scripts\quick_validate.py") .\frontend-prototype-planner
```

macOS / Linux 示例：

```bash
PYTHONUTF8=1 PYTHONIOENCODING=utf-8 \
python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py ./frontend-prototype-planner
```

成功时会看到：

```text
Skill is valid!
```

`quick_validate.py` 检查的 `name` / `description` 约束正是 Codex 与 Claude Code 共享格式的交集，校验通过即两个平台都可用。Claude Code 侧的实测方式：新开一个会话，确认 skill 出现在可用技能列表，并能通过 `/frontend-prototype-planner` 调用。

### 维护建议

- 保持 `SKILL.md` 的 frontmatter 只有 `name` 和 `description`，这是 Codex 与 Claude Code 的双平台安全交集；确需扩展时只能从 `license` / `allowed-tools` / `metadata` 中选（Codex 校验器白名单），Claude 专属字段（`version`、`model`、`disable-model-invocation` 等）会让 `quick_validate.py` 直接失败。
- 修改 `SKILL.md` 后运行 `quick_validate.py`。
- 修改触发场景后，同步更新 `agents/openai.yaml`。
- 模板、任务卡格式、测试栈默认值只在 `references/` 对应文件中维护一份，`SKILL.md` 只保留引用，避免多处定义漂移。
- 修改 `references/test-plan-template.md` 的测试栈默认值后，同步更新 README 中的对应示例。
- 安装或复制时必须携带完整目录（含 `references/`），SKILL.md 会按需读取这些文件。
- 如果复制到全局 skills 目录，重启 Codex 后再测试。
- 不要把临时输出、生成的测试文件、构建产物或本地缓存提交到仓库。

---

## English

`frontend-prototype-planner` is an Agent Skill — one format compatible with both OpenAI Codex and Anthropic Claude Code — that turns frontend prototypes, PRDs, screenshots, flowcharts, page modules, task cards, or plain-text requirements into implementation-ready, verifiable, and handoff-ready frontend construction plans.

By default, this is a **planning skill**. It outputs Markdown plans, task cards, test case plans, or `.spec.ts` file plans. It does not modify your project files unless you explicitly ask it to write code, generate files, update `package.json`, write tests into the project, or implement the plan.

### Core Capabilities

- Frontend requirement decomposition: pages, routes, components, forms, state, permissions, data models, APIs, and interaction states.
- Source coverage audit: check whether PRDs, prototypes, screenshots, flowcharts, attachments, and dynamic pages were parsed.
- Technical implementation directions for complex features such as watermarking, import/export, multilingual content, approval workflows, permission-heavy actions, public share pages, large tables, and media processing.
- Full technical Option Matrix: compare alternatives for rendering, state, API shape, caching, permissions, component extraction, library choices, infrastructure, and testing strategy.
- Component extraction planning: distinguish page-local components, reusable business components, base components, composables/hooks, services, and policy utilities, including what should not be abstracted yet.
- Engineering task cards: split implementation plans into executable tasks for AI agents or frontend engineers.
- Unit test planning: generate actionable `.spec.ts` plans, test file maps, test case lists, mock strategies, and verification commands for Vue, React, and other frontend stacks.
- Plan scale adaptation: size the output to component / page / module / system scale, so small requirements no longer produce full-matrix filler.
- Output language follows the user: plan content follows the request language; stable IDs, enum values, and template field names stay in English for cross-agent handoff.

### Repository Structure

```text
frontend-prototype-planner/
├── SKILL.md                       # Core workflow and mode rules, required
├── references/
│   ├── output-template.md         # Full plan template and section applicability
│   ├── task-card-format.md        # Single authority for task card fields and format
│   ├── test-plan-template.md      # Test plan template and per-stack defaults
│   └── example-plan.md            # Format calibration example (reference only)
├── agents/
│   └── openai.yaml                # Codex UI metadata (ignored by Claude Code)
├── README.md                      # Bilingual user guide
├── .gitignore                     # Repository ignore rules
└── .gitattributes                 # Text and line-ending rules
```

### Installation (Codex)

#### Option 1: Clone Into The Codex Global Skills Directory

macOS / Linux:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
git clone <your-repo-url> "${CODEX_HOME:-$HOME/.codex}/skills/frontend-prototype-planner"
```

Windows PowerShell:

```powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
New-Item -ItemType Directory -Force -Path (Join-Path $codexHome "skills") | Out-Null
git clone <your-repo-url> (Join-Path $codexHome "skills\frontend-prototype-planner")
```

#### Option 2: Download ZIP And Copy

Copy the extracted `frontend-prototype-planner` directory into:

```text
$CODEX_HOME/skills/frontend-prototype-planner
```

If `CODEX_HOME` is not set, the default location is usually:

```text
~/.codex/skills/frontend-prototype-planner
```

Common Windows path:

```text
C:\Users\<YourName>\.codex\skills\frontend-prototype-planner
```

Restart Codex after installation so the new skill can be loaded.

### Installation (Claude Code)

Personal scope (available in all projects):

macOS / Linux:

```bash
mkdir -p ~/.claude/skills
git clone <your-repo-url> ~/.claude/skills/frontend-prototype-planner
```

Windows PowerShell:

```powershell
New-Item -ItemType Directory -Force -Path (Join-Path $HOME ".claude\skills") | Out-Null
git clone <your-repo-url> (Join-Path $HOME ".claude\skills\frontend-prototype-planner")
```

Project scope (current project only): copy the whole `frontend-prototype-planner` folder into `.claude/skills/frontend-prototype-planner` inside the project.

Start a **new session** after installation; no app restart is needed.

### Basic Usage

In Codex, ask:

```text
Use $frontend-prototype-planner to analyze this frontend prototype and produce an implementation-ready, verifiable, handoff-ready construction plan.
```

Task card planning:

```text
Use $frontend-prototype-planner to split this PRD into executable frontend implementation task cards.
```

Vue unit test planning:

```text
Use $frontend-prototype-planner to generate a Vue 3 + Vitest unit test case plan for the task cards above.
```

React component test planning:

```text
Use $frontend-prototype-planner to generate a Testing Library component test plan for this React page.
```

In Claude Code:

- Automatic triggering: just describe the need, for example "Analyze this frontend prototype and produce an implementation-ready, verifiable construction plan"; Claude invokes the skill based on its description.
- Explicit invocation: type `/frontend-prototype-planner`, or say "Use the frontend-prototype-planner skill to split this PRD into implementation task cards".

The `$frontend-prototype-planner` syntax is Codex-only; use the two methods above in Claude Code.

### Default Boundary

The skill only produces planning output by default:

- Frontend construction plans
- Technical implementation directions
- Component extraction plans
- API drafts
- Mock and integration strategy
- Implementation task cards
- Unit test case plans
- `.spec.ts` file plans

It should only enter implementation mode when the user explicitly asks for:

- Write code
- Generate pages
- Modify the project
- Generate test files
- Write files into the project
- Update `package.json`
- Implement test code
- Apply the plan to code

Exception: saving the plan, task cards, or test plan itself as a standalone Markdown document (for example under `docs/`) when explicitly requested is a document deliverable, not implementation; source code, configuration, and dependency files are still never touched for that purpose.

### Unit Test Planning

The skill enters “Unit Test Case Generation Mode” when users ask for:

- Unit test cases
- Component test cases
- `.spec.ts` file planning
- Actionable test code plans
- Test cases for task cards
- Vitest plans for Vue projects
- Testing Library plans for React projects
- Test case list
- Test task cards

Before producing the test plan, it should inspect:

- `package.json`
- `vite.config.*`
- `tsconfig.*`
- `src/`
- Existing test dependencies
- Existing test scripts
- Existing test setup files
- Existing Vitest / Jest / Playwright / Cypress setup
- Whether the project is Vue, React, Svelte, Angular, Next.js, Nuxt, or another stack

For Vue 3 + Vite + TypeScript projects without a unit test setup, it recommends:

```bash
npm install -D vitest @vue/test-utils happy-dom
```

Suggested scripts:

```json
{
  "scripts": {
    "test:unit": "vitest run",
    "test:unit:watch": "vitest"
  }
}
```

Suggested `vite.config.ts` test environment:

```ts
test: {
  environment: "happy-dom"
}
```

For React + Vite + TypeScript projects without a unit test setup, it recommends:

```bash
npm install -D vitest @testing-library/react @testing-library/jest-dom @testing-library/user-event jsdom
```

with `test.environment = "jsdom"` in `vite.config.ts` and a setup file that imports `@testing-library/jest-dom`.

If the project already has a test framework, the skill should reuse it and avoid duplicate dependencies. Defaults for other stacks live in `references/test-plan-template.md`.

### Validate The Skill

If Codex's built-in `skill-creator` skill is installed, run this from the repository's parent directory (the relative path resolves against it):

Windows PowerShell:

```powershell
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
python (Join-Path $codexHome "skills\.system\skill-creator\scripts\quick_validate.py") .\frontend-prototype-planner
```

macOS / Linux:

```bash
PYTHONUTF8=1 PYTHONIOENCODING=utf-8 \
python ~/.codex/skills/.system/skill-creator/scripts/quick_validate.py ./frontend-prototype-planner
```

Expected output:

```text
Skill is valid!
```

The `name` / `description` constraints checked by `quick_validate.py` are exactly the intersection of the format shared by Codex and Claude Code, so a passing skill works on both platforms. To verify on the Claude Code side: start a new session, confirm the skill appears in the available skills list, and invoke it via `/frontend-prototype-planner`.

### Maintenance Notes

- Keep the `SKILL.md` frontmatter limited to `name` and `description` — the safe cross-platform intersection for Codex and Claude Code. If extra fields are ever needed, pick only from `license` / `allowed-tools` / `metadata` (the Codex validator allowlist); Claude-specific fields such as `version`, `model`, or `disable-model-invocation` make `quick_validate.py` fail.
- Run `quick_validate.py` after changing `SKILL.md`.
- Update `agents/openai.yaml` when trigger behavior changes.
- Maintain templates, the task card format, and test stack defaults in their single `references/` file; `SKILL.md` only points to them, so definitions cannot drift apart.
- After changing test stack defaults in `references/test-plan-template.md`, update the matching examples in this README.
- Always install or copy the full directory including `references/`; `SKILL.md` reads those files on demand.
- Restart Codex after copying the skill into the global skills directory.
- Do not commit temporary outputs, generated test files, build artifacts, or local caches.
