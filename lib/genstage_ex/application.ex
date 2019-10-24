defmodule GenstageEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc """
	  For our application we’ll use all three GenStage roles. 
		Our producer will be responsible for counting and emitting numbers.
		We’ll use a producer-consumer to filter out only the even numbers 
		and later respond to demand from downstream. Last we’ll build a 
		consumer to display the remaining numbers for us.
	""" 

  use Application

  def start(_type, _args) do
		import Supervisor.Spec #, warn: false

    children = [
      # Starts a worker by calling: GenstageEx.Worker.start_link(arg)
      # {GenstageEx.Worker, arg}
			worker(GenstageEx.Producer, [0]),
			worker(GenstageEx.ProducerConsumer, []),
			worker(GenstageEx.Consumer, [], id: 1),
			worker(GenstageEx.Consumer, [], id: 2)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GenstageEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
