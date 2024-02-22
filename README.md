# Zenohex On Nerves

This is the sample repository of [Zenohex](https://github.com/b5g-ex/zenohex) on Nerves.

## Getting Started

To start your Nerves app:

- `export MIX_TARGET=my_target` or prefix every command with
  `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi4`
- Install dependencies with `mix deps.get`
- Create firmware with `mix firmware`
- Burn to an SD card with `mix burn`

### Let's try Zenohex to communicate between Nerves(target) & PC(host)

**Zenohex itself doesn't include `Zenohex.Examples`.  
We copied the examples from Zenohex to demonstrate.**

On Nerves iex shell,

```elixir
iex> RingLogger.attach
iex> Zenohex.Examples.Subscriber.start_link
{:ok, #PID<>}
```

On PC iex shell, **make sure MIX_TARGET is unset before starting iex**

```elixir
iex> Zenohex.Examples.Publisher.start_link
{:ok, #PID<>}
iex(2)> Zenohex.Examples.Publisher.put("hello")
:ok
```

Back to Nerves iex shell to confirm receiving.

```elixir
23:11:34.054 [debug] %Zenohex.Sample{key_expr: "zenohex/examples/pub", value: "hello", kind: :put, reference: #Reference<0.2097591244.707657743.258773>}
```

Yay!!

Of course, we can do the opposite, starting Subscriber on your PC and Publisher on Nerves. Please try it!  
(`RingLogger.attach` is not necessary on this case.)

## Learn more

### About Zenohex

- https://github.com/b5g-ex/zenohex
- https://hex.pm/packages/zenohex
- https://hexdocs.pm/zenohex

### About Nerves

- Official docs: https://hexdocs.pm/nerves/getting-started.html
- Official website: https://nerves-project.org/
- Forum: https://elixirforum.com/c/nerves-forum
- Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
- Source: https://github.com/nerves-project/nerves
