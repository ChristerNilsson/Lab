content = """		
	<tr>
		<td>
			<button id='helpButton' style="background-color:black; color:white; padding-left:0px; font-size:100%; width:100%; text-align:left">Info</button>
		</td> 
	</tr>  
  <tr id="helpText" style="display:none">
    <td>
      <div>
        <ul style="list-style-type:none"> 
          <li><h3>Bagarmossen Sushi o Cafe</h3></li>
          <li><a href="https://www.google.se/maps/place/Bagarmossen+Sushi+%26+Caf%C3%A9/@59.2648854,18.1521259,13z/data=!4m5!3m4!1s0x0:0xbb412f14a5d09ac2!8m2!3d59.2775081!4d18.1327736" target="_blank">Lagaplan 5, Bagarmossen</a></li>
          <li>08-600 07 88</li>
        </ul>
        <ol>
          <li>Select dishes from the menu</li>
          <li>Set meal count with green button</li>
          <li>Some dishes can be customized</li>
          <li>Order by your mail</li>
          <li>Fetch your food</li>
        </ol>
      </div>
    </td>
  </tr>
"""

class Help
	constructor : ->
		@table = document.getElementById "help"
		@table.innerHTML = content
		b = document.getElementById "helpButton"
		b.onclick = ->
			helpText = document.getElementById "helpText"
			if helpText.style.display == 'table-row'
				@style.backgroundColor = BLACK 
				@style.color = WHITE
				helpText.style.display = 'none'
			else
				@style.backgroundColor = WHITE 
				@style.color = BLACK
				helpText.style.display = 'table-row'
