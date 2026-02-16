-- ALMA PREMIER LEAGUE 2026 - SCHEMA

-- 1. Teams Table
CREATE TABLE teams (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    short_name TEXT UNIQUE,
    logo_url TEXT,
    banner_url TEXT,
    captain_id UUID -- Circular dependency handled later
);

-- 2. Players Table
CREATE TABLE players (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id UUID REFERENCES teams(id),
    name TEXT NOT NULL,
    jersey_number INTEGER,
    role TEXT CHECK (role IN ('Batsman', 'Bowler', 'All-Rounder', 'Wicket Keeper')),
    batting_style TEXT,
    bowling_style TEXT,
    photo_url TEXT,
    matches_played INTEGER DEFAULT 0
);

-- 3. Batting Stats Table
CREATE TABLE batting_stats (
    player_id UUID PRIMARY KEY REFERENCES players(id),
    runs INTEGER DEFAULT 0,
    balls INTEGER DEFAULT 0,
    fours INTEGER DEFAULT 0,
    sixes INTEGER DEFAULT 0,
    fifties INTEGER DEFAULT 0,
    hundreds INTEGER DEFAULT 0,
    highest_score INTEGER DEFAULT 0,
    not_outs INTEGER DEFAULT 0
);

-- 4. Bowling Stats Table
CREATE TABLE bowling_stats (
    player_id UUID PRIMARY KEY REFERENCES players(id),
    wickets INTEGER DEFAULT 0,
    runs_conceded INTEGER DEFAULT 0,
    overs_bowled DECIMAL(5,1) DEFAULT 0.0,
    maidens INTEGER DEFAULT 0,
    best_bowling TEXT -- e.g. "5/12"
);

-- 5. Matches Table
CREATE TABLE matches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_a_id UUID REFERENCES teams(id),
    team_b_id UUID REFERENCES teams(id),
    match_date DATE,
    match_time TIME,
    venue TEXT,
    status TEXT DEFAULT 'Upcoming' CHECK (status IN ('Upcoming', 'Live', 'Completed')),
    result TEXT
);

-- 6. Points Table
CREATE TABLE points_table (
    team_id UUID PRIMARY KEY REFERENCES teams(id),
    played INTEGER DEFAULT 0,
    won INTEGER DEFAULT 0,
    lost INTEGER DEFAULT 0,
    tied INTEGER DEFAULT 0,
    nr INTEGER DEFAULT 0,
    points INTEGER DEFAULT 0,
    nrr DECIMAL(5,3) DEFAULT 0.000
);
