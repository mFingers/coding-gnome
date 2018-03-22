defmodule Hangman.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec  # deprecated module

    children = [
      worker(Hangman.Server, [])  # deprecated way for creating a child spec
    ]

    options = [
      name: Hangman.Supervisor,
      strategy: :simple_one_for_one,  # deprecated strategy, replaced with DynamicSupervisor
    ]

    Supervisor.start_link(children, options)
  end
end
