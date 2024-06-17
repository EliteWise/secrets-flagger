# Secrets Flagger Script

### Overview
This script scans files added, copied, or modified in the git index to ensure they don't contain any sensitive patterns that might expose credentials, keys, or other sensitive information. It's designed to be used as a preventative measure, potentially in a git pre-commit hook, to prevent accidental exposure of secrets.

### Patterns Checked
The script checks for the following patterns by default:

- AWS Access Key IDs
- Bearer tokens
- 32 or 64-character hex strings (commonly used as API keys)
- Private Keys (both generic and PGP)
- Database connection strings (MongoDB, PostgreSQL, MySQL)
- Stripe live keys
- Password fields
- Slack tokens
- SendGrid tokens

### Usage
Ensure the script is executable:
```bash
chmod +x flagger.sh
```

Run the script in your repository:
```bash
./flagger.sh
```

If any pattern is detected in the files, a warning will be displayed on the console.

### Integration with Git Hooks
To use this script as a git pre-commit hook:

1. Copy the script to `.git/hooks/pre-commit` (or in `.husky/pre-commit`) in your repository. <br />
2. Ensure the script is executable: `chmod +x .git/hooks/pre-commit` (or `chmod +x .husky/pre-commit`) <br />
3. When committing files, the script will automatically run. If a sensitive pattern is detected, the commit will be aborted. <br />


### Notes
For performance reasons, if there are numerous files and patterns, it might take some time. Future enhancements might involve optimizing this aspect. <br />
The script currently only checks files added, copied, or modified in the git index. Files that are untracked or unchanged won't be inspected.
