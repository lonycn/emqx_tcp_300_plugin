-module(tcp_handler).
-behaviour(gen_server).

-export([start_link/0, init/1, handle_info/2, handle_call/3, handle_cast/2]).

-record(state, {listen_socket}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(ListenSocket) ->
    {ok, _Socket} = gen_tcp:accept(ListenSocket),
    {ok, #state{}}.

handle_info({tcp, _Socket, Data}, State) ->
    % 使用 Data 变量,例如:
    handle_data(Data),
    {noreply, State};

handle_info({tcp_closed, _Socket}, State) ->
    % 处理连接关闭的逻辑
    {stop, normal, State};

handle_info(_Info, State) ->
    {noreply, State}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

% Other callbacks...

% 添加一个新函数来处理接收到的数据
handle_data(Data) ->
    % 在这里实现数据处理逻辑
    io:format("Received data: ~p~n", [Data]).
