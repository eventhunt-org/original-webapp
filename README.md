# EventHunt - a Get Together fork

EventHunt is an open source event manager for local communities.

## What is monolith?

Monolith is the original Get Together codebase.
It is a Django 2 webapp that connects to a database.
In the short term, security improvements, bug fixes, and some low hanging fruit features will land in this repository to the original codebase.
In the long-term, a separate API and front-end apps will be created.

## Goals

- Be feature-competitive with Meetup.com
- Allow multiple instances to share federated event data
- Provide sustainable, cost-effective hosting for FOSS communites
- Be developed and maintained by the communities using it

## Stack

This project has been built using [Django 2](https://www.djangoproject.com) and [Python 3](https://www.python.org).

For more details on dependencies, please check [requirements.txt](requirements.txt).

## Getting Started

### Install Git

First, make sure you have [Git](https://git-scm.com/downloads) already installed.

It usually comes pre-installed in Mac and Linux but in Windows you need to run the installer available in the link above.

### Install virtualenv

Also make sure you have [virtualenv](https://virtualenv.pypa.io/en/latest/installation.html) in your computer by running:

```bash
virtualenv --version
```

If you get an error, use ```pip``` (included in Python3) with the following command:

```bash
pip install virtualenv
```

### Configure your local repository

If you haven't already, fork the project at <https://github.com/eventhunt-org/monolith>

Clone your forked repository in your computer (see detailed instructions [here](https://help.github.com/en/articles/cloning-a-repository)).

Navigate to the repository's location using the command line: `cd monolith`

Add <https://github.com/eventhunt-org/monolith.git> to remote following [these instructions](https://help.github.com/en/articles/configuring-a-remote-for-a-fork).

### Configure the virtual environment

- If you have Python3 already configured as the default version for your computer, just run:

```bash
virtualenv ./env
```

- But if your default is Python2, then run:

```bash
virtualenv --python=python3 ./env
```

### Install dependencies and migrate the database

- If you are in Mac or Linux:

```bash
./env/bin/pip install -r requirements.txt
./env/bin/python manage.py migrate
```

- If you are in Windows:

```bash
./env/Scripts/pip install -r requirements.txt
./env/Scripts/python manage.py migrate
```

### Rename the local_settings file

Find the file `local_settings.example` and copy it in `local_settings.py` with the following command:

```bash
cp local_settings.example local_settings.py
```

### Create a super user

- If you're in Mac or Linux run:

```bash
./env/bin/python manage.py createsuperuser
```

- If you are in Windows:

```bash
winpty ./env/Scripts/python manage.py createsuperuser
```

### Start the server

- If you're in Mac or Linux run:

```bash
./env/bin/python manage.py runserver
```

- If you're in Windows:

```bash
winpty ./env/Scripts/python manage.py runserver
```

## Installing pre-commit hooks

Pre-commit is a tool that helps us commiting better code. Before writing any code first install the hooks to your repo.

- If you're using Mac or Linux, run:

```bash
./env/bin/pre-commit install
```

- If you're in Windows:

```bash
./env/Scripts/pre-commit install
```

From now on everytime you commit some code this will be checked by our pre-commit hooks.

### Code formatters

We use the following code formatters:

- [Black](https://black.readthedocs.io/en/stable/)
- [iSort](https://timothycrosley.github.io/isort/)

They are included in the requirements.txt so they were installed already when you [installed dependencies](#install-dependecies-and-migrate-the-database).

On the first commit after doing `pre-commit install`, Black and iSort it will create a new environment, which may take a few minutes. This environment will be reused for all subsequent commits.

### Loading City data

In order to make it easier to create Places and Teams without having to manually
enter records for Country, SPR (State/Province/Region) and City, you can preload
them using data files from <https://download.geonames.org/export/dump/>

The provided `load_spr` and `load_cities` commands will only load data if the
parent country (or SPR for cities) exists in the database. This lets you choose
whether you want to load every city, only cities for select countries, or only
for select SPRs.

#### Countries

Download the [countryInfo.txt](https://download.geonames.org/export/dump/countryInfo.txt)
file from GeoNames, and load it:

```bash
wget https://download.geonames.org/export/dump/countryInfo.txt
./env/bin/python manage.py load_countries countryInfo.txt
```

#### SPR

Download the [admin1CodesASCII.txt](https://download.geonames.org/export/dump/admin1CodesASCII.txt)
file from GeoNames, then run:

```bash
wget https://download.geonames.org/export/dump/admin1CodesASCII.txt
./env/bin/python manage.py load_spr admin1CodesASCII.txt
```

#### Cities

You have a few choices for City data files. GeoNames provides data files for
cities with [more than 15,000](https://download.geonames.org/export/dump/cities15000.zip)
residents, cities with [more than 5,000](https://download.geonames.org/export/dump/cities5000.zip)
residents, and cities [with more than 1,000](https://download.geonames.org/export/dump/cities1000.zip)
residents. The smaller the number, the more cities there will be in the data
file (and the longer it will take to import them all).

Download the file you want from the links above. They will be zip files that you
must unzip before using. Then import the cities by running (for your downloaded
file):

`./env/bin/python manage.py load_cities cities15000.txt`

### Using docker

```bash
docker build -t get_together .
docker run -e "DEBUG_MODE=True" -e "SECRET_KEY=xxxxx" -e "ALLOWED_HOSTS=localhost,127.0.0.1" -d --name get_together -p 8000:8000 get_together
docker exec -it get_together python manage.py createsuperuser
```

### Using docker-compose

```bash
docker-compose up -d
docker-compose exec get_together python manage.py createsuperuser
```

You can then connect to the container by going to localhost:8000

## Test Federation

You can import live event data into your "Searchable" table with this command:

`./env/bin/python manage.py import https://gettogether.community/searchables/`

## Getting Involved

To contribute to EventHunt, you can file issues here on GitHub or work on
features you want it to have via a PR.
