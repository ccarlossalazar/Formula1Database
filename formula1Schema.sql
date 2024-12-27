CREATE TABLE IF NOT EXISTS constructors (
    constructorId INT AUTO_INCREMENT PRIMARY KEY,
    constructorRef VARCHAR(255),
    name VARCHAR(255),
    nationality VARCHAR(255),
    url VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS drivers (
    driverId INT AUTO_INCREMENT PRIMARY KEY,
    driverRef VARCHAR(255),
    forename VARCHAR(255),
    surname VARCHAR(255),
    dob DATE,
    nationality VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS circuits (
    circuitId INT AUTO_INCREMENT PRIMARY KEY, 
    circuitRef VARCHAR(255),
    name VARCHAR(255),
    location VARCHAR(255),
    country VARCHAR(255),
    lat DECIMAL(8, 6),
    lng DECIMAL(9, 6)
); 

CREATE TABLE IF NOT EXISTS seasons (
    year INT PRIMARY KEY,
    url VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS status (
    statusId INT AUTO_INCREMENT PRIMARY KEY, 
    status VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS races (
    raceId INT AUTO_INCREMENT PRIMARY KEY, 
    year INT,
    round INT,
    circuitId INT,
    seasonYear INT,
    name VARCHAR(255),
    date DATE,
    time TIME,
    url VARCHAR(255),
    FOREIGN KEY (seasonYear) REFERENCES seasons(year), 
    FOREIGN KEY (circuitId) REFERENCES circuits(circuitId)  
);

CREATE TABLE IF NOT EXISTS results (
    resultId INT AUTO_INCREMENT PRIMARY KEY, 
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    grid INT,
    position INT,
    positionText VARCHAR(255),
    positionOrder INT,
    points INT,
    laps INT,
    time VARCHAR(50),
    milliseconds INT,
    fastestLap VARCHAR(50),
    positionRank INT,
    fastestLapTime VARCHAR(50),
    fastestLapSpeed DECIMAL(10, 2),
    statusId INT,
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId), 
    FOREIGN KEY (driverId) REFERENCES drivers(driverId), 
    FOREIGN KEY (raceId) REFERENCES races(raceId), 
    FOREIGN KEY (statusId) REFERENCES status(statusId)  
);

CREATE TABLE IF NOT EXISTS constructor_results (
    constructorResultsId INT AUTO_INCREMENT PRIMARY KEY, 
    raceId INT,
    constructorId INT,
    points INT,
    status VARCHAR(255),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId), 
    FOREIGN KEY (raceId) REFERENCES races(raceId) 
);

CREATE TABLE IF NOT EXISTS constructor_standings (
    constructorStandingsId INT AUTO_INCREMENT PRIMARY KEY, 
    raceId INT,
    constructorId INT,
    points INT,
    position INT,
    positionText VARCHAR(255),
    wins INT,
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId), 
    FOREIGN KEY (raceId) REFERENCES races(raceId)  
);

CREATE TABLE IF NOT EXISTS driver_standings (
    driverStandingsId INT AUTO_INCREMENT PRIMARY KEY,  
    raceId INT,
    driverId INT,
    points INT,
    position INT,
    positionText VARCHAR(255),
    wins INT,
    FOREIGN KEY (driverId) REFERENCES drivers(driverId), 
    FOREIGN KEY (raceId) REFERENCES races(raceId) 
);

CREATE TABLE IF NOT EXISTS laptimes (
    raceId INT,
    driverId INT,
    lap INT,
    position INT,
    time VARCHAR(50),
    milliseconds INT,
    FOREIGN KEY (driverId) REFERENCES drivers(driverId), 
    FOREIGN KEY (raceId) REFERENCES races(raceId) 
);

CREATE TABLE IF NOT EXISTS pitstops (
    raceId INT,
    driverId INT,
    stop INT,
    lap INT,
    time VARCHAR(50),
    duration DECIMAL(10, 2),
    milliseconds INT,
    FOREIGN KEY (driverId) REFERENCES drivers(driverId), 
    FOREIGN KEY (raceId) REFERENCES races(raceId) 
);

CREATE TABLE IF NOT EXISTS qualifying (
    qualifyId INT AUTO_INCREMENT PRIMARY KEY, 
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    position INT,
    q1 VARCHAR(50),
    q2 VARCHAR(50),
    q3 VARCHAR(50),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId), 
    FOREIGN KEY (driverId) REFERENCES drivers(driverId), 
    FOREIGN KEY (raceId) REFERENCES races(raceId)  
);
