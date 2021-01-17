import time
import random
import logging
import sys
import json
import collections
import psycopg2

from argparse import ArgumentParser, RawTextHelpFormatter


import psycopg2


conn = psycopg2.connect(
    user='root',
    database='defaultdb',
    port=26257,
    host='localhost'
)




def PASTEALL(conn):

    with conn.cursor() as cur:




        cur.execute("SELECT * FROM Players" )
        rows = cur.fetchall()

        objects_list = []
        for row in rows:

            d = collections.OrderedDict()

            d['id'] = row[0]
            d['name'] = row[1]
            objects_list.append(d)







        cur.execute("SELECT * FROM Games" )
        rows2 = cur.fetchall()

        objects_list2 = []
        for row2 in rows2:

            d2 = collections.OrderedDict()

            d2['id'] = row2[0]
            d2['title'] = row2[1]
            d2['description'] = row2[2]
            d2['tags'] = row2[3]
            d2['host'] = row2[4]
            objects_list2.append(d2)








        cur.execute("SELECT * FROM Tags" )
        rows3 = cur.fetchall()

        objects_list3 = []
        for row3 in rows3:

            d3 = collections.OrderedDict()

            d3['id'] = row3[0]
            d3['title'] = row3[1]
            d3['tag'] = row3[2]
            d3['value'] = row3[3]
            d3['hasScored'] = row3[4]
            objects_list3.append(d3)



        jsonD={}

        jsonD["users"]=objects_list
        jsonD["games"]=objects_list2
        jsonD["tags"]=objects_list3

        j= json.dumps(jsonD)



        #JList= objects_list + objects_list2 + objects_list3

        #j = json.dumps(JList)

        print(j)

        conn.close()




PASTEALL(conn)
