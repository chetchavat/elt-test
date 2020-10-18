## Github Data Model
This document will tell you how to:
- pull data from GitHub
- push it into Postgres
- transform the data using the dbt CLI
- generate documentation

### Setting up your tap and target
To do this you will need Python 3.5 or higher (I think, I'm using Python 3.83)

1. the Postgres target uses a different version of singer-python than the GitHub tap, so we will install the tap and target in virtual environments
    - `deactivate` returns you to your base project
```
python3 -m venv ~/.virtualenvs/tap-github
source ~/.virtualenvs/tap-github/bin/activate
pip install tap-github

python3 -m venv ~/.virtualenvs/target-postgres
source ~/.virtualenvs/target-postgres/bin/activate
pip install tap-github

deactivate
```
2. set up [tap-github](https://github.com/singer-io/tap-github)
    - create a [personal access token](https://github.com/settings/tokens) on GitHub
    - create a config file
        - the config contains your access token, and the desired repository to pull data from
        - an example can be found in `configs/tap-github`
    - run the tap in discovery mode to get the properties file
        - this contains the GitHub schema
        - each Stream roughtly corresponds to a table or set of related tables
        - any nested relationships will create another table
    - select the streams you want to pull down
3. set up [target-postgres](https://github.com/datamill-co/target-postgres)
    - do you have postgres installed?
        - do you have dbt installed? yes? you have postgres installed!
        - if not, instructions can be found on their [website](https://www.postgresql.org/download/)
    - create your target database
        - there are many ways to do this, but I used [this tutorial](https://www.robinwieruch.de/postgres-sql-macos-setup) to get me started
        - at a high level, it was these commands
        ```
        initdb /usr/local/var/postgres
        pg_ctl -D /usr/local/var/postgres start
        createdb netlify_takehome
        ```
    - after this I downloaded [Postico](https://eggerapps.at/postico/), because using a CLI to interact with a database makes me uncomfortable
    - connect to the database with postico, all you should need to change are the database name to the database you created (`netlify_takehome`)
    - those same credentials will be used in your target config
        - an example can be found in `configs/target-postgres`
4. let it fly
- run your tap and pipe it to your target with the proper configs
```
~/.virtualenvs/tap-github/bin/tap-github --config tap-github-config.json --properties properties.json | ~/.virtualenvs/target-postgres/bin/target-postgres --config target-postgres-config.json >> state.json
```
### Transform the data with dbt
In this example, we will be using the CLI


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
