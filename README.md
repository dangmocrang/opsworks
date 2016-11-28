# OpsWorks
Custom cookbook

Main cookbooks:

* webserver

Dependencies:

* java-se


# How-to

You can edit the Berksfile in each of "Main cookbooks" to include required only cookbook for chosen technology. Then in chef command, run:

```
berks packages
```

to create an archive of your chosen cookbooks and upload to Amazon S3
