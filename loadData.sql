
INSERT INTO USERS(USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER)
SELECT DISTINCT USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER FROM project1.PUBLIC_USER_INFORMATION;



INSERT INTO CITIES (CITY_NAME, STATE_NAME, COUNTRY_NAME)
SELECT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY FROM PROJECT1.PUBLIC_USER_INFORMATION UNION SELECT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY FROM PROJECT1.PUBLIC_USER_INFORMATION;  






INSERT INTO USER_CURRENT_CITIES
SELECT DISTINCT PROJECT1.PUBLIC_USER_INFORMATION.USER_ID, CITIES.CITY_ID FROM PROJECT1.PUBLIC_USER_INFORMATION INNER JOIN CITIES ON PROJECT1.PUBLIC_USER_INFORMATION.CURRENT_CITY = CITIES.CITY_NAME AND PROJECT1.PUBLIC_USER_INFORMATION.CURRENT_STATE = CITIES.STATE_NAME AND PROJECT1.PUBLIC_USER_INFORMATION.CURRENT_COUNTRY = CITIES.COUNTRY_NAME; 



INSERT INTO USER_HOMETOWN_CITIES
SELECT DISTINCT PROJECT1.PUBLIC_USER_INFORMATION.USER_ID, CITIES.CITY_ID FROM PROJECT1.PUBLIC_USER_INFORMATION INNER JOIN CITIES ON PROJECT1.PUBLIC_USER_INFORMATION.HOMETOWN_CITY = CITIES.CITY_NAME AND PROJECT1.PUBLIC_USER_INFORMATION.HOMETOWN_STATE = CITIES.STATE_NAME AND PROJECT1.PUBLIC_USER_INFORMATION.HOMETOWN_COUNTRY = CITIES.COUNTRY_NAME;



INSERT INTO PROGRAMS(INSTITUTION, CONCENTRATION, DEGREE)
SELECT  DISTINCT INSTITUTION_NAME, PROGRAM_CONCENTRATION, PROGRAM_DEGREE  FROM project1.PUBLIC_USER_INFORMATION WHERE INSTITUTION_NAME IS NOT NULL;


INSERT INTO FRIENDS (USER1_ID, USER2_ID)
SELECT DISTINCT USER1_ID, USER2_ID FROM project1.PUBLIC_ARE_FRIENDS;


SET AUTOCOMMIT OFF
INSERT INTO PHOTOS (PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK)
SELECT DISTINCT PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK  FROM project1.PUBLIC_PHOTO_INFORMATION;

INSERT INTO ALBUMS(ALBUM_ID, ALBUM_OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID)
SELECT DISTINCT ALBUM_ID, OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID FROM project1.PUBLIC_PHOTO_INFORMATION;
COMMIT;
SET AUTOCOMMIT ON


INSERT INTO TAGS (TAG_PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X, TAG_Y)
SELECT PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE FROM project1.PUBLIC_TAG_INFORMATION;


INSERT INTO USER_EVENTS(EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_ADDRESS, EVENT_CITY_ID, EVENT_START_TIME, EVENT_END_TIME)
SELECT  DISTINCT EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_ADDRESS, CITIES.CITY_ID, EVENT_START_TIME, EVENT_END_TIME  FROM project1.PUBLIC_EVENT_INFORMATION, CITIES WHERE project1.PUBLIC_EVENT_INFORMATION.EVENT_CITY = CITIES.CITY_NAME AND project1.PUBLIC_EVENT_INFORMATION.EVENT_STATE = CITIES.STATE_NAME AND project1.PUBLIC_EVENT_INFORMATION.EVENT_COUNTRY = CITIES.COUNTRY_NAME;  


INSERT INTO EDUCATION(USER_ID, PROGRAM_ID, PROGRAM_YEAR) 
SELECT DISTINCT project1.PUBLIC_USER_INFORMATION.USER_ID, PROGRAMS.PROGRAM_ID, project1.PUBLIC_USER_INFORMATION.PROGRAM_YEAR FROM project1.PUBLIC_USER_INFORMATION INNER JOIN PROGRAMS ON project1.PUBLIC_USER_INFORMATION.INSTITUTION_NAME = PROGRAMS.INSTITUTION AND project1.PUBLIC_USER_INFORMATION.PROGRAM_CONCENTRATION = CONCENTRATION AND project1.PUBLIC_USER_INFORMATION.PROGRAM_DEGREE = PROGRAMS.DEGREE;
