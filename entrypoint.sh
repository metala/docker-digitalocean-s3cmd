#!/bin/sh

DATACENTERS="AMS2 AMS3 BLR1 FRA1 LON1 NYC1 NYC2 NYC3 SFO1 SFO2 SGP1 TOR1"

#
# Validate environment variables
#
REGION="${DATACENTER_REGION}"
if ! echo -n " $DATACENTERS" | grep -q " ${REGION} "; then
    echo "WARNING: Unknown datacenter region '$REGION'."
    echo "> List of known datacenters: $DATACENTERS"
fi

#
# Replace key and secret in the /.s3cfg file with the one the user provided
#
REGION_LCASE=`echo -n "${REGION}" | tr '[:upper:]' '[:lower:]'`
HOST_BASE="${HOST_BASE:-"${REGION_LCASE}.digitaloceanspaces.com"}"
HOST_BUCKET="${HOST_BUCKET:-"%(bucket).${HOST_BASE}"}"

cat >> /.s3cfg <<CONFIG
access_key = ${ACCESS_KEY}
secret_key = ${SECRET_KEY}
bucket_location = ${REGION}
host_base = ${HOST_BASE}
host_bucket = ${HOST_BUCKET}
gpg_passphrase = ${ENCRYPTION_PASSWORD}
CONFIG

# Run s3cmd with the parameters provided to the container
exec s3cmd $@
