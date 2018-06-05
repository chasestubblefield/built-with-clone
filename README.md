#### (Examples use the [jq](https://stedolan.github.io/jq/) utility to parse the JSON response.)

# Part 1

POST a JSON with a `url` you would like to analyze to `/analyze`:

```
$ curl -s -X POST -H "Content-Type: application/json" -d '{"url":"http://www.example.com"}' http://0.0.0.0:3000/analyze | jq '.'
{
  "body": "<!doctype html>\n<html>\n<head>\n    <title>Example Domain</title>\n\n    <meta charset=\"utf-8\" />\n    <meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n    <style type=\"text/css\">\n    body {\n        background-color: #f0f0f2;\n        margin: 0;\n        padding: 0;\n        font-family: \"Open Sans\", \"Helvetica Neue\", Helvetica, Arial, sans-serif;\n        \n    }\n    div {\n        width: 600px;\n        margin: 5em auto;\n        padding: 50px;\n        background-color: #fff;\n        border-radius: 1em;\n    }\n    a:link, a:visited {\n        color: #38488f;\n        text-decoration: none;\n    }\n    @media (max-width: 700px) {\n        body {\n            background-color: #fff;\n        }\n        div {\n            width: auto;\n            margin: 0 auto;\n            border-radius: 0;\n            padding: 1em;\n        }\n    }\n    </style>    \n</head>\n\n<body>\n<div>\n    <h1>Example Domain</h1>\n    <p>This domain is established to be used for illustrative examples in documents. You may use this\n    domain in examples without prior coordination or asking for permission.</p>\n    <p><a href=\"http://www.iana.org/domains/example\">More information...</a></p>\n</div>\n</body>\n</html>\n"
}
```

# Part 2

The response will also include some other information about the URL requested:

```
$ curl -s -X POST -H "Content-Type: application/json" -d '{"url":"https://getbootstrap.com/"}' http://0.0.0.0:3000/analyze | jq 'del(.body)'
{
  "is_html": true,
  "is_using_bootstrap": true,
  "is_using_google_analytics": true
}
```

You can search for text within the response with the `search` param:

```
$ curl -s -X POST -H "Content-Type: application/json" -d '{"url":"https://github.com","search":"Microsoft is acquiring GitHub!"}' http://0.0.0.0:3000/analyze | jq '.contains_search_term'
true
```
