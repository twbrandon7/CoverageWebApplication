CoverageWebApplication
======================

A coverage web application including graph coverage, data flow coverage, and logic coverage


## Build docker image

```bash
docker build -t coverage-web-application .
```

## Run

```bash
docker run --rm -d --name mycoverage -p 8080:8080 coverage-web-application
```
