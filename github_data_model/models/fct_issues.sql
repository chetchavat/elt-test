WITH base AS (
    SELECT
        id AS issue_id
        , "number" AS issue_number
        , "state" AS issue_state
        , _sdc_repository AS repository
        , pull_request__url AS pull_request__url
        , SPLIT_PART(
            pull_request__url
            , CONCAT('https://api.github.com/repos/', _sdc_repository, '/pulls/')
            , 2) AS pull_request_number
        , user__id AS user_id
        , issue_labels."name" AS label_name
        , created_at 
        , closed_at
        , updated_at
    FROM {{ source('github', 'issues') }} AS issues
    LEFT JOIN {{ source('github', 'issues__labels') }} AS issue_labels
        ON issues.id = issue_labels._sdc_source_key_id
)
SELECT
    *
FROM base