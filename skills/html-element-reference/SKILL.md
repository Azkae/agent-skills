---
name: html-element-reference
description: Use this skill when the user provides an HTML element reference in the format `[ComponentName] tag.className > [ChildComponent] tag.className > span.className`. This breadcrumb format helps locate an element in the source code by showing the component hierarchy and HTML structure. It is informational only - use it as a guide to find the approximate location, not as an exact selector.
---

# HTML Element Reference

When a user provides a reference like:

```
[StudyDetailLayout] div.contentColumn > [StudyTasksView] div.page > section.tasksCol > [StudyStepsLangMenu] div.langSelector
```

This is a **breadcrumb** that traces a path from a top-level component down to a specific HTML element. Use it to locate the approximate position in the source code.

## Format

Each segment is separated by ` > ` and follows this pattern:

```
[ComponentName] tag.className
```

Or without a component name (plain HTML element):

```
tag.className
```

### Components

- `[ComponentName]` - The React component that renders this element. Look for a file or function named `ComponentName`.
- Components are listed from outermost (parent) to innermost (child).

### HTML elements

- `tag` - The HTML tag name (`div`, `section`, `span`, `button`, `ul`, `li`, etc.)
- `.className` - The CSS class applied to that element (from CSS modules in this project)

## How to use it

1. **Start from the rightmost (innermost) element** - This is the target, find it first
2. **Look for the class name** - Search for the last class name in (it's usually unique enough)
3. **Identify the owning component** - The `[ComponentName]` right before it tells you which component renders it
4. **Work backwards if needed** - Only go up the chain if you need more context about where this element sits in the hierarchy

## Important

- This is **informational only**. Do not try to construct an exact CSS selector from it.
- The reference gives you the **approximate location**. The actual element might have additional classes, different nesting, or be wrapped in other elements.
- **Start from the innermost element** (rightmost) - search for its class name directly. You don't need to traverse every level of the chain, only go up if you need more context.

## Example walkthrough

Given:

```
[StudyDetailLayout] div.contentColumn > [StudyTasksView] div.page > section.tasksCol > [StudyStepsLangMenu] div.langSelector
```

To find this element (fastest path, start from the innermost):

1. Search for `langSelector` - this class name is usually unique enough to find the file directly
2. The component rendering it is `[StudyStepsLangMenu]` - open that file
3. Find the `div` with class `langSelector` in its JSX - **this is the target element**

If you need more context about where this element sits:

4. Find where `StudyStepsLangMenu` is rendered (search for `<StudyStepsLangMenu`)
5. That parent is inside a `section.tasksCol`, which is inside `[StudyTasksView] div.page`
6. `StudyTasksView` is rendered inside `[StudyDetailLayout] div.contentColumn`
