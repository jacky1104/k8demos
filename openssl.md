### P12 to key and crt

```$markdown
// this will not promote `Enter PEM pass phrase`
openssl pkcs12 -nodes -nocerts -in server.p12 -out server.pem
openssl pkcs12 -nodes -in filename.pfx -clcerts -nokeys -out filename.crt

// this will promote `Enter PEM pass phrase`
openssl pkcs12 -in filename.pfx -nocerts -out filename.key
openssl pkcs12 -in filename.pfx -clcerts -nokeys -out filename.crt
openssl pkcs12 -in filename.pfx -clcerts -nokeys -nodes -out filename.crt

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
openssl pkcs12 -in wildcard.forticloud.com.p12 -out certificate.pem -nodes cat certificate.pem | openssl x509 -noout
-enddate

```

### verify certificate

```
 openssl x509 -in file.crt  -text -noout

```

### Generate a Self-Signed Certificate from an Existing Private Key and CSR

```markdown
openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt
```

### get the certificate from url

```markdown
openssl s_client -connect globalaptctrl.fortinet.com:443
```

### Check a pkcs#12 files

```markdown
openssl pkcs12 -info -in keyStore.p12
```

### check csr

```markdown
openssl req -text -noout -verify -in domain.csr
```

### check private key

```markdown
openssl rsa -in private.key -check
```

### check certificate

```markdown
openssl x509 -in certificate.crt -text -noout
```

### validate the cert from some host

```markdown
openssl s_client -showcerts -connect host:443 | openssl x509 -outform PEM >mycertfile.pem openssl x509 -enddate -noout
-in mycertfile.pem

```

### Add the server cert to the client truststore

```markdown
cd $JAVA_HOME/bin/

keytool -importcert -alias {cert_alias} -file {cert location} -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts -storetype JKS
```

### download the cert via openssl

```markdown
openssl s_client -showcerts -connect {{host}}:443 | openssl x509 -outform PEM > mycertfile.pem
```

### cer to crt

```markdown
openssl x509 -inform DER -in certificate.cer -out certificate.crt

openssl x509 -inform PEM -in certificate.cer -out certificate.crt
```


### generate p12 with keytool
```markdown
keytool -genkeypair -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore jacky.p12 -validity 365
```
```markdown
1.Generate 2048-bit RSA private key:

openssl genrsa -out key.pem 2048
2. Generate a Certificate Signing Request:

3. openssl req -new -sha256 -key key.pem -out csr.csr
Generate a self-signed x509 certificate suitable for use on web servers.

openssl req -x509 -sha256 -days 365 -key key.pem -in csr.csr -out certificate.pem
4. Create SSL identity file in PKCS12 as mentioned here

openssl pkcs12 -export -out client-identity.p12 -inkey key.pem -in certificate.pem

```


### How to verify crt and key

```markdown
openssl x509 -noout -modulus -in server.crt| openssl md5
openssl rsa -noout -modulus -in server.key| openssl md5
```
