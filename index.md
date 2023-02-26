---
date: 1
header: true
---

Home
====

- 

**Workflow**

```yml
# spx/.github/workflows/update.yml
name: Fetch Save and Autocommit
on:
  schedule:
    # Run at 00:01 06:01 12:01 18:01 UTC every day
    - cron: '1 0/6 * * *'
jobs:
  update:
    name: manifest turn
    runs-on: ubuntu-latest
    steps:
      # CHECKOUT
      - name: checkout
        uses: actions/checkout@v3

      # Get UNIX
      - name: "Get current unix"
        id: unix
        run: echo "unix_seconds=$(date +%s)" >> $GITHUB_ENV

      # Get Dice
      - name: "Get dice"
        id: dice
        run: echo "dice_value=$(expr 1 + $RANDOM % 6)" >> $GITHUB_ENV

      # write to CSV file
      - name: Write to CSV file
        uses: gr2m/write-csv-file-action@v1.0.0
        with:
          path: "data/turn.csv"
          columns: run, unix, dice
          "run": "${{ env.GITHUB_RUN_NUMBER }}"
          "unix": "${{ env.unix_seconds }}"
          "dice": "${{ env.dice_value }}"

      # COMMIT
      - name: Git Auto Commit
        uses: stefanzweifel/git-auto-commit-action@v4.8.0
```