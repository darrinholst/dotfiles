# Global instructions

## Code comments

NEVER add comments to code. No explanatory, descriptive, or section comments.
Do not add comments even to "clarify" non-obvious logic. The only exception is
when the user explicitly asks for comments in a specific request.

When logic isn't self-evident, make the intent clear through the code itself:
extract well-named functions, introduce descriptive intermediate variables, or
restructure the code. Naming and structure carry the explanation, not comments.

This applies to all languages and all files.

## Tests

Test descriptions must start with "should".
