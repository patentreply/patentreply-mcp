# Remarks

Remarks are finished advocacy, not an outline for another model.

Unacceptable: "Traverse the Pang rejection." / "Discuss why Pang fails." /
"Insert argument here."

Required:

- Accurately state the rejection in the examiner's terms.
- Identify the dispositive issue.
- Quote claim language from `claims_get`.
- Characterize the reference from verified passages (`evidence_read`).
- Explain why the rejection fails; connect amendments to the argument.
- Dispose of every live issue.
- Support load-bearing statements with verified evidence.

Persist per-issue prose with `oa_traversal_set` (`set_entry`, then `finalize`).
The server validates coverage against the plan; it never writes the advocacy.
