## 📘 Git Pre-Push Build Check (One-Time Setup for This Repo)

This project shwows how to uses a **Git pre-push hook** to run a build before pushing.
If the build fails, the push is stopped — so broken code never makes it to the remote repo.

---

### ✅ How to Set It Up (Just Once)

1. **Navigate to your repo’s `.git/hooks` directory**:

   ```bash
   cd your-project/.git/hooks
   ```

2. **Create a `pre-push` file** (if it doesn’t exist yet):

   ```bash
   touch pre-push
   ```

3. **Make it executable**:

   ```bash
   chmod +x pre-push
   ```

4. **Edit the file and add this script or the enhanced script stored in the root of this project**:

   ```bash
   #!/bin/sh

   echo "Running build before push..."

   # Run your build command
   if ! npm run build; then
     echo "Build failed. Push aborted."
     exit 1
   fi

   echo "Build passed. Proceeding with push..."
   exit 0
   ```

   >  You can replace `npm run build` with `yarn build`, `pnpm build`, or whatever works for your project.

---

### What This Does

* Every time you run `git push`, it will first try to build the project.
* If the build **fails**, the push is canceled, and you'll see an error message.
* If the build **passes**, the push goes through as usual.

---

### Want to Remove It Later?

Just delete the `.git/hooks/pre-push` file:

```bash
rm .git/hooks/pre-push
```

---

### Example Output

```bash
$ git push
Running build before push...
> next build
Compiled successfully in 4.32s
Build passed. Proceeding with push...
Counting objects: 5, done.
...
```

Or, if there's a failure:

```bash
$ git push
Running build before push...
> next build
Error: Module not found...

Build failed. Push aborted.
```

