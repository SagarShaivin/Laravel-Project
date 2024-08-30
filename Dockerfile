# Use the official PHP image with Apache
FROM php:8.2-apache

# Set the working directory
WORKDIR /var/www/html

# Install necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Copy the existing Laravel project to the container
COPY . /var/www/html

# Set file permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port 8000 and run the Laravel development server
EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000
