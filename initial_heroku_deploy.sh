#!/bin/sh
# Kevin Xu / imkevinxu
#
# Script for initial deploy to Heroku
# Tested on Mac 10.7 (Lion) and 10.8 (Mountain Lion)

####################################
# Script that undos the work of the initial heroku deployment littered with emoticans
# Invoked by an --undo parameter
#
# UNINSTALLS 'psycopg2', 'dj-database-url', and 'django-postgrespool'
# RESETS the git head back one commit, and
# DESTROYS the heroku app
#####################################

if [ ! -d $1 ]; then
    if [ $1 == "--undo" ]; then
        echo
        echo "    Sounds like something broke during the initial deployment......"
        echo
        echo "    (╯°□°）╯︵ ┻━┻    FFFFFFFUUUUUUUUUUUU"
        echo
        read -p "    Are you sure you wish to undo the initial deploy? " -n 1
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo
            echo "    （╯ ﾟ ヮﾟ）╯︵ ♥♥♥♥  i love you!"
            exit 0
        fi
        echo
        echo "    This will UNINSTALL 'psycopg2', 'dj-database-url', and 'django-postgrespool'"
        echo "    RESET the git head back one commit, and DESTROY the heroku app"
        read -p "    Last chance, are you sure you want to undo? " -n 1
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo
            echo "    ┬──┬ ノ( ゜-゜ノ)  chill out bro"
            exit 0
        fi

        echo
        echo "    ┻━┻ ︵ヽ(\`Д´)ﾉ︵* ┻━┻    RAAAAAAAAAGEEEEEEEE!!!!!"
        echo
        read -p "    What is the name of the Heroku app? "
        echo
        echo "[START] Undoing initial Heroku deployment....."
        pip uninstall psycopg2 dj-database-url django-postgrespool
        git reset --hard HEAD^
        heroku destroy --app $REPLY
        echo
        echo "[COMPLETE] Initial Heroku deployment successfully undone!"
        echo
        echo "    (^_^メ) That wasn't too bad..."

        exit 0
    else
        echo "[EXTRA ARGUMENTS] Script takes no extra arguments"
        exit 0
    fi
fi

# Detects if the user has heroku installed and prompts them to install it if not
if [ -z `which heroku` ]; then
    echo "[MISSING HEROKU] Detected Heroku has not been installed"
    echo "  INSTALL Heroku here https://devcenter.heroku.com/articles/quickstart"
    exit 0
fi

# Proceed if user is working in a virtualenv
if [ -z "$VIRTUAL_ENV" ]; then
    echo "[MISSING VIRTUALEV] Not currently working in the project's virtualenv"
    echo "  run 'workon PROJECT_NAME'"
    exit 0
fi

# Proceed if user is currently in the top level directory of the project
if [ ! -s "manage.py" ]; then
    echo "[WRONG FOLDER] You're not in the top level of the project directory"
    echo "  Only run script in the same folder as 'manage.py' of the project"
    exit 0
fi

# Proceed if user is currently in the master branch
branch_name=$(git symbolic-ref HEAD 2>/dev/null)
branch_name=${branch_name##refs/heads/}
if [ $branch_name != "master" ]; then
    echo "[WRONG BRANCH] You currently have the '$branch_name' git branch checked out"
    echo "  Please check out the 'master' branch and make any updates/merges"
    exit 0
fi

# Proceed if master branch is clean
if ! git diff-index --quiet HEAD --; then
    echo "[UNCOMMITTED CHANGES] Detected changes that have not been committed"
    echo "  Please commit your changes before deploying to Heroku"
    exit 0
fi

# Begin Deployment Script
echo
echo "    *** Starting Initial Heroku Deploy! ***"
echo
echo "      　　　　 /｀》,-―‐‐＜｀}           "
echo "      　　 　./::/≠´::::;::ヽ.           "
echo "      　 　　/::〃::::／}::丿ハ          "
echo "      　 　./:::i{::／  ﾉ／}::}          "
echo "      　　 /::::瓜イ＞ ´＜,':ﾉ           "
echo "      　 ./::::ﾉ ﾍ{､ ( ﾌ_ノイ            "
echo "      　 |::::|  ／} ｽ/￣￣￣￣/         "
echo "       　|::::| (::つ/ Heroku / Deploy!  "
echo "    ￣￣￣￣￣￣￣＼/＿＿＿＿/￣￣￣￣   "
echo

# Prompts user for a name of the heroku app
read -p "    What will you name the new Heroku app? (single word lowercase. leave blank for random name) "
HEROKU_NAME=$REPLY

echo
echo "[START] Preparing the project for Heroku deployment....."

# Installs psycopg2, dj-database-url, and django-postgrespool and updates requirements.txt
pip install psycopg2 dj-database-url django-postgrespool
pip freeze > requirements.txt

# Commiting for initial heroku deploy
git add -A && git commit -m "Initial Heroku Deploy preparation complete!"

echo
echo "[COMPLETE] Project prepared for Heroku deployment!"
echo "[START] Creating new Heroku server and deploying....."
echo

# Creates a new heroku app with prompted or random name and adds the git remote
heroku create $HEROKU_NAME

# Downloads heroku-config and pushes environment variables in .env to heroku
# https://devcenter.heroku.com/articles/config-vars#using-foreman-and-herokuconfig
heroku plugins:install git://github.com/ddollar/heroku-config.git
heroku config:push

# Deploys to heroku
git push heroku master

# Sync the Django models with the database schema
heroku run python manage.py syncdb

# Migrate the Django models on the production database
heroku run python manage.py migrate

# Opens the website in default browser
echo
heroku open

echo "[COMPLETE] Heroku app deployed and synced!"
echo
echo "    ヽ(^o^)丿  yaaaaaaaay"
echo
echo "    # Make sure you also:"
echo "        - Configure any custom domains"
echo
echo "    # In case there was an error during deployment, run the script again with --undo parameter"