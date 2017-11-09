# TeamPlayer

Find out what access a user has to an organization's repositories.

## Requirements

* [Bundler](bundler.io/)

## Configure

1. bundle install
1. copy `.env-dist` to `.env`
1. Update .env to include _your_ access token

## Usage

```bash
bundle exec ruby teamplayer.rb <org> <user>
```

## Example

```bash
$ bundle exec ruby teamplayer.rb acmecorp johndoe
write	acmecorp/foobar
read	acmecorp/wiki
write	acmecorp/emailtemplates
none	acmecorp/hr
write	acmecorp/website
read	acmecorp/accounting
```
