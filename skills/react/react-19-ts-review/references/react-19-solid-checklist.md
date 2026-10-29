# React 19 & SOLID Reference Checklist

Use this reference during Step 2, Step 3, and Step 4 of `/review-react-19` when generating before/after refactor examples.

## 1. React 19 Patterns (Before vs. After)

### `ref` as a Standard Prop & Ref Callback Cleanup
```tsx
// ❌ Legacy (React 18 and earlier)
const TextInput = forwardRef<HTMLInputElement, ComponentPropsWithoutRef<'input'>>(
  (props, ref) => <input ref={ref} {...props} />
);

// ✅ React 19 Standard
function TextInput({ ref, ...props }: ComponentProps<'input'>) {
  return (
    <input
      ref={(node) => {
        if (typeof ref === 'function') ref(node);
        else if (ref) ref.current = node;
        return () => {
          // Optional React 19 ref cleanup
        };
      }}
      {...props}
    />
  );
}
```

### Direct `<Context>` Provider & Conditional `use()`
```tsx
// ❌ Legacy
<ThemeContext.Provider value={theme}>{children}</ThemeContext.Provider>
const theme = useContext(ThemeContext); // Cannot be called after early return

// ✅ React 19 Standard
<ThemeContext value={theme}>{children}</ThemeContext>
if (!isVisible) return null;
const theme = use(ThemeContext); // Allowed conditionally after early returns
```

### Actions (`useActionState`, `useFormStatus`, `useOptimistic`)
```tsx
// ✅ React 19 Form Action + useActionState + useOptimistic
function UpdateNameForm({ currentName }: { currentName: string }) {
  const [optimisticName, setOptimisticName] = useOptimistic(currentName);
  const [state, submitAction, isPending] = useActionState(
    async (_prev: { error?: string }, formData: FormData) => {
      const nextName = String(formData.get('name') ?? '').trim();
      if (!nextName) return { error: 'Name is required' };
      setOptimisticName(nextName);
      await saveUserName(nextName);
      return {};
    },
    {}
  );

  return (
    <form action={submitAction}>
      <p>Current: {optimisticName}</p>
      <input name="name" defaultValue={currentName} disabled={isPending} />
      {state.error && <span role="alert">{state.error}</span>}
      <SubmitButton />
    </form>
  );
}

function SubmitButton() {
  const { pending } = useFormStatus();
  return <button type="submit" disabled={pending}>Save</button>;
}
```

---

## 2. Layer-Scoped SOLID Rules

| Principle | UI Components (`*.tsx`) | Non-Component Code (`*.ts`, hooks, services, adapters) |
| :--- | :--- | :--- |
| **S (SRP)** | Split data orchestration (custom hooks) and pure formatting (`.ts` utils) from JSX view rendering. | Keep each hook, service, or utility focused on a single domain responsibility. |
| **O (OCP)** | Extend via composition (`children`, slots, variant maps) rather than adding page-specific boolean flags. | Use strategy maps or plugin callbacks instead of growing `switch` statements. |
| **L (LSP)** | Wrapper components (`<Button>`, `<Input>`) must accept `ComponentProps<'element'>`, spread `...rest`, and preserve native semantics. | Subtypes and adapter implementations must honor the return types and error contracts of their base TypeScript interface. |
| **I (ISP)** | Accept narrow prop types (`Pick<User, 'id' | 'name'>`) instead of requiring massive backend DTOs. | Keep function parameters and hook options minimal and focused on required fields. |
| **D (DIP)** | **DO NOT APPLY to UI components.** Avoid passing service containers or repositories as component props. | **APPLY STRICTLY.** Business logic and custom hooks must depend on TypeScript interfaces/contracts or Context boundaries rather than hardcoded low-level SDKs (`axios`, `localStorage`, `firebase`). |

