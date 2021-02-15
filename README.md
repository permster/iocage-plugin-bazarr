# iocage-plugin-lazylibrarian
## Post install steps
### Add permissions using FreeNAS 11.3 ACL manager
1. Click the three dots next to the media dataset; in this example, it is called "media"
2. Select "Edit ACL"
3. Click the "Add ACL Item" button. A new section will appear at the bottom of the list of existing ACL items.
4. Fill in the following (*note that 351 is the correct user here*):

![ACL Permissions](https://static.ixsystems.co/uploads/2020/02/pasted-image-0-1.png)

Don't worry if it says "Could not find a username for this ID"
5. If files already exist in the dataset, select the "Apply permissions recursively" checkbox.
6. Click "Save"

### Stop the services
```
iocage exec jail_name "service lazylibrarian stop"
```
### Add mount points
```
iocage fstab -a jail_name /mnt/pool-1/apps/lazylibrarian /config nullfs rw 0 0
iocage fstab -a jail_name /mnt/pool-1/multimedia/books /media/ nullfs rw 0 0
```
### Update file ownerships (optional)
```
iocage exec jail_name "chown -R lazylibrarian:lazylibrarian /config"
```
### Start the services
```
iocage exec jail_name "service lazylibrarian start"
```
