## Overwatch League Data Cleanup
This is the SQL code I used to clean data from the Overwatch League and turn it into a connected database (not reflected in the code is the various queries I used to find the all the major and minor errors in the data that I cleaned up).

## Before

#### 4,958,301 rows of data from 14 flat CSV files
- Spelling errors
- Inconsistent formatting
- Incorrect values
- Missing values
- Duplicate rows
- Outdated names
- Lack of overarching organizational structure

## After

#### 4,920,155 rows of data connected across 7 tables
- 5 tables in a hierarchy `season` > `stage` > `match` > `game` > `round`<br>
- 2 reference tables `player_stat` and `hero`
  

- Fixed all of the aforementioned problems
- Added **primary keys**
- Added *foreign keys*
- Added constraints
- Added new data via the `hero` table
- Brought database to first normal form

## Database Schema
![Overwatch League Database organized v4](https://user-images.githubusercontent.com/97869630/154815413-24f2b310-a25f-4fd7-beed-77aee0237a48.PNG)

## Resources
- Wiki of Overwatch League information <br>    https://liquipedia.net/overwatch/
- VODs of Overwatch League matches (change "match_id" to the match_id number of the match you want to watch) <br>    https://overwatchleague.com/en-us/match/match_id
- Source of raw data (found under "Download the Data" near the bottom) <br>    https://overwatchleague.com/en-us/statslab

