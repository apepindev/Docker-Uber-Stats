style: """
	color: white
	right: 3%
	bottom: 5%
	font-size: 18px
	font-family: SFNS Display, 'Helvetica Neue', sans-serif
	text-shadow: 1px 1px 0 rgba(#000, 0.4)

	table
		margin: 0 auto

	.ip
		opacity: 0.6
		font-size: 14px

	.indicator
		font-size: 20px
		padding: 0 12px
		&.running
			color: rgb(153, 227, 160)
		&.stopped
			color: rgb(244, 115, 94)
"""

command: "dockermachinestats.widget/helper.sh getStatus"

refreshFrequency: (60000)

render: -> """
	<div>
  	<table></table>
	</div>
"""

update: (output, domEl) ->
	machines 	= output.split("\n")
	table = $(domEl).find('table')

	table.html('')

	renderMachine = (name, ip, status) -> """
		<tr class="row">
			<td class="#{ status.toLowerCase() } indicator">&#9679;</td>
			<td>
				<strong>#{ name }</strong><br>
				<div class="ip">#{ ip }</div>
			</td>
		</tr>
	"""

	for machine in machines
		[name, ip, status] = machine.split(' ')
		if name.length > 0
			if ip isnt "Unknown"
				ip = ip.split(/\/\/(.*):/)[1]
			table.append renderMachine(name, ip, status)
