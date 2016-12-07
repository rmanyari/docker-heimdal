#!/bin/bash
/usr/heimdal/libexec/kdc&
/usr/heimdal/sbin/kadmin -l add --password=Passw0rd --use-defaults bob && echo "Passw0rd" > /opt/bob-pass
/usr/heimdal/bin/kinit --password-file=/opt/bob-pass bob
/usr/heimdal/bin/klist -l