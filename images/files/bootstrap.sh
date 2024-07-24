#!/bin/sh
tedge cert create --device-id "$DEVICE_ID" ||:
tedge config set c8y.url "$C8Y_BASEURL"

#
# Upload cert if credentials are available
if [ -n "$C8Y_PASSWORD" ] && [ -n "$C8Y_USER" ]; then
    env C8YPASS="$C8Y_PASSWORD" tedge cert upload c8y --user "$C8Y_USER" ||:
fi

sleep 5

tedge connect c8y
