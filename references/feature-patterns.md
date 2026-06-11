# Feature Pattern Reference

Read this when producing technical implementation directions. Treat these patterns as prompts for discovery, not as a closed keyword list.

When a requirement contains a technical noun, engineering mechanism, platform capability, integration point, or frontend/backend tradeoff, create a `TECH-XXX` item and link it to relevant `API-XXX`, `COMP-XXX`, `STATE-XXX`, `ENUM-XXX`, and acceptance case IDs.

## Trigger Patterns

- Media and asset processing: watermark, image processing, video, audio, file preview, thumbnail, compression, transcoding, OCR, PDF, canvas, print, download protection.
- Data exchange: import, export, Excel, CSV, upload, download, batch operation, validation preview, error file, async task.
- Content and language: multilingual content, i18n, translation, proofreading, locale fallback, rich text, template rendering.
- Workflow and state: approval, workflow, state machine, task queue, audit log, rollback, recall, publish, shelf on/off.
- Security and access: permission, role, capability code, row-level action, public share, token, expiry, unauthenticated route, watermark/security boundary.
- Data-heavy UI: large table, virtual scroll, pagination, tree table, drag-and-drop, chart, dashboard, realtime refresh, WebSocket/SSE.
- Platform integration: CDN/OSS, payment, map, notification, email/SMS, third-party auth, SSO, browser API, native bridge, mini-program, Electron.

For any other technical term not listed here, infer the implementation problem and produce an explicit, realistic implementation direction. State what runs in the frontend, what must be handled by backend or infrastructure, what can be mocked, what is risky, and what should be verified.
