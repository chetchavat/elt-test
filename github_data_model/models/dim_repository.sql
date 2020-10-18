WITH repository AS (
    SELECT DISTINCT
        _sdc_repository AS repository
        , repository_url AS repository_url
    FROM {{ source('github', 'issues') }}
)

SELECT * FROM repository