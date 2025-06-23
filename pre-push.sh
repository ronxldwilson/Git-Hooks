#!/bin/sh

# Git hook: pre-push
# Prevents push if build fails, unless --skip-check is used in the Git command

# Read stdin (used by Git, even if not needed here)
while read local_ref local_sha remote_ref remote_sha; do
  true # no-op
done

# Check for --skip-check in the actual Git command history
SKIP_FLAG_PRESENT=$(ps -ocommand= -p $PPID | grep -- "--skip-check")

if [ -n "$SKIP_FLAG_PRESENT" ]; then
  echo "⚠️  Skipping pre-push check due to --skip-check"
  exit 0
fi

echo " Checking build before pushing..."

# Detect build tool
if [ -f "pnpm-lock.yaml" ]; then
  BUILD_CMD="pnpm build"
elif [ -f "yarn.lock" ]; then
  BUILD_CMD="yarn build"
else
  BUILD_CMD="npm run build"
fi

echo " Running: $BUILD_CMD"
if ! $BUILD_CMD; then
  echo " Build failed. Push aborted."
  exit 1
fi

echo " Build passed. Proceeding with push."
exit 0

