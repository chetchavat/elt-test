## Github Data Model
This document will tell you how to:
- pull data from GitHub
- push it into Postgres
- transform the data using the dbt CLI
- generate documentation

### Setting up your tap and target
To do this you will need Python 3.5 or higher (I think, I'm using Python 3.83)

1. We will need to install the tap and target packages in virtual environments, because `target-postgres` uses a different version of `singer-python` than `tap-github`. 
    - `deactivate` returns to the base environment
```
python3 -m venv ~/.virtualenvs/tap-github
source ~/.virtualenvs/tap-github/bin/activate
pip install tap-github

python3 -m venv ~/.virtualenvs/target-postgres
source ~/.virtualenvs/target-postgres/bin/activate
pip install target-postgres

deactivate
```
2. Set up [tap-github](https://github.com/singer-io/tap-github)
    - Create a [Personal Access Token](https://github.com/settings/tokens) on GitHub
    - Create a config file
        - The config contains your access token, and the desired repository to pull data from
        - An example can be found in `configs/tap-github`
    - Run `tap-github` in discovery mode to get the `properties.json` file
        - This contains the GitHub schema
        - Each `stream` roughly corresponds to a table or set of related tables
    - Select the streams you want to pull down
3. Set up [target-postgres](https://github.com/datamill-co/target-postgres)
    - Do you have postgres installed?
        - Do you have dbt installed? Yes? You have postgres installed!
        - If not, instructions can be found on their [website](https://www.postgresql.org/download/)
    - Create your target database
        - There are many ways to do this, but I used [this tutorial](https://www.robinwieruch.de/postgres-sql-macos-setup) to get me started
        - At a high level, it was these commands
        ```
        initdb /usr/local/var/postgres
        pg_ctl -D /usr/local/var/postgres start
        createdb netlify_takehome
        ```
    - After this I used [Postico](https://eggerapps.at/postico/), because using a CLI to interact with a database makes me uncomfortable
    - Connect to the database with Postico
        - All you should need to change from default is the database
            - Mine is called `netlify_takehome`
    - Those same credentials will be used in your target config
        - An example can be found in `configs/target-postgres`
4. Let it fly
- Run your tap and pipe it to the target using proper configs
```
~/.virtualenvs/tap-github/bin/tap-github --config tap-github-config.json --properties properties.json | ~/.virtualenvs/target-postgres/bin/target-postgres --config target-postgres-config.json >> state.json
```
### Transform the data with dbt
In this example, we will be using the dbt CLI.


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
