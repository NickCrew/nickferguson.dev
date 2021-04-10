{
    "title": "Foreman and FreeIPA Realm Integration",
    "date": "2021-04-10"
}


A configuration by which  hosts created with Foreman auto-join your FreeIPA Realm and registered as IPA hosts

> Note: This guide was originally written to target Redhat 7

---

### FreeIPA Host

We need to create an IPA user for foreman. I used *"foreman-user"* but you can choose something different if you'd like. This article will assume *"foreman-user"*. Avoid foreman-proxy or other usernames that occur as users on the Foreman host. Assign this user the __role__ of *Smart Proxy Host Manager*.

Before beginning, your Foreman host needs to be registered as an IPA host. 

	$ ipa-client-install


We need to create a __service__ for the Foreman proxy.  

If you're using the FreeIPA webui:  

> *Identity* => *Services* => *"add +"*

#### Example

> foremanproxy/foreman.example.com@EXAMPLE.COM

---

### Foreman Host

You need to install the `ipa-admintools` package:  

	$ yum install ipa-admintools
	$ foreman-prepare-realm admin foreman-user
  

Now we need to edit some config files.

##### */etc/foreman-proxy/settings.d/freeipa_realm.yml*

````bash
# /etc/foreman-proxy/settings.d/freeipa_realm.yml

# Authentication for Kerberos-based Realms
:keytab_path: /etc/foreman-proxy/freeipa.keytab
:principal: foreman-user@EXAMPLE.COM

:ipa_config: /etc/ipa/default.conf
# Remove from DNS when deleting the FreeIPA entry
:remove_dns: true
````


##### */etc/foreman-proxy/settings.d/realm.yml*

````bash
# /etc/foreman-proxy/settings.d/realm.yml

# Can be true, false, or http/https to enable just one of the protocols
:enabled: true

# Available providers:
#   realm_ad
#   realm_freeipa
:use_provider: realm_freeipa
````

---

### FreeIPA Host
Copy the keytab from the IPA server, where *freeipa* is the hostname of your IPA server and *foremanproxy* is the name of the service:

	$ ipa-getkeytab -s freeipa.example.com -p foremanproxy/freeipa.example.com -k /etc/krb5.keytab *

Copy the keytab to the appropriate location.

	$ cp freeipa.keytab /etc/foreman-proxy/freeipa.keyab


Make the foreman-proxy user owner and set correct permissions.

	$ chown foreman-proxy /etc/foreman-proxy/freeipa.leytab
	$ chmod 600 /etc/foreman-proxy/freeipa.keytab
	$ cp /etc/ipa/ca.crt /etc/pki/ca-trust/source/anchors/ipa.crt
	$ update-ca-trust enable && update-ca-trust
	$ systemctl restart foreman-proxy

Test the keytab is present.

````bash
$ sudo -u foreman-user kinit -k -t /etc/foreman-proxy/freeipa.keytab foreman-user
````

You should now be able to select your realm in the Foreman webui  

> *Infrastructure* => *Realms*

Ensure your provisioning template calls the `freeipa_register` snippet. Read over the snippet to see optional host parameters you may set.  


*If you are using FreeIPA as your DNS server and you would like the records automatically updated, set the following host parameter:*

> `Name: `freeipa_opts Value: Î-enable-dns-updates`


*If you are using the automount feature of FreeIPA:*

> `Name: freeipa_automount Value: true`

Now when you create a host, as long as you have your realm selected, it should automatically join the realm and register with the server.  


