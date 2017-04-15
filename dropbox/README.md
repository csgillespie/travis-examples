Upload files to your Dropbox account
------------------------------------

First you need the [`dropbox.sh`](https://github.com/craigcitro/r-travis/blob/master/scripts/dropbox.sh) script. Add these lines in your `before_install`

```
- curl -OL http://raw.github.com/craigcitro/r-travis/master/scripts/dropbox.sh
- chmod 755 ./dropbox.sh
The use the script anywhere to upload files to your dropbox, for example:

after_script:
  - ./dropbox.sh upload mypackage.Rcheck/00check.log
```

You need proper authorization to upload files to dropbox, so you need to set these environment variables:

```
APPKEY=xxx
APPSECRET=yyy
ACCESS_LEVEL=sandbox
OAUTH_ACCESS_TOKEN=xxx
OAUTH_ACCESS_TOKEN_SECRET=xxx
```

The first thing to do is create a dropbox app. This gives you `APPKEY` and `APPSECRET`. 
You can then get oauth tokens:

```
# replace by yours
export APPKEY="-----"
export APPSECRET="------"
curl -k -s --show-error --globoff -i --data "oauth_consumer_key=$APPKEY&oauth_signature_method=PLAINTEXT&oauth_signature=$APPSECRET%26" "https://api.dropbox.com/1/oauth/request_token" | tail -n1
```

This should give you something that looks like this:

```
oauth_token_secret=xxxxx&oauth_token=xxxxx
```

Next, we need to use travis to encrypt these keys as we do not want to make them publicly available. See this for details.

Run this in your repo directory

```
travis encrypt APPKEY=xxx --add
```

This will add a line in your `.travis.yml` that encrypts the variable. 
Do the same for `APPSECRET`, `OAUTH_ACCESS_TOKEN` and `OAUTH_ACCESS_TOKEN_SECRET`.


