-- =========================================================
-- Netflix Content Growth Analysis
-- Author: Vineeth
-- Description:
-- This query analyzes how Netflix content additions
-- have changed over time using BigQuery.
-- =========================================================


-- Step 1: Aggregate number of titles added per year
WITH yearly_additions AS (
    SELECT
        EXTRACT(YEAR FROM PARSE_DATE('%B %e, %Y', date_added)) AS year_added,
        COUNT(*) AS titles_added
  FROM  `netflix-analysis-484810.netlfix_data.netflix_titles` 
 WHERE date_added IS NOT NULL
GROUP BY year_added)

SELECT
    year_added,
    titles_added,
    round(AVG(titles_added) OVER (),2) AS avg_titles_per_year,
    round(titles_added - AVG(titles_added) OVER (),2) AS diff_from_avg,
    RANK() OVER (ORDER BY titles_added DESC) AS rank_by_volume
FROM yearly_additions
ORDER BY year_added;