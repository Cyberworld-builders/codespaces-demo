FROM mcr.microsoft.com/devcontainers/php:1-8.2-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    postgresql-client \
    redis-tools \
    supervisor \
    cron \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_pgsql \
    pdo_sqlite \
    pgsql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    xml \
    zip

# Install Redis PHP extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Node.js 20.x
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Create vscode user
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid vscode --shell /bin/bash --create-home vscode \
    && echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set user permissions for Laravel directories
RUN mkdir -p /workspace && chown -R vscode:vscode /workspace

# Switch to vscode user
USER vscode

# Install global Composer packages
RUN composer global require laravel/installer laravel/valet

# Add Composer global bin to PATH
ENV PATH="/home/vscode/.composer/vendor/bin:${PATH}"

# Install global npm packages
RUN npm install -g @vue/cli npm-check-updates

WORKDIR /workspace

# Keep container running
CMD ["sleep", "infinity"] 