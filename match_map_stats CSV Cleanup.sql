
-- Corrects column misspellings, "perecent" -> "percent"
      ALTER TABLE match_map_stats
           RENAME attacker_control_perecent TO attacker_control_percent;
           
      ALTER TABLE match_map_stats
           RENAME defender_control_perecent TO defender_control_percent;


-- Creates "match_loser" column
      ALTER TABLE match_map_stats
       ADD COLUMN match_loser;

-- Populates "match_loser" column
           UPDATE match_map_stats
              SET match_loser = (CASE
                                   WHEN match_winner = team_one_name 
                                     THEN team_two_name
                                   ELSE team_one_name
                                 END);

-- Removes columns "team_one_name" and "team_two_name"
      ALTER TABLE match_map_stats
      DROP COLUMN team_one_name;

      ALTER TABLE match_map_stats
      DROP COLUMN team_two_name;


-- Renames "control_round_name" to "map_subsection"
      ALTER TABLE match_map_stats
           RENAME control_round_name TO map_subsection;


-- Corrects map_subsection of match 21352, game 1, round 1
           UPDATE match_map_stats
              SET map_subsection  = "MEKA Base"
            WHERE ROWID = 4065;

-- Creates an estimate (based off game footage) of round_start_time for match 21352, game 1, round 1
           UPDATE match_map_stats
              SET round_start_time = (SELECT datetime((strftime("%s", round_end_time) - 215), "unixepoch")
                                        FROM match_map_stats
                                       WHERE ROWID = 4065)
            WHERE ROWID = 4065;
 
 
-- Each one deletes a duplicate row (some with incorrect round_start_time)
      DELETE FROM match_map_stats
            WHERE ROWID = 4066;
                   
      DELETE FROM match_map_stats
            WHERE ROWID = 7343;
                      
      DELETE FROM match_map_stats
            WHERE ROWID = 7937;

      DELETE FROM match_map_stats
            WHERE ROWID = 9943;
          
          
-- Each one corrects a game_number
           UPDATE match_map_stats
              SET game_number = "4"
            WHERE ROWID IN (664, 665);

           UPDATE match_map_stats
              SET game_number = "4"
            WHERE ROWID IN (5364, 5365);
            
            
-- Corrects the round numbers in "map_round"
             WITH
 map_round_lag AS (
           SELECT round_start_time,
                  LAG(map_round, 1, "0") OVER() map_round_lag
             FROM match_map_stats
                  ),
				  
    map_round_new AS (
           SELECT mrl.round_start_time,
	            (CASE
		       WHEN mms.map_round = "1"
			 THEN 1
		       WHEN mms.map_round = "5" AND mrl.map_round_lag = "3"
		         THEN 3
		       WHEN mms.map_round = "7" AND mrl.map_round_lag = "5"
		         THEN 4
	               ELSE mrl.map_round_lag + 1
		     END) map_round
              FROM match_map_stats mms
              JOIN map_round_lag mrl ON mrl.round_start_time = mms.round_start_time
                   )
				   
            UPDATE match_map_stats
               SET map_round = mrn.map_round
              FROM map_round_new mrn
             WHERE mrn.round_start_time = match_map_stats.round_start_time;
             
-- Renames "map_round" to "round_number"
       ALTER TABLE match_map_stats
	    RENAME map_round TO round_number;
	    
	    
