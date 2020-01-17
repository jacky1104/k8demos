### P12 to key and crt 
```$markdown
openssl pkcs12 -in filename.pfx -nocerts -out filename.key
openssl pkcs12 -in filename.pfx -clcerts -nokeys -out filename.crt

```

### key and crt to p12

```markdown
openssl pkcs12 -export -in two.crt -inkey two.key -out two.p12
```


### generate new key and crt

```markdown
openssl req -newkey rsa:2048 -nodes -keyout domain.key -x509 -days 365 -out domain.crt
```


### check expire date of p12
```markdown
openssl pkcs12 -in wildcard.forticloud.com.p12  -out certificate.pem -nodes
cat certificate.pem | openssl x509 -noout -enddate

```

### verify certificate
```
 openssl x509 -in file.crt  -text -noout

```