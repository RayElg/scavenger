#imports 

import time
import random
import logging
import sys

from argparse import ArgumentParser, RawTextHelpFormatter


import psycopg2
from psycopg2.errors import SerializationFailure



#METHOD TO CREATE NEW USER IN DB
def create_new_user(conn, ID, NAME, POINTS):
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO Players (ID, Name, pointsCollected) VALUES ('%s', '%s', %s)", ID, NAME, POINTS
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()


#METHOD TO CREATE NEW TAG IN DB
def create_new_tag(conn, ID, Tag, Title, Value, HasScored):
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO Tags (ID, Tag, Title, Value, HasScored) VALUES ('%s', '%s', '%s', %s, '%s')", ID, Tag, Title, Value, HasScored
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()


#METHOD TO CREATE NEW GAME IN DB
def create_new_Game(conn, ID, Tags, GameTitle, GameHOST):
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO Tags (ID, Tag, Title, Value) VALUES (%s, %s, %s, %s)", ID, Tags, GameTitle, GameHOST
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()






if __name__ == "__main__":

    opt = parse_cmdline()
    logging.basicConfig(level=logging.DEBUG if opt.verbose else logging.INFO)

    conn = psycopg2.connect(opt.dsn)

    if (sys.argv[1]=='Players'):

        ID=argv[2]
        NAME=argv[3]
        POINTS=argv[4]
        create_new_user(conn, ID, NAME, POINTS)


    if (sys.argv[1]=='Tags'):

        ID=argv[2]
        Tag=argv[3]
        Title=argv[4]
        Value=argv[5]
        HasScored=argv[6]
        create_new_tag(conn, ID, Tag, Title, Value, HasScored)

    if (sys.argv[2]=='Game'):

        ID=argv[2]
        Tags=argv[3]
        GameTitle=argv[4]
        GameHOST=argv[5]
        create_new_Game(conn, ID, Tags, GameTitle, GameHOST)




