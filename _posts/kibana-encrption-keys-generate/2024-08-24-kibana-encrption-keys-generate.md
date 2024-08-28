---
layout: post
title: "kibana-encrption-keys generate"
date: 2024-08-24 02:47:23 +0900
categories: []
tags: []
---

```console
kibana@d5bd29eeb88a:~$ kibana-encryption-keys generate
## Kibana Encryption Key Generation Utility

The 'generate' command guides you through the process of setting encryption keys for:

xpack.encryptedSavedObjects.encryptionKey
    Used to encrypt stored objects such as dashboards and visualizations
    https://www.elastic.co/guide/en/kibana/current/xpack-security-secure-saved-objects.html#xpack-security-secure-saved-objects

xpack.reporting.encryptionKey
    Used to encrypt saved reports
    https://www.elastic.co/guide/en/kibana/current/reporting-settings-kb.html#general-reporting-settings

xpack.security.encryptionKey
    Used to encrypt session information
    https://www.elastic.co/guide/en/kibana/current/security-settings-kb.html#security-session-and-cookie-settings


Already defined settings are ignored and can be regenerated using the --force flag.  Check the documentation links for instructions on how to rotate encryption keys.
Definitions should be set in the kibana.yml used configure Kibana.

Settings:
xpack.encryptedSavedObjects.encryptionKey: 43f1e85494ec78b6459d4226cc64d6f7
xpack.reporting.encryptionKey: 6efc65c72ba44cb08ec23281be8eebe1
xpack.security.encryptionKey: 3ef3849bc4705f5ec45191b0321fe223

```
