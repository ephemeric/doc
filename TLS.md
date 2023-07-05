# CN, SAN and TLS Verify across Different Clients

## TL; DR

*If no SAN v3 exts and only CN in cert this works!*

`curl` reports correctly at least, if we ignore the fact of why is the `CN` ignored:

```
*  subjectAltName does not match server.hotrod.local
```

OpenSSL client works out the box but the Rust clients are lame at logging.

## Logs

```
openssl s_client -connect server.hotrod.local:3002 </dev/null
CONNECTED(00000003)
depth=1 CN = hotrod, C = ZA, ST = Gauteng, L = Johannesburg, O = Hotrod
verify return:1
depth=0 CN = server.hotrod.local, C = ZA, ST = Gauteng, L = Johannesburg, O = Hotrod
verify return:1
---
Certificate chain
 0 s:CN = server.hotrod.local, C = ZA, ST = Gauteng, L = Johannesburg, O = Hotrod
   i:CN = hotrod, C = ZA, ST = Gauteng, L = Johannesburg, O = Hotrod
   a:PKEY: rsaEncryption, 4096 (bit); sigalg: RSA-SHA256
   v:NotBefore: Jun 22 11:28:53 2023 GMT; NotAfter: Jun 19 11:28:53 2033 GMT
---
Server certificate
-----BEGIN CERTIFICATE-----
ZF2TeFHCwk0JCApFrI6yUvctRYX9HxZRWG4oaiKJ8DdQmhAHfu/LzIO9xOE3NPva
o/Emt2HToI48t+wtSF4KgA5uhQ==
-----END CERTIFICATE-----
subject=CN = server.hotrod.local, C = ZA, ST = Gauteng, L = Johannesburg, O = Hotrod
issuer=CN = hotrod, C = ZA, ST = Gauteng, L = Johannesburg, O = Hotrod
---
No client certificate CA names sent
Peer signing digest: SHA512
Peer signature type: RSA-PSS
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 2371 bytes and written 401 bytes
Verification: OK
---
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Server public key is 4096 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
DONE
```

```
vagrant@pipes:~/tmp/rustls$ curl --cacert /etc/ssl/certs/ca-certificates.crt -vv https://server.hotrod.local:3002
* Uses proxy env variable no_proxy == 'hotrod.local,127.0.0.1,localhost'
*   Trying 192.168.235.10:3002...
* Connected to server.hotrod.local (192.168.235.10) port 3002 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
*  CAfile: /etc/ssl/certs/ca-certificates.crt
*  CApath: /etc/ssl/certs
* TLSv1.0 (OUT), TLS header, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS header, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS header, Finished (20):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.2 (OUT), TLS header, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=server.hotrod.local; C=ZA; ST=Gauteng; L=Johannesburg; O=Hotrod
*  start date: Jun 21 21:54:48 2023 GMT
*  expire date: Jun 18 21:54:48 2033 GMT
*  subjectAltName does not match server.hotrod.local
* SSL: no alternative certificate subject name matches target host name 'server.hotrod.local'
* Closing connection 0
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.3 (OUT), TLS alert, close notify (256):
curl: (60) SSL: no alternative certificate subject name matches target host name 'server.hotrod.local'
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

```
vagrant@pipes:~/tmp/rustls$ cargo run --bin tlsclient-mio -- --cafile /etc/ssl/certs/ca-certificates.crt -p 3002 --http server.hotrod.local
    Finished dev [unoptimized + debuginfo] target(s) in 0.06s
     Running `target/debug/tlsclient-mio --cafile /etc/ssl/certs/ca-certificates.crt -p 3002 --http server.hotrod.local`
TLS error: InvalidCertificate(NotValidForName)
Connection closed
```

Verbose output the same useless info:

```
vagrant@pipes:~$ ./tlsclient-mio --verbose --cafile /etc/ssl/certs/ca-certificates.crt -p 3002 --http server.hotrod.local
[2023-06-22T12:30:04Z DEBUG rustls::anchors] add_parsable_certificates processed 127 valid and 0 invalid certs
[2023-06-22T12:30:04Z DEBUG rustls::client::hs] No cached session for DnsName("server.hotrod.local")
[2023-06-22T12:30:04Z DEBUG rustls::client::hs] Not resuming any session
[2023-06-22T12:30:04Z TRACE rustls::client::hs] Sending ClientHello Message {
        version: TLSv1_0,
        payload: Handshake {
            parsed: HandshakeMessagePayload {
                typ: ClientHello,
                payload: ClientHello(
                    ClientHelloPayload {
                        client_version: TLSv1_2,
                        random: 05c57b96f4ea7e5ec27b7ddfd9f22e57ea43423aaf32821f06cfd420e80b058b,
                        session_id: 6edce8cbcc7783b82363f217305b2dda68cf26ac281bb663b94baee0616f19a1,
                        cipher_suites: [
                            TLS13_AES_256_GCM_SHA384,
                            TLS13_AES_128_GCM_SHA256,
                            TLS13_CHACHA20_POLY1305_SHA256,
                            TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
                            TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
                            TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256,
                            TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
                            TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
                            TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256,
                            TLS_EMPTY_RENEGOTIATION_INFO_SCSV,
                        ],
                        compression_methods: [
                            Null,
                        ],
                        extensions: [
                            SupportedVersions(
                                [
                                    TLSv1_3,
                                    TLSv1_2,
                                ],
                            ),
                            ECPointFormats(
                                [
                                    Uncompressed,
                                ],
                            ),
                            NamedGroups(
                                [
                                    X25519,
                                    secp256r1,
                                    secp384r1,
                                ],
                            ),
                            SignatureAlgorithms(
                                [
                                    ECDSA_NISTP384_SHA384,
                                    ECDSA_NISTP256_SHA256,
                                    ED25519,
                                    RSA_PSS_SHA512,
                                    RSA_PSS_SHA384,
                                    RSA_PSS_SHA256,
                                    RSA_PKCS1_SHA512,
                                    RSA_PKCS1_SHA384,
                                    RSA_PKCS1_SHA256,
                                ],
                            ),
                            ExtendedMasterSecretRequest,
                            CertificateStatusRequest(
                                OCSP(
                                    OCSPCertificateStatusRequest {
                                        responder_ids: [],
                                        extensions: ,
                                    },
                                ),
                            ),
                            ServerName(
                                [
                                    ServerName {
                                        typ: HostName,
                                        payload: HostName(
                                            DnsName(
                                                "server.hotrod.local",
                                            ),
                                        ),
                                    },
                                ],
                            ),
                            SignedCertificateTimestampRequest,
                            KeyShare(
                                [
                                    KeyShareEntry {
                                        group: X25519,
                                        payload: 016781c63b7a9d109fd60599fc0d295fdc582a016aad97e190d13cdfffe28273,
                                    },
                                ],
                            ),
                            PresharedKeyModes(
                                [
                                    PSK_DHE_KE,
                                ],
                            ),
                            SessionTicket(
                                Request,
                            ),
                        ],
                    },
                ),
            },
            encoded: 010000f1030305c57b96f4ea7e5ec27b7ddfd9f22e57ea43423aaf32821f06cfd420e80b058b206edce8cbcc7783b82363f217305b2dda68cf26ac281bb663b94baee0616f19a10014130213011303c02cc02bcca9c030c02fcca800ff01000094002b00050403040303000b00020100000a00080006001d00170018000d00140012050304030807080608050804060105010401001700000005000501000000000000001800160000137365727665722e686f74726f642e6c6f63616c00120000003300260024001d0020016781c63b7a9d109fd60599fc0d295fdc582a016aad97e190d13cdfffe28273002d0002010100230000,
        },
    }
[2023-06-22T12:30:04Z TRACE mio::poll] registering event source with poller: token=Token(0), interests=WRITABLE
[2023-06-22T12:30:04Z TRACE mio::poll] reregistering event source with poller: token=Token(0), interests=READABLE
[2023-06-22T12:30:04Z TRACE rustls::client::hs] We got ServerHello ServerHelloPayload {
        legacy_version: TLSv1_2,
        random: 5d5e1e5b05dbcec103c6eedf6a16325e3836e61111bd1a559aeff58e463530ed,
        session_id: 6edce8cbcc7783b82363f217305b2dda68cf26ac281bb663b94baee0616f19a1,
        cipher_suite: TLS13_AES_256_GCM_SHA384,
        compression_method: Null,
        extensions: [
            KeyShare(
                KeyShareEntry {
                    group: X25519,
                    payload: d52706737817cdc5b5d252d248a4bd3dcdbbaabf9c6d6b22b237fd1f89007a44,
                },
            ),
            SupportedVersions(
                TLSv1_3,
            ),
        ],
    }
[2023-06-22T12:30:04Z DEBUG rustls::client::hs] Using ciphersuite TLS13_AES_256_GCM_SHA384
[2023-06-22T12:30:04Z DEBUG rustls::client::tls13] Not resuming
[2023-06-22T12:30:04Z TRACE rustls::client::client_conn] EarlyData rejected
[2023-06-22T12:30:04Z TRACE rustls::conn] Dropping CCS
[2023-06-22T12:30:04Z DEBUG rustls::client::tls13] TLS1.3 encrypted extensions: [ServerNameAck]
[2023-06-22T12:30:04Z DEBUG rustls::client::hs] ALPN protocol is None
[2023-06-22T12:30:04Z TRACE rustls::client::tls13] Server cert is [Certificate(b"0\x82\x05\xfa0\x82\x03\xe2\xa0\x03\x02\x01\x02\x02\x14\x07\r\x0c\xd2\xdd\xbb\xbe\xe6\xb4\xf3\x91\xcf\xd8\x1c%\x1b\x7f\xdf\x12\xd70\r\x06\t*\x86H\x86\xf7\r\x01\x01\x0b\x05\00X1\x0f0\r\x06\x03U\x04\x03\x0c\x06hotrod1\x0b0\t\x06\x03U\x04\x06\x13\x02ZA1\x100\x0e\x06\x03U\x04\x08\x0c\x07Gauteng1\x150\x13\x06\x03U\x04\x07\x0c\x0cJohannesburg1\x0f0\r\x06\x03U\x04\n\x0c\x06Hotrod0\x1e\x17\r230622122409Z\x17\r330619122409Z0e1\x1c0\x1a\x06\x03U\x04\x03\x0c\x13server.hotrod.local1\x0b0\t\x06\x03U\x04\x06\x13\x02ZA1\x100\x0e\x06\x03U\x04\x08\x0c\x07Gauteng1\x150\x13\x06\x03U\x04\x07\x0c\x0cJohannesburg1\x0f0\r\x06\x03U\x04\n\x0c\x06Hotrod0\x82\x02\"0\r\x06\t*\x86H\x86\xf7\r\x01\x01\x01\x05\0\x03\x82\x02\x0f\00\x82\x02\n\x02\x82\x02\x01\0\x91\xack\xf5-\x8ey\xab\x87\x13K\x99yR\x19\x9b$q\xd8D\xc6\x17Z\x94\xb8\xbf\xc0\"\xc4\xeb\xc0\x16 \x93\xb6\xa0{\xe3@\xcd\xb3*5\x15>^P\xa4\x18\xc9v\xf34\x8c:\x0c#ZI\xd6\xc4\xb5p\x1bK~\x1c\xd4\x03\xee\x98\r\xafx\rmX\xe5\xc9\xe7P+\xb7\"'X\x91f\xf6\x0eA+P_u\xc6\x86\x14\xd4.\x89}R\xed\xe8_\x88{\x15\xfe\x8dE\xd4j\x05\xdf0\xa9l2\xe9\xa6\0%\xc6\xcfe\xea\0=)\xe6[a$h:Od\xa2\x97\xed\xf9\x08\x94\xf3\xe0\x1c\xb1=\xf8\xc6\xa3dN\xe48\xab\xa5+ \x08-\xe3r\x84P\x10\xf8\xdf\xe8\xeca:LWnX\xa5\xa0\x0f?13\xe38@\xa7\xbe\x8e\x9d\xae\xc9\0?\x19\t\xda\xab\x7f\xec>=\x87\xf4F\xd0&\xae\xd9Ym\xe1\xff\x1c;&+t\0\xf8\x17\xa21\x88\xd4\xce&mp\x9f\x83\x97m4y\x1c\x89_\xc6\xa9c\xeaX\xfd\xa6\xf6\xd6\xa1b\x0bE\xea\xdc\xfe\x1d\xa1h\x9d\xbd\xd7\xb6\xd7\xfa\xb6?\x1d\x1b\xd3\x02T\xf1\xe5\xed\xe3\x8c\xadp\x02\x11\xde<i\xa3[=g\xfdH\xee\x10\x08}&ZN\xf2w\xd8\xa1\xa3\x1f\x90\x1c\xa0\xfb\xb0\xda\xca\xce\x1b\\\xe6\x08(\xda\xc4\xf8R_\xb9\xaf\xf9\x1e\xab\x18\xa5\xda~\xe9\x93V\xca\"\xc1+ h\xcd\x96\xe8\xd9%\xb2r'>\xb1:\x81\xc3\xdco\xf1}\xdb\xd3\xa7\xda\xda\xef\xd7S/^\xb1\xf3\x18\x87a)9of\xee\xc7\xeb\xfb\xcf\xa6\xb7\x1f,\xe5\xadp\x9c\x03?|\xe8\x90\xa8\x9f\xfa=\xda\xa9\xb4/\x96\xe5\x1e\x9c\xe2\x1b\x11\xda\xbf\xb2|5\x7f\x87\x9b\xd6\x84H\xc08\xda\xe4E\xba8\xaaL\xa2u&\xc3\x0b=*\xc3\xf2\x17\x17\x9b\xb5\xf4\xb9{\xd3^\xffbmK\xb9b\x86\x13\x81\x98\xdeu|K\x90\xcb\xcf&\xb6Ut\xdb\xa6Rk\x8c1\x84\x93\x83~\xc1U\xc7\x0c\xf1\x87\x0c\xc1h\x83\xda\xc8\x0e:O\xff\x0c\x106z}C\xee\xf1\x80\x01>\xf0Ic*g\x88#2\xd9\x02\x03\x01\0\x01\xa3\x81\xae0\x81\xab0\x1f\x06\x03U\x1d#\x04\x180\x16\x80\x14\xab\x05Y\xf3\x9czx\x89{cR>G\xdf\xd5\xc9\xe0\xcdD\xbb0\t\x06\x03U\x1d\x13\x04\x020\00\x0b\x06\x03U\x1d\x0f\x04\x04\x03\x02\x04\xf00Q\x06\x03U\x1d\x11\x04J0H\x82\x14server1.hotrod.local\x82\x14server2.hotrod.local\x82\x14server3.hotrod.local\x87\x04\xc0\xa8\xeb\n0\x1d\x06\x03U\x1d\x0e\x04\x16\x04\x14[\x18\xaf\xe3~\xa3\x8dzP^|C]\xa8\xac\x8a7\xe1<\x800\r\x06\t*\x86H\x86\xf7\r\x01\x01\x0b\x05\0\x03\x82\x02\x01\0\00tM\\v\x96\x1c1\xb6?\xfa\xd9\xfe\x9b1J\xac\xfc\x1e4\x9d\x7f\xde\x99\xd5\xf5\x11\0\xff\xaf\x13#\x1eyD\nkG\xadv\x9c{\xf2\xbf\x8d\xeah'p\x0c\xf6\xcbEIj\x89\xbf\xc8\xe5\x19\xb0\x8c\r\xa0\x15\x13\xbb\xd5B\xb9\xab\xe9Il\x05\x8d!\x84\xa1#9\x85\xebg0\x06\xd7,2\xd2\x8bb\xffE#\xe8\x9bN\x1f\x95X\x9d~\xb7\xaa\0\xc0?\x1e\x0f\xfb\x02\xc2\xaa[7\xe3\xa5\xc8\xe2&\x017\xaaA\x0c~z\x7f/\xf3\xd9\x96\x97.\x06\xfe\xe4\t\xf4\x84\x91\x17\x150\x9b\x89\xf5\xbc\xb6\xea=\xbd;\x19\xf1\xca&\x9bYL\x0c3!S\xb2\xe8\xbe\xdb\x05,\xe1\x9a[H\xb6?lF\xe0\xe3S\xd5j@9\xab\xdeJ\xcc\xeaJ\xc5Wbd\x04\t\x8c'{T\x1c4\xa6@\x87\xe1\x18\xca\xa1\xbc\x03\xa5~T9\xb0\x8c\xa5q\x93\xfbc\xd3\x97\xf4H\x16q\\\x1cm\xbev.\xebE|\xa5\xabD\xcc\x87E\xfc\x853\x959\xcd<~u*\x9e\x95\x07=l\xceC\xc1?Y\xf6b\xcc@=\xea\xc9\xfe\xc4^\x12P\xb0\x8b\xcff\x87%\xb0\xa3\xadA\"G\x82\xf0\x18\x91\xd7!0z\n\xe4(\xfc\xae\xa0ZF\x1d\xf6\x06\xbd\x89\xb6\x1d\x17\xae\x0e\x97DBp\xc5\xfb\x0c+2\xb1\xae\xa8\x98\x15O\xf2\xe4\xa8\xc9\xff\xa2\x06\xda\xc4\x17p\x8aPV\xca\x90\xd0\x18\xaah\xf4\xd2\x0f?\xc0\x8b\x0b\xa8\xa0\xbb\xc2\xf9v\x8b\xbdT\x85\xe4\xf7G\0w\xfe\x95#W\x1a\xf8:\x1a\xba\xe6\xfcR\xf5\x15\xf0J\xcf<,\x19?-\xda\x1e\xfa\xd4\xfa\x9cP\xd3\xdd\xee?\x85\xd40H\xe6\"B\xf5\xf7\x07\xf8D\xf6\x8f\xe1\x80\xe5\x8f\x15\xd7\xc0\x8e\xcf\x8d\x1b\x1b\xa5\xaah\xe1\xd9\xe4m\x05\xf2\x14:\xd9B\xab\t\x01\x9d\xe0\xdb\xbd\x87\xfc\x98\xf9,\x8fJ\xd7\xd6\x9f7\xeb\xcd\xad4\xaf\x8f\x05\xbb\xc2\x89~\xc8\t`3\xdb\xdc$\xec\x9c\xf2qe\x92\x04\xc7\xa3z1\xa96+\xc2i\x9b\xe8ug\xea@\xe9\xea\xd1\xeb\x05\xf5\x1e\xefn")]
TLS error: InvalidCertificate(NotValidForName)
Connection closed
```

```
vagrant@pipes:~$ curl --cacert /etc/ssl/certs/ca-certificates.crt -vv https://server.hotrod.local:3002
* Uses proxy env variable no_proxy == 'hotrod.local,127.0.0.1,localhost'
*   Trying 192.168.235.10:3002...
* Connected to server.hotrod.local (192.168.235.10) port 3002 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
*  CAfile: /etc/ssl/certs/ca-certificates.crt
*  CApath: /etc/ssl/certs
* TLSv1.0 (OUT), TLS header, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS header, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS header, Finished (20):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.2 (OUT), TLS header, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: CN=server.hotrod.local; C=ZA; ST=Gauteng; L=Johannesburg; O=Hotrod
*  start date: Jun 22 11:28:53 2023 GMT
*  expire date: Jun 19 11:28:53 2033 GMT
*  subjectAltName: host "server.hotrod.local" matched cert's "server.hotrod.local"
*  issuer: CN=hotrod; C=ZA; ST=Gauteng; L=Johannesburg; O=Hotrod
*  SSL certificate verify ok.
* Using HTTP2, server supports multiplexing
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* Using Stream ID: 1 (easy handle 0x55f1b9436e90)
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
> GET / HTTP/2
> Host: server.hotrod.local:3002
> user-agent: curl/7.81.0
> accept: */*
>
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* Connection state changed (MAX_CONCURRENT_STREAMS == 4294967295)!
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
< HTTP/2 200
< content-type: text/html; charset=utf-8
< date: Thu, 22 Jun 2023 11:46:12 GMT
< content-length: 553
<
* TLSv1.2 (IN), TLS header, Supplemental data (23):
<!DOCTYPE html>
<html lang="en" data-theme="default01">
    <head>
        <title>Hotrod Admin</title>
        <meta charset="UTF-8">
        <meta name="description" content="Hotrod Cloud" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <link rel="icon" type="image/png" href="./favicon.ico" />
        <script defer src="/bundle.js"></script>
        <link rel="stylesheet" href="/main.css" />
        <link rel="stylesheet" href="/bundle.css" />
    </head>
    <body style="height: 100vh;"></body>
</html>
* Connection #0 to host server.hotrod.local left intact
```

```
./tlsclient-mio --cafile /etc/ssl/certs/ca-certificates.crt --http -p 3002 server.hotrod.local
HTTP/1.0 200 OK
content-type: text/html; charset=utf-8
content-length: 553
date: Thu, 22 Jun 2023 11:36:23 GMT

<!DOCTYPE html>
<html lang="en" data-theme="default01">
    <head>
        <title>Hotrod Admin</title>
        <meta charset="UTF-8">
        <meta name="description" content="Hotrod Cloud" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <link rel="icon" type="image/png" href="./favicon.ico" />
        <script defer src="/bundle.js"></script>
        <link rel="stylesheet" href="/main.css" />
        <link rel="stylesheet" href="/bundle.css" />
    </head>
    <body style="height: 100vh;"></body>
</html>
Connection closed
```

## Notes

It is not enough to have `CN=server.hotrod.local` in the cert, must have SAN entry too:

```
# Create a v3 ext file for SAN properties.
cat >$MYCERT.v3.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = server.hotrod.local
DNS.2 = server1.hotrod.local
DNS.3 = server2.hotrod.local
DNS.4 = server3.hotrod.local
IP.1 = 192.168.235.10
EOF
```

`openssl s_client` without SAN match _works_!

`reqwest` with `rust-native-tls` (`openssl` uses system cert store) fails: host mismatch when no SAN match:

```
Jun 21 20:17:51 splunk hotrod[13738]: 2023-06-21T20:17:51.613Z ERROR hotrod > Failed to start agent RunAgentError("Failed to instantiate agent id: AgentInitialisationError(\"Failed to auto enroll agent: reqwest::Error { kind: Request, url: Url { scheme: \\\"https\\\", cannot_be_a_base: false, username: \\\"\\\", password: None, host: Some(Domain(\\\"server.hotrod.local\\\")), port: Some(3002), path: \\\"/api/v1/agents/enroll\\\", query: None, fragment: None }, source: hyper::Error(Connect, Ssl(Error { code: ErrorCode(1), cause: Some(Ssl(ErrorStack([Error { code: 337047686, library: \\\"SSL routines\\\", function: \\\"tls_process_server_certificate\\\", reason: \\\"certificate verify failed\\\", file: \\\"ssl/statem/statem_clnt.c\\\", line: 1921 }]))) }, X509VerifyResult { code: 62, error: \\\"Hostname mismatch\\\" })) }\")")
```

`reqwest` with `rust-tls` fails: I don't know how to add `/etc/ssl/certs/ca-certificates` as a CA file to client?

`curl` without SAN match fails.

`tlsclient` without SAN match fails.
