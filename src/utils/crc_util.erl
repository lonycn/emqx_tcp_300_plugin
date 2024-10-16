-module(crc_util).

-export([calc_crc/1]).

calc_crc(Data) ->
    % Implement CRC16 algorithm as per protocol specification
    % This is a placeholder implementation
    erlang:crc32(Data) band 16#FFFF.
