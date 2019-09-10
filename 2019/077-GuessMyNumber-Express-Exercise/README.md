# GuessMyNumber Express 

npm install -g express

## start

node index

* [express.urlencoded](https://stackoverflow.com/questions/23259168/what-are-express-json-and-express-urlencoded/51844327)
* get
* post

# Communication

## Request: / GET
localhost:3000

## Response:
```
<h1>1-3</h1>
<form action="/" method="post">
	<input type="text" name="nr" autofocus="autofocus"/>
	<input type="submit" value="Submit"/>
</form>
```
## Request: / POST
```
nr=2
```

## Response:
```
<h1>1-1</h1>
<form action="/" method="post">
	<input type="text" name="nr" autofocus="autofocus"/>
	<input type="submit" value="Submit"/>
</form>
```