SELECT
  content,
  publish_date,
  updated_at as updated,
  title,
  excerpt,
  status,
  permalink,
  comment_count,
  thumbnail,
  (SELECT group_concat(wp_terms.name separator ', ')
    FROM wp_terms
    INNER JOIN wp_term_taxonomy on wp_terms.term_id = wp_term_taxonomy.term_id
    INNER JOIN wp_term_relationships wpr on wpr.term_taxonomy_id = wp_term_taxonomy.term_taxonomy_id
    WHERE taxonomy= 'category' and posts.ID = wpr.object_id
  ) AS "categories",
   (SELECT group_concat(wp_terms.name separator ', ')
    FROM wp_terms
    INNER JOIN wp_term_taxonomy on wp_terms.term_id = wp_term_taxonomy.term_id
    INNER JOIN wp_term_relationships wpr on wpr.term_taxonomy_id = wp_term_taxonomy.term_taxonomy_id
    WHERE taxonomy= 'post_tag' and posts.ID = wpr.object_id
  ) AS "tags"

FROM
(select
  ID,
  meta_value as meta_post_id,
  post_content AS content,
  post_date AS publish_date,
  post_modified AS updated_at,
  post_title AS title,
  post_excerpt AS excerpt,
  post_status AS status,
  post_name AS permalink,
  comment_count AS comment_count

FROM
(SELECT * FROM wp_posts INNER JOIN wp_postmeta ON wp_posts.ID = wp_postmeta.post_id) AS posts

WHERE posts.post_type = 'post'AND posts.meta_key = '_thumbnail_id') AS posts

INNER JOIN

(SELECT
  meta_id,
  post_id,
  meta_value AS thumbnail
FROM wp_postmeta WHERE wp_postmeta.meta_key = '_wp_attached_file') AS meta

ON posts.meta_post_id = meta.post_id

