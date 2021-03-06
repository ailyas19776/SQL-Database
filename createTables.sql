CREATE TABLE USERS(
        USER_ID INTEGER PRIMARY KEY,
        FIRST_NAME VARCHAR2(100) NOT NULL,
        LAST_NAME varchar2(100) NOT NULL,
        YEAR_OF_BIRTH INTEGER,
        MONTH_OF_BIRTH INTEGER,
        DAY_OF_BIRTH INTEGER,
        GENDER VARCHAR2(100)
);

CREATE TABLE FRIENDS(
        USER1_ID INTEGER NOT NULL,
        USER2_ID INTEGER NOT NULL,
        PRIMARY KEY (USER1_ID, USER2_ID),
	FOREIGN KEY (USER1_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY (USER2_ID) REFERENCES USERS(USER_ID)
);

CREATE TRIGGER ORDER_FRIENDS_PAIRS
BEFORE INSERT ON FRIENDS
FOR EACH ROW
DECLARE temp NUMBER;
BEGIN
	IF :NEW.USER1_ID > :NEW.USER2_ID THEN
		temp := :NEW.USER2_ID;
		:NEW.USER2_ID := :NEW.USER1_ID;
		:NEW.USER1_ID := temp;
	END IF;
END;
/



CREATE TABLE CITIES(
        CITY_ID INTEGER PRIMARY KEY,
        CITY_NAME VARCHAR2(100) NOT NULL,
        STATE_NAME varchar2(100) NOT NULL,
        COUNTRY_NAME varchar2(100) NOT NULL,
        UNIQUE (CITY_NAME, STATE_NAME, COUNTRY_NAME)
);

CREATE SEQUENCE CITY_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER CITY_TRIG
BEFORE INSERT ON CITIES
FOR EACH ROW
BEGIN
	SELECT CITY_SEQ.NEXTVAL INTO :NEW.CITY_ID FROM DUAL;
END;
/

/* USE DISTINCT FOR COMBINATION */
CREATE TABLE USER_CURRENT_CITIES( 
        USER_ID NUMBER PRIMARY KEY,
        CURRENT_CITY_ID INTEGER NOT NULL,
	FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY (CURRENT_CITY_ID) REFERENCES CITIES(CITY_ID)
);

CREATE TABLE USER_HOMETOWN_CITIES(
        USER_ID NUMBER PRIMARY KEY,
        HOMETOWN_CITY_ID INTEGER NOT NULL,
        FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
        FOREIGN KEY (HOMETOWN_CITY_ID) REFERENCES CITIES(CITY_ID)
);

CREATE TABLE MESSAGES(
        MESSAGE_ID NUMBER,
        SENDER_ID NUMBER NOT NULL,
        RECEIVER_ID NUMBER NOT NULL,
        MESSAGE_CONTENT VARCHAR2(2000) NOT NULL,
        SENT_TIME TIMESTAMP NOT NULL,
	PRIMARY KEY (MESSAGE_ID),
	FOREIGN KEY (SENDER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY (RECEIVER_ID) REFERENCES USERS(USER_ID)
);

CREATE TABLE PROGRAMS(
        PROGRAM_ID INTEGER PRIMARY KEY,
        INSTITUTION VARCHAR2(100) NOT NULL, -- SINGLE LINE COMMENT
        CONCENTRATION VARCHAR2(100) NOT NULL,
        DEGREE VARCHAR2(100) NOT NULL,
	UNIQUE (INSTITUTION, CONCENTRATION, DEGREE)
);


CREATE SEQUENCE PROGRAM_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TRIGGER PROGRAM_TRIG
BEFORE INSERT ON PROGRAMS
FOR EACH ROW
BEGIN
	SELECT PROGRAM_SEQ.NEXTVAL INTO :NEW.PROGRAM_ID FROM DUAL;
END;
/


CREATE TABLE EDUCATION(
        USER_ID NUMBER,
        PROGRAM_ID INTEGER,
        PROGRAM_YEAR INTEGER NOT NULL,
	PRIMARY KEY (USER_ID, PROGRAM_ID),
	FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY (PROGRAM_ID) REFERENCES PROGRAMS(PROGRAM_ID)
);

CREATE TABLE USER_EVENTS(
        EVENT_ID NUMBER PRIMARY KEY,
        EVENT_CREATOR_ID NUMBER NOT NULL,
        EVENT_NAME VARCHAR2(100) NOT NULL,
        EVENT_TAGLINE VARCHAR2(100),
        EVENT_DESCRIPTION VARCHAR2(100),
        EVENT_HOST VARCHAR2(100),
        EVENT_TYPE VARCHAR2(100),
        EVENT_SUBTYPE VARCHAR2(100),
        EVENT_ADDRESS VARCHAR2(2000),
        EVENT_CITY_ID INTEGER NOT NULL,
        EVENT_START_TIME TIMESTAMP,
        EVENT_END_TIME TIMESTAMP,
	FOREIGN KEY (EVENT_CREATOR_ID) REFERENCES USERS(USER_ID),
	FOREIGN KEY (EVENT_CITY_ID) REFERENCES CITIES(CITY_ID)	
);

CREATE TABLE PARTICIPANTS(
        EVENT_ID NUMBER,
	USER_ID NUMBER,
        CONFIRMATION VARCHAR2(100) NOT NULL CONSTRAINT PARTICIPANTS_1 CHECK (CONFIRMATION = 'ATTENDING' OR CONFIRMATION = 'UNSURE' OR CONFIRMATION = 'DECLINES' OR CONFIRMATION = 'NOT_REPLIED'),
	PRIMARY KEY (EVENT_ID, USER_ID),
	FOREIGN KEY (EVENT_ID) REFERENCES USER_EVENTS(EVENT_ID),
	FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);


CREATE TABLE ALBUMS(
        ALBUM_ID NUMBER PRIMARY KEY,
        ALBUM_OWNER_ID NUMBER NOT NULL,
        ALBUM_NAME VARCHAR2(100) NOT NULL,
        ALBUM_CREATED_TIME TIMESTAMP NOT NULL,
        ALBUM_MODIFIED_TIME TIMESTAMP,
        ALBUM_LINK VARCHAR2(100) NOT NULL,
        ALBUM_VISIBILITY VARCHAR2(100) NOT NULL CHECK (ALBUM_VISIBILITY = 'EVERYONE' OR ALBUM_VISIBILITY = 'FRIENDS' OR ALBUM_VISIBILITY = 'FRIENDS_OF_FRIENDS' OR ALBUM_VISIBILITY = 'MYSELF'),
        COVER_PHOTO_ID NUMBER NOT NULL,
	FOREIGN KEY (ALBUM_OWNER_ID) REFERENCES USERS(USER_ID) 
);


CREATE TABLE PHOTOS(
        PHOTO_ID NUMBER PRIMARY KEY,
        ALBUM_ID NUMBER NOT NULL,
        PHOTO_CAPTION VARCHAR2(2000),
        PHOTO_CREATED_TIME TIMESTAMP NOT NULL,
        PHOTO_MODIFIED_TIME TIMESTAMP,
        PHOTO_LINK VARCHAR2(2000) NOT NULL
);

ALTER TABLE ALBUMS
ADD CONSTRAINT ALBUM_CONSTRAINT
FOREIGN KEY (COVER_PHOTO_ID) REFERENCES PHOTOS(PHOTO_ID)
INITIALLY DEFERRED DEFERRABLE;


ALTER TABLE PHOTOS
ADD CONSTRAINT PHOTO_CONSTRAINT
FOREIGN KEY (ALBUM_ID) REFERENCES ALBUMS(ALBUM_ID)
INITIALLY DEFERRED DEFERRABLE;



CREATE TABLE TAGS(
        TAG_PHOTO_ID NUMBER,
        TAG_SUBJECT_ID NUMBER,
        TAG_CREATED_TIME TIMESTAMP NOT NULL,
        TAG_X NUMBER NOT NULL,
        TAG_Y NUMBER NOT NULL,
        PRIMARY KEY(TAG_PHOTO_ID, TAG_SUBJECT_ID),
	FOREIGN KEY (TAG_PHOTO_ID) REFERENCES PHOTOS(PHOTO_ID),
	FOREIGN KEY (TAG_SUBJECT_ID) REFERENCES USERS(USER_ID)
);
