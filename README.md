# Send Qiita Trend to Slack

# How to use?
```
$ docker run --rm --env SLACK_API_TOKEN=<token> --env NOTIFY_CHANNEL=#qiita crossts/qiita-trend-to-slack:latest
```

or

```
$ docker run --rm --env-file .env crossts/qiita-trend-to-slack:latest
```
