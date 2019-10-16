defmodule GenstageEx.ProducerConsumer do
	use GenStage
	require Integer

	@moduledoc """
		We’ll want to request numbers from our producer, filter out the odd one, and respond to demand.
	"""
	
	def start_link do
		GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
	end


	def init(state) do
		{:producer_consumer, state, subscribe_to: [GenstageEx.Producer]}
	end
	
	# The handle_events/3 function is our workhorse, where we receive our incoming events,
	# process them, and return our transformed set.
	def handle_events(events, _from, state) do
		numbers =
			events
			|> Enum.filter(&Integer.is_even/1)

		{:noreply, numbers, state}
	end
end
