#!/bin/bash

echo "🚀 Setting up Laravel development environment..."

# Copy .env.example to .env if it doesn't exist and update for devcontainer
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp .env.example .env
    
    # Update .env for devcontainer services
    echo "⚙️ Configuring .env for devcontainer..."
    
    # Update database settings
    sed -i 's/DB_CONNECTION=sqlite/DB_CONNECTION=pgsql/' .env
    sed -i 's/# DB_HOST=127.0.0.1/DB_HOST=postgres/' .env
    sed -i 's/# DB_PORT=3306/DB_PORT=5432/' .env
    sed -i 's/# DB_DATABASE=laravel/DB_DATABASE=laravel/' .env
    sed -i 's/# DB_USERNAME=root/DB_USERNAME=laravel/' .env
    sed -i 's/# DB_PASSWORD=/DB_PASSWORD=password/' .env
    
    # Update cache settings
    sed -i 's/CACHE_STORE=database/CACHE_STORE=redis/' .env
    sed -i 's/# CACHE_PREFIX=/CACHE_PREFIX=laravel_cache/' .env
    
    # Update Redis settings
    sed -i 's/REDIS_HOST=127.0.0.1/REDIS_HOST=redis/' .env
    
    # Update mail settings for MailHog
    sed -i 's/MAIL_MAILER=log/MAIL_MAILER=smtp/' .env
    sed -i 's/MAIL_HOST=127.0.0.1/MAIL_HOST=mailhog/' .env
    sed -i 's/MAIL_PORT=2525/MAIL_PORT=1025/' .env
    
    # Add missing mail encryption setting
    echo "MAIL_ENCRYPTION=null" >> .env
    
    # Update APP_URL
    sed -i 's/APP_URL=http:\/\/localhost/APP_URL=http:\/\/localhost:8000/' .env
fi

# Install PHP dependencies
echo "📦 Installing PHP dependencies..."
composer install --no-interaction --prefer-dist --optimize-autoloader

# Install Node.js dependencies
echo "📦 Installing Node.js dependencies..."
npm install

# Generate application key
echo "🔑 Generating application key..."
php artisan key:generate --ansi

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
while ! pg_isready -h postgres -p 5432 -U laravel -d laravel -q 2>/dev/null; do
    sleep 1
done

# Run database migrations
echo "🗄️ Running database migrations..."
php artisan migrate --force --seed

# Create storage link
echo "🔗 Creating storage link..."
php artisan storage:link

# Clear and cache config
echo "🧹 Clearing and caching configuration..."
php artisan config:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set proper permissions
echo "🔒 Setting proper permissions..."
chmod -R 775 storage bootstrap/cache
chmod +x artisan

# Create useful aliases
echo "⚙️ Setting up aliases..."
cat >> ~/.bashrc << 'EOF'

# Laravel Artisan aliases
alias art='php artisan'
alias tinker='php artisan tinker'
alias migrate='php artisan migrate'
alias seed='php artisan db:seed'
alias serve='php artisan serve --host=0.0.0.0 --port=8000'
alias test='php artisan test'
alias pint='vendor/bin/pint'

# Laravel Sail aliases (if available)
alias sail='vendor/bin/sail'

# Composer aliases
alias comp='composer'
alias compd='composer dump-autoload'

# NPM/Node aliases
alias dev='npm run dev'
alias build='npm run build'
alias watch='npm run dev -- --watch'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# Quick Laravel commands
alias fresh='php artisan migrate:fresh --seed'
alias cache='php artisan cache:clear && php artisan config:clear && php artisan view:clear && php artisan route:clear'
alias queue='php artisan queue:work'

EOF

echo "✅ Laravel development environment setup complete!"
echo ""
echo "🎉 Available commands:"
echo "  - php artisan (or 'art') - Laravel Artisan CLI"
echo "  - composer (or 'comp') - Composer package manager"
echo "  - npm - Node package manager"
echo "  - psql - PostgreSQL client (connect to: psql -h postgres -U laravel -d laravel)"
echo "  - redis-cli -h redis - Redis client"
echo ""
echo "🌐 Services:"
echo "  - Laravel app: http://localhost:8000 (run 'serve' or 'php artisan serve --host=0.0.0.0')"
echo "  - Vite dev server: http://localhost:5173 (run 'npm run dev')"
echo "  - PostgreSQL: localhost:5432 (user: laravel, password: password)"
echo "  - Redis: localhost:6379"
echo "  - MailHog: http://localhost:8025"
echo ""
echo "🚀 Quick start:"
echo "  1. Run 'serve' to start the Laravel development server"
echo "  2. Run 'npm run dev' in another terminal for Vite"
echo "  3. Visit http://localhost:8000 to see your app!" 