# SHIELD MySQL / MariaDB Add-on

This BOSH release provides add-on tools for augmenting SHIELD
Agents with various versions of the MySQL / MariaDB command-line
utilities for backup and restore: mysql, and mysqldump.

## Versions

The following versions are currently available:

 - **MySQL** - Oracle MySQL
   - **5.7.43** via `shield-addon-mysql-5.7` for Jammy
   - **8.0.34** via `shield-addon-mysql-8.0` for Jammy

Note: These are built from source and may need large compilation VM's

Need a version we don't (yet) support?  Open a [Github Issue][bug]
asking that we package it up.  If possible, supply which package
(Oracle MySQL, F/OSS MariaDB, or xtrabackup), the full version,
and a link to the canonical download page.

## Using this BOSH Release

**Note:** This BOSH release is not intended to stand on its own.
It exists to augment the `shield-agent` job of the [SHIELD BOSH
Release][1], and only in cases where the mysql / mysqldump utilities
are missing.

To colocate this BOSH release with your shield-agent instance
group, just add a new job to the group:

```yaml
instance_groups:
  - name: whatever
    jobs:
      # ...
      - name:    shield-addon-mysql-8.0
        release: shield-addon-mysql
```

That's really all there is to it.

[bug]: https://github.com/shieldproject/shield-addon-mysql-boshrelease/issues
[1]:   https://github.com/starkandwayne/shield-boshrelease
