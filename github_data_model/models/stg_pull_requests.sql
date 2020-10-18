WITH base AS (
    SELECT 
        _sdc_repository AS repository
        , id AS pull_request_id
        , "number" AS pull_request_number
        , url AS pull_request_url
        , title AS pull_request_title
        , state AS current_pr_state
        , name AS label_name
        , description AS label_description
        , user__id AS user_id
        , created_at
        , merged_at
        , closed_at
        , updated_at
    FROM {{ source('github', 'pull_requests')}} AS pull_requests
    LEFT JOIN {{ source('github', 'pull_requests__labels')}} AS labels
        ON pull_requests.id = labels._sdc_source_key_id
)
SELECT
    *
FROM pull_requests