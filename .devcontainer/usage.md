I'll help you gather the contents of the .devcontainer files and create a comprehensive markdown document. First, let me check what files are in the .devcontainer directory.

Ran tool
Great! I'll read each file to create a comprehensive markdown document. I already have the contents of `setup.sh`, so let me gather the others.

Read file: .devcontainer/Dockerfile
Read file: .devcontainer/devcontainer.json
Read file: .devcontainer/docker-compose.yml
Read file: .devcontainer/README.md
Now I'll create a comprehensive markdown document that explains all the files and their purposes. Here's the markdown:

```markdown
# Laravel Development Container Documentation

This document provides a comprehensive overview of the Laravel development container setup, explaining each component and how they work together to create a complete development environment.

## Overview

The development container consists of 5 key files that work together to create a complete Laravel development environment:

1. `Dockerfile` - Defines the base development container
2. `docker-compose.yml` - Orchestrates all services
3. `devcontainer.json` - Configures VS Code and container settings
4. `setup.sh` - Initializes the development environment
5. `README.md` - Documentation and usage instructions

## File Details

### 1. Dockerfile
The Dockerfile creates the base development container with:
- PHP 8.2 with all required extensions
- Node.js 20.x
- Composer
- PostgreSQL client
- Redis tools
- Various system dependencies
- Global Composer packages (Laravel installer, Valet)

Key features:
- Uses Microsoft's official PHP devcontainer image
- Installs all necessary PHP extensions
- Sets up proper user permissions
- Configures global development tools

### 2. docker-compose.yml
Defines the complete service stack:
- `laravel` - Main application container
- `postgres` - PostgreSQL 15 database
- `redis` - Redis 7 cache server
- `mailhog` - Email testing service

Features:
- Persistent volumes for database and cache
- Network isolation
- Environment variable configuration
- Port forwarding for all services

### 3. devcontainer.json
Configures the VS Code development environment:
- VS Code extensions for Laravel development
- Editor settings and configurations
- Port forwarding rules
- Post-creation commands
- Development features (Git, GitHub CLI, SSH)

Key extensions:
- PHP IntelliSense
- Laravel Blade support
- Tailwind CSS
- GitLab workflow
- Code formatting tools

### 4. setup.sh
Initializes the development environment:
- Creates and configures `.env` file
- Installs PHP and Node.js dependencies
- Sets up database
- Configures permissions
- Creates useful aliases
- Caches Laravel configuration

### 5. README.md
Provides comprehensive documentation:
- Quick start guide
- Available commands and aliases
- Service configurations
- Troubleshooting guide
- Development workflow

## Usage Instructions

### Getting Started

1. **Open in Codespaces/DevContainer**
   - The environment will automatically set up

2. **Access Services**
   - Laravel app: http://localhost:8000
   - Vite dev server: http://localhost:5173
   - MailHog: http://localhost:8025
   - PostgreSQL: localhost:5432
   - Redis: localhost:6379

3. **Development Workflow**
   ```bash
   # Start Laravel server
   serve
   
   # Start Vite (in another terminal)
   npm run dev
   
   # Database operations
   migrate    # Run migrations
   fresh      # Fresh migrate with seeding
   
   # Testing
   test       # Run PHPUnit tests
   ```

### Useful Aliases

```bash
# Laravel
art         # php artisan
tinker      # Laravel Tinker
serve       # Start development server
fresh       # Fresh migrate with seeding
cache       # Clear all caches

# Composer
comp        # composer
compd       # composer dump-autoload

# NPM
dev         # npm run dev
build       # npm run build
watch       # npm run dev -- --watch
```

### Database Access

```bash
# PostgreSQL
psql -h postgres -U laravel -d laravel
# Password: password

# Redis
redis-cli -h redis
```

### Troubleshooting

1. **Container Issues**
   - Rebuild container: "Dev Containers: Rebuild Container"
   - Check Docker is running

2. **Permission Issues**
   ```bash
   sudo chown -R $USER:$USER storage bootstrap/cache
   chmod -R 775 storage bootstrap/cache
   ```

3. **Cache Issues**
   ```bash
   cache  # Clear Laravel caches
   php artisan config:clear
   composer dump-autoload
   ```

## Customization

1. **Adding PHP Extensions**
   - Edit `.devcontainer/Dockerfile`
   - Rebuild container

2. **Additional Services**
   - Edit `.devcontainer/docker-compose.yml`
   - Add new service definitions

3. **VS Code Settings**
   - Modify `customizations.vscode` in `devcontainer.json`

## Best Practices

1. **Development Workflow**
   - Use provided aliases for common commands
   - Keep Vite running during frontend development
   - Use MailHog for email testing
   - Run tests before committing changes

2. **Database Management**
   - Use migrations for all database changes
   - Test migrations with `fresh` command
   - Backup data before major changes

3. **Performance**
   - Use Redis for caching
   - Keep node_modules in container
   - Use volume caching for better performance

4. **Security**
   - Never commit sensitive data
   - Use environment variables
   - Keep dependencies updated
```

This markdown document provides a comprehensive overview of the development container setup and can be used as a reference for both new and existing team members. It covers all aspects of the development environment, from setup to troubleshooting, and includes best practices for development workflow.