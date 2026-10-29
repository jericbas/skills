---
name: react-19-ts-review
description: >-
  Reviews React 19 and TypeScript branch diffs against a confirmed base branch
  using React 19 standards, core React principles, and layer-scoped SOLID rules.
  Use when the user asks to review a React 19 TypeScript project, pull request,
  or branch changes.
trigger: /review-react-19
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [React, React 19, TypeScript, Code Review, SOLID, Git, Graphify]
    category: react
    related_skills: [react-srp-dry-analyzer, graphify-review, depcruise]
---

## Install
Run:
`npx skills add jericbas/skills --skill react-19-ts-review`

# React 19 + TypeScript Branch Reviewer

**Trigger Command:** `/review-react-19`

**Purpose:** Performs a focused, sprint-sized code review of a React 19 + TypeScript project by comparing the current branch against a user-confirmed base branch (e.g., `develop`). Evaluates changes against React 19 standards and new features, core React principles, strict TypeScript practices, and layer-scoped SOLID principles (S, O, L, I for UI components; full S, O, L, I, D for hooks, services, and non-component layers).

## Instructions for the Agent:

### Step 1: Pre-Flight, Branch Confirmation & `/graphify` Check
1. **Verify Project Context:**
   * Inspect `package.json` and `tsconfig.json` to confirm the project uses React 19 (`react` / `react-dom` `^19.x`) and TypeScript.
   * Check if `babel-plugin-react-compiler` (React Compiler) is enabled, as this impacts manual memoization (`useMemo` / `useCallback` / `React.memo`) recommendations.
2. **Confirm Branch Comparison:**
   * Run `git branch --show-current` to identify the active branch.
   * Explicitly ask the user: *"You are currently on branch `<current-branch>`. Which target branch should I compare it against (e.g., `develop`, `main`), or should I review only uncommitted/staged changes?"*
   * Wait for the user's confirmation before proceeding.
   * Once confirmed, run `git diff --name-only <base-branch>...HEAD -- '*.ts' '*.tsx'` and `git diff <base-branch>...HEAD -- '*.ts' '*.tsx'` to scope the review strictly to modified TypeScript and React files.
3. **`/graphify` Integration (If Available):**
   * Check if `/graphify` (or `.graphify/graph.json`, `/graphify-review`, `/graphify-map`) is available in the repository.
   * If `/graphify` is available, run it in the same step against the changed files to map upstream/downstream dependencies, adjacent components/hooks, blast radius, and potential test gaps.
   * If `/graphify` is not available, proceed directly using the git diff and file imports without blocking.

### Step 2: React 19 Standards & New Feature Inspection
Inspect all modified `.tsx` and `.ts` files both for deprecated legacy patterns and opportunities to leverage new React 19 features:
* **`ref` as a Standard Prop (No `forwardRef`):** Flag `React.forwardRef(...)` boilerplate. Recommend accepting `ref` directly as a prop on function components (`function Input({ ref, ...props }: ComponentProps<'input'>)`).
* **Ref Callback Cleanup Functions:** Flag `useEffect` hooks used solely to clean up DOM refs or observers. Recommend returning a cleanup function directly from the `ref` callback (`ref={(node) => { ...; return () => cleanup(); }}`).
* **Direct `<Context>` Provider:** Flag `<MyContext.Provider value={...}>` and recommend the React 19 `<MyContext value={...}>` syntax.
* **The `use()` API:**
  * Recommend `use(MyContext)` over `useContext(MyContext)`—especially when reading context conditionally after early returns.
  * Where appropriate, highlight opportunities to read promises declaratively in render via `use(promise)` paired with `<Suspense>` and Error Boundaries instead of `useEffect` + `useState` loading waterfalls.
* **Actions, `useActionState`, and `useFormStatus`:**
  * Flag manual form submission boilerplate (`e.preventDefault()`, manual `isSubmitting`/`isLoading`, `error` state hooks) where React 19 **Actions** (`<form action={fn}>` or `startTransition(async () => ...)`) apply.
  * Recommend `useActionState` to manage action state and pending status, and `useFormStatus()` in nested form buttons/inputs instead of prop-drilling `isPending`.
* **Optimistic UI (`useOptimistic`):** When reviewing async mutations that update list/item state, check if `useOptimistic(state, updateFn)` can provide instant UI feedback with automatic rollback on failure.
* **Native Document Metadata & Resource Preloading:** Flag `react-helmet` or `useEffect` mutations of `document.title` / `<head>`. Recommend rendering `<title>`, `<meta>`, and `<link>` (with `precedence` for stylesheets) natively inside components, or using `preload` / `preinit` / `preconnect` from `react-dom`.
* **Compiler-Aware Memoization:** If React Compiler is active, flag unnecessary `useMemo`/`useCallback`/`React.memo` wrappers unless required for third-party referential stability. If React Compiler is not active, flag missing memoization only on genuinely expensive calculations or unstable dependencies passed to effects/memoized children.

### Step 3: Core React Principles Check
* **Declarative UI & Derived State ("You Might Not Need an Effect"):**
  * Flag `useEffect` hooks that transform data for rendering or synchronize derived state (`setFilteredItems` inside an effect). Compute derived values directly during render.
  * Flag `useEffect` hooks used to trigger side effects in response to user actions (move to event handlers or React 19 Actions).
  * Recommend resetting component state with a `key` prop (`<Profile key={userId} />`) instead of clearing state inside `useEffect`.
* **Render Purity & Rules of React:**
  * Ensure render functions are pure (no side effects, no mutating props, state, or `ref.current` during render).
  * Verify hooks are called only at the top level (with the explicit exception of `use()`, which React 19 allows conditionally).
* **State Colocation & Composition:**
  * Keep state colocated to the lowest common ancestor that needs it.
  * Avoid deep prop drilling by using component composition (`children` / slots) or React 19 `<Context value={...}>`.

### Step 4: SOLID Principles (Layer-Scoped)
Apply SOLID principles according to the architectural layer—**never apply Dependency Inversion (D) to UI components**:

1. **S — Single Responsibility Principle (SRP) *(Components, Hooks & Services)*:**
   * Each component, custom hook, or module should have a single reason to change.
   * Flag "God components" that combine data fetching/mutations, complex domain formatting, and multi-section UI rendering. Suggest extracting business orchestration into custom hooks, pure functions into `.ts` utilities, and distinct UI blocks into focused subcomponents (or suggest running `/analyze-srp-dry` for deep refactors).
2. **O — Open/Closed Principle (OCP) *(Components & Modules)*:**
   * Components should be open for extension via **composition** (`children`, slot props, compound components, variant maps) and closed for modification.
   * Flag components bloated with boolean mode flags or Growing `switch`/`if-else` trees for specific pages (e.g., `isCheckoutPage`, `showAdminHeader`).
3. **L — Liskov Substitution Principle (LSP) *(Wrapper & Base Components)*:**
   * Custom UI wrappers (`<Button>`, `<Input>`, `<Modal>`) wrapping native HTML elements or base primitives must honor the underlying contract.
   * Ensure they type props with `ComponentProps<'element'>` (which includes `ref` in React 19), spread remaining props (`...rest`), safely merge `className`/handlers, and preserve accessibility/native attributes (`disabled`, `type`, `aria-*`).
4. **I — Interface Segregation Principle (ISP) *(Component Props & Hook Signatures)*:**
   * Never force a component or hook to accept more data than it actually uses.
   * Flag components that require full backend DTOs or massive domain objects (e.g., `user: UserDTO` with 25 fields) when only rendering `name` and `avatarUrl`. Recommend narrow prop types (`Pick<UserDTO, 'name' | 'avatarUrl'>` or dedicated minimal interfaces).
5. **D — Dependency Inversion Principle (DIP) *(Non-Component Layers ONLY: `*.ts`, Custom Hooks, Services, Adapters)*:**
   * **DO NOT apply DIP to UI Components (`*.tsx`):** Keep React components clean and declarative; do not recommend injecting service containers or repositories via component props.
   * **DO apply DIP to Non-Component Code (`*.ts`, hooks, services, state stores, domain logic):** Flag custom hooks, domain services, or business logic that hardcode low-level infrastructure or third-party SDK calls directly (`axios`, `localStorage`, `firebase`, raw `fetch` endpoints). Recommend depending on TypeScript interfaces/contracts, adapter functions, or React Context boundaries so business logic remains decoupled and testable.

### Step 5: TypeScript Strictness Check
* **No `React.FC` / `React.FunctionComponent`:** Prefer typing function parameters directly (`function UserCard({ name, ref }: UserCardProps)`).
* **Discriminated Unions over Boolean Soup:** Replace impossible state combinations (`isLoading: boolean; isError: boolean; data?: T`) with discriminated unions (`type AsyncState<T> = { status: 'idle' | 'loading' } | { status: 'success'; data: T } | { status: 'error'; error: Error }`).
* **Type Safety & Narrowing:** Flag explicit `any`, non-null assertions (`!`), and unsafe `as` casts (especially when parsing `FormData` inside React 19 Actions or API responses—recommend runtime validation/type guards).

### Step 6: Structured Review Output
Consult [react-19-solid-checklist.md](./references/react-19-solid-checklist.md) for canonical React 19 and layer-scoped SOLID refactor patterns when drafting code examples. Present the review findings in a clean, scannable report:
1. **Review Scope Summary:** Current branch, compared base branch, number of `.ts`/`.tsx` files analyzed, React 19 / Compiler status, and `/graphify` blast-radius summary (if used).
2. **React 19 Standards & Feature Opportunities:** List any legacy patterns (`forwardRef`, `<Context.Provider>`, manual form state) and where React 19 features (`use`, `useActionState`, `useFormStatus`, `useOptimistic`, ref cleanup, native metadata) can simplify the code.
3. **React Principles & SOLID Findings:** Group issues by severity (`🔴 Critical`, `🟡 Suggestion`, `🟢 Nit/Praise`) with `file:line` references, the specific principle violated (`SRP`, `OCP`, `LSP`, `ISP`, `DIP [non-component]`, or `Declarative React`), and concise **Before vs. After** TypeScript code snippets.
4. **Halt & Next Steps:** Ask the user which findings they would like you to apply automatically.

