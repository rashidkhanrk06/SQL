SELECT * from matches;
-- ------------------TEAM--------------------------------
-- ---------Most Winning team in IPL----------------------

select winner 
from matches
group by winner 
order by count( winner)  desc limit 1;

-- ---------No of Matches Played in IPL----------------------

select  count(*) as MatchesPlayed	from matches
where team1 = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1) or
 team2 = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1);

-- ---------No of Matches Won in IPL----------------------

select count(winner) 
from matches
where winner  = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1);

-- ---------No of Matches Lost in IPL------------------

select 
(select  count(*) as MatchesPlayed	from matches
where team1 = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1) or
 team2 = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
)-count(*) as Lost  from matches
where winner = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1);

-- ---------No of Matches Won Bat 1st in IPL----------------------

select count(winner) 'Won_Bat_1st'
from matches
where winner  = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
and result = 'runs' ;

-- ---------No of Matches Won Bat 2nd in IPL----------------------

select count(winner) 'Won_Bat_2nd'
from matches
where winner  = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
and result = 'wickets' ;

-- ---------No of Matches Tie  in IPL----------------------

select count(winner) tie
from matches
where winner  = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
and result = 'tie' ;




-- ---------No of Toss Won in IPL------------------

select count(*) WonToss
from matches
where toss_winner  = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1);

-- ---------No of Toss Lost in IPL------------------

select count(*) WonToss
from matches
where toss_winner  <> ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
and (team1 = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
or
team2 = ( select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
);

-- ---------Highest Match Won Bat 1st in IPL----------------------

select max(result_margin) HighestWonbyRun
from matches
where result = 'runs' and
winner = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1);
 
 -- ---------Most Man of the Match in IPL----------------------

select player_of_match, count(*)
from matches
where winner = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
group by player_of_match
order by count(*) desc limit 1;

-- ----best batsman of Most winnig tea in IPL----------------------

select b.batsman, sum(b.batsman_runs) from matches as a
join ipl as b on a.id=b.id
where a.winner = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
group by  b.batsman
order by sum(b.batsman_runs) desc limit 1;

-- ----best Bowler of Most winnig tea in IPL----------------------

select b.bowler, sum(b.is_wicket) from matches as a
join ipl as b on a.id=b.id
where a.winner = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
and dismissal_kind not in ('run out', 'hit wicket')
group by  b.bowler
order by sum(b.is_wicket) desc limit 1;

-- ----Best Winnig team by runs in IPL----------------------

select winner, max(result_margin) 
from matches 
where result = 'runs'
group by winner
order by max(result_margin) desc limit 1;

 -- ----Best Winnig team by wickets in IPL----------------------

select winner,  max(result_margin) 
from matches 
where result = 'wickets'
group by winner
having  max(result_margin) >= 10
order by winner, max(result_margin) desc;

select winner
from matches where result = 'wickets' and result_margin = 10
group by winner
order by count(result_margin) desc limit 1;

-- ----- Most winnig matches by cities in IPL------------

select city, count(*) Noofmatches from matches
where winner = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
group by city
order by  Noofmatches desc ;

-- ----- Most winnig matches by cities & venue in IPL----------

select city, venue, count(*) Noofmatches from matches
where winner = (select winner 
from matches
group by winner 
order by count( winner)  desc limit 1)
group by city, venue
order by  Noofmatches desc ;