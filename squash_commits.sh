#!/bin/bash

# Script to squash commits from Dec 16, 2025 (48 commits) down to ~10 meaningful commits

echo "Starting interactive rebase to squash December 16th commits..."
echo "You will see 48 commits marked as 'pick'"
echo ""
echo "Strategy: Group related commits and squash them into meaningful chunks:"
echo "1. Initial setup and documentation (commits about README, gitignore, etc)"
echo "2. Weblog structure and templates"
echo "3. GitHub Actions workflows"
echo "4. Theme and styling improvements"
echo "5. Dark/light mode toggle feature"
echo "6. Post template experiments"
echo "7. Performance fixes"
echo "8. Auto-sync optimizations"
echo "9. Test workflows cleanup"
echo "10. Final adjustments"
echo ""
echo "For each group:"
echo "- Keep the first commit as 'pick'"
echo "- Change subsequent commits in the group to 'squash' or 's'"
echo "- Edit the commit message to be descriptive of the whole group"
echo ""
echo "Starting git rebase -i..."

git rebase -i 51c0884
