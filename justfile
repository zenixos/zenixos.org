# Build the site locally
build:
    npm run build

# Start dev server
dev:
    npm run dev

# Initialize database (backend)
init:
    cd @shared/server && bun db/init/load-data autoload

# Run tests (backend)
test:
    cd @shared/server && bun test

# Deploy to Cloudflare Pages (production)
deploy: build
    npx wrangler pages deploy .dist --project-name zenixos-org --branch=main --commit-dirty=true

# Git push and deploy
ship message: 
    git add -A
    git commit -m "{{message}}"
    git push origin main
    just deploy

# Full workflow: commit, push, and deploy
publish message: (ship message)
    @echo "✅ Published to GitHub and Cloudflare!"

# Quick deploy without git commit
quick-deploy:
    just deploy
    @echo "✅ Deployed to Cloudflare!"

# Clean build directory
clean:
    rm -rf .dist

# Rebuild from scratch
rebuild: clean build

# Show deployment status
status:
    npx wrangler pages project list
