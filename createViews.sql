CREATE VIEW VIEW_USER_INFORMATION AS
SELECT USERS.USER_ID, USERS.FIRST_NAME, USERS.LAST_NAME, USERS.YEAR_OF_BIRTH, USERS.MONTH_OF_BIRTH, USERS.DAY_OF_BIRTH, USERS.GENDER, CITIES.CITY_NAME, CITIES.STATE_NAME, CITIES.COUNTRY_NAME, PROGRAMS.INSTITUTION, EDUCATION.PROGRAM_YEAR, PROGRAMS.CONCENTRATION, PROGRAMS.DEGREE
FROM USERS
LEFT JOIN USER_CURRENT_CITIES ON  USERS.USER_ID = USER_CURRENT_CITIES.USER_ID
LEFT JOIN CITIES ON USER_CURRENT_CITIES.CURRENT_CITY_ID = CITIES.CITY_ID
LEFT JOIN USER_HOMETOWN_CITIES ON USERS.USER_ID = USER_HOMETOWN_CITIES.USER_ID
LEFT JOIN CITIES USER_HOMETOWN_CITIES ON USER_HOMETOWN_CITIES.CITY_ID = CITIES.CITY_ID
LEFT JOIN EDUCATION ON USERS.USER_ID = EDUCATION.USER_ID
LEFT JOIN PROGRAMS ON EDUCATION.PROGRAM_ID = PROGRAMS.PROGRAM_ID;



CREATE VIEW VIEW_ARE_FRIENDS AS
SELECT DISTINCT * 
FROM FRIENDS;

CREATE VIEW VIEW_PHOTO_INFORMATION AS
SELECT ALBUMS.ALBUM_ID, ALBUMS.ALBUM_OWNER_ID, ALBUMS.ALBUM_NAME, ALBUMS.ALBUM_CREATED_TIME, ALBUMS.ALBUM_MODIFIED_TIME, ALBUMS.ALBUM_LINK, ALBUMS.ALBUM_VISIBILITY, ALBUMS.COVER_PHOTO_ID , PHOTOS.PHOTO_ID, PHOTOS.PHOTO_CAPTION, PHOTOS.PHOTO_CREATED_TIME, PHOTOS.PHOTO_MODIFIED_TIME, PHOTOS.PHOTO_LINK
FROM ALBUMS
INNER JOIN PHOTOS ON PHOTOS.ALBUM_ID = ALBUMS.ALBUM_ID;


CREATE VIEW VIEW_EVENT_INFORMATION AS
SELECT USER_EVENTS.EVENT_ID, USER_EVENTS.EVENT_CREATOR_ID, USER_EVENTS.EVENT_NAME, USER_EVENTS.EVENT_TAGLINE, USER_EVENTS.EVENT_DESCRIPTION, USER_EVENTS.EVENT_HOST, USER_EVENTS.EVENT_TYPE, USER_EVENTS.EVENT_SUBTYPE, USER_EVENTS.EVENT_ADDRESS, CITIES.CITY_NAME, CITIES.STATE_NAME, CITIES.COUNTRY_NAME, USER_EVENTS.EVENT_START_TIME, USER_EVENTS.EVENT_END_TIME 
FROM USER_EVENTS
INNER JOIN CITIES ON USER_EVENTS.EVENT_CITY_ID = CITIES.CITY_ID; 

CREATE VIEW VIEW_TAG_INFORMATION AS
SELECT *
FROM TAGS;
