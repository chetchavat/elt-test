WITH commits AS (
    SELECT
        _sdc_repository AS repository
        , sha AS commit_sha
        , commit__tree__sha AS commit_tree_sha
        , commit__author__name AS commit_author_name
        , commit__author__email AS commit_author_email
        , commit__committer__name AS commit_committer_name
        , commit__committer__email AS commit_committer_email
        , commit__message AS commit_message
        , commit__author__date AS commit_author_date
        , commit__committer__date AS commit_committer_date
    FROM {{ source('github', 'commits') }}
)
SELECT * FROM commits