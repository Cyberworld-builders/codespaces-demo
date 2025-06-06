# Laravel Development Container

This devcontainer provides a complete Laravel development environment with all necessary tools and services.

## What's Included

### Development Environment
- **PHP 8.2** with all required extensions
- **Composer** - PHP dependency manager
- **Node.js 20.x** with npm - for frontend assets
- **Laravel Installer** - globally available
- **Git** - version control

### Services
- **PostgreSQL 15** - Primary database
- **Redis 7** - Cache and session storage
- **MailHog** - Email testing tool

### VS Code Extensions
- **Intelephense** - PHP IntelliSense
- **Laravel Blade** - Blade template support
- **Laravel Extensions** - Enhanced Laravel development
- **Tailwind CSS** - CSS IntelliSense
- **Prettier** - Code formatting

## Quick Start

1. **Open in Codespaces/DevContainer**
   - The setup script will automatically run and configure everything

2. **Start the Laravel server**
   ```bash
   serve
   # or
   php artisan serve --host=0.0.0.0 --port=8000
   ```

3. **Start the Vite development server** (in another terminal)
   ```bash
   npm run dev
   ```

4. **Access your application**
   - Laravel app: http://localhost:8000
   - Vite dev server: http://localhost:5173
   - MailHog: http://localhost:8025

## Available Commands & Aliases

### Laravel Artisan
- `art` - Short alias for `php artisan`
- `tinker` - Laravel Tinker REPL
- `migrate` - Run database migrations
- `seed` - Run database seeders
- `serve` - Start development server
- `test` - Run PHPUnit tests
- `fresh` - Fresh migrate with seeding
- `cache` - Clear all caches

### Composer
- `comp` - Short alias for `composer`
- `compd` - Dump autoloader

### NPM/Frontend
- `dev` - Start Vite development server
- `build` - Build production assets
- `watch` - Watch and rebuild assets

### Database & Services
- **PostgreSQL**: `psql -h postgres -U laravel -d laravel` (password: `password`)
- **Redis**: `redis-cli -h redis`

## Database Configuration

The devcontainer is configured with:
- **Host**: `postgres`
- **Database**: `laravel`
- **Username**: `laravel`
- **Password**: `password`

## Environment Variables

The `.env` file is automatically configured for the devcontainer with:
- PostgreSQL database connection
- Redis cache and sessions
- MailHog for email testing
- Proper service hostnames

## Development Workflow

1. **Make changes to your Laravel code**
2. **Database changes**: Run `migrate` or `fresh` for clean slate
3. **Frontend changes**: Ensure `npm run dev` is running
4. **Email testing**: Check MailHog at http://localhost:8025
5. **Testing**: Run `test` or `php artisan test`

## Debugging

### PHP Debugging
- Xdebug is available for step debugging
- Configure your VS Code launch configuration

### Database Access
- Use VS Code PostgreSQL extension or connect directly:
  ```bash
  psql -h postgres -U laravel -d laravel
  ```

### Logs
- Laravel logs: `storage/logs/laravel.log`
- Container logs: Use VS Code's integrated terminal

## Customization

### Adding PHP Extensions
Edit `.devcontainer/Dockerfile` and rebuild the container.

### Additional Services
Edit `.devcontainer/docker-compose.yml` to add more services.

### VS Code Settings
Modify the `customizations.vscode` section in `devcontainer.json`.

## Troubleshooting

### Container Won't Start
- Check Docker is running
- Try rebuilding: "Dev Containers: Rebuild Container"

### Database Connection Issues
- Ensure PostgreSQL container is running
- Check environment variables in `.env`

### Permission Issues
```bash
sudo chown -R $USER:$USER storage bootstrap/cache
chmod -R 775 storage bootstrap/cache
```

### Clear Everything
```bash
cache  # Clear Laravel caches
php artisan config:clear
composer dump-autoload
npm run build
```

## Port Forwarding

The following ports are automatically forwarded:
- **8000** - Laravel application
- **5173** - Vite development server
- **5432** - PostgreSQL database
- **6379** - Redis
- **8025** - MailHog web interface

Access these via `http://localhost:[port]` from your local machine. 