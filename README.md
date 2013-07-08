# OpenNews IRC Log Bot

[Mozilla OpenNews](http://mozillaopennews.org/) | #opennews on [IRC.Mozilla](http://irc.mozilla.org/)

Operated by [Mike Tigas](http://mike.tig.as/) ([@mtigas](https://twitter.com/mtigas))

Constant work-in-progress.

---

This is a simple Python-based log bot that tracks #opennews on
[IRC.Mozilla](http://irc.mozilla.org/).

This bot runs persistently on an EC2 server (in a `screen` session because of
laziness), with a 15 minute cron job that runs the `s3dir.py` utility to upload
the logs to S3:

```shell
# m h  dom mon dow   command
  */15 *  *   *   *     python /home/ubuntu/logbot/s3dir.py >> /home/ubuntu/s3log.txt
```

The S3 bucket is configured to use “website mode” (so "index.html" serves the directory) and
served on a CNAME for easy access.

That’s it.

## Credits ##

Originally written by Chris Oliver <chris@excid3.com>. Additions by
[Mike Tigas](https://github.com/mtigas). See `LICENSE`.
