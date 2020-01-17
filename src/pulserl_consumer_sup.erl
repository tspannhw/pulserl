%%%-------------------------------------------------------------------
%%% @author Alpha Umaru Shaw <shawalpha5@gmail.com>
%%% @doc
%%%
%%% @end
%%% Company: Skulup Ltd
%%% Copyright: (C) 2019
%%%-------------------------------------------------------------------
-module(pulserl_consumer_sup).
-author("Alpha Umaru Shaw").

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).


start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).


init([]) ->
  SupFlags = #{strategy => simple_one_for_one,
    intensity => 1000,
    period => 3600},
  ChildSpecs = [
    #{
      id => pulserl_consumer,
      start => {pulserl_consumer, start_link, []},
      restart => transient,
      shutdown => 10000,
      type => worker,
      modules => [pulserl_consumer]
    }
  ],
  {ok, {SupFlags, ChildSpecs}}.
