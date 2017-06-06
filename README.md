# chrome headless sample

# usage

## build

```
docker build -t chrome-headless .
```

## run

print page title by javascript code result.

```
docker run --rm -it -v $(pwd):/var/ruby chrome-headless ruby /var/ruby/sample.rb
# => 'https://www.google.co.jp' title is 'Google'
```

