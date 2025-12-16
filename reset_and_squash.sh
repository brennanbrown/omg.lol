#!/bin/bash

# Better approach: Use git reset --soft to the commit before the spree
# This keeps all changes staged and lets us create clean, meaningful commits

echo "=== Squashing December 16th commits (48 -> ~10) ==="
echo ""
echo "Current state: All changes from Dec 16th are preserved"
echo "We'll reset to just before the spree and recreate clean commits"
echo ""

# Find the commit before December 16th
BASE_COMMIT="51c0884"

echo "Step 1: Reset to commit $BASE_COMMIT keeping all changes staged..."
git reset --soft $BASE_COMMIT

echo ""
echo "Step 2: Now you can create clean, meaningful commits."
echo ""
echo "Suggested commit groups:"
echo "1. git add README.md .gitignore && git commit -m 'Initial project setup and documentation'"
echo "2. git add weblog/ && git commit -m 'Add weblog structure and basic templates'"
echo "3. git add .github/workflows/ && git commit -m 'Add GitHub Actions for auto-sync'"
echo "4. git add profile/ && git commit -m 'Update profile with gruvbox palette'"
echo "5. git add weblog/css/ && git commit -m 'Add external stylesheet system'"
echo "6. git add weblog/post-template.html && git commit -m 'Create dedicated post template'"
echo "7. git add . && git commit -m 'Implement dark/light mode toggle'"
echo "8. git add . && git commit -m 'Fix performance and accessibility issues'"
echo "9. git add . && git commit -m 'Add auto-sync optimizations'"
echo "10. git add . && git commit -m 'Complete auto-sync coverage for all content types'"
echo ""
echo "After creating commits:"
echo "git push --force-with-lease origin main  # Careful: rewrites history!"
echo ""
echo "Ready to reset? (Run: ./reset_and_squash.sh)"
