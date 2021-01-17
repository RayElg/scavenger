# Scavenger

## What it does
Scavenger provides a platform for users to create & participate together in scavenger hunts. Users capture their findings with their phone camera, and the app automatically checks the items off the list.

Scavenger provides the option for regular games (for fun!), or for games with alternate labels (for learning!). A french teacher could example add "Stylo" to their scavenger hunt, with students able to check this item off by taking a picture of a pen.

## How we built it

We built the frontend for the app in Flutter/dart, and the backend in php/python using a local cockroachDB cluster to store data. 

After the user captures an image, it is encoded as a base64 String, and sent in a POST request to google vision. Google vision handles the labeling of the data, and sends back some labels. If any of the labels match the scavenger hunt, the user is awarded points.

**Backend code: in ./py scripts/**  
**Frontend code: everywhere else**    
**What's not here: auth.dart (holds api key)**  

## Challenges we ran into

1) Issues with the remote cockroachDB cluster (luckily we could spin up a local one)
2) Our relatively nice code slowly becoming spaghetti

## Accomplishments that we're proud of

It works(!), and is well integrated with the database backend and the vision API. It's something that we actually want and plan to use!

## What we learned

Mitch: Flutter
Asgar: CockroachDB & PostGreSQL
Raynor: HTTP & GCP API


## What's next for Scavenger

* Beautification
* Proper login (not just the mockup we currently have)
* Smooth the process
* Migrate google vision API request to backend (so we can actually release the .apk without worrying about leaking our key)
* Clean up ugly code
