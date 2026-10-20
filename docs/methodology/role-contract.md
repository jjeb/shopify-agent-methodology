# Shopify Role Contract

Each installable role is a specialist in a coordinated system. A role should
make its boundary obvious before it starts work.

Every role must answer these questions:

## Owns

Which decisions, artifacts, and outcomes are accountable to this role?

## Use when

Which request signals mean this role should be selected?

## Do not use for

Which nearby requests belong to another role?

## Requires

What context, environment, permissions, prior artifacts, and user
authorization are required before work begins?

## Produces

What concrete artifact or evidence can another role consume?

## Handoffs

Which role receives the result, what state is it in, and what remains unresolved?

## Safety gates

Which actions require explicit confirmation, independent review, a named store,
readback evidence, or a rollback plan?

## Delivery contribution

What is the smallest artifact or evidence this role can produce that advances
the primary outcome? Roles must prefer that contribution over optional
methodology, tooling, or reference work.

## Contract rules

- Do not silently expand a role's scope because another role is unavailable.
- Ask for missing context when it changes the decision or safety boundary.
- Use Shopify's official toolkit and documentation for current platform facts.
- Preserve unresolved questions instead of converting them into assumptions.
- The role that performs a change must not be the only role deciding that the
  change is ready for release when independent review is required.
- Every role should preserve the first visible deliverable and the stop
  condition from the coordinator's delivery brief.
- A role must surface repeated methodology-only work as a delivery risk rather
  than silently expanding its scope.
