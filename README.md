# iOS CLI Development Skill

一个无需 Xcode GUI 的 iOS 应用开发工作流系统。

## 核心理念

| 角色 | 职责 |
|------|------|
| **用户** | 产品负责人：描述需求、验收结果 |
| **Claude** | 开发者：实现、验证、报告 |

**用户不需要写代码或读代码**，只需描述想要什么。

## 快速开始

告诉 Claude 你想做什么：

```
1. 新建应用    → 创建完整 iOS 项目
2. 修复 Bug   → 诊断并修复问题
3. 添加功能    → 实现新特性
4. 编写测试    → 单元测试/UI测试
5. 性能优化    → 分析并优化
6. 发布应用    → TestFlight/App Store
```

Claude 会自动读取对应的工作流文件并执行。

## 工作原则

### 1. 证明，而非承诺
每次修改后都会运行构建、测试、模拟器验证。

### 2. 小步迭代
```
修改 → 验证 → 报告 → 下一步
```

### 3. 报告结果，而非代码
```
✗ "我重构了 DataService 使用 async/await"
✓ "内存泄漏已修复，leaks 显示 0 泄漏"
```

## 文件结构

```
ios.md              # 主入口，路由到具体工作流
workflows/          # 6 个工作流程
references/         # 19 个技术参考文档
```

## 参考文档索引

| 类别 | 文档 |
|------|------|
| 架构 | app-architecture, swiftui-patterns, navigation-patterns |
| 数据 | data-persistence, networking |
| 平台 | push-notifications, storekit, background-tasks |
| 质量 | polish-and-ux, accessibility, performance |
| 资源 | app-icons, security, app-store |
| 开发 | project-scaffolding, cli-workflow, cli-observability, testing, ci-cd |

## 环境要求

- macOS
- Xcode Command Line Tools (`xcode-select --install`)
- iOS Simulator

## 使用示例

**用户：** "我想做一个记账 App"

**Claude：**
1. 读取 `workflows/build-new-app.md`
2. 询问 App 名称、功能需求
3. 创建项目结构
4. 构建验证
5. 报告：Build ✓，App 已在模拟器启动
