-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with cte as (
  select 
    sent_at::date,
    user_name,
    count(1) as cnt
  from npn_users u
  left join npn_messages m
  on u.user_id = m.sender_id
  group by 1, user_name
  order by 1, cnt desc
),
max_cnts as (
  select sent_at, max(cnt) as max_per_day
  from cte
  group by sent_at  
)
select c.*
from cte c
join max_cnts m
on c.sent_at = m.sent_at
and c.cnt = m.max_per_day
