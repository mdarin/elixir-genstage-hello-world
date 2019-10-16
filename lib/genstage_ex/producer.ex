defmodule GenstageEx.Producer do
	use GenStage

	@moduledoc """
		As we discussed before, we want to create a producer that emits a constant stream of numbers.
	"""

	def start_link(initial \\ 0) do 
		GenStage.start_link(__MODULE__, initial, name: __MODULE__) 
	end

	def init(counter), do: {:producer, counter}

	# The handle_demand/2 function is where the majority of our producer is defined.
	# It must be implemented by all GenStage producers.
	def handle_demand(demand, state) do
		events = Enum.to_list(state..(state + demand - 1))
		{:noreply, events, state + demand} 
	end
end
