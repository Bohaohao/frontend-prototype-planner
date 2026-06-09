# Frontend Prototype Planner

[中文](#中文) | [English](#english)

---

## 中文

`frontend-prototype-planner` 是一个 Codex Skill，用于把前端原型、PRD、截图、流程图、页面模块、任务卡或纯文本需求，转化为可实施、可验证、可交接的前端建设方案。

它默认是**规划型 skill**：只输出 Markdown 方案、任务卡、测试用例计划或 `.spec.ts` 文件规划，不会修改你的工程文件。只有当用户明确要求“写代码 / 生成文件 / 写入工程 / 修改 package.json / 落地代码 / 实现测试代码”时，才进入代码实现。

### 核心能力

- 前端需求解析：页面、路由、组件、表单、状态、权限、数据模型、API、交互状态。
- 资料完整性审计：识别 PRD、原型、截图、流程图、附件、动态页面等是否成功解析。
- 复杂功能技术实施方案：针对水印、导入导出、多语言、审批流、权限、分享页、大表格、媒体处理等技术点给出前后端边界和实现方向。
- 全技术方向 Option Matrix：当渲染、状态、API、缓存、权限、组件抽取、库选型、基础设施、测试策略等存在多种方案时，输出取舍矩阵。
- 组件抽取规划：区分页内组件、业务组件、基础组件、composable/hook、service、policy utility，并说明哪些暂时不该抽象。
- 工程任务卡：把施工计划拆成 AI agent / 前端工程师可直接执行的任务卡。
- 单元测试用例计划：为 Vue / React 等前端工程生成可落地的 `.spec.ts` 规划、测试文件映射、测试用例清单、mock 策略和验证命令。

### 目录结构

```text
frontend-prototype-planner/
├── SKILL.md              # Codex Skill 主体说明，必须保留
├── agents/
│   └── openai.yaml       # Codex UI 元信息
├── README.md             # 中英双语使用说明
├── .gitignore            # 仓库忽略规则
└── .gitattributes        # 文本换行规则
```

### 安装方式

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

如果工程已有测试框架，优先沿用现有测试框架，不重复推荐依赖。

### 校验 Skill

如果你已经安装了 Codex 自带的 `skill-creator`，可以运行官方校验脚本：

Windows PowerShell:

```powershell
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"
python C:\Users\Administrator\.codex\skills\.system\skill-creator\scripts\quick_validate.py D:\private\frontDev-skills\frontend-prototype-planner
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

### 维护建议

- 保持 `SKILL.md` 的 frontmatter 只有 `name` 和 `description`。
- 修改 `SKILL.md` 后运行 `quick_validate.py`。
- 修改触发场景后，同步更新 `agents/openai.yaml`。
- 如果复制到全局 skills 目录，重启 Codex 后再测试。
- 不要把临时输出、生成的测试文件、构建产物或本地缓存提交到仓库。

---

## English

`frontend-prototype-planner` is a Codex Skill that turns frontend prototypes, PRDs, screenshots, flowcharts, page modules, task cards, or plain-text requirements into implementation-ready, verifiable, and handoff-ready frontend construction plans.

By default, this is a **planning skill**. It outputs Markdown plans, task cards, test case plans, or `.spec.ts` file plans. It does not modify your project files unless you explicitly ask it to write code, generate files, update `package.json`, write tests into the project, or implement the plan.

### Core Capabilities

- Frontend requirement decomposition: pages, routes, components, forms, state, permissions, data models, APIs, and interaction states.
- Source coverage audit: check whether PRDs, prototypes, screenshots, flowcharts, attachments, and dynamic pages were parsed.
- Technical implementation directions for complex features such as watermarking, import/export, multilingual content, approval workflows, permission-heavy actions, public share pages, large tables, and media processing.
- Full technical Option Matrix: compare alternatives for rendering, state, API shape, caching, permissions, component extraction, library choices, infrastructure, and testing strategy.
- Component extraction planning: distinguish page-local components, reusable business components, base components, composables/hooks, services, and policy utilities, including what should not be abstracted yet.
- Engineering task cards: split implementation plans into executable tasks for AI agents or frontend engineers.
- Unit test planning: generate actionable `.spec.ts` plans, test file maps, test case lists, mock strategies, and verification commands for Vue, React, and other frontend stacks.

### Repository Structure

```text
frontend-prototype-planner/
├── SKILL.md              # Required Codex Skill instructions
├── agents/
│   └── openai.yaml       # Codex UI metadata
├── README.md             # Bilingual user guide
├── .gitignore            # Repository ignore rules
└── .gitattributes        # Text and line-ending rules
```

### Installation

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

If the project already has a test framework, the skill should reuse it and avoid duplicate dependencies.

### Validate The Skill

If Codex's built-in `skill-creator` skill is installed, run:

Windows PowerShell:

```powershell
$env:PYTHONUTF8 = "1"
$env:PYTHONIOENCODING = "utf-8"
python C:\Users\Administrator\.codex\skills\.system\skill-creator\scripts\quick_validate.py D:\private\frontDev-skills\frontend-prototype-planner
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

### Maintenance Notes

- Keep the `SKILL.md` frontmatter limited to `name` and `description`.
- Run `quick_validate.py` after changing `SKILL.md`.
- Update `agents/openai.yaml` when trigger behavior changes.
- Restart Codex after copying the skill into the global skills directory.
- Do not commit temporary outputs, generated test files, build artifacts, or local caches.
