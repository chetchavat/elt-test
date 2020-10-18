WITH issue_events AS (
-- assuming that most actions go trough issues,
-- this should be enough to get a good amount of users
-- ideally we'd do this with commits, pr_commits, etc
    SELECT DISTINCT
        actor__id AS user_id
        , actor__type AS user_type
        , actor__login AS user_login
    FROM {{ source('github', 'issue_events')}}

    UNION

    SELECT DISTINCT
        requested_reviewer__id
        , requested_reviewer__type
        , requested_reviewer__login
    FROM {{ source('github', 'issue_events')}}

    UNION 

    SELECT DISTINCT
        review_requester__id
        , review_requester__type
        , review_requester__login
    FROM {{ source('github', 'issue_events')}}

    UNION

    SELECT DISTINCT
        assignee__id
        , assignee__type
        , assignee__login
    FROM {{ source('github', 'issue_events')}}
)
SELECT
    *
FROM issue_events