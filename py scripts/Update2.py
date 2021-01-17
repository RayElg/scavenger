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
            "INSERT INTO Players (ID, NAME, pointsCollected) VALUES (%s, %s, %s)", ID, NAME, POINTS
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()


def create_new_tag(conn, ID, NAME, POINTS):
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO Tags (ID, Tag, pointsCollected) VALUES (%s, %s, %s)", ID, NAME, POINTS
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
