# -*- coding: utf-8 -*-

# Reducerar en json på 1900 rader till 27 unika signaturer.
# Kan användas till att få förståelse för en json-struktur.

#s = [ {'name':'Christer', 'born':1954, 'phones':['070-7496800', '0435-10125']}, {'name':'Kasper', 'born':1982, 'phones':['08-7041920']}]

s = {
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "import yaml\n",
    "def dump(s): # json to yaml\n",
    "    s = yaml.dump(s, default_flow_style = False) #, width=100, indent=2\n",
    "    s = s.replace('!!python/unicode ','')\n",
    "    s = s.replace(\"'\",'')\n",
    "    return s"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "import urllib2\n",
    "import json\n",
    "\n",
    "def turf(command,params=None):\n",
    "    req = urllib2.Request('http://api.turfgame.com/v4/'+command)\n",
    "    req.add_header('Content-Type', 'application/json')\n",
    "    if params==None:\n",
    "        response = urllib2.urlopen(req)\n",
    "    else:    \n",
    "        response = urllib2.urlopen(req, json.dumps(params))\n",
    "    return json.load(response) "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "2015-10-17 20:20:15.864000 FemteMyran\n"
     ]
    },
    {
     "ename": "KeyboardInterrupt",
     "evalue": "",
     "output_type": "error",
     "traceback": [
      "\u001b[1;31m---------------------------------------------------------------------------\u001b[0m",
      "\u001b[1;31mKeyboardInterrupt\u001b[0m                         Traceback (most recent call last)",
      "\u001b[1;32m<ipython-input-19-4392602f694a>\u001b[0m in \u001b[0;36m<module>\u001b[1;34m()\u001b[0m\n\u001b[0;32m      6\u001b[0m     \u001b[0mowner\u001b[0m \u001b[1;33m=\u001b[0m \u001b[0mz\u001b[0m\u001b[1;33m[\u001b[0m\u001b[1;34m'currentOwner'\u001b[0m\u001b[1;33m]\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0;32m      7\u001b[0m     \u001b[1;32mprint\u001b[0m \u001b[0mdatetime\u001b[0m\u001b[1;33m.\u001b[0m\u001b[0mnow\u001b[0m\u001b[1;33m(\u001b[0m\u001b[1;33m)\u001b[0m\u001b[1;33m,\u001b[0m\u001b[0mowner\u001b[0m\u001b[1;33m[\u001b[0m\u001b[1;34m'name'\u001b[0m\u001b[1;33m]\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[1;32m----> 8\u001b[1;33m     \u001b[0msleep\u001b[0m\u001b[1;33m(\u001b[0m\u001b[1;36m60\u001b[0m\u001b[1;33m)\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0m",
      "\u001b[1;31mKeyboardInterrupt\u001b[0m: "
     ]
    }
   ],
   "source": [
    "from datetime import datetime\n",
    "from time import sleep\n",
    "while True:\n",
    "    s = turf(\"zones\",[{'name' : 'Skarpzone'}])\n",
    "    z = s[0]\n",
    "    owner = z['currentOwner']\n",
    "    print datetime.now(),owner['name']\n",
    "    sleep(60)    "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "['[{\"region\":{\"id\":141,\"name\":\"Stockholm\"},\"medals\":[55,34,13,47,28,4,22,5,67,70,16],\"pointsPerHour\":2,\"blocktime\":28,\"zones\":[54765],\"country\":\"se\",\"id\":123270,\"rank\":28,\"name\":\"StrollingBones\",\"uniqueZonesTaken\":396,\"taken\":1255,\"points\":17672,\"place\":989,\"totalPoints\":243215}]']\n",
      "[{'uniqueZonesTaken': 396, 'pointsPerHour': 2, 'rank': 28, 'zones': [54765], 'id': 123270, 'totalPoints': 243215, 'name': 'StrollingBones', 'country': 'se', 'region': {'id': 141, 'name': 'Stockholm'}, 'blocktime': 28, 'points': 17672, 'place': 989, 'taken': 1255, 'medals': [55, 34, 13, 47, 28, 4, 22, 5, 67, 70, 16]}]\n",
      "\n",
      "[\n",
      "    {\n",
      "        \"uniqueZonesTaken\": 396, \n",
      "        \"pointsPerHour\": 2, \n",
      "        \"rank\": 28, \n",
      "        \"zones\": [\n",
      "            54765\n",
      "        ], \n",
      "        \"id\": 123270, \n",
      "        \"totalPoints\": 243215, \n",
      "        \"name\": \"StrollingBones\", \n",
      "        \"country\": \"se\", \n",
      "        \"region\": {\n",
      "            \"id\": 141, \n",
      "            \"name\": \"Stockholm\"\n",
      "        }, \n",
      "        \"blocktime\": 28, \n",
      "        \"points\": 17672, \n",
      "        \"place\": 989, \n",
      "        \"taken\": 1255, \n",
      "        \"medals\": [\n",
      "            55, \n",
      "            34, \n",
      "            13, \n",
      "            47, \n",
      "            28, \n",
      "            4, \n",
      "            22, \n",
      "            5, \n",
      "            67, \n",
      "            70, \n",
      "            16\n",
      "        ]\n",
      "    }\n",
      "]\n",
      "\n",
      "- blocktime: 28\n",
      "  country: se\n",
      "  id: 123270\n",
      "  medals:\n",
      "  - 55\n",
      "  - 34\n",
      "  - 13\n",
      "  - 47\n",
      "  - 28\n",
      "  - 4\n",
      "  - 22\n",
      "  - 5\n",
      "  - 67\n",
      "  - 70\n",
      "  - 16\n",
      "  name: StrollingBones\n",
      "  place: 989\n",
      "  points: 17672\n",
      "  pointsPerHour: 2\n",
      "  rank: 28\n",
      "  region:\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  taken: 1255\n",
      "  totalPoints: 243215\n",
      "  uniqueZonesTaken: 396\n",
      "  zones:\n",
      "  - 54765\n",
      "\n"
     ]
    }
   ],
   "source": [
    "import json\n",
    "data = [] \n",
    "s = !curl --raw -s -H \"Content-Type: application/json\" -X POST -d \"[{\\\"name\\\" : \\\"StrollingBones\\\"}]\" http://api.turfgame.com/v4/users\n",
    "print s    \n",
    "data = eval(s[0])\n",
    "print data\n",
    "print\n",
    "print json.dumps(data,indent=4)\n",
    "print\n",
    "print dump(data)    "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 445,
   "metadata": {
    "collapsed": True
   },
   "outputs": [],
   "source": [
    "takeovers = turf('feeds/takeover')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 447,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "yyy Skarpzone 2015-09-09T12:22:21+0000\n",
      "yyy SandFieldZone 2015-09-09T12:17:40+0000\n",
      "yyy LotsOfDogs 2015-09-09T12:15:47+0000\n",
      "yyy Hundpark 2015-09-09T12:14:20+0000\n"
     ]
    }
   ],
   "source": [
    "for to in takeovers: # verkar bara ge sista tio minuterna.\n",
    "    if to[\"zone\"][\"region\"][\"name\"]==\"Stockholm\":\n",
    "        if to[\"currentOwner\"][\"name\"]==\"yyy\":\n",
    "            #print dump(to)\n",
    "            print to[\"currentOwner\"][\"name\"],to[\"zone\"][\"name\"],to[\"time\"]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 457,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "2015-09-08T19:28:16+0000 freddi Pungpinan\n",
      "2015-09-09T11:53:39+0000 yyy Listudden\n",
      "2015-09-09T11:57:05+0000 yyy Tätorpan\n",
      "2015-09-09T12:02:07+0000 yyy TimeSpot\n",
      "2015-09-09T12:04:24+0000 yyy Eragon\n",
      "2015-09-09T12:07:05+0000 yyy Riksrådet\n",
      "2015-09-09T12:11:21+0000 yyy Horizone\n",
      "2015-09-09T12:14:20+0000 yyy Hundpark\n",
      "2015-09-09T12:15:47+0000 yyy LotsOfDogs\n",
      "2015-09-09T12:17:40+0000 yyy SandFieldZone\n",
      "2015-09-09T12:22:21+0000 yyy Skarpzone\n"
     ]
    }
   ],
   "source": [
    "_ =turf('zones',[{'name':z[\"name\"]} for z in route])\n",
    "_.sort(key = lambda z : z[\"dateLastTaken\"])\n",
    "for z in _:\n",
    "    #print z\n",
    "    print z[\"dateLastTaken\"],z[\"currentOwner\"][\"name\"],z[\"name\"]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 373,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "62\n",
      "Gymrat Bogards 2015-09-08T23:20:13+0000\n",
      "Fibban HornZone 2015-09-08T23:19:57+0000\n",
      "Merrick KingsGarden 2015-09-08T23:19:32+0000\n",
      "Fibban Mariatorget 2015-09-08T23:17:27+0000\n",
      "Merrick Norrmalmstorg 2015-09-08T23:16:45+0000\n",
      "Fibban SödraStation 2015-09-08T23:14:52+0000\n",
      "Merrick NybroZone 2015-09-08T23:14:32+0000\n",
      "Fibban HalfMoonZone 2015-09-08T23:13:21+0000\n",
      "Merrick Nybrokajen 2015-09-08T23:11:55+0000\n",
      "Fibban MediZone 2015-09-08T23:11:39+0000\n",
      "Gymrat Churchzone 2015-09-08T23:10:22+0000\n",
      "Fibban BearZone 2015-09-08T23:10:22+0000\n",
      "Merrick ShipZone 2015-09-08T23:09:50+0000\n",
      "Merrick Strömkajen 2015-09-08T23:07:57+0000\n",
      "Fibban Mosebacke 2015-09-08T23:07:11+0000\n",
      "Gymrat Sandsborg 2015-09-08T23:06:12+0000\n",
      "pancosmic AkallaT 2015-09-08T23:06:10+0000\n"
     ]
    }
   ],
   "source": [
    "#print dump(takeovers)\n",
    "print len(takeovers0100)\n",
    "for to in takeovers:\n",
    "    if to[\"zone\"][\"region\"][\"name\"]==\"Stockholm\":\n",
    "        print to[\"currentOwner\"][\"name\"],to[\"zone\"][\"name\"],to[\"time\"]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 372,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "64\n",
      "Gymrat Bogards 2015-09-08T23:20:13+0000\n",
      "Fibban HornZone 2015-09-08T23:19:57+0000\n",
      "Merrick KingsGarden 2015-09-08T23:19:32+0000\n",
      "Fibban Mariatorget 2015-09-08T23:17:27+0000\n",
      "Merrick Norrmalmstorg 2015-09-08T23:16:45+0000\n",
      "Fibban SödraStation 2015-09-08T23:14:52+0000\n",
      "Merrick NybroZone 2015-09-08T23:14:32+0000\n",
      "Fibban HalfMoonZone 2015-09-08T23:13:21+0000\n",
      "Merrick Nybrokajen 2015-09-08T23:11:55+0000\n",
      "Fibban MediZone 2015-09-08T23:11:39+0000\n",
      "Gymrat Churchzone 2015-09-08T23:10:22+0000\n",
      "Fibban BearZone 2015-09-08T23:10:22+0000\n",
      "Merrick ShipZone 2015-09-08T23:09:50+0000\n",
      "Merrick Strömkajen 2015-09-08T23:07:57+0000\n",
      "Fibban Mosebacke 2015-09-08T23:07:11+0000\n",
      "Gymrat Sandsborg 2015-09-08T23:06:12+0000\n",
      "pancosmic AkallaT 2015-09-08T23:06:10+0000\n"
     ]
    }
   ],
   "source": [
    "print len(takeovers0120)\n",
    "for to in takeovers:\n",
    "    if to[\"zone\"][\"region\"][\"name\"]==\"Stockholm\":\n",
    "        print to[\"currentOwner\"][\"name\"],to[\"zone\"][\"name\"],to[\"time\"]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 378,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "u = turf('users',[{'name':'Gymrat'}])[0]\n",
    "ids = [{'id':id} for id in u[\"zones\"]]\n",
    "zones = turf(\"zones\",ids)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 403,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      "2015-09-06T14 1 TrollKrysset\n",
      "2015-09-08T20 10 SandTennis Longswordzone Tågbroarna SugarLane VickerZone Winterzone EriksdalsRaps RosenlundZone SouthAllén Ånghästen\n",
      "2015-09-08T21 10 TantoTreeZone GlobalZink HighlidZone LillyBridge SillyLilly MarievikPark Rundilen Årstadal Solbrygga SeaBayHill\n",
      "2015-09-08T22 20 ÅrstaBergStn PaintingLake ÅrstaSiljan SandInletZone LostHighway Odelzone ReMember Pylonen DragoLand Stralsund Revalen AndraSkedet FörstaSkedet Trädskolan Plantskolan SockenplanT Spoontan StingAntT Murklan Maggan\n",
      "2015-09-08T23 4 BirdSwamp Sandsborg Churchzone Bogards\n",
      "2015-09-06T18 5 Catnose PysselParken HagsätraSport Klockhammar Cuckoo\n",
      "2015-09-08T19 14 Bakverksträd Gubbängenmot Gubbzone HökenT Hökisbron GubbSpeedway OttekilGlänta Ottekilen Earvillage SturesBoll BollstaWoods Skönsmo StamPark Eldsberget\n"
     ]
    }
   ],
   "source": [
    "zones.sort(key = lambda x : x[\"dateLastTaken\"])\n",
    "#for z in zones:\n",
    "    #print z[\"dateLastTaken\"],z[\"name\"]\n",
    "print\n",
    "\n",
    "values = set(map(lambda z:z[\"dateLastTaken\"][0:13], zones))\n",
    "newlist = [[x,[z[\"name\"] for z in zones if z[\"dateLastTaken\"][0:13]==x]] for x in values]\n",
    "for ts,g in newlist:\n",
    "    print ts,len(g),' '.join(g)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {
    "collapsed": True
   },
   "outputs": [],
   "source": [
    "from math import radians, cos, sin, asin, sqrt\n",
    "def haversine(a,b):\n",
    "    \"\"\"\n",
    "    Calculate the great circle distance between two points on the earth (specified in decimal degrees)\n",
    "    \"\"\"\n",
    "    lon1 = a[\"longitude\"]\n",
    "    lat1 = a[\"latitude\"]\n",
    "    lon2 = b[\"longitude\"]\n",
    "    lat2 = b[\"latitude\"]\n",
    "    # convert decimal degrees to radians \n",
    "    lon1, lat1, lon2, lat2 = map(radians, [lon1, lat1, lon2, lat2])\n",
    "    # haversine formula \n",
    "    dlon = lon2 - lon1 \n",
    "    dlat = lat2 - lat1 \n",
    "    a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2\n",
    "    c = 2 * asin(sqrt(a)) \n",
    "    m = 6367 * c * 1000\n",
    "    return m"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "import math\n",
    "\n",
    "def length(n1, n2):\n",
    "    return dist_matrix.distance(n1,n2)\n",
    "\n",
    "class Node(object):\n",
    "    def __init__(self, name,longitude,latitude):\n",
    "        self.name = name\n",
    "        self.longitude = longitude\n",
    "        self.latitude = latitude\n",
    "\n",
    "def total_length(solution):\n",
    "    sum = 0\n",
    "    for i in range(len(solution)):\n",
    "        sum += length(solution[i], solution[(i+1) % len(solution)])\n",
    "    return sum"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {
    "collapsed": True
   },
   "outputs": [],
   "source": [
    "def avg(a,b):\n",
    "    lat = (a[\"latitude\"] + b[\"latitude\"])/2\n",
    "    long = (a[\"longitude\"] + b[\"longitude\"])/2\n",
    "    return str(lat) + \",\" + str(long)\n",
    "\n",
    "def lat_long(a):\n",
    "    return str(a[\"latitude\"]) + ',' + str(a[\"longitude\"])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 418,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "class DistMatrix(object):\n",
    "    def __init__(self,zone):\n",
    "        self.zones = [zone]  # [{name,longitude,latitude}]\n",
    "        self.matrix = [[0]]  # [[avstånd i meter]]\n",
    "        \n",
    "    def exist(self,zone,zones):\n",
    "        for z in zones:\n",
    "            if z[\"name\"] == zone[\"name\"]:\n",
    "                return True\n",
    "        return False    \n",
    "    \n",
    "    def distance(self,a,b): # hash,hash\n",
    "        row=-1\n",
    "        col=-1\n",
    "        for i in range(len(self.zones)):\n",
    "            z = self.zones[i]\n",
    "            if z[\"name\"] == a[\"name\"]:\n",
    "                row=i\n",
    "            if z[\"name\"] == b[\"name\"]:\n",
    "                col=i\n",
    "        if row==-1:\n",
    "            if self.add(a):\n",
    "                row=len(self.matrix)-1\n",
    "        if col==-1:\n",
    "            if self.add(b):\n",
    "                col=len(self.matrix)-1\n",
    "        if row!=-1 and col!=-1:\n",
    "            return self.matrix[row][col]\n",
    "        else:\n",
    "            return haversine(a,b) \n",
    "    \n",
    "    def add_col(self,response):\n",
    "        arr = response['rows']\n",
    "        for i in range(len(arr)):\n",
    "            elements = arr[i]['elements']\n",
    "            for j in range(len(elements)):\n",
    "                element = elements[j]\n",
    "                value = element['distance']['value']\n",
    "            self.matrix[i].append(value)\n",
    "\n",
    "    def add_row(self,response):\n",
    "        row = []\n",
    "        arr = response['rows']\n",
    "        for i in range(len(arr)):\n",
    "            elements = arr[i]['elements']\n",
    "            for j in range(len(elements)):\n",
    "                element = elements[j]\n",
    "                value = element['distance']['value']\n",
    "                row.append(value)\n",
    "        self.matrix.append(row)                    \n",
    "            \n",
    "    def add_zero(self):\n",
    "        n = len(self.matrix)\n",
    "        self.matrix[-1].append(0)\n",
    "        \n",
    "    def add(self,zone): # {name,longitude,latitude} Hämtar avstånd till befintliga zones om zonen ej är med i zones\n",
    "        if self.exist(zone,self.zones):\n",
    "            print zone[\"name\"] + \" is already in matrix\"\n",
    "            return True\n",
    "        else:\n",
    "            response1 = self.distance_matrix(self.zones,[zone])\n",
    "            response2 = self.distance_matrix([zone],self.zones)\n",
    "            if response1['status']=='OK' and response2['status']=='OK':    \n",
    "                self.add_col(response1)\n",
    "                self.add_row(response2)\n",
    "                self.add_zero()\n",
    "                self.zones.append(zone)\n",
    "                print \"Added \" + zone[\"name\"] + \" to matrix succesfully\"\n",
    "                return True\n",
    "            print \"Failed adding \" + zone[\"name\"] + \" to matrix\"\n",
    "            return False\n",
    "\n",
    "    def distance_matrix(self,zones1,zones2):\n",
    "        list1 = [lat_long(z) for z in zones1]\n",
    "        list2 = [lat_long(z) for z in zones2]\n",
    "        coords1 = '|'.join(list1)\n",
    "        coords2 = '|'.join(list2)\n",
    "        _url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=' + coords1 + '&destinations=' + coords2 + '&key=AIzaSyDEkImuzFYUhT7FGXxoev2BSQShw-y6eyc&mode=bicycling'\n",
    "        print len(_url)    \n",
    "        print _url\n",
    "        req = urllib2.Request(_url)\n",
    "        req.add_header('Content-Type', 'application/json')\n",
    "        return json.load(urllib2.urlopen(req))\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "yyy\n"
     ]
    }
   ],
   "source": [
    "home = {'name':'yyy', 'latitude':59.265200, 'longitude':18.132717, 'takeoverPoints':0 }\n",
    "print home['name']"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "ename": "NameError",
     "evalue": "name 'DistMatrix' is not defined",
     "output_type": "error",
     "traceback": [
      "\u001b[1;31m---------------------------------------------------------------------------\u001b[0m",
      "\u001b[1;31mNameError\u001b[0m                                 Traceback (most recent call last)",
      "\u001b[1;32m<ipython-input-9-13d43b3cfe12>\u001b[0m in \u001b[0;36m<module>\u001b[1;34m()\u001b[0m\n\u001b[1;32m----> 1\u001b[1;33m \u001b[0mdist_matrix\u001b[0m \u001b[1;33m=\u001b[0m \u001b[0mDistMatrix\u001b[0m\u001b[1;33m(\u001b[0m\u001b[0mhome\u001b[0m\u001b[1;33m)\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0m",
      "\u001b[1;31mNameError\u001b[0m: name 'DistMatrix' is not defined"
     ]
    }
   ],
   "source": [
    "dist_matrix = DistMatrix(home)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {
    "collapsed": False,
    "scrolled": False
   },
   "outputs": [
    {
     "ename": "NameError",
     "evalue": "name 'dist_matrix' is not defined",
     "output_type": "error",
     "traceback": [
      "\u001b[1;31m---------------------------------------------------------------------------\u001b[0m",
      "\u001b[1;31mNameError\u001b[0m                                 Traceback (most recent call last)",
      "\u001b[1;32m<ipython-input-8-5275c701e16b>\u001b[0m in \u001b[0;36m<module>\u001b[1;34m()\u001b[0m\n\u001b[0;32m      3\u001b[0m \u001b[1;31m#print len(dist_matrix.matrix),\"zoner i matrisen\"\u001b[0m\u001b[1;33m\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0;32m      4\u001b[0m \u001b[1;31m#print[zone[\"name\"] for zone in dist_matrix.zones]\u001b[0m\u001b[1;33m\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[1;32m----> 5\u001b[1;33m \u001b[1;32mprint\u001b[0m \u001b[0mdist_matrix\u001b[0m\u001b[1;33m.\u001b[0m\u001b[0mmatrix\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0m",
      "\u001b[1;31mNameError\u001b[0m: name 'dist_matrix' is not defined"
     ]
    }
   ],
   "source": [
    "#for row in dist_matrix.matrix:\n",
    "#    print row\n",
    "#print len(dist_matrix.matrix),\"zoner i matrisen\"\n",
    "#print[zone[\"name\"] for zone in dist_matrix.zones]\n",
    "print dist_matrix.matrix\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 172,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "59.311284,18.182665\n",
      "59.245043,18.048909\n",
      "226\n",
      "Gullmasubzone 176\n",
      "Talltopp 24092\n",
      "PizzaSlice 178\n",
      "ReMember 7717\n",
      "Lillängsplan 25812\n",
      "OttekilGlänta 37074\n",
      "BirdBayHill 31925\n",
      "LänkSlut 11234\n",
      "Elderberry 7441\n",
      "TimeSpot 24078\n",
      "Byaängen 25396\n",
      "KebabPlate 1125\n",
      "SvedmyraSkog 25393\n",
      "EkebergaSlope 7584\n",
      "Hellashällen 46947\n",
      "Southball 257\n",
      "Spoontan 1417\n",
      "HightopOne 8615\n",
      "Sundsta 22223\n",
      "BlowOutT 7317\n",
      "Bogards 7577\n",
      "Styrbord 22739\n",
      "HammarbySkans 43577\n",
      "JärlaBoll 10843\n",
      "Henrikzone 255\n",
      "Brotorp 37394\n",
      "Hundpark 37730\n",
      "Vitestenzone 148\n",
      "GlobeT 15338\n",
      "SandTennis 7718\n",
      "Trädskolan 24082\n",
      "Skönvila 37399\n",
      "Storängenzon 18925\n",
      "JärlaÄnde 25813\n",
      "OneSpoonT 7472\n",
      "Gubbzone 274\n",
      "CellarIsland 219\n",
      "NackaCÅtta 46952\n",
      "Pylonen 47322\n",
      "Horizone 7578\n",
      "EnBitPåVägen 46953\n",
      "BästaSvängen 37402\n",
      "CrossWay 1414\n",
      "HightopTwo 8614\n",
      "Blekingekollo 24100\n",
      "Sicklasjön 24089\n",
      "Jarlspeak 1478\n",
      "Picnicspot 28206\n",
      "NackaStation 45218\n",
      "FlataOvalen 25755\n",
      "SleekBaking 7716\n",
      "JärlaHill 25814\n",
      "Offside 1416\n",
      "EnTrettiAndra 46889\n",
      "Tegelvikzone 150\n",
      "Skogsgravarna 37731\n",
      "Murklan 7587\n",
      "Maggan 24080\n",
      "SmåGrodorna 25380\n",
      "Styvmorsviol 24090\n",
      "Kvicken 24281\n",
      "BagisBeach 8193\n",
      "Sirocco 11233\n",
      "Bagizone 220\n",
      "BjörkhagenT 25375\n",
      "Helgesons 21904\n",
      "Bakverksträd 37400\n",
      "Dubbelskansen 21534\n",
      "BajenKaj 22224\n",
      "Terrassen 21893\n",
      "FinnZone 268\n",
      "NackaZone 218\n",
      "GubbSpeedway 22199\n",
      "Gubbängenmot 24282\n",
      "Sicklabanan 22740\n",
      "Stralsund 24083\n",
      "Odelzone 180\n",
      "CigarrSkogen 11118\n",
      "Karrzone 269\n",
      "Tullgården 21533\n",
      "JärlaSeaView 11226\n",
      "HenkesBrygga 13504\n",
      "Majrosen 22200\n",
      "Softzone 273\n",
      "Wilhelm 28205\n",
      "LänsmansPlan 23636\n",
      "Lillängen 18922\n",
      "Stickspåret 21900\n",
      "SöndagsZon 37401\n",
      "Vivstavarv 25395\n",
      "Plantskolan 24081\n",
      "SicklaBoule 24088\n",
      "Epicentrum 25374\n",
      "Riksrådet 23637\n",
      "SicklaPark 33102\n",
      "Erikzone 145\n",
      "Dammskogen 25377\n",
      "JulMums 7583\n",
      "BandisT 7474\n",
      "SwampWoods 7574\n",
      "cliffzone 7665\n",
      "Stylusleden 43897\n",
      "Bomstopp 46951\n",
      "Flatenstarten 25751\n",
      "Bajenbacken 24096\n",
      "RosenlundZone 33123\n",
      "Sandsborg 1100\n",
      "OmOchOmIgen 46948\n",
      "NiceCroft 7709\n",
      "Stensötunneln 47327\n",
      "TågKollen 11228\n",
      "Skarpzone 272\n",
      "Årstaskogen 22222\n",
      "Ankarsegel 43575\n",
      "Winterzone 153\n",
      "Asfaltskroken 18923\n",
      "Skönis 37398\n",
      "JärlaEkudden 11227\n",
      "FarstaÄngdal 37404\n",
      "Tallis 11120\n",
      "Tenntorp 46954\n",
      "AlmBussCykel 47328\n",
      "Ufot 28377\n",
      "Jönåkers 7594\n",
      "ÄltaBuss 25754\n",
      "TreasureRoad 7575\n",
      "Churchzone 270\n",
      "SockenplanT 7473\n",
      "Ottekilen 33108\n",
      "Sicklabron 24086\n",
      "Thunbergarn 24095\n",
      "Tullyard 152\n",
      "FlatenZone 7666\n",
      "Tallkrogen 37732\n",
      "Korphoppplan 35919\n",
      "JärlaTorg 25815\n",
      "StingAntT 7318\n",
      "SvedmyraPark 37733\n",
      "Petrejus 24097\n",
      "Gullmarzone 175\n",
      "TaÅtPepparn 37403\n",
      "Altazone 271\n",
      "EnJärlaPlats 10844\n",
      "DammtorpTrio 25376\n",
      "Ovalzone 217\n",
      "StoraSköndal 37397\n",
      "BridgeZone 1415\n",
      "BrinkT 7713\n",
      "BakerMaam 7582\n",
      "Röksvampen 57083\n",
      "Rusthållarn 25391\n",
      "Hökisbron 22198\n",
      "UlvsjöKlippa 54765\n",
      "EntranceZone 154\n",
      "Finesea 7592\n",
      "TaBrevet 37734\n",
      "Kollipiren 21535\n",
      "TrollKrysset 22201\n",
      "Vitascenzone 147\n",
      "FarstaSprint 24280\n",
      "FörstaSkedet 47319\n",
      "Hawkzone 1567\n",
      "HammarTextil 35918\n",
      "Kranglan 18924\n",
      "Circlezone 216\n",
      "BandMeadow 7475\n",
      "Lillbleckan 28372\n",
      "LillaSickla 24087\n",
      "Fäholmaskogen 37077\n",
      "Kolarängen 54764\n",
      "Hammarbyhöjd 37076\n",
      "VickerZone 8197\n",
      "RundaViken 11236\n",
      "Eragon 25392\n",
      "LumaScene 215\n",
      "SandFieldZone 7581\n",
      "Tätorpan 37395\n",
      "ToTheHill 30340\n",
      "Arenazone 256\n",
      "Källtorp 46949\n",
      "Tjurberget 21532\n",
      "SpiritZone 31912\n",
      "DragoLand 7712\n",
      "DonutStreet 7319\n",
      "Bjurholmsplan 12420\n",
      "HökenT 22202\n",
      "GulWoods 7711\n",
      "Hammarkajen 21894\n",
      "YmsenZone 7710\n",
      "KottStigen 9591\n",
      "Hellasweet 46946\n",
      "VonDillZone 22734\n",
      "GreenaGatan 7573\n",
      "MemoryRemains 25379\n",
      "Eriksroof 978\n",
      "HögmoraTräsk 11115\n",
      "Listudden 37396\n",
      "Revalen 47321\n",
      "Johannezone 177\n",
      "Fannyskans 25811\n",
      "Rottneros 37408\n",
      "Nytorpsvärnet 24084\n",
      "LotsOfDogs 7580\n",
      "Alphyddan 24093\n",
      "HillZone 214\n",
      "EriksdalsRaps 43576\n",
      "KnalleGräset 11235\n",
      "Nytorparn 24085\n",
      "Linktaket 22737\n",
      "NackaSocker 10841\n",
      "Kärrtorpsplan 24245\n",
      "BirdSwamp 24079\n",
      "DalensVård 37075\n",
      "WillysPark 24099\n",
      "SculptorZone 7723\n",
      "NackaWoods 10842\n",
      "LumaWater 33099\n",
      "Pungpinan 7576\n",
      "BetweenTops 43171\n",
      "RosenZone 158\n",
      "UlrikHarbour 24098\n",
      "NoMoreGas 7579\n",
      "AndraSkedet 47320\n",
      "GubbenT 22203\n",
      "LjusaStigen 25378\n",
      "ÄltaBad 29530\n"
     ]
    }
   ],
   "source": [
    "# Get the home zone\n",
    "#home = turf(\"zones\",[{'name':'Skarpzone'}])[0]\n",
    "\n",
    "# Get two corners\n",
    "ne = turf(\"zones\",[{'name':'Stickspåret'}])[0]\n",
    "sw = turf(\"zones\",[{'name':'Högmoraträsk'}])[0]\n",
    "\n",
    "print lat_long(ne)\n",
    "print lat_long(sw)\n",
    "#print lat_long(turf(\"zones\",[{'name':'Evalunden'}])[0])\n",
    "\n",
    "# Get closest zones in a rectangle\n",
    "params = [{\"northEast\" : ne,\"southWest\" : sw}]\n",
    "closest =  turf(\"zones\", params)\n",
    "\n",
    "# print count\n",
    "print len(closest)\n",
    "\n",
    "# print closest sorted by bird distance [dist,zone]*\n",
    "#list = [[int(haversine(home,zone)), zone] for zone in closest]\n",
    "#list.sort()\n",
    "for z in closest:\n",
    "    print z[\"name\"],z[\"id\"]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 322,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "47\n",
      "[{u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T13:13:59+0000', u'name': u'Skarpzone', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1777, u'dateCreated': u'2010-09-04T14:41:37+0000', u'currentOwner': {u'id': 96561, u'name': u'smaldavid'}, u'longitude': 18.132076, u'latitude': 59.266239, u'id': 272}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-06T22:42:19+0000', u'name': u'Horizone', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1407, u'dateCreated': u'2012-03-28T23:10:39+0000', u'currentOwner': {u'id': 88745, u'name': u'Gymrat'}, u'longitude': 18.121179, u'latitude': 59.268022, u'id': 7578}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T04:59:35+0000', u'name': u'Pungpinan', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1103, u'dateCreated': u'2012-03-28T22:55:24+0000', u'currentOwner': {u'id': 123914, u'name': u'aivar'}, u'longitude': 18.115302, u'latitude': 59.272649, u'id': 7576}, {u'takeoverPoints': 140, u'dateLastTaken': u'2015-09-07T09:14:45+0000', u'name': u'Riksr\\xe5det', u'pointsPerHour': 4, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 476, u'dateCreated': u'2013-12-05T18:33:06+0000', u'currentOwner': {u'id': 100922, u'name': u'P\\xf6pli'}, u'longitude': 18.123072, u'latitude': 59.274094, u'id': 23637}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T13:16:41+0000', u'name': u'Eragon', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 701, u'dateCreated': u'2014-02-14T23:58:52+0000', u'currentOwner': {u'id': 96561, u'name': u'smaldavid'}, u'longitude': 18.127001, u'latitude': 59.270527, u'id': 25392}, {u'takeoverPoints': 140, u'dateLastTaken': u'2015-09-07T13:50:17+0000', u'name': u'TimeSpot', u'pointsPerHour': 4, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 524, u'dateCreated': u'2013-12-20T23:53:49+0000', u'currentOwner': {u'id': 100922, u'name': u'P\\xf6pli'}, u'longitude': 18.135089, u'latitude': 59.271409, u'id': 24078}, {u'takeoverPoints': 155, u'dateLastTaken': u'2015-09-07T13:21:14+0000', u'name': u'Rusth\\xe5llarn', u'pointsPerHour': 3, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 359, u'dateCreated': u'2014-02-07T23:57:14+0000', u'currentOwner': {u'id': 96561, u'name': u'smaldavid'}, u'longitude': 18.141968, u'latitude': 59.273047, u'id': 25391}, {u'takeoverPoints': 140, u'dateLastTaken': u'2015-09-06T19:32:19+0000', u'name': u'Epicentrum', u'pointsPerHour': 4, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 464, u'dateCreated': u'2014-02-02T22:56:05+0000', u'currentOwner': {u'id': 123270, u'name': u'yyy'}, u'longitude': 18.140868, u'latitude': 59.277336, u'id': 25374}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T14:07:52+0000', u'name': u'Bagizone', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1862, u'dateCreated': u'2010-09-04T14:41:37+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.131311, u'latitude': 59.276583, u'id': 220}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T14:00:59+0000', u'name': u'L\\xe4nsmansPlan', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 610, u'dateCreated': u'2013-12-05T18:31:17+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.121454, u'latitude': 59.279754, u'id': 23636}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T08:51:30+0000', u'name': u'Karrzone', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1828, u'dateCreated': u'2010-09-04T14:41:37+0000', u'currentOwner': {u'id': 123989, u'name': u'ribot'}, u'longitude': 18.117872, u'latitude': 59.287352, u'id': 269}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T05:41:41+0000', u'name': u'Bj\\xf6rkhagenT', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1551, u'dateCreated': u'2014-02-09T22:58:50+0000', u'currentOwner': {u'id': 9054, u'name': u'linan'}, u'longitude': 18.115564, u'latitude': 59.291121, u'id': 25375}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T13:40:42+0000', u'name': u'UlrikHarbour', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1434, u'dateCreated': u'2013-12-30T00:40:23+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.107995, u'latitude': 59.292387, u'id': 24098}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T13:37:06+0000', u'name': u'WillysPark', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1918, u'dateCreated': u'2014-01-01T00:00:02+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.107261, u'latitude': 59.29505, u'id': 24099}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T06:47:26+0000', u'name': u'ToTheHill', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 566, u'dateCreated': u'2014-05-27T19:44:53+0000', u'currentOwner': {u'id': 76878, u'name': u'MagNoose'}, u'longitude': 18.107215, u'latitude': 59.297811, u'id': 30340}, {u'takeoverPoints': 140, u'dateLastTaken': u'2015-09-07T13:38:52+0000', u'name': u'Linktaket', u'pointsPerHour': 4, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 748, u'dateCreated': u'2013-11-04T12:44:19+0000', u'currentOwner': {u'id': 42385, u'name': u'ErlingHoken'}, u'longitude': 18.100866, u'latitude': 59.299307, u'id': 22737}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T08:09:09+0000', u'name': u'Korphoppplan', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 825, u'dateCreated': u'2014-09-13T06:00:00+0000', u'currentOwner': {u'id': 125794, u'name': u'TTY'}, u'longitude': 18.098898, u'latitude': 59.302154, u'id': 35919}, {u'takeoverPoints': 80, u'dateLastTaken': u'2015-09-07T13:58:01+0000', u'name': u'HammarTextil', u'pointsPerHour': 8, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 952, u'dateCreated': u'2014-09-12T06:00:00+0000', u'currentOwner': {u'id': 122803, u'name': u'dinolisa'}, u'longitude': 18.090044, u'latitude': 59.301881, u'id': 35918}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T07:34:11+0000', u'name': u'Terrassen', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1623, u'dateCreated': u'2013-09-30T16:03:37+0000', u'currentOwner': {u'id': 125794, u'name': u'TTY'}, u'longitude': 18.090381, u'latitude': 59.304611, u'id': 21893}, {u'takeoverPoints': 80, u'dateLastTaken': u'2015-09-07T10:57:54+0000', u'name': u'LumaScene', u'pointsPerHour': 8, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 3944, u'dateCreated': u'2010-09-04T14:41:37+0000', u'currentOwner': {u'id': 74824, u'name': u'jana5'}, u'longitude': 18.095899, u'latitude': 59.304517, u'id': 215}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T10:50:49+0000', u'name': u'BajenKaj', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1667, u'dateCreated': u'2013-10-21T19:25:32+0000', u'currentOwner': {u'id': 74824, u'name': u'jana5'}, u'longitude': 18.095657, u'latitude': 59.306533, u'id': 22224}, {u'takeoverPoints': 80, u'dateLastTaken': u'2015-09-07T10:47:14+0000', u'name': u'LumaWater', u'pointsPerHour': 8, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1164, u'dateCreated': u'2014-07-31T16:05:00+0000', u'currentOwner': {u'id': 74824, u'name': u'jana5'}, u'longitude': 18.098848, u'latitude': 59.305543, u'id': 33099}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T13:16:22+0000', u'name': u'Styrbord', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1715, u'dateCreated': u'2013-11-24T12:47:30+0000', u'currentOwner': {u'id': 42385, u'name': u'ErlingHoken'}, u'longitude': 18.103143, u'latitude': 59.303489, u'id': 22739}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T13:12:30+0000', u'name': u'SicklaPark', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 842, u'dateCreated': u'2014-07-31T16:05:00+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.107888, u'latitude': 59.304754, u'id': 33102}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T13:16:05+0000', u'name': u'Ovalzone', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 2726, u'dateCreated': u'2010-09-04T14:41:37+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.111421, u'latitude': 59.302876, u'id': 217}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T13:19:04+0000', u'name': u'Sicklabron', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1540, u'dateCreated': u'2013-12-21T00:14:16+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.114812, u'latitude': 59.301349, u'id': 24086}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T13:24:57+0000', u'name': u'LillaSickla', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 434, u'dateCreated': u'2014-01-02T00:14:11+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.122698, u'latitude': 59.299966, u'id': 24087}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T13:54:09+0000', u'name': u'K\\xe4rrtorpsplan', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 2022, u'dateCreated': u'2013-12-24T11:00:30+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.114286, u'latitude': 59.283682, u'id': 24245}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T12:16:44+0000', u'name': u'SwampWoods', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1962, u'dateCreated': u'2012-03-28T22:48:36+0000', u'currentOwner': {u'id': 108785, u'name': u'Sarkje'}, u'longitude': 18.109189, u'latitude': 59.281355, u'id': 7574}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T14:00:37+0000', u'name': u'TreasureRoad', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1017, u'dateCreated': u'2012-03-28T22:49:30+0000', u'currentOwner': {u'id': 123224, u'name': u'VHGGSTRM'}, u'longitude': 18.111303, u'latitude': 59.275962, u'id': 7575}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T05:49:52+0000', u'name': u'SpiritZone', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 505, u'dateCreated': u'2014-06-24T21:44:36+0000', u'currentOwner': {u'id': 97246, u'name': u'Rektorinnan'}, u'longitude': 18.099411, u'latitude': 59.277044, u'id': 31912}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T05:42:33+0000', u'name': u'Skogsgravarna', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 381, u'dateCreated': u'2014-10-14T06:00:00+0000', u'currentOwner': {u'id': 97246, u'name': u'Rektorinnan'}, u'longitude': 18.103084, u'latitude': 59.271211, u'id': 37731}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T13:02:33+0000', u'name': u'SandFieldZone', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 2222, u'dateCreated': u'2012-03-28T23:15:26+0000', u'currentOwner': {u'id': 96561, u'name': u'smaldavid'}, u'longitude': 18.113957, u'latitude': 59.260497, u'id': 7581}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T13:03:49+0000', u'name': u'LotsOfDogs', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1787, u'dateCreated': u'2012-03-28T23:13:57+0000', u'currentOwner': {u'id': 96561, u'name': u'smaldavid'}, u'longitude': 18.113702, u'latitude': 59.262657, u'id': 7580}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T13:05:11+0000', u'name': u'Hundpark', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 461, u'dateCreated': u'2014-10-08T06:00:00+0000', u'currentOwner': {u'id': 96561, u'name': u'smaldavid'}, u'longitude': 18.117681, u'latitude': 59.264136, u'id': 37730}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-06T19:56:12+0000', u'name': u'Listudden', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 262, u'dateCreated': u'2014-10-06T04:00:00+0000', u'currentOwner': {u'id': 123270, u'name': u'yyy'}, u'longitude': 18.134797, u'latitude': 59.261208, u'id': 37396}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T08:26:21+0000', u'name': u'FlataOvalen', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 310, u'dateCreated': u'2014-03-11T21:24:13+0000', u'currentOwner': {u'id': 123989, u'name': u'ribot'}, u'longitude': 18.157605, u'latitude': 59.260371, u'id': 25755}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T08:31:59+0000', u'name': u'Flatenstarten', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 323, u'dateCreated': u'2014-02-11T21:16:12+0000', u'currentOwner': {u'id': 123989, u'name': u'ribot'}, u'longitude': 18.147688, u'latitude': 59.26244, u'id': 25751}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-07T08:35:27+0000', u'name': u'T\\xe4torpan', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 314, u'dateCreated': u'2014-10-03T06:00:00+0000', u'currentOwner': {u'id': 123989, u'name': u'ribot'}, u'longitude': 18.142474, u'latitude': 59.265494, u'id': 37395}, {u'takeoverPoints': 155, u'dateLastTaken': u'2015-09-07T13:31:25+0000', u'name': u'Blekingekollo', u'pointsPerHour': 3, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 364, u'dateCreated': u'2014-01-17T00:44:52+0000', u'currentOwner': {u'id': 105178, u'name': u'KK77'}, u'longitude': 18.115725, u'latitude': 59.296387, u'id': 24100}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-06T17:27:10+0000', u'name': u'Hammarbyh\\xf6jd', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 216, u'dateCreated': u'2014-10-08T06:00:00+0000', u'currentOwner': {u'id': 42385, u'name': u'ErlingHoken'}, u'longitude': 18.096675, u'latitude': 59.292074, u'id': 37076}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T13:43:49+0000', u'name': u'FinnZone', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 2824, u'dateCreated': u'2010-09-04T14:41:37+0000', u'currentOwner': {u'id': 42385, u'name': u'ErlingHoken'}, u'longitude': 18.102223, u'latitude': 59.295581, u'id': 268}, {u'takeoverPoints': 140, u'dateLastTaken': u'2015-09-06T23:05:37+0000', u'name': u'Thunbergarn', u'pointsPerHour': 4, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1156, u'dateCreated': u'2013-12-21T00:34:05+0000', u'currentOwner': {u'id': 88745, u'name': u'Gymrat'}, u'longitude': 18.096325, u'latitude': 59.295001, u'id': 24095}, {u'takeoverPoints': 95, u'dateLastTaken': u'2015-09-07T09:02:25+0000', u'name': u'Nytorparn', u'pointsPerHour': 7, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1415, u'dateCreated': u'2013-12-24T11:00:41+0000', u'currentOwner': {u'id': 122502, u'name': u'Ubbepower'}, u'longitude': 18.102162, u'latitude': 59.290003, u'id': 24085}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-06T16:35:15+0000', u'name': u'DalensV\\xe5rd', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 563, u'dateCreated': u'2014-09-25T06:00:00+0000', u'currentOwner': {u'id': 122502, u'name': u'Ubbepower'}, u'longitude': 18.099507, u'latitude': 59.288183, u'id': 37075}, {u'takeoverPoints': 110, u'dateLastTaken': u'2015-09-07T09:53:54+0000', u'name': u'F\\xe4holmaskogen', u'pointsPerHour': 6, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 440, u'dateCreated': u'2014-10-09T06:00:00+0000', u'currentOwner': {u'id': 125738, u'name': u'Mackes\\xc5klagare'}, u'longitude': 18.105367, u'latitude': 59.286259, u'id': 37077}, {u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-06T15:29:00+0000', u'name': u'GreenaGatan', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1401, u'dateCreated': u'2012-03-28T22:46:29+0000', u'currentOwner': {u'id': 122502, u'name': u'Ubbepower'}, u'longitude': 18.101103, u'latitude': 59.281707, u'id': 7573}]\n"
     ]
    }
   ],
   "source": [
    "#names = u'Skarpzone Tätorpan Flatenstarten FlataOvalen ÄltaBuss Elderberry Stensötunneln AlmBussCykel Bomstopp NackaCÅtta EnBitPåVägen Tenntorp Källtorp Hellasweet OmOchOmIgen Sicklasjön LillaSickla Sicklabron Ovalzone SicklaPark Styrbord LumaWater BajenKaj LumaScene Terrassen HammarTextil Korphoppplan Linktaket ToTheHill WillysPark UlrikHarbour BjörkhagenT Karrzone Kärrtorpsplan SwampWoods LänsmansPlan Bagizone Epicentrum Rusthållarn TimeSpot Riksrådet Pungpinan Eragon Horizone Hundpark LotsOfDogs Listudden'.split(' ')\n",
    "#names = u'Skarpzone Tätorpan Flatenstarten FlataOvalen Sicklabron Ovalzone SicklaPark Styrbord LumaWater BajenKaj LumaScene Terrassen HammarTextil Korphoppplan Linktaket ToTheHill WillysPark UlrikHarbour BjörkhagenT Karrzone Kärrtorpsplan SwampWoods LänsmansPlan Bagizone Epicentrum Rusthållarn TimeSpot Riksrådet Pungpinan Eragon Horizone Hundpark LotsOfDogs Listudden SandFieldZone  BakerMaam StoraSköndal TreasureRoad Skogsgravarna Bakverksträd Gubbängenmot Bogards SpiritZone SöndagsZon LillaSickla'.split(' ')\n",
    "names = u'Skarpzone Horizone Pungpinan Riksrådet Eragon TimeSpot Rusthållarn Epicentrum Bagizone LänsmansPlan Karrzone BjörkhagenT UlrikHarbour WillysPark ToTheHill Linktaket Korphoppplan HammarTextil Terrassen LumaScene BajenKaj LumaWater Styrbord SicklaPark Ovalzone Sicklabron LillaSickla Kärrtorpsplan SwampWoods TreasureRoad SpiritZone Skogsgravarna SandFieldZone LotsOfDogs Hundpark Listudden FlataOvalen Flatenstarten Tätorpan Blekingekollo Hammarbyhöjd FinnZone Thunbergarn Nytorparn DalensVård Fäholmaskogen GreenaGatan'.split(' ')\n",
    "\n",
    "\n",
    "print len(names) # should be 47 to display in 25+25\n",
    "route = []\n",
    "route_by_name = {}\n",
    "route_by_id = {}\n",
    "for name in names:\n",
    "    for z in closest:\n",
    "        if name==z[\"name\"]:\n",
    "            route.append(z)\n",
    "            route_by_name[name]=z\n",
    "            route_by_id[z[\"id\"]]=z\n",
    "print route            \n",
    "#print len(route)\n",
    "#for n in names:\n",
    "#    if n not in [c[\"name\"] for c in closest]:\n",
    "#        print n\n",
    "#print dump([z[\"name\"] for z in route])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 113,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "# zones är en lista med mina zoners id.\n",
    "data =  turf('users', [{\"name\" : \"yyy\"}])\n",
    "zones = data[0]['zones']\n",
    "# data är en lista med mina zoner\n",
    "data =  turf('zones', [{'id': zone} for zone in zones])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 114,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "2015-09-06T11:14:41+0000 59.266239 18.132076 Skarpzone\n",
      "2015-09-06T11:17:04+0000 59.268022 18.121179 Horizone\n",
      "2015-09-06T11:22:50+0000 59.272649 18.115302 Pungpinan\n",
      "2015-09-06T11:25:18+0000 59.275962 18.111303 TreasureRoad\n",
      "2015-09-06T11:35:46+0000 59.291121 18.115564 BjörkhagenT\n",
      "2015-09-06T11:38:11+0000 59.292387 18.107995 UlrikHarbour\n",
      "2015-09-06T11:39:41+0000 59.29505 18.107261 WillysPark\n",
      "2015-09-06T11:41:10+0000 59.295581 18.102223 FinnZone\n",
      "2015-09-06T11:51:19+0000 59.293478 18.127183 Offside\n",
      "2015-09-06T11:53:18+0000 59.29118 18.136452 DammtorpTrio\n",
      "2015-09-06T11:55:20+0000 59.286702 18.138486 Dammskogen\n",
      "2015-09-06T11:58:22+0000 59.282727 18.147326 BagisBeach\n",
      "2015-09-06T12:00:36+0000 59.280943 18.143144 LjusaStigen\n",
      "2015-09-06T12:09:25+0000 59.279754 18.121454 LänsmansPlan\n",
      "2015-09-06T12:12:30+0000 59.274094 18.123072 Riksrådet\n",
      "2015-09-06T12:23:06+0000 59.270443 18.148031 Brotorp\n"
     ]
    }
   ],
   "source": [
    "data.sort(key = lambda z: z['dateLastTaken'])\n",
    "for zone in data:\n",
    "    print zone['dateLastTaken'],zone['latitude'],zone['longitude'],zone['name']"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 115,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "# key=AIzaSyDEkImuzFYUhT7FGXxoev2BSQShw-y6eyc' "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 116,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "import time\n",
    "\n",
    "def optimize(nodes):\n",
    "    start = time.clock()\n",
    "    \n",
    "    solution = [n for n in nodes]\n",
    "    go = True\n",
    "    while go:\n",
    "        (go,solution) = optimize2opt(solution)\n",
    "    print (time.clock() - start)\n",
    "    return solution\n",
    "\n",
    "def optimize2opt(solution):\n",
    "    sn = len(solution)\n",
    "    best = 0\n",
    "    best_move = None\n",
    "    for ci in range(sn):\n",
    "        for xi in range(sn):\n",
    "            yi = (ci + 1) % sn\n",
    "            zi = (xi + 1) % sn\n",
    "\n",
    "            c = solution[ci]\n",
    "            y = solution[yi]\n",
    "            x = solution[xi]\n",
    "            z = solution[zi]\n",
    "\n",
    "            cy = length(c, y)\n",
    "            xz = length(x, z)\n",
    "            cx = length(c, x)\n",
    "            yz = length(y, z)\n",
    "\n",
    "            #if xi != ci and xi != yi:\n",
    "            if xi != ci and xi != yi and yi != ci and xi != zi and yi != zi and ci != zi:\n",
    "                gain = (cy + xz) - (cx + yz)\n",
    "                if gain > best:\n",
    "                    best_move = (ci, yi, xi, zi)\n",
    "                    best = gain\n",
    "\n",
    "    #print best_move, best\n",
    "    if best_move is not None:\n",
    "        (ci, yi, xi, zi) = best_move\n",
    "\n",
    "        new_solution = range(0,sn)\n",
    "        new_solution[0] = solution[ci]\n",
    "        n = 1\n",
    "        while xi != yi:\n",
    "            new_solution[n] = solution[xi]\n",
    "            n += 1\n",
    "            xi = (xi-1)%sn\n",
    "        new_solution[n] = solution[yi]\n",
    "        n += 1\n",
    "        while zi != ci:\n",
    "            new_solution[n] = solution[zi]\n",
    "            n += 1\n",
    "            zi = (zi+1) % sn\n",
    "        return True, new_solution\n",
    "    else:\n",
    "        return False, solution"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 117,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "def rotate(candidates, home):\n",
    "    i = 0\n",
    "    while candidates[i][\"name\"] != home[\"name\"]:            \n",
    "        i += 1\n",
    "    return candidates[i:] + candidates[:i]            "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 284,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "13 zoner kvar:\n",
      "Sicklasjön\n",
      "Stensötunneln\n",
      "- missing 29529 -\n",
      "- missing 29530 -\n",
      "Hellasweet\n",
      "Flatenstarten\n",
      "Bomstopp\n",
      "AlmBussCykel\n",
      "Källtorp\n",
      "OmOchOmIgen\n",
      "Tenntorp\n",
      "EnBitPåVägen\n",
      "NackaCÅtta\n"
     ]
    }
   ],
   "source": [
    "# find out how many points are missing.\n",
    "yyy = turf(\"users\",[{'name':'yyy'}])[0]\n",
    "my_zones = yyy[\"zones\"]\n",
    "print len(my_zones), \"zoner kvar:\"\n",
    "for id in my_zones:\n",
    "    if id in route_by_id:\n",
    "        print route_by_id[id][\"name\"]\n",
    "    else:\n",
    "        print '- missing ' + str(id) + \" -\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 146,
   "metadata": {
    "collapsed": False
   },
   "outputs": [],
   "source": [
    "target = 10 # plats på Stockholmslistan\n",
    "stop_zones = ['NoMoreGas'] # zoner som inte går att ta."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 147,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "2180 poäng behövs\n"
     ]
    }
   ],
   "source": [
    "params = {\"region\": \"Stockholm\", \"from\": target, \"to\": target}\n",
    "user = turf(\"users/top\", params)[0]\n",
    "points_needed = user[\"points\"] - yyy[\"points\"]\n",
    "print points_needed,\"poäng behövs\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 148,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "yyy 0\n",
      "BakerMaam 155\n",
      "StoraSköndal 155\n",
      "Skogsgravarna 125\n",
      "Bakverksträd 155\n",
      "Gubbängenmot 155\n",
      "Kolarängen 170\n",
      "FlatenZone 170\n",
      "Bogards 140\n",
      "UlvsjöKlippa 170\n",
      "JulMums 155\n",
      "SwampWoods 140\n",
      "SpiritZone 125\n",
      "Kärrtorpsplan 125\n",
      "SöndagsZon 155\n",
      "Bomstopp 155\n",
      "16 zoner 2250 poäng\n"
     ]
    }
   ],
   "source": [
    "# Vilka zoner är de närmaste som behöver tas?\n",
    "points = 0\n",
    "candidates = [home]\n",
    "for dist,zone in list:\n",
    "    if points >= points_needed: \n",
    "        break\n",
    "    if zone[\"id\"] not in taken_zones and zone[\"name\"] not in stop_zones:\n",
    "        points += zone[\"takeoverPoints\"]\n",
    "        candidates.append(zone)\n",
    "sum=0\n",
    "for candidate in candidates:\n",
    "    sum += candidate[\"takeoverPoints\"]\n",
    "    print candidate[\"name\"],candidate[\"takeoverPoints\"]\n",
    "print len(candidates), \"zoner\", sum, \"poäng\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 458,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "{'latitude': 59.2652, 'takeoverPoints': 0, 'name': 'yyy', 'longitude': 18.132717}\n",
      "0.0362050692784\n"
     ]
    },
    {
     "ename": "IndexError",
     "evalue": "list index out of range",
     "output_type": "error",
     "traceback": [
      "\u001b[1;31m---------------------------------------------------------------------------\u001b[0m",
      "\u001b[1;31mIndexError\u001b[0m                                Traceback (most recent call last)",
      "\u001b[1;32m<ipython-input-458-8381223b68bc>\u001b[0m in \u001b[0;36m<module>\u001b[1;34m()\u001b[0m\n\u001b[0;32m     20\u001b[0m \u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0;32m     21\u001b[0m \u001b[1;33m\u001b[0m\u001b[0m\n\u001b[1;32m---> 22\u001b[1;33m \u001b[0mloop\u001b[0m \u001b[1;33m=\u001b[0m \u001b[0mrotate\u001b[0m\u001b[1;33m(\u001b[0m\u001b[0msolution\u001b[0m\u001b[1;33m,\u001b[0m \u001b[0mhome\u001b[0m\u001b[1;33m)\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0m\u001b[0;32m     23\u001b[0m \u001b[1;31m#loop = solution\u001b[0m\u001b[1;33m\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0;32m     24\u001b[0m \u001b[1;33m\u001b[0m\u001b[0m\n",
      "\u001b[1;32m<ipython-input-117-d248e5cdd706>\u001b[0m in \u001b[0;36mrotate\u001b[1;34m(candidates, home)\u001b[0m\n\u001b[0;32m      1\u001b[0m \u001b[1;32mdef\u001b[0m \u001b[0mrotate\u001b[0m\u001b[1;33m(\u001b[0m\u001b[0mcandidates\u001b[0m\u001b[1;33m,\u001b[0m \u001b[0mhome\u001b[0m\u001b[1;33m)\u001b[0m\u001b[1;33m:\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0;32m      2\u001b[0m     \u001b[0mi\u001b[0m \u001b[1;33m=\u001b[0m \u001b[1;36m0\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[1;32m----> 3\u001b[1;33m     \u001b[1;32mwhile\u001b[0m \u001b[0mcandidates\u001b[0m\u001b[1;33m[\u001b[0m\u001b[0mi\u001b[0m\u001b[1;33m]\u001b[0m\u001b[1;33m[\u001b[0m\u001b[1;34m\"name\"\u001b[0m\u001b[1;33m]\u001b[0m \u001b[1;33m!=\u001b[0m \u001b[0mhome\u001b[0m\u001b[1;33m[\u001b[0m\u001b[1;34m\"name\"\u001b[0m\u001b[1;33m]\u001b[0m\u001b[1;33m:\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0m\u001b[0;32m      4\u001b[0m         \u001b[0mi\u001b[0m \u001b[1;33m+=\u001b[0m \u001b[1;36m1\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n\u001b[0;32m      5\u001b[0m     \u001b[1;32mreturn\u001b[0m \u001b[0mcandidates\u001b[0m\u001b[1;33m[\u001b[0m\u001b[0mi\u001b[0m\u001b[1;33m:\u001b[0m\u001b[1;33m]\u001b[0m \u001b[1;33m+\u001b[0m \u001b[0mcandidates\u001b[0m\u001b[1;33m[\u001b[0m\u001b[1;33m:\u001b[0m\u001b[0mi\u001b[0m\u001b[1;33m]\u001b[0m\u001b[1;33m\u001b[0m\u001b[0m\n",
      "\u001b[1;31mIndexError\u001b[0m: list index out of range"
     ]
    }
   ],
   "source": [
    "from IPython.core.display import HTML\n",
    "\n",
    "def names_to_zones(s):\n",
    "    slist = [{'name':name} for name in s]\n",
    "    return turf('zones',slist)\n",
    "\n",
    "print home\n",
    "\n",
    "#names = 'ÅrstaBergStn PaintingLake ÅrstaSiljan SandInletZone LostHighway Odelzone ReMember Pylonen DragoLand Stralsund Revalen AndraSkedet FörstaSkedet Trädskolan Plantskolan SockenplanT Spoontan StingAntT Murklan Maggan'.split(' ')\n",
    "names = 'Skarpzone Horizone Eragon Tätorpan Listudden TimeSpot Riksrådet Pungpinan Hundpark LotsOfDogs SandFieldZone'.split(' ')\n",
    "names = 'Skarpzone Tätorpan TimeSpot Eragon Riksrådet Pungpinan Horizone LotsOfDogs SandFieldZone Hundpark'.split(' ')\n",
    "route = names_to_zones(names)\n",
    "candidates = route\n",
    "#print candidates\n",
    "\n",
    "solution = optimize(candidates)\n",
    "\n",
    "#solution = [home]+solution\n",
    "route = solution \n",
    "\n",
    "\n",
    "loop = rotate(solution, home)\n",
    "#loop = solution\n",
    "\n",
    "for z in loop:\n",
    "    print z[\"name\"]\n",
    "\n",
    "loop.append(home)\n",
    "html=\"\"\n",
    "\n",
    "sum = 0 \n",
    "for i in range(len(loop)):\n",
    "    a = loop[i]\n",
    "    b = loop[(i+1)%len(loop)]\n",
    "    #dist = dist_matrix.distance(a,b)\n",
    "    #sum += dist\n",
    "    dist=0\n",
    "    sum=0\n",
    "    html += a[\"name\"] + ' <a target=\"_blank\" href=\"https://www.google.se/maps/dir/' + \\\n",
    "        lat_long(a) + '/' + lat_long(b) + \\\n",
    "        '/@' + avg(a,b) + ',20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">' + str(dist) +'</a><br>'\n",
    "        \n",
    "s = \"/\".join([lat_long(candidate) for candidate in loop[:25]])\n",
    "html += '<br>Totalt: <a target=\"_blank\" href=\"https://www.google.se/maps/dir/' + s +'/@' + lat_long(home) + ',20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">' + str(sum) +'</a><br>'\n",
    "\n",
    "HTML(html)    "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 80,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "- latitude: 59.2652\n",
      "  longitude: 18.132717\n",
      "  name: yyy\n",
      "  takeoverPoints: 0\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2010-09-04T14:41:37+0000\n",
      "  dateLastTaken: 2015-09-05T19:11:32+0000\n",
      "  id: 272\n",
      "  latitude: 59.266239\n",
      "  longitude: 18.132076\n",
      "  name: Skarpzone\n",
      "  pointsPerHour: 5\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 125\n",
      "  totalTakeovers: 1773\n",
      "- currentOwner:\n",
      "    id: 64334\n",
      "    name: Nightcat\n",
      "  dateCreated: 2014-10-06T04:00:00+0000\n",
      "  dateLastTaken: 2015-09-05T17:11:43+0000\n",
      "  id: 37396\n",
      "  latitude: 59.261208\n",
      "  longitude: 18.134797\n",
      "  name: Listudden\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 259\n",
      "- currentOwner:\n",
      "    id: 54085\n",
      "    name: NisseNasse\n",
      "  dateCreated: 2014-10-03T06:00:00+0000\n",
      "  dateLastTaken: 2015-09-05T13:47:14+0000\n",
      "  id: 37395\n",
      "  latitude: 59.265494\n",
      "  longitude: 18.142474\n",
      "  name: \"T\\xE4torpan\"\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 310\n",
      "- currentOwner:\n",
      "    id: 120559\n",
      "    name: \"\\xD6jje\"\n",
      "  dateCreated: 2014-02-14T23:58:52+0000\n",
      "  dateLastTaken: 2015-09-05T20:56:33+0000\n",
      "  id: 25392\n",
      "  latitude: 59.270527\n",
      "  longitude: 18.127001\n",
      "  name: Eragon\n",
      "  pointsPerHour: 5\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 125\n",
      "  totalTakeovers: 696\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2013-12-20T23:53:49+0000\n",
      "  dateLastTaken: 2015-09-05T19:14:06+0000\n",
      "  id: 24078\n",
      "  latitude: 59.271409\n",
      "  longitude: 18.135089\n",
      "  name: TimeSpot\n",
      "  pointsPerHour: 4\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 140\n",
      "  totalTakeovers: 520\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2012-03-28T23:10:39+0000\n",
      "  dateLastTaken: 2015-09-05T20:05:49+0000\n",
      "  id: 7578\n",
      "  latitude: 59.268022\n",
      "  longitude: 18.121179\n",
      "  name: Horizone\n",
      "  pointsPerHour: 5\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 125\n",
      "  totalTakeovers: 1405\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2014-10-08T06:00:00+0000\n",
      "  dateLastTaken: 2015-09-05T20:02:58+0000\n",
      "  id: 37730\n",
      "  latitude: 59.264136\n",
      "  longitude: 18.117681\n",
      "  name: Hundpark\n",
      "  pointsPerHour: 4\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 140\n",
      "  totalTakeovers: 457\n",
      "- currentOwner:\n",
      "    id: 54085\n",
      "    name: NisseNasse\n",
      "  dateCreated: 2014-02-11T21:16:12+0000\n",
      "  dateLastTaken: 2015-09-05T16:19:58+0000\n",
      "  id: 25751\n",
      "  latitude: 59.26244\n",
      "  longitude: 18.147688\n",
      "  name: Flatenstarten\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 319\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2012-03-28T23:13:57+0000\n",
      "  dateLastTaken: 2015-09-05T20:01:40+0000\n",
      "  id: 7580\n",
      "  latitude: 59.262657\n",
      "  longitude: 18.113702\n",
      "  name: LotsOfDogs\n",
      "  pointsPerHour: 4\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 140\n",
      "  totalTakeovers: 1783\n",
      "- currentOwner:\n",
      "    id: 88745\n",
      "    name: Gymrat\n",
      "  dateCreated: 2014-10-15T06:00:00+0000\n",
      "  dateLastTaken: 2015-09-03T15:17:37+0000\n",
      "  id: 37399\n",
      "  latitude: 59.257307\n",
      "  longitude: 18.120166\n",
      "  name: \"Sk\\xF6nvila\"\n",
      "  pointsPerHour: 2\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 170\n",
      "  totalTakeovers: 251\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2012-03-28T23:15:26+0000\n",
      "  dateLastTaken: 2015-09-05T20:00:28+0000\n",
      "  id: 7581\n",
      "  latitude: 59.260497\n",
      "  longitude: 18.113957\n",
      "  name: SandFieldZone\n",
      "  pointsPerHour: 4\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 140\n",
      "  totalTakeovers: 2218\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2010-09-04T14:41:37+0000\n",
      "  dateLastTaken: 2015-09-05T19:16:49+0000\n",
      "  id: 220\n",
      "  latitude: 59.276583\n",
      "  longitude: 18.131311\n",
      "  name: Bagizone\n",
      "  pointsPerHour: 4\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 140\n",
      "  totalTakeovers: 1857\n",
      "- currentOwner:\n",
      "    id: 88745\n",
      "    name: Gymrat\n",
      "  dateCreated: 2014-04-14T16:26:43+0000\n",
      "  dateLastTaken: 2015-09-03T15:20:36+0000\n",
      "  id: 28205\n",
      "  latitude: 59.254033\n",
      "  longitude: 18.125154\n",
      "  name: Wilhelm\n",
      "  pointsPerHour: 2\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 170\n",
      "  totalTakeovers: 331\n",
      "- currentOwner:\n",
      "    id: 54085\n",
      "    name: NisseNasse\n",
      "  dateCreated: 2014-03-11T21:24:13+0000\n",
      "  dateLastTaken: 2015-09-05T13:53:23+0000\n",
      "  id: 25755\n",
      "  latitude: 59.260371\n",
      "  longitude: 18.157605\n",
      "  name: FlataOvalen\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 306\n",
      "- currentOwner:\n",
      "    id: 88745\n",
      "    name: Gymrat\n",
      "  dateCreated: 2012-03-28T23:17:28+0000\n",
      "  dateLastTaken: 2015-09-04T02:36:49+0000\n",
      "  id: 7582\n",
      "  latitude: 59.256565\n",
      "  longitude: 18.110821\n",
      "  name: BakerMaam\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 1763\n",
      "- currentOwner:\n",
      "    id: 88745\n",
      "    name: Gymrat\n",
      "  dateCreated: 2014-10-06T04:00:00+0000\n",
      "  dateLastTaken: 2015-09-03T15:22:51+0000\n",
      "  id: 37397\n",
      "  latitude: 59.252147\n",
      "  longitude: 18.119125\n",
      "  name: \"StoraSk\\xF6ndal\"\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 315\n",
      "- currentOwner:\n",
      "    id: 42385\n",
      "    name: ErlingHoken\n",
      "  dateCreated: 2012-03-28T22:49:30+0000\n",
      "  dateLastTaken: 2015-09-05T14:49:33+0000\n",
      "  id: 7575\n",
      "  latitude: 59.275962\n",
      "  longitude: 18.111303\n",
      "  name: TreasureRoad\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 1014\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2013-12-05T18:31:17+0000\n",
      "  dateLastTaken: 2015-09-05T19:19:09+0000\n",
      "  id: 23636\n",
      "  latitude: 59.279754\n",
      "  longitude: 18.121454\n",
      "  name: \"L\\xE4nsmansPlan\"\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 608\n",
      "- currentOwner:\n",
      "    id: 54085\n",
      "    name: NisseNasse\n",
      "  dateCreated: 2014-10-14T06:00:00+0000\n",
      "  dateLastTaken: 2015-09-05T13:37:32+0000\n",
      "  id: 37731\n",
      "  latitude: 59.271211\n",
      "  longitude: 18.103084\n",
      "  name: Skogsgravarna\n",
      "  pointsPerHour: 5\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 125\n",
      "  totalTakeovers: 378\n",
      "- currentOwner:\n",
      "    id: 88745\n",
      "    name: Gymrat\n",
      "  dateCreated: 2014-10-01T06:00:00+0000\n",
      "  dateLastTaken: 2015-09-05T18:14:21+0000\n",
      "  id: 37400\n",
      "  latitude: 59.257784\n",
      "  longitude: 18.10383\n",
      "  name: \"Bakverkstr\\xE4d\"\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 954\n",
      "- currentOwner:\n",
      "    id: 88745\n",
      "    name: Gymrat\n",
      "  dateCreated: 2013-12-24T11:00:35+0000\n",
      "  dateLastTaken: 2015-09-05T19:47:48+0000\n",
      "  id: 24282\n",
      "  latitude: 59.260526\n",
      "  longitude: 18.100608\n",
      "  name: \"Gubb\\xE4ngenmot\"\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 880\n",
      "- currentOwner:\n",
      "    id: 50782\n",
      "    name: Morr\n",
      "  dateCreated: 2015-06-14T21:03:07+0000\n",
      "  dateLastTaken: 2015-09-05T13:12:21+0000\n",
      "  id: 54764\n",
      "  latitude: 59.267153\n",
      "  longitude: 18.165912\n",
      "  name: \"Kolar\\xE4ngen\"\n",
      "  pointsPerHour: 2\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 170\n",
      "  totalTakeovers: 19\n",
      "- currentOwner:\n",
      "    id: 54085\n",
      "    name: NisseNasse\n",
      "  dateCreated: 2012-03-29T20:37:46+0000\n",
      "  dateLastTaken: 2015-09-05T16:15:39+0000\n",
      "  id: 7666\n",
      "  latitude: 59.253266\n",
      "  longitude: 18.158213\n",
      "  name: FlatenZone\n",
      "  pointsPerHour: 2\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 170\n",
      "  totalTakeovers: 363\n",
      "- currentOwner:\n",
      "    id: 42907\n",
      "    name: videren\n",
      "  dateCreated: 2012-03-28T22:59:02+0000\n",
      "  dateLastTaken: 2015-09-05T19:55:09+0000\n",
      "  id: 7577\n",
      "  latitude: 59.266038\n",
      "  longitude: 18.097855\n",
      "  name: Bogards\n",
      "  pointsPerHour: 4\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 140\n",
      "  totalTakeovers: 1317\n",
      "- currentOwner:\n",
      "    id: 99095\n",
      "    name: tapioca\n",
      "  dateCreated: 2012-03-28T23:18:17+0000\n",
      "  dateLastTaken: 2015-09-05T10:54:24+0000\n",
      "  id: 7583\n",
      "  latitude: 59.252477\n",
      "  longitude: 18.104915\n",
      "  name: JulMums\n",
      "  pointsPerHour: 3\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 155\n",
      "  totalTakeovers: 1568\n",
      "- currentOwner:\n",
      "    id: 42385\n",
      "    name: ErlingHoken\n",
      "  dateCreated: 2012-03-28T22:48:36+0000\n",
      "  dateLastTaken: 2015-09-05T14:53:19+0000\n",
      "  id: 7574\n",
      "  latitude: 59.281355\n",
      "  longitude: 18.109189\n",
      "  name: SwampWoods\n",
      "  pointsPerHour: 4\n",
      "  region:\n",
      "    country: se\n",
      "    id: 141\n",
      "    name: Stockholm\n",
      "  takeoverPoints: 140\n",
      "  totalTakeovers: 1954\n",
      "\n"
     ]
    }
   ],
   "source": [
    "print dump(candidates)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 459,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table><tr><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.266239,18.132076/@59.266239,18.132076,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Skarpzone</a><br><br></td><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.265494,18.142474/@59.265494,18.142474,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Tätorpan</a><br><br></td></tr><tr><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.271409,18.135089/@59.271409,18.135089,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">TimeSpot</a><br><br></td><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.270527,18.127001/@59.270527,18.127001,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Eragon</a><br><br></td></tr><tr><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.274094,18.123072/@59.274094,18.123072,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Riksrådet</a><br><br></td><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.272649,18.115302/@59.272649,18.115302,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Pungpinan</a><br><br></td></tr><tr><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.268022,18.121179/@59.268022,18.121179,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Horizone</a><br><br></td><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.262657,18.113702/@59.262657,18.113702,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">LotsOfDogs</a><br><br></td></tr><tr><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.260497,18.113957/@59.260497,18.113957,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">SandFieldZone</a><br><br></td><td><a target=\"_blank\" href=\"https://www.google.se/maps/dir/current+location/59.264136,18.117681/@59.264136,18.117681,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Hundpark</a><br><br></td></tr></table><br>Totalt: <a target=\"_blank\" href=\"https://www.google.se/maps/dir/59.2652,18.132717/59.266239,18.132076/59.265494,18.142474/59.271409,18.135089/59.270527,18.127001/59.274094,18.123072/59.272649,18.115302/59.268022,18.121179/59.262657,18.113702/59.260497,18.113957/59.264136,18.117681/59.2652,18.132717/@59.2652,18.132717,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">First 25</a><br><br>Totalt: <a target=\"_blank\" href=\"https://www.google.se/maps/dir/59.2652,18.132717/59.266239,18.132076/59.265494,18.142474/59.271409,18.135089/59.270527,18.127001/59.274094,18.123072/59.272649,18.115302/59.268022,18.121179/59.262657,18.113702/59.260497,18.113957/59.264136,18.117681/59.2652,18.132717/@59.2652,18.132717,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">Last 25</a><br>"
      ],
      "text/plain": [
       "<IPython.core.display.HTML object>"
      ]
     },
     "execution_count": 459,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "def zone(name):\n",
    "    return turf('zones', [{\"name\" : name}])[0]\n",
    "\n",
    "def directions(zone): # from current location\n",
    "    return '<a target=\"_blank\" href=\"https://www.google.se/maps/dir/' + \\\n",
    "        'current+location/' + lat_long(zone) + \\\n",
    "        '/@' + lat_long(zone) + ',20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">' + zone[\"name\"] +'</a><br><br>'\n",
    "\n",
    "html = \"\"\n",
    "#route.sort(key=lambda x: x[\"name\"])\n",
    "i=0\n",
    "for z in route:\n",
    "    s = directions(z)        \n",
    "    if i%2==0:\n",
    "        s = '<tr><td>' + s + '</td>'\n",
    "    else:\n",
    "        s = '<td>' + s + '</td></tr>'\n",
    "    html += s\n",
    "    i+=1 \n",
    "\n",
    "_route = [home] + route + [home]    \n",
    "    \n",
    "# maximum 25 in google map. Not possible in iPhone or iPad.\n",
    "s1 = \"/\".join([lat_long(z) for z in _route[:25]]) \n",
    "s2 = \"/\".join([lat_long(z) for z in _route[-25:]])\n",
    "half1 = '<br>Totalt: <a target=\"_blank\" href=\"https://www.google.se/maps/dir/' + s1 +'/@' + lat_long(home) + ',20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">' + \"First 25\" +'</a><br>'\n",
    "half2 = '<br>Totalt: <a target=\"_blank\" href=\"https://www.google.se/maps/dir/' + s2 +'/@' + lat_long(home) + ',20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en\">' + \"Last 25\" +'</a><br>'\n",
    "\n",
    "HTML('<table>' + html + '</table>' + half1 + half2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 428,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "{u'takeoverPoints': 125, u'dateLastTaken': u'2015-09-08T18:45:27+0000', u'name': u'GreenaGatan', u'pointsPerHour': 5, u'region': {u'country': u'se', u'id': 141, u'name': u'Stockholm'}, u'totalTakeovers': 1405, u'dateCreated': u'2012-03-28T22:46:29+0000', u'currentOwner': {u'id': 42907, u'name': u'videren'}, u'longitude': 18.101103, u'latitude': 59.281707, u'id': 7573}\n",
      "73\n",
      "73\n",
      "yyy\n",
      "Skarpzone\n",
      "Listudden\n",
      "Tätorpan\n",
      "Eragon\n",
      "TimeSpot\n",
      "Horizone\n",
      "Hundpark\n",
      "Flatenstarten\n",
      "LotsOfDogs\n",
      "Skönvila\n",
      "SandFieldZone\n",
      "Bagizone\n",
      "Wilhelm\n",
      "FlataOvalen\n",
      "BakerMaam\n",
      "StoraSköndal\n",
      "TreasureRoad\n",
      "LänsmansPlan\n",
      "Skogsgravarna\n",
      "Bakverksträd\n",
      "Gubbängenmot\n",
      "Kolarängen\n",
      "FlatenZone\n",
      "Bogards\n",
      "JulMums\n",
      "SwampWoods\n",
      "Rusthållarn\n",
      "Epicentrum\n",
      "UlvsjöKlippa\n",
      "SpiritZone\n",
      "Kärrtorpsplan\n",
      "SöndagsZon\n",
      "Bomstopp\n",
      "ÄltaBuss\n",
      "Elderberry\n",
      "Stensötunneln\n",
      "AlmBussCykel\n",
      "ÄltaBad\n",
      "NackaCÅtta\n",
      "EnBitPåVägen\n",
      "Altazone\n",
      "Tenntorp\n",
      "Källtorp\n",
      "Hellasweet\n",
      "OmOchOmIgen\n",
      "LillaSickla\n",
      "Sicklabron\n",
      "Ovalzone\n",
      "SicklaPark\n",
      "Styrbord\n",
      "BajenKaj\n",
      "LumaScene\n",
      "UlrikHarbour\n",
      "LumaWater\n",
      "Terrassen\n",
      "HammarTextil\n",
      "Korphoppplan\n",
      "Linktaket\n",
      "ToTheHill\n",
      "WillysPark\n",
      "Karrzone\n",
      "Pungpinan\n",
      "Sicklasjön\n",
      "BjörkhagenT\n",
      "Riksrådet\n",
      "Blekingekollo\n",
      "Hammarbyhöjd\n",
      "FinnZone\n",
      "Thunbergarn\n",
      "Nytorparn\n",
      "DalensVård\n",
      "Fäholmaskogen\n",
      "Added GreenaGatan to matrix succesfully\n",
      "True\n"
     ]
    }
   ],
   "source": [
    "z = zone(u'GreenaGatan')\n",
    "print z\n",
    "\n",
    "print len(dist_matrix.zones)\n",
    "print len(dist_matrix.matrix)\n",
    "\n",
    "# fattas:\n",
    "#       \n",
    "for _z in dist_matrix.zones:\n",
    "    print _z[\"name\"] \n",
    "#for x in dist_matrix.zones:\n",
    "#    print x[\"name\"] \n",
    "print dist_matrix.add(z)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {
    "collapsed": False
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "'2015-09-10 10:17:23'"
      ]
     },
     "execution_count": 7,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import datetime\n",
    "str(datetime.datetime.now())[:19]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": None,
   "metadata": {
    "collapsed": True
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 2",
   "language": "python",
   "name": "python2"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 2
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython2",
   "version": "2.7.9"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 0
}

hash = {}
def probe(names,doc,s):
    if s.__class__ is list:
        for i in range(len(s)):
            probe(names, doc + '[' + str(i) + ']', s[i])
    elif s.__class__ is dict:
        for key in s:
            probe(names+'#'+key, doc + '["' + key + '"]', s[key])
    else:
        if names not in hash:
            hash[names] = True
            print doc + ' = ' + str(s)

probe('','s',s)

# Reducerades till:
#s["nbformat_minor"] = 0
#s["nbformat"] = 4
#s["cells"][0]["execution_count"] = 4
#s["cells"][0]["cell_type"] = code
#s["cells"][0]["source"][0] = import yaml
#s["cells"][0]["metadata"]["collapsed"] = False
#s["cells"][2]["outputs"][0]["output_type"] = stream
#s["cells"][2]["outputs"][0]["name"] = stdout
#s["cells"][2]["outputs"][0]["text"][0] = 2015-10-17 20:20:15.864000 FemteMyran
#s["cells"][2]["outputs"][1]["ename"] = KeyboardInterrupt
#s["cells"][2]["outputs"][1]["evalue"] =
#s["cells"][2]["outputs"][1]["traceback"][0] = \u001b[1;31m---------------------------------------------------------------------------\u001b[0m
#s["cells"][17]["metadata"]["scrolled"] = False
#s["cells"][31]["outputs"][0]["execution_count"] = 459
#s["cells"][31]["outputs"][0]["data"]["text/plain"][0] = <IPython.core.display.HTML object>
#s["cells"][31]["outputs"][0]["data"]["text/html"][0] = <table><tr><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.266239,18.132076/@59.266239,18.132076,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Skarpzone</a><br><br></td><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.265494,18.142474/@59.265494,18.142474,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Tätorpan</a><br><br></td></tr><tr><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.271409,18.135089/@59.271409,18.135089,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">TimeSpot</a><br><br></td><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.270527,18.127001/@59.270527,18.127001,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Eragon</a><br><br></td></tr><tr><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.274094,18.123072/@59.274094,18.123072,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Riksrådet</a><br><br></td><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.272649,18.115302/@59.272649,18.115302,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Pungpinan</a><br><br></td></tr><tr><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.268022,18.121179/@59.268022,18.121179,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Horizone</a><br><br></td><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.262657,18.113702/@59.262657,18.113702,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">LotsOfDogs</a><br><br></td></tr><tr><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.260497,18.113957/@59.260497,18.113957,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">SandFieldZone</a><br><br></td><td><a target="_blank" href="https://www.google.se/maps/dir/current+location/59.264136,18.117681/@59.264136,18.117681,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Hundpark</a><br><br></td></tr></table><br>Totalt: <a target="_blank" href="https://www.google.se/maps/dir/59.2652,18.132717/59.266239,18.132076/59.265494,18.142474/59.271409,18.135089/59.270527,18.127001/59.274094,18.123072/59.272649,18.115302/59.268022,18.121179/59.262657,18.113702/59.260497,18.113957/59.264136,18.117681/59.2652,18.132717/@59.2652,18.132717,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">First 25</a><br><br>Totalt: <a target="_blank" href="https://www.google.se/maps/dir/59.2652,18.132717/59.266239,18.132076/59.265494,18.142474/59.271409,18.135089/59.270527,18.127001/59.274094,18.123072/59.272649,18.115302/59.268022,18.121179/59.262657,18.113702/59.260497,18.113957/59.264136,18.117681/59.2652,18.132717/@59.2652,18.132717,20z/data=!3m1!4b1!4m2!4m1!3e1?hl=en">Last 25</a><br>
#s["metadata"]["kernelspec"]["display_name"] = Python 2
#s["metadata"]["kernelspec"]["name"] = python2
#s["metadata"]["kernelspec"]["language"] = python
#s["metadata"]["language_info"]["mimetype"] = text/x-python
#s["metadata"]["language_info"]["nbconvert_exporter"] = python
#s["metadata"]["language_info"]["name"] = python
#s["metadata"]["language_info"]["file_extension"] = .py
#s["metadata"]["language_info"]["version"] = 2.7.9
#s["metadata"]["language_info"]["pygments_lexer"] = ipython2
#s["metadata"]["language_info"]["codemirror_mode"]["version"] = 2
#s["metadata"]["language_info"]["codemirror_mode"]["name"] = ipython

