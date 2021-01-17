#imports

import time
import random
import logging
import sys

from argparse import ArgumentParser, RawTextHelpFormatter


import psycopg2
from psycopg2.errors import SerializationFailure





#NAME-ID
#METHOD TO CREATE NEW USER IN DB
def create_new_user(conn, ID, NAME):

    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO Players (ID, Name) VALUES ('%s', '%s')" % (ID,NAME)
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()

#METHOD TO UPDATE USER IN DB
def update_user(conn, ID, NAME):
    with conn.cursor() as cur:
        cur.execute(
            "UPDATE Players SET Name ='%s' WHERE ID='%s'" % (NAME, ID)
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()




#TITLE-TAGS-DESCRIPTION-ID-HOST
#METHOD TO CREATE NEW GAME IN DB
def create_new_Game(conn, ID, title, description, tags, host):
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO Games (ID, title, description, tags, host) VALUES ('%s', '%s', '%s', '%s', '%s')" % (ID, title, description, tags, host)
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()

#METHOD TO UPDATE GAME IN DB
def update_Game(conn, ID, title, description, tags, host):
    with conn.cursor() as cur:
        cur.execute(
            "UPDATE Games SET title='%s', description='%s', tags='%s', host='%s' WHERE ID='%s'" % (title, description, tags, host, ID)
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()





#TITLE-TAG-HASSCORED-VALUE-ID
#METHOD TO CREATE NEW TAG IN DB
def create_new_tag(conn, ID, title, tag, value, hasScored):
    value = int(value)
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO Tags (ID, title, tag, value, hasScored) VALUES ('%s', '%s', '%s', %d, '%s')" % (ID, title, tag, value, hasScored)
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()



#METHOD TO UPDATE TAG IN DB
def update_tag(conn, ID, title, tag, value, hasScored):
    value = int(value)
    with conn.cursor() as cur:
        cur.execute(
            "UPDATE Tags SET title='%s', tag='%s', value=%d, hasScored='%s' WHERE ID='%s'" % (title, tag, value, hasScored, ID)
        )

        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
    conn.commit()



if __name__ == "__main__":


    conn = psycopg2.connect(
    user='root',
    database='defaultdb',
    port=26257,
    host='localhost')


#players table
#runs when first arg=='Players'
    if (sys.argv[1]=='Players'):

        Param1=sys.argv[2]
        Param2=sys.argv[3]

        create_new_user(conn, Param1, Param2)

#update players table
#runs when first arg=='PlayersUpdate'
    if (sys.argv[1]=='PlayersUpdate'):

        Param1=sys.argv[2]
        Param2=sys.argv[3]
        Param3=sys.argv[4]

        update_user(conn, Param1, Param2, Param3)


#tags table
#runs when first arg=='Tags'
    if (sys.argv[1]=='Tags'):

        Param1=sys.argv[2]
        Param2=sys.argv[3]
        Param3=sys.argv[4]
        Param4=sys.argv[5]
        Param5=sys.argv[6]

        create_new_tag(conn, Param1, Param2, Param3, Param4, Param5)

#update Tags table
#runs when first arg=='TagsUpdate'
    if (sys.argv[1]=='TagsUpdate'):

        Param1=sys.argv[2]
        Param2=sys.argv[3]
        Param3=sys.argv[4]
        Param4=sys.argv[5]
        Param5=sys.argv[6]

        update_tag(conn, Param1, Param2, Param3, Param4, Param5)




#game table
#runs when first arg=='Game'
    if (sys.argv[1]=='Game'):

        Param1=sys.argv[2]
        Param2=sys.argv[3]
        Param3=sys.argv[4]
        Param4=sys.argv[5]
        Param5=sys.argv[6]

        create_new_Game(conn, Param1, Param2, Param3, Param4, Param5)

#update games table
#runs when first arg=='GameUpdate'
    if (sys.argv[1]=='GameUpdate'):

        Param1=sys.argv[2]
        Param2=sys.argv[3]
        Param3=sys.argv[4]
        Param4=sys.argv[5]
        Param5=sys.argv[6]

        update_Game(conn, Param1, Param2, Param3, Param4, Param5)
