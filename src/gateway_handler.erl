-module(gateway_handler).

-export([process/1]).

process({handshake, Version, Seq}) ->
    Response = encoder:encode_handshake_response(Version, Seq),
    lager:info("Handshake response: ~p", [Response]),
    Response;

process({status_report, GW_ID, Status}) ->
    Response = encoder:encode_status_ack(GW_ID, Status),
    lager:info("Status ACK: ~p", [Response]),
    Response.

% Implement other gateway-specific handlers...
