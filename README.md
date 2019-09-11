# metala/digitalocean-s3cmd

This is a simple containerized [s3cmd](http://s3tools.org/s3cmd) for DigitalOcean Spaces.

## Options

**Environment variables**

- `DATACENTER_REGION` - DigitalOcean datacenter location key
- `ACCESS_KEY` - API access key
- `SECRET_KEY` - API secret key
- `ENCRYPTION_PASSWORD` - GPG encryption passphrase used by s3cmd> (Optional)

**Volumes**

- /local/path:/mnt

## Getting started

You can provide the credentials through envronment varaibles:

`$ docker run --rm -e 'DATACENTER_REGION=AMS3' -e 'ACCESS_KEY=<ACCESS_KEY>' -e 'SECRET_KEY=<SECRET_KEY>' metala/digitalocean-s3cmd ls s3://bucket-name/`

Or provide the access key and secret key as arguments:

`$ docker run --rm -e 'DATACENTER_REGION=AMS3' metala/digitalocean-s3cmd --access_key=<ACCESS_KEY> --secret_key=<SECRET_KEY> ls s3://bucket-name/`

Or you can provide all the parameters as command arguments:

`$ docker run --rm metala/digitalocean-s3cmd --host=ams3.digitaloceanspaces.com --host-bucket="%(bucket)s.ams3.digitaloceanspaces.com" --access_key=<ACCESS_KEY> --secret_key=<SECRET_KEY> ls s3://bucket-name`

### Syncing using local path

The current working directory in the docker is `/mnt`.

For brevity, I would store the environment variables in `s3cmd.env` file:

```
DATACENTER_REGION=AMS3
ACCESS_KEY=<ACCESS_KEY>
SECRET_KEY=<SECRET_KEY>
```

Now, we can sync `/local/path/to/sync` using the following command:

```
$ docker run --rm --env-file s3cmd.env -v /local/path/to/sync:/mnt metala/digitalocean-s3cmd sync ./ s3://bucket-name/prefix-directory/
```

## s3cmd docs

See [Usage](http://s3tools.org/usage) for full usage information.
