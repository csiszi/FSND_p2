-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE DATABASE tournament;
\c tournament;
CREATE TABLE players (name TEXT,
                      id SERIAL PRIMARY KEY);
CREATE TABLE matches (winner INTEGER REFERENCES players (id),
                      looser INTEGER REFERENCES players (id),
                      id SERIAL PRIMARY KEY);

-- Views

CREATE VIEW matches_view AS
  SELECT players.id as id, count(matches) AS matches
  FROM players LEFT JOIN matches
  ON (players.id = matches.winner) OR (players.id = matches.looser)
  GROUP BY players.id
  ORDER BY matches DESC;

CREATE VIEW wins AS
  SELECT players.id as id, count(matches.winner) AS wins
  FROM players LEFT JOIN matches
  ON players.id = matches.winner
  GROUP BY players.id
  ORDER BY wins DESC;

CREATE VIEW losses AS
  SELECT players.id as id, count(matches.looser) AS losses
  FROM players LEFT JOIN matches
  ON players.id = matches.looser
  GROUP BY players.id
  ORDER BY losses DESC;