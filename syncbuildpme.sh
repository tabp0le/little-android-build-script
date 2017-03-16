repo sync && . build/envsetup.sh && breakfast pme && make installclean && brunch pme && . build/upload-sftp android@ustx2.safesecure.host:/var/www/vhosts/androidbuilds.spryservers.net/httpdocs/rr/pme/stable/ $OUT/*RR-N* -oIdentityFile=~/.ssh/androidbuild


