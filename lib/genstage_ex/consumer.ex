defmodule GenstageEx.Consumer do
	use GenStage

	@moduledoc """
		Last we’ll build a consumer to display the remaining numbers for us.
	"""

	def start_link do
		GenStage.start_link(__MODULE__, :state_doesnt_matter)
	end

	def init(state) do
		{:consumer, state, subscribe_to: [GenstageEx.ProducerConsumer]}
	end

	def handle_events(events, _from, state) do
		# process events
		for event <- events do
			IO.inspect({self(), event, state})	
		end
	
		# As a consumer we never emit events
		{:noreply, [], state}
	end

end
