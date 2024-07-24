# tedge-archive-plugin

## Plugin summary

Manage simple archive packages (e.g. tarballs) on a device using thin-edge.io software management plugin api.

**Technical summary**

The following details the technical aspects of the plugin to get an idea what systems it supports.

|||
|--|--|
|**Languages**|`shell` (posix compatible)|
|**CPU Architectures**|`all/noarch`. Not CPU specific|
|**Supported init systems**|`N/A`|
|**Required Dependencies**|-|
|**Optional Dependencies (feature specific)**|-|

### How to do I get it?

The following linux package formats are provided on the releases page and also in the [tedge-community](https://cloudsmith.io/~thinedge/repos/community/packages/) repository:

|Operating System|Repository link|
|--|--|
|Alpine Linux (apk)|[![Latest version of 'tedge-archive-plugin' @ Cloudsmith](https://api-prd.cloudsmith.io/v1/badges/version/thinedge/community/alpine/tedge-archive-plugin/latest/a=noarch;d=alpine%252Fany-version/?render=true&show_latest=true)](https://cloudsmith.io/~thinedge/repos/community/packages/detail/alpine/tedge-archive-plugin/latest/a=noarch;d=alpine%252Fany-version/)|

### What will be deployed to the device?

* The following software management plugins which is called when installing and removing `archive` packages via Cumulocity IoT
    * `archive` - Manage (list/install/remove) packages using a tarball (gzip) format


## Plugin Dependencies

The following packages are required to use the plugin:

* Posix shell (`/bin/sh`)

## Package format

The software management plugin installs and removes archives (e.g. tarball) using a very simple packaging format which mirrors some of the Debian package format conventions.

The following Table

|Path|Description|
|----|-----------|
|`SCRIPTS/preinst`|Maintainer script which is executed prior to the archive being expanded. Must have `755` chmod permissions to be executed!|
|`SCRIPTS/postinst`|Maintainer script which is executed after the archive has been expanded. Must have `755` chmod permissions to be executed!|
|`*/*`|All other paths will be unpacked into the `ROOT_DIR` as defined in the `/etc/tedge/sm-plugins/archive` script|

The `ROOT_DIR` can be controlled by setting a dotenv file in the following location:

```sh
/etc/tedge-archive-plugin/env
```

```sh
# The root directory where all of the tars will be unpacked to
ROOT_DIR=/data
```

## Development

### Start demo

1. Start the demo

    ```sh
    just up
    ```

2. Bootstrap the device

    ```sh
    just bootstrap
    ```

### Stop demo

```sh
just down
```
