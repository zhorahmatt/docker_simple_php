FROM php:alpine

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN mkdir /app
# Copy semua source code ke directory /app dalam docker container
ADD . /app
# Semacam cd (pindah directory) ke /app
WORKDIR /app

RUN composer config -g repo.packagist composer https://packagist.org

RUN composer config -g github-protocols https ssh

RUN composer install

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080"]