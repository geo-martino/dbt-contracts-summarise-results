# dbt-contracts-summarise-results

Summarises the results of a dbt-contracts execution as a markdown table within the workflow run.

## Example

```yaml
- name: 📃 Summarise dbt-contracts results
  if: failure() && steps.dbt-contracts.outcome == 'failure'
  with:
    title: "🗄 DBT Contracts results | jaffle_shop"
    path: ${{ steps.dbt-contracts.outputs.annotations_path }}
    additional-file-dir: jaffle_shop
    ignore-missing-file: false
```
