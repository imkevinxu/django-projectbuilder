[Django Project Builder](https://github.com/prototypemagic/django-projectbuilder)
======================

### *Extremely outdated, please use [django-kevin](https://github.com/imkevinxu/django-kevin) instead.*

## Introduction

Django Project Builder is the fastest, easiest way to build a new Django project!
Originally created by [Prototype Magic](https://github.com/prototypemagic),
this is a forked version with updated themes, packages, and opinionated best
practices I have picked up over the years.

### Features and Benefits

* Create a new Django project inside a `git` repo and `virtualenv`
  with sane defaults and best practices _all_ with a single command

* Auto-deploy your shiny new Django app to Heroku with a simple command!

* Three frontend options with CSS, JS, and HTML Templates.

* A bunch of extra packages and apps to go with your Django project

### Who is DPB for?

Django programmers using a Unix-based OS looking to do more coding and less config.

For those looking to enjoy convenient server deployments, note that
the __server scripts__ currently assume you're using Bash + virtualenv +
virtualenvwrapper + Ubuntu + Apache.  We're working on reducing the
number of dependencies.

[Original TODO](https://github.com/prototypemagic/django-projectbuilder/blob/master/TODO.md)
for what's on the horizon, and for what you may want to help out with.


## Local Development Instructions

### Installing Dependencies

If you're on a Mac (only been tested with OSX 10.7 (Lion) and 10.8 (Mountain Lion) so far)
and are missing some dependencies like `pip`, `django`, `virtualenv`, or `virtualenvwrapper`
then `cd` into the django-projectbuilder repo and run

    source install_dependencies.sh

If you want to install dependencies without cloning this repo run

    curl -O https://raw.github.com/imkevinxu/django-projectbuilder/master/install_dependencies.sh && source install_dependencies.sh && rm -f install_dependencies.sh

### Local Development Usage

After cloning this repo to your local machine, `cd` into it and run
something like

    python djangobuilder.py --path ~/new_project

to create the `~/new_project` directory, which contains _tons_ of
Django boilerplate -- common imports, virtualenv creation, a new git
repo, and more! `virtualenv` and `virtualenvwrapper` are required. `git` is
recommended. Django is awesome.

### Frontend Themes

If you add the optional `--theme {bootstrap, foundation}` argument, your project
will be created using the selected theme defaults for the front-end.

    python djangobuilder.py --path ~/new_project --theme bootstrap

### Extra packages

If you add the optional `--bcrypt` argument, your project will be created
using bcrypt as the default password hashing

    python djangobuilder.py --path ~/new_project --bcrypt

If you add the optional `--debug` argument, your project will be created
with the super handy Django Debug Toolbar

    python djangobuilder.py --path ~/new_project --debug

If you add the optional `--jinja2` argument, your project will be created
using Jinja2 as the default templating engine with Coffin as the adapter

    python djangobuilder.py --path ~/new_project --jinja2


## Production Instructions

### Auto Initial Heroku Deploy

To automate the steps for your initial Heroku deploy, `cd` into your project folder and run

    bash /path/to/django-projectbuilder/initial_heroku_deploy.sh

See [Getting Started with Django on Heroku/Cedar](https://devcenter.heroku.com/articles/django)
for more on deploying to Heroku and the [initial heroku deploy script](https://github.com/imkevinxu/django-projectbuilder/blob/master/initial_heroku_deploy.sh) to see how it works

### Normal Server Usage

After cloning this repo to one of your many servers like AWS, `cd` into it and run

    bash gitbuilder.sh ~/new_project

to create the top-level project directory, bare git repo, and empty
${PROJECT_NAME}_site directory for the soon-to-exist Django project.
Follow the instructions echoed to the screen, which include using
`apachebuilder.sh` to generate your project's Apache config.


## Troubleshooting

### Postgres

On Ubuntu, install Postgres with

    sudo apt-get install postgresql-server-dev-all

To install `psycopg2`, Django's Postgres driver, run

    pip install psycopg2

If you get the following error when trying to install `psycopg2`

    ./psycopg/psycopg.h:30:20: fatal error: Python.h: No such file or directory
    compilation terminated.
    error: command 'gcc' failed with exit status 1

that means you haven't installed all the necessary header (*.h) files
to compile additional Python modules/Django apps.  On Ubuntu, run

    sudo apt-get install python-dev

to fix this issue, then again try running

    pip install psycopg2

from within your project's virtualenv to install `psycopg2`.

## Authors

### Original Authors

* [Steve Phillips](https://github.com/elimisteve) <steve@builtbyptm.com>
* [AJ Bahnken](https://github.com/ajvb) <aj@builtbyptm.com>

Originally created by PTM Web Engineering, LLC in Santa Barbara, California

### Personal Fork

* [Kevin Xu](https://github.com/imkevinxu) <kevin@imkevinxu.com>

This is an updated fork of django-projectbuilder with a bunch of opinionated best practices

## Copyright and license

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

  [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
