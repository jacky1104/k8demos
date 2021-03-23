How to add Nginx instances via docker?

1. In /home/gui folder, generate a self signed key and crt.
```
openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -days 365 -out server.crt
```

2. Encrypt the server.key
```
openssl rsa -des3 -in unencrypted.key -out encrypted.key
```

How to verify the password?
```
openssl rsa  -in encrypted.key  -out decrypted.key
```

Put the password in password.txt file.

3. Prepare the nginx config file
```
server {
       listen         443 ssl;
       server_name    sandboxgui.fortinet.com;
       ssl_certificate /home/gui/server.crt;
       ssl_certificate_key /home/gui/server_encrypted.key;
       ssl_password_file /home/gui/password.txt;
       location / {
           proxy_pass http://172.16.97.25:8082;
       }
}
```

4. Start the nginx container
```
docker run -ti --name nginx_gui -d -p 9443:443 -v /home/gui/default.conf:/etc/nginx/conf.d/default.conf:ro -v /home/gui/:/home/gui/ nginx:1.19
```
