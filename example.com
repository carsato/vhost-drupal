<VirtualHost *:80>
  ServerAdmin info@example.com
  ServerName  example.com
  ServerAlias *.example.com
  ServerAlias myexample.com
  ServerAlias *.myexample.com
  
  DocumentRoot /var/www/example.com/htdocs
  <Directory /var/www/example.com/htdocs/>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    
    RewriteEngine on
    RewriteBase /
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ index.php?q=$1 [L,QSA]
    
    Order allow,deny
    allow from all
  </Directory>
  
  # Possible values include: debug, info, notice, warn, error, crit,
  # alert, emerg.
  LogLevel warn
  
  ErrorLog /var/www/example.com/logs/error.log
  CustomLog /var/www/example.com/logs/access.log combined
</VirtualHost>

