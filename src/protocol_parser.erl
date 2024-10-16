-module(protocol_parser).

-export([parse/1]).

-include("protocol.hrl").

parse(<<_Start:16, _Length:8, Command:8, Payload/binary>>) ->
    case Command of
        ?HANDSHAKE_CMD -> parse_handshake(Payload);
        ?STATUS_REPORT_CMD -> parse_status_report(Payload);
        ?SENSOR_DATA_CMD -> parse_sensor_data(Payload);
        ?ALARM_DATA_CMD -> parse_alarm_data(Payload);
        _ -> {error, unknown_command}
    end.

parse_handshake(<<Version:8, Seq:16, _CRC:16, EndBytes:16>>) ->
    case EndBytes of
        ?END_BYTES -> {gateway, {handshake, Version, Seq}};
        _ -> {error, invalid_end_bytes}
    end.

parse_status_report(<<GW_ID:32, Status:8>>) ->
    {gateway, {status_report, GW_ID, Status}}.

% 实现其他解析函数...
parse_sensor_data(_Payload) ->
    % 实现传感器数据解析逻辑
    {error, not_implemented}.

parse_alarm_data(_Payload) ->
    % 实现警报数据解析逻辑
    {error, not_implemented}.
