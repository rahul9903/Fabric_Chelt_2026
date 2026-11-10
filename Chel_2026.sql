-- 1. Dimension Tables
CREATE TABLE Dim_Date (
    DateKey INT NOT NULL,
    RaceDate DATE NOT NULL,
    DayName VARCHAR(20) NOT NULL,
    FestivalDayName VARCHAR(50) NOT NULL
);

CREATE TABLE Dim_Race (
    RaceKey INT NOT NULL,
    RaceId VARCHAR(50) NOT NULL,
    RaceTitle VARCHAR(150) NOT NULL,
    RaceTime VARCHAR(10) NOT NULL,
    RaceGrade VARCHAR(30) NOT NULL,
    RaceType VARCHAR(30) NOT NULL,
    DistanceFurlongs DECIMAL(5,2),
    TotalPrizeFund DECIMAL(18,2)
);

CREATE TABLE Dim_Trainer (
    TrainerKey INT NOT NULL,
    TrainerName VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
);

CREATE TABLE Dim_Jockey (
    JockeyKey INT NOT NULL,
    JockeyName VARCHAR(100) NOT NULL
);

CREATE TABLE Dim_Horse (
    HorseKey INT NOT NULL,
    HorseName VARCHAR(100) NOT NULL,
    Age INT,
    Sex VARCHAR(10)
);

-- 2. Fact Table
CREATE TABLE Fact_Race_Runner (
    RunnerFactKey BIGINT NOT NULL,
    RaceKey INT NOT NULL,
    DateKey INT NOT NULL,
    HorseKey INT NOT NULL,
    TrainerKey INT NOT NULL,
    JockeyKey INT NOT NULL,
    FinishingPosition INT,
    StartingPrice VARCHAR(20),
    DecimalOdds DECIMAL(8,3),
    ImpliedProbability DECIMAL(6,4),
    IsWinner INT NOT NULL,
    IsPlaced INT NOT NULL,
    PrizeMoneyWon DECIMAL(18,2)
);

-- 1. Populate Dim_Date
INSERT INTO Dim_Date (DateKey, RaceDate, DayName, FestivalDayName) VALUES
(20260310, '2026-03-10', 'Tuesday', 'Day 1 - Champion Day'),
(20260311, '2026-03-11', 'Wednesday', 'Day 2 - Ladies Day'),
(20260312, '2026-03-12', 'Thursday', 'Day 3 - St Patrick''s Day'),
(20260313, '2026-03-13', 'Friday', 'Day 4 - Gold Cup Day');

-- 2. Populate Dim_Race
INSERT INTO Dim_Race (RaceKey, RaceId, RaceTitle, RaceTime, RaceGrade, RaceType, DistanceFurlongs, TotalPrizeFund) VALUES
(1, 'CHELT_2026_D1_R4', 'Champion Hurdle', '16:00', 'Grade 1', 'Hurdle', 16.5, 450000.00),
(2, 'CHELT_2026_D2_R3', 'Grand Annual Chase', '16:40', 'Handicap', 'Chase', 16.0, 150000.00),
(3, 'CHELT_2026_D2_R4', 'Queen Mother Champion Chase', '16:00', 'Grade 1', 'Chase', 16.0, 400000.00),
(4, 'CHELT_2026_D3_R4', 'Ryanair Chase', '16:00', 'Grade 1', 'Chase', 20.5, 375000.00),
(5, 'CHELT_2026_D4_R1', 'Triumph Hurdle', '13:20', 'Grade 1', 'Hurdle', 16.0, 150000.00),
(6, 'CHELT_2026_D4_R4', 'Cheltenham Gold Cup', '16:00', 'Grade 1', 'Chase', 26.0, 625000.00);

-- 3. Populate Dim_Trainer
INSERT INTO Dim_Trainer (TrainerKey, TrainerName, Country) VALUES
(1, 'W P Mullins', 'IRE'),
(2, 'Gordon Elliott', 'IRE'),
(3, 'Dan Skelton', 'UK'),
(4, 'Venetia Williams', 'UK'),
(5, 'Henry De Bromhead', 'IRE'),
(6, 'Nicky Henderson', 'UK');

-- 4. Populate Dim_Jockey
INSERT INTO Dim_Jockey (JockeyKey, JockeyName) VALUES
(1, 'Paul Townend'),
(2, 'Jack Kennedy'),
(3, 'Harry Skelton'),
(4, 'Charlie Deutsch'),
(5, 'Darragh O''Keeffe'),
(6, 'Nico de Boinville'),
(7, 'Patrick Mullins');

-- 5. Populate Dim_Horse
INSERT INTO Dim_Horse (HorseKey, HorseName, Age, Sex) VALUES
(1, 'Lossiemouth', 7, 'Mare'),
(2, 'Brighterdaysahead', 6, 'Mare'),
(3, 'The New Lion', 7, 'Gelding'),
(4, 'Martator', 9, 'Gelding'),
(5, 'Il Etait Temps', 8, 'Gelding'),
(6, 'Heart Wood', 8, 'Gelding'),
(7, 'Jonbon', 10, 'Gelding'),
(8, 'Apolon De Charnie', 4, 'Gelding'),
(9, 'Gaelic Warrior', 8, 'Gelding'),
(10, 'Jango Baie', 7, 'Gelding');

-- 6. Populate Fact_Race_Runner
INSERT INTO Fact_Race_Runner (
    RunnerFactKey, RaceKey, DateKey, HorseKey, TrainerKey, JockeyKey, 
    FinishingPosition, StartingPrice, DecimalOdds, ImpliedProbability, IsWinner, IsPlaced, PrizeMoneyWon
) VALUES
-- Champion Hurdle
(101, 1, 20260310, 1, 1, 1, 1, '7/5f', 2.400, 0.4167, 1, 1, 253000.00),
(102, 1, 20260310, 2, 2, 2, 2, '7/2', 4.500, 0.2222, 0, 1, 95000.00),
(103, 1, 20260310, 3, 3, 3, 3, '3/1', 4.000, 0.2500, 0, 1, 47500.00),

-- Grand Annual (Venetia Williams 66/1 longshot winner)
(104, 2, 20260311, 4, 4, 4, 1, '66/1', 67.000, 0.0149, 1, 1, 84000.00),

-- Queen Mother Champion Chase (Il Etait Temps)
(105, 3, 20260311, 5, 1, 1, 1, '5/2', 3.500, 0.2857, 1, 1, 225000.00),

-- Ryanair Chase (Heart Wood beats Jonbon)
(106, 4, 20260312, 6, 5, 5, 1, '9/2', 5.500, 0.1818, 1, 1, 211000.00),
(107, 4, 20260312, 7, 6, 6, 2, '2/1f', 3.000, 0.3333, 0, 1, 79000.00),

-- Triumph Hurdle (Apolon De Charnie 50/1 upset)
(108, 5, 20260313, 8, 1, 7, 1, '50/1', 51.000, 0.0196, 1, 1, 84000.00),

-- Cheltenham Gold Cup (Gaelic Warrior)
(109, 6, 20260313, 9, 1, 1, 1, '11/4jf', 3.750, 0.2667, 1, 1, 351000.00),
(110, 6, 20260313, 10, 6, 6, 2, '11/4jf', 3.750, 0.2667, 0, 1, 132000.00);