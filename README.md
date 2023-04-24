# VG4U

VG4U is a web platform for discovering video games based on your platforms and interests.

Follow the development journey by watching this repo or bookmarking <https://vg4u.fly.dev/>

## Feature List
- [ ] Discover and track upcoming games

## Prerequisites
- Git
- Rails 7.0.4
- Ruby 3.0.0
- PostgreSQL 14.7

## Information

This app uses IDGB's API for their video game database.

Documentation can be found [here](https://api-docs.igdb.com)

## Install

### Clone the repository

```
git clone git@github.com:CobiOneCanobi/vg4u.git
cd vg4u
```

### Install dependencies

```
bundle install
```

### Create a Twitch account and a new application

Follow the steps listed [here](https://api-docs.igdb.com/?ruby#getting-started)

### Set environment variables

Create a `.env` file in the main directory.

Add variables:

```
TWITCH_CLIENT_ID = client id generated from your twitch application
TWITCH_CLIENT_SECRET = client secret generated from your twitch application
```

### Initialize the database

```
rails db:create db:migrate db:seed
```

### Start server

```
rails s
```
