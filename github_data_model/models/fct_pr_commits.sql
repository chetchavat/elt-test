WITH pr_commits AS (
    SELECT
        _sdc_repository AS repository
        , pr_id AS pull_request_id
        , pr_number AS pull_request_number
        , sha AS commit_sha
        , commit__tree__sha AS commit_tree_sha
        , commit__committer__name AS commit_committer_name
        , commit__committer__email AS commit_committer_email
        , commit__committer__date AS commit_committer_date
    FROM {{ source('github', 'pr_commits') }}
)
SELECT * FROM pr_commits