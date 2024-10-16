-module(encoder).
-export([encode_handshake_response/2, encode_status_ack/2]).

-include("protocol.hrl").

encode_handshake_response(Version, Seq) ->
    Payload = <<Version:8, Seq:16>>,
    CRC = crc_util:calc_crc(Payload),
    <<?START_BYTES, 8:8, ?HANDSHAKE_CMD, Payload/binary, CRC:16, ?END_BYTES>>.

encode_status_ack(GW_ID, Status) ->
    Payload = <<GW_ID:32, Status:8>>,
    CRC = crc_util:calc_crc(Payload),
    <<?START_BYTES, 9:8, ?STATUS_REPORT_CMD, Payload/binary, CRC:16, ?END_BYTES>>.

% Implement other encoding functions...
